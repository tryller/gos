if GetObjectName(myHero) ~= "Vayne" then return end

local ver = "0.06"

require ("OpenPredict")
require ("MapPositionGOS")
require ("ChallengerCommon")


local mainMenu = Menu("Vayne", "Vayne")
mainMenu:SubMenu("Combo", "Combo")
mainMenu.Combo:Boolean("CQ", "Use Q", true)
mainMenu.Combo:SubMenu("EO", "E Options")
mainMenu.Combo.EO:Boolean("EC", "Use E To Peel", true)
mainMenu.Combo.EO:Slider("ECC", "Push Distance",125,0,550,5)
mainMenu.Combo.EO:Boolean("ES", "E To Stun", true)
mainMenu.Combo:Boolean("CR", "Use R", true)
mainMenu.Combo:Slider("CMM", "Min Mana To Combo",20,0,100,1)
mainMenu.Combo:Boolean("BORK", "Use BORK", true)
mainMenu.Combo:Boolean("Bilge", "Use Bilge", true)
mainMenu.Combo:Boolean("RotSec", "ZZRot Condemn", true)
mainMenu.Combo:Boolean("CF", "Condemn Flash Combo", true)

mainMenu:SubMenu("Harass", "Harass")
mainMenu.Harass:Boolean("HQ", "Use Q", true)
mainMenu.Harass:SubMenu("HEO", "E Options")
mainMenu.Harass.HEO:Boolean("HEC", "Use E To Peel", true)
mainMenu.Harass.HEO:Slider("HECC", "Push Distance",125,0,550,5)
mainMenu.Harass.HEO:Boolean("HES", "Use E To Stun", true)
mainMenu.Harass:Slider("HMM", "Min Mana To Harass",20,0,100,1)

mainMenu:SubMenu("LaneClear", "LaneClear")
mainMenu.LaneClear:Boolean("LCQ", "Use Q", true)
mainMenu.LaneClear:Slider("LCMM", "Min Mana To LaneClear",20,0,100,1)

mainMenu:SubMenu("JungleClear", "JungleClear")
mainMenu.JungleClear:Boolean("JCQ", "Use Q", true)
mainMenu.JungleClear:Boolean("JCE", "Use E", true)
mainMenu.JungleClear:Slider("JCMM", "Min Mana To JungleClear",20,0,100,1)

mainMenu:SubMenu("KillSteal", "KillSteal")
mainMenu.KillSteal:Boolean("KSQ", "Use Q", true)
mainMenu.KillSteal:Boolean("KSW", "Use W", true)

mainMenu:SubMenu("Misc", "Misc")
mainMenu.Misc:DropDown("AutoLevel", "AutoLevel", 1, {"Off", "QEW", "QWE", "WQE", "WEQ", "EQW", "EWQ", "Toshi Special"})
mainMenu.Misc:Boolean("AC", "Auto Condemn", true)
mainMenu.Misc:Boolean("ACA", "Anivia Wall Condemn", true)
mainMenu.Misc:Boolean("ACT", "Trundle Pillar Condemn", true)
mainMenu.Misc:Boolean("QSS", "Use QSS", true)
mainMenu.Misc:Slider("QSSC", "HP To QSS", 90,0,100,1)
mainMenu.Misc:Boolean("AI", "Auto Ignite", true)
mainMenu.Misc:Boolean("AR", "Auto R", true)
mainMenu.Misc:Slider("ARC", "Min Enemies To Auto R",3,1,6,1)
mainMenu.Misc:Boolean("DAAS", "Don't AA While Invis", true)
mainMenu.Misc:Boolean("QAC", "Q Animation Cancel", true)

mainMenu:SubMenu("GapClose", "GapClose")
mainMenu.GapClose:Boolean("GCQ", "Use Q", true)
mainMenu.GapClose:Boolean("GCR", "Use R", false)

mainMenu:SubMenu("AntiGapCloser", "AntiGapCloser")
mainMenu:SubMenu("Interrupter", "Interrupter")


local target = GetCurrentTarget()
function QDmg(unit) return CalcDamage(myHero, unit, myHero.totalDamage + (myHero.totalDamage * (0.25 + 0.05 * GetCastLevel(myHero, _W))), 0) end
function WDmg(unit) return CalcDamage(myHero, unit, AADmg(unit), 0) + (unit.maxHealth * (0.045 + 0.015 * GetCastLevel(myHero, _W))) end
function AADmg(unit) return CalcDamage(myHero, unit, myHero.totalDamage, 0) end
function EDmg(unit) return CalcDamage(myHero, unit, (10 + 35 * GetCastLevel(myHero, _E)) + (myHero.totalDamage * 0.5)) end
function WStacks(unit) return GetBuffData(unit, "VayneSilveredDebuff").Count end
local Move = {delay = 0.5, speed = math.huge, width = 50, range = math.huge}
local CCType = {[5] = "Stun", [7] = "Silence", [8] = "Taunt", [9] = "Polymorph", [11] = "Snare", [21] = "Fear", [22] = "Charm", [24] = "Suppression"}
local QSS = nil
local MercSkimm = nil
local AARange = GetRange(myHero) + GetHitBox(myHero)
local ERange = GetCastRange(myHero, _E) + GetHitBox(myHero)
local QRange = GetCastRange(myHero, _Q)
local CPos = nil
local ZSpot = nil
local ZZRot = nil
local WallC = nil
local WallT = nil
local EStats = {delay = 0.25, range = ERange, radius = 1, speed = 2000}
local Meh = nil
local Meh2 = nil
local SMeh = nil
local SMeh2 = nil
local FFPos = nil
local FFPos2 = nil
local FFPos3 = nil
local CFPos = nil
local CFPos2 = nil
local CFPos3 = nil
local flash = (GetCastName(GetMyHero(),SUMMONER_1):lower():find("summonerflash") and SUMMONER_1 or (GetCastName(GetMyHero(),SUMMONER_2):lower():find("summonerflash") and SUMMONER_2 or nil))
local Pink = nil

function Mode()
    if _G.IOW_Loaded and IOW:Mode() then
        return IOW:Mode()
        elseif _G.PW_Loaded and PW:Mode() then
        return PW:Mode()
        elseif _G.DAC_Loaded and DAC:Mode() then
        return DAC:Mode()
        elseif _G.AutoCarry_Loaded and DACR:Mode() then
        return DACR:Mode()
        elseif _G.SLW_Loaded and SLW:Mode() then
        return SLW:Mode()
    end
end

function ResetAA()
    if _G.IOW_Loaded then
        return IOW:ResetAA()
        elseif _G.PW_Loaded then
        return PW:ResetAA()
        elseif _G.DAC_Loaded then
        return DAC:ResetAA()
        elseif _G.AutoCarry_Loaded then
        return DACR:ResetAA()
        elseif _G.SLW_Loaded then
        return SLW:ResetAA()
    end
end

function BlockAttack(boolean)
	if _G.IOW_Loaded then
		return IOW.attacksEnabled == (boolean)
		elseif _G.PW_Loaded then
        return PW.attacksEnabled == (boolean)
        elseif _G.DAC_Loaded then
        return DAC.attacksEnabled == (boolean)
        elseif _G.AutoCarry_Loaded then
        return DACR.attacksEnabled == (boolean)
        elseif _G.SLW_Loaded then
        return SLW.attacksEnabled == (boolean)
    end
end

OnTick(function()
	
	target = GetCurrentTarget()
	local IDamage = (50 + (20 * GetLevel(myHero)))
	local BORK = GetItemSlot(myHero, 3153)
	local Bilge = GetItemSlot(myHero, 3144)
	QSS = GetItemSlot(myHero, 3140)
	MercSkimm = GetItemSlot(myHero, 3139)
	local movePos = GetPrediction(target,Move).castPos
	CPos = target.pos + (target.pos - myHero.pos):normalized() * 430
	ZSpot = target.pos + (target.pos - myHero.pos):normalized() * 100
	ZZRot = GetItemSlot(myHero, 3512)
	local Invis = GotBuff(myHero, "vaynetumblefade")
	
	FFPos = target.pos + (target.pos - myHero.pos):normalized() * 425
	FFPos2 = target.pos + (target.pos - myHero.pos):perpendicular():normalized() * 425
	FFPos3 = target.pos + (target.pos - myHero.pos):perpendicular2():normalized() * 425
	FFPos4 = target.pos + (target.pos - myHero.pos):normalized() * -425
	
	CFPos = target.pos + (target.pos - FFPos):normalized() * 440
	CFPos2 = target.pos + (target.pos - FFPos):normalized():perpendicular() * 440
	CFPos3 = target.pos + (target.pos - FFPos):normalized():perpendicular2() * 440
	CFPos4 = target.pos + (target.pos - FFPos):normalized() * -440
	
	SMehPus = GetPrediction(target, EStats)
	SMehPos = Vector(SMehPus)
	SMeh = SMehPos + (SMehPos - myHero.pos):normalized() * 420
	SMeh2 = SMehPos + (SMehPos - myHero.pos):normalized() * 180

	
	if Invis > 0 and Pink ~= nil and GetDistance(myHero, Pink) > 1000 and mainMenu.Misc.DAAS:Value() and EnemiesAround(myHero, 800) > 0 and GetDistance(myHero, target) < 300 then BlockAttack(true)
		elseif Pink == nil and mainMenu.Misc.DAAS:Value() and EnemiesAround(myHero, 800) > 0 and GetDistance(myHero, target) < 300 then BlockAttack(true)
	end
	
	if Invis < 1 then BlockAttack(false) end
	
	--AutoLevel
	if mainMenu.Misc.AutoLevel:Value() == 2 then
		spellorder = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
		if GetLevelPoints(myHero) > 0 then
			LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
		end
	end

	if mainMenu.Misc.AutoLevel:Value() == 3 then
		spellorder = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
		if GetLevelPoints(myHero) > 0 then
			LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
		end
	end
	
	if mainMenu.Misc.AutoLevel:Value() == 4 then
		spellorder = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
		if GetLevelPoints(myHero) > 0 then
			LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
		end
	end
	
	if mainMenu.Misc.AutoLevel:Value() == 5 then
		spellorder = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
		if GetLevelPoints(myHero) > 0 then
			LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
		end
	end
	
	if mainMenu.Misc.AutoLevel:Value() == 6 then
		spellorder = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
		if GetLevelPoints(myHero) > 0 then
			LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
		end
	end
	
	if mainMenu.Misc.AutoLevel:Value() == 7 then
		spellorder = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
		if GetLevelPoints(myHero) > 0 then
			LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
		end
	end
	
	if mainMenu.Misc.AutoLevel:Value() == 8 then
		spellorder = {_Q, _W, _E, _Q, _Q, _R, _W, _W, _W, _W, _R, _Q, _Q, _E, _E, _R, _E, _E}
		if GetLevelPoints(myHero) > 0 then
			LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
		end
	end		
	
	--Combo
	if Mode() == "Combo" then
		
		if mainMenu.Combo.EO.EC:Value() and Ready(_E) and ValidTarget(target, ERange) then
			if GetPercentMP(myHero) >= mainMenu.Combo.CMM:Value() and GetDistance(myHero, target) <= mainMenu.Combo.EO.ECC:Value() then
				CastTargetSpell(target, _E)
			end
		end
		
		if mainMenu.Combo.EO.ES:Value() and Ready(_E) and ValidTarget(target, ERange) then
			if GetPercentMP(myHero) >= mainMenu.Combo.CMM:Value() and MapPosition:inWall(SMeh) or MapPosition:inWall(SMeh2) then
				blahblah = false
				blahblah2 = false
				blahblah3 = false
				blahblah4 = false
				CastTargetSpell(target, _E)
			end
		end		

		if mainMenu.Combo.CR:Value() and Ready(_R) and ValidTarget(target, 750) then
			if GetPercentMP(myHero) >= mainMenu.Combo.CMM:Value() then
				if GetPercentHP(myHero) >= GetPercentHP(target) and GetPercentHP(target) >= 30 then
					CastSpell(_R)
				end
			end	
		end		
		
		if mainMenu.Combo.BORK:Value() and Ready(BORK) and ValidTarget(target, 550) then
			if GetPercentHP(myHero) <= 90 and GetDistance(movePos) < GetDistance(target) then
				CastTargetSpell(target, BORK)
			end
		end
		
		if mainMenu.Combo.BORK:Value() and Ready(BORK) and ValidTarget(target, 550) then
			if GetPercentHP(myHero) >= GetPercentHP(target) and GetDistance(movePos) > GetDistance(target) then
				CastTargetSpell(target, BORK)
			end
		end		

		if mainMenu.Combo.Bilge:Value() and Ready(Bilge) and ValidTarget(target, 550) then
			if GetPercentHP(myHero) >= GetPercentHP(target) and GetDistance(movePos) > GetDistance(target) then
				CastTargetSpell(target, Bilge)
			end
		end

		if mainMenu.Combo.Bilge:Value() and Ready(Bilge) and ValidTarget(target, 550) then
			if GetPercentHP(myHero) >= 90 and GetDistance(movePos) < GetDistance(target) then
				CastTargetSpell(target, Bilge)
			end
		end
		
		--Condemn Flash
		if flash and mainMenu.Combo.CF:Value() then
			if Ready(_E) and Ready(flash) and ValidTarget(target, 375) and EnemiesAround(myHero, 800) < 2 and AlliesAround(myHero) < 2 and GetDistance(myHero, target) > 200 then
				if MapPosition:inWall(CFPos) and not MapPosition:inWall(CFPos4) and not MapPosition:inWall(CFPos2) and not MapPosition:inWall(CFPos3) then
					blahblah = true
					CastTargetSpell(target, _E)
					else blahblah = false
				end

				if MapPosition:inWall(CFPos2) and not MapPosition:inWall(CFPos) and not MapPosition:inWall(CFPos4) and not MapPosition:inWall(CFPos3) then
					blahblah2 = true
					CastTargetSpell(target, _E)
					else blahblah2 = false
				end
				
				if MapPosition:inWall(CFPos3) and not MapPosition:inWall(CFPos) and not MapPosition:inWall(CFPos2) and not MapPosition:inWall(CFPos4) then
					blahblah3 = true
					CastTargetSpell(target, _E)
					else blahblah3 = false
				end
			
				if MapPosition:inWall(CFPos4) and not MapPosition:inWall(CFPos) and not MapPosition:inWall(CFPos2) and not MapPosition:inWall(CFPos3) then
					blahblah3 = true
					CastTargetSpell(target, _E)
					else blahblah4 = false
				end
			end
		end
	end
	
	--Harass
	if Mode() == "Harass" then
		
		if mainMenu.Harass.HEO.HEC:Value() and Ready(_E) and ValidTarget(target, ERange) then
			if GetPercentMP(myHero) >= mainMenu.Harass.HMM:Value() and GetDistance(myHero, target) <= mainMenu.Harass.HEO.HECC:Value() then
				CastTargetSpell(target, _E)
			end
		end
		
		if mainMenu.Harass.HEO.HES:Value() and Ready(_E) and ValidTarget(target, ERange) then
			if GetPercentMP(myHero) >= mainMenu.Harass.HMM:Value() and MapPosition:inWall(SMeh) or MapPosition:inWall(SMeh2) then
				CastTargetSpell(target, _E)
			end	
		end
	end
	
	--JungleClear
	if Mode() == "LaneClear" then
	
		for _, minion in pairs(minionManager.objects) do
			local CMPos = minion.pos + (minion.pos - myHero.pos):normalized() * 450
			if GetTeam(minion) == 300 then
				if not GetObjectName(minion):lower():find("sru_dragon") and not GetObjectName(minion):lower():find("sru_baron") and not GetObjectName(minion):lower():find("mini") then
					if mainMenu.JungleClear.JCE:Value() and Ready(_E) and ValidTarget(minion, ERange) then
						if GetPercentMP(myHero) >= mainMenu.JungleClear.JCMM:Value() and GetPercentHP(minion) >= 30 then
							if MapPosition:inWall(CMPos) then
								CastTargetSpell(minion, _E)
							end
						end
					end
				end
			end
		end
	end

	--KillSteal
	for _, enemy in pairs(GetEnemyHeroes()) do
		
		Meh = GetPrediction(enemy, EStats)
		Mehh = Vector(Meh)
		MehPos = Mehh + (Mehh - myHero.pos):normalized() * 440
		MehPos2 = Mehh + (Mehh - myHero.pos):normalized() * 180
		
		if MapPosition:inWall(MehPos) or MapPosition:inWall(MehPos2) then
			inwall = true
			else inwall = false
		end	

		if mainMenu.Misc.AC:Value() and Ready(_E) and ValidTarget(enemy, ERange) then
			if inwall == true then
				blahblah = false
				blahblah2 = false
				blahblah3 = false
				blahblah4 = false
				CastTargetSpell(enemy, _E)
			end
		end	
	
		if AniviaWall ~= nil then
			WallC = AniviaWall.pos + (AniviaWall.pos - myHero.pos):normalized() * 430
		end	
		
		if TrundlePillar ~= nil then
			WallT = TrundlePillar.pos + (TrundlePillar.pos - myHero.pos):normalized() * 430
		end
		
		if mainMenu.KillSteal.KSQ:Value() and Ready(_Q) and ValidTarget(enemy, QRange + AARange) then
			if GetCurrentHP(enemy) + GetDmgShield(enemy) <= QDmg(enemy) then
				CastSkillShot(_Q, enemy)
				AttackUnit(enemy)
			end
		end
	
		if mainMenu.KillSteal.KSW:Value() and ValidTarget(enemy, AARange) then
			if GetCurrentHP(enemy) + GetDmgShield(enemy) + GetHPRegen(enemy) <= WDmg(enemy) + EDmg(enemy) then
				if AlliesAround(enemy, 600) >= 2 and WStacks(enemy) == 2 then
					CastTargetSpell(enemy, _E)
				end
			end
		end

		--AutoCondemn TWall, AWall
		if AniviaWall ~= nil then
			if mainMenu.Misc.ACA:Value() and Ready(_E) and ValidTarget(enemy, ERange) and CountObjectsOnLineSegment(WallC, AniviaWall, 400, GetEnemyHeroes()) > 0 then
				blah = false
				CastTargetSpell(enemy, _E)
			end	
		end
 
		if TrundlePillar ~= nil then
			if mainMenu.Misc.ACT:Value() and Ready(_E)	and ValidTarget(enemy, ERange) and CountObjectsOnLineSegment(WallT, TrundlePillar, 225, GetEnemyHeroes()) > 0 then
				blah = false
				CastTargetSpell(enemy, _E)
			end	
		end	
		
		--Auto Ignite 
		if GetCastName(myHero, SUMMONER_1):lower():find("summonerdot") then
			if mainMenu.Misc.AI:Value() and Ready(SUMMONER_1) and ValidTarget(enemy, 600) then
				if GetCurrentHP(enemy) + GetShieldDmg(enemy) < IDamage then
					CastTargetSpell(enemy, SUMMONER_1)
				end
			end
		end
	
		if GetCastName(myHero, SUMMONER_2):lower():find("summonerdot") then
			if mainMenu.Misc.AI:Value() and Ready(SUMMONER_2) and ValidTarget(enemy, 600) then
				if GetCurrentHP(enemy) + GetDmgShield(enemy) < IDamage then
					CastTargetSpell(enemy, SUMMONER_2)
				end
			end
		end
	end

	--Auto R
	if mainMenu.Misc.AR:Value() and Ready(_R) then
		if EnemiesAround(myHero, 800) >= mainMenu.Misc.ARC:Value() and GetPercentHP(myHero) >= 30 then
			CastSpell(_R)
		end
	end
	
	--GapClose
	if Mode() == "Combo" or Mode() == "Harass" then
		if mainMenu.GapClose.GCQ:Value() and Ready(_Q) and ValidTarget(target, 1000) and GetDistance(myHero, target) > 700 then
			if GetDistance(movePos) > GetDistance(target) then
				CastSkillShot(_Q, target)
			end
		end
	end
	
	if Mode() == "Combo" then
		if mainMenu.GapClose.GCR:Value() and Ready(_R) and ValidTarget(target, 1200) and GetDistance(myHero, target) > AARange then
			if GetDistance(movePos) > GetDistance(target) and target.ms > myHero.ms then
				CastSpell(_R)
			end
		end	
	end
	
	--ZZRot Condemn
	if mainMenu.Combo.RotSec:Value() and Ready(_E) and ValidTarget(target, 375) and EnemiesAround(target, 800) < 1 then
		if not MapPosition:inWall(MehPos) and not MapPosition:inWall(MehPos2) and ZZRot > 0 and Ready(ZZRot) then
			CastTargetSpell(target, _E)
			blah = true
			else blah = false
		end
	end		
end)	

--Auto QSS
OnUpdateBuff(function(unit, buff)
	if unit.isMe and CCType[buff.Type] and mainMenu.Misc.QSS:Value() and QSS > 0 and Ready(QSS) then
		if GetPercentHP(myHero) <= mainMenu.Misc.QSSC:Value() and EnemiesAround(myHero, 900) >= 1 then
			CastSpell(QSS)
		end	
	end
	
	if unit.isMe and CCType[buff.Type] and mainMenu.Misc.QSS:Value() and MercSkimm > 0 and Ready(MercSkimm) then
		if GetPercentHP(myHero) <= mainMenu.Misc.QSSC:Value() and EnemiesAround(myHero, 900) >= 1 then
			CastSpell(MercSkimm)
		end
	end
end)	

-- Auto Attack Resets
OnProcessSpellComplete(function(unit, spell)
	if unit.isMe and spell.name:lower():find("attack") and spell.target.isHero then
		if Mode() == "Combo" then
			if mainMenu.Combo.CQ:Value() and Ready(_Q) and IsObjectAlive(spell.target) and GetCurrentHP(spell.target) > AADmg(spell.target) then
				if GetPercentMP(myHero) >= mainMenu.Combo.CMM:Value() then	
					CastSkillShot(_Q, GetMousePos())
				end	
			end
		end
			
		if Mode() == "Harass" then
			if mainMenu.Harass.HQ:Value() and Ready(_Q) and IsObjectAlive(spell.target) and GetCurrentHP(spell.target) > AADmg(spell.target) then
				if GetPercentMP(myHero) >= 	mainMenu.Harass.HMM:Value() then
					CastSkillShot(_Q, GetMousePos())
				end				
			end
		end
	end

	if unit.isMe and spell.name:lower():find("attack") and spell.target.isMinion then
		if Mode() == "LaneClear" then
			if GetTeam(spell.target) == 300 - GetTeam(myHero) then
				if mainMenu.LaneClear.LCQ:Value() and Ready(_Q) and IsObjectAlive(spell.target) and GetCurrentHP(spell.target) > AADmg(spell.target) then
					if GetPercentMP(myHero) >= mainMenu.LaneClear.LCMM:Value() then
						CastSkillShot(_Q, GetMousePos())
					end
				end
			end

			if GetTeam(spell.target) == 300 then
				if mainMenu.JungleClear.JCQ:Value() and Ready(_Q) and IsObjectAlive(spell.target) and GetCurrentHP(spell.target) > AADmg(spell.target) then
					if GetPercentMP(myHero) >= mainMenu.JungleClear.JCMM:Value() then
						CastSkillShot(_Q, GetMousePos())
					end
				end
			end
		end
	end
end)

OnCreateObj(function(object)
	if object.isSpell and object.spellName:lower():find("crystallize") and object.spellOwner.team == GetTeam(myHero) then
		AniviaWall = object
	end
	
	if object.isSpell and object.spellName:lower():find("trundlewall") and object.spellOwner.team == GetTeam(myHero) then
		TrundlePillar = object
	end
	
	if object.isSpell and object.spellName:lower():find("visionward") and object.spellOwner.team == 300 - GetTeam(myHero) then
		Pink = object
	end
end)

OnDeleteObj(function(object)
	if object.isSpell and object.spellName:lower():find("crystallize") and object.spellOwner.team == GetTeam(myHero) then
        AniviaWall = nil
	end
	
	if object.isSpell and object.spellName:lower():find("trundlewall") and object.spellOwner.team == GetTeam(myHero) then
		TrundlePillar = nil
	end
	
	if object.isSpell and object.spellName:lower():find("visionward") and object.spellOwner.team == 300 - GetTeam(myHero) then
		Pink = nil
	end
end)	

OnAnimation(function(unit, animation)
	if unit.isMe and animation:lower():find("spell1") then
		if mainMenu.Misc.QAC:Value() then
			CastEmote(EMOTE_DANCE)
			ResetAA()
		end		
	end	
end)	

OnProcessSpell(function(unit, spell)
	if unit.isMe and spell.name:lower():find("vaynecondemn") and spell.target.isHero and blah then
		if ZZRot > 0 then
			if Ready(ZZRot) and IsObjectAlive(spell.target) then
				CastSkillShot(ZZRot, ZSpot)
			end	
		end
	end
	
	if unit.isMe and spell.name:lower():find("vaynecondemn") and spell.target.isHero and blahblah == true and blahblah2 == false and blahblah3 == false and blahblah4 == false then
		CastSkillShot(flash, FFPos)
	end
	
	if unit.isMe and spell.name:lower():find("vaynecondemn") and spell.target.isHero and blahblah2 == true and blahblah3 == false and blahblah4 == false and blahblah == false then
		CastSkillShot(flash, FFPos2)
	end
	
	if unit.isMe and spell.name:lower():find("vaynecondemn") and spell.target.isHero and blahblah3 == true and blahblah4 == false and blahblah == false and blahblah2 == false then
		CastSkillShot(flash, FFPos3)
	end
	
	if unit.isMe and spell.name:lower():find("vaynecondemn") and spell.target.isHero and blahblah4 == true and blahblah == false and blahblah2 == false and blahblah3 == false then
		CastSkillShot(flash, FFPos4)
	end
end)	

OnLoad(function()
	ChallengerCommon.Interrupter(mainMenu.Interrupter, function(unit, spell)
		if unit.team == MINION_ENEMY and Ready(_E) and GetDistance(myHero, unit) <= ERange then
			CastTargetSpell(unit, _E)
		end
	end)
	
	ChallengerCommon.AntiGapcloser(mainMenu.AntiGapCloser, function(unit, spell)
		if unit.team == MINION_ENEMY and Ready(_E) and GetDistance(myHero, unit) <= ERange then
			CastTargetSpell(unit, _E)
		end	
	end)
end)	

print("Thanks For Using Eternal Vayne, Have Fun " ..myHero.name.. " :)")	
