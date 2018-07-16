if GetObjectName(GetMyHero()) ~= "Kindred" then return end

local ver = "0.04"

require ("OpenPredict")
require("MapPositionGOS")

--Menu
local mainMenu = Menu("Kindred", "Kindred")
mainMenu:SubMenu("Combo", "Combo")
mainMenu.Combo:Boolean("CQ", "Use Q", true)
mainMenu.Combo:Boolean("CW", "Use W", true)
mainMenu.Combo:Boolean("CE", "Use E", true)
mainMenu.Combo:Boolean("CR", "Use R", true)
mainMenu.Combo:Slider("CRC", "Min HP To R",10,0,100,1)
mainMenu.Combo:Slider("CMM", "Min Mana To Combo",25,0,100,1)
mainMenu.Combo:Boolean("Bilge", "Use Cutlass", true)
mainMenu.Combo:Boolean("BORK", "Use BORK", true)

mainMenu:SubMenu("Harass", "Harass")
mainMenu.Harass:Boolean("HQ", "Use Q", true)
mainMenu.Harass:Boolean("HW", "Use W", true)
mainMenu.Harass:Boolean("HE", "Use E", true)
mainMenu.Harass:Slider("HMM", "Min Mana To Harass",25,0,100,1)

mainMenu:SubMenu("LaneClear", "LaneClear")
mainMenu.LaneClear:Boolean("LCQ", "Use Q", true)
mainMenu.LaneClear:Boolean("LCW", "Use W", true)
mainMenu.LaneClear:Boolean("LCE", "Use E", true)
mainMenu.LaneClear:Slider("LCMM", "Min Mana To LaneClear",25,0,100,1)

mainMenu:SubMenu("JungleClear", "JungleClear")
mainMenu.JungleClear:Boolean("JCQ", "Use Q", true)
mainMenu.JungleClear:Boolean("JCW", "Use W", true)
mainMenu.JungleClear:Boolean("JCE", "Use E", true)
mainMenu.JungleClear:Slider("JCMM", "Min Mana To JungleClear",25,0,100,1)

mainMenu:SubMenu("KillSteal", "KillSteal")
mainMenu.KillSteal:Boolean("KSQ", "Use Q", true)

mainMenu:SubMenu("WJ", "WallJump")
mainMenu.WJ:Boolean("WJQ", "Use Q", true)
mainMenu.WJ:KeyBinding("WJ", "Wall Jump", string.byte("Z"))

mainMenu:SubMenu("GapClose", "GapClose")
mainMenu.GapClose:Boolean("GCQ", "Use Q", true)

mainMenu:SubMenu("Misc", "Misc")
mainMenu.Misc:DropDown("AutoLevel", "AutoLevel", 1, {"Off", "QEW", "QWE", "WQE", "WEQ", "EQW", "EWQ"})
mainMenu.Misc:Boolean("AR", "Auto R When Low", true)
mainMenu.Misc:Slider("ARC", "HP To Use R",10,0,100,1)
mainMenu.Misc:Boolean("ARA", "Auto R Save Allies", true)
mainMenu.Misc:Slider("ARAC", "Min Ally HP To Use R",10,0,100,1)
mainMenu.Misc:Boolean("QSS", "Use QSS", true)

mainMenu:SubMenu("AutoSmite", "Auto Smite")
mainMenu.AutoSmite:Boolean("ASG", "Smite Gromp", false)
mainMenu.AutoSmite:Boolean("ASB", "Smite Blue", true)
mainMenu.AutoSmite:Boolean("ASR", "Smite Red", false)
mainMenu.AutoSmite:Boolean("ASK", "Smite Big Krug", false)
mainMenu.AutoSmite:Boolean("ASD", "Smite Dragon", true)
mainMenu.AutoSmite:Boolean("ASBA", "Smite Baron", true)

local mark = 0
local target = GetCurrentTarget()
function QDmg(unit) return CalcDamage(myHero, unit, 35 + 20 * GetCastLevel(myHero, _Q) + (myHero.totalDamage * 0.2) + (5 * mark), 0) end
local Move = {delay = 0.5, speed = math.huge, width = 50, range = math.huge}
local nextAttack = 0
local CCType = {[5] = "Stun", [7] = "Silence", [8] = "Taunt", [9] = "Polymorph", [11] = "Snare", [21] = "Fear", [22] = "Charm", [24] = "Suppression"}
local QSS = nil
local MercSkimm = nil
local WRange = GetCastRange(myHero, _W) + GetHitBox(myHero)
local ERange = GetCastRange(myHero, _E) + GetHitBox(myHero)
local QRange = GetCastRange(myHero, _Q) + GetHitBox(myHero)
local RRange = GetCastRange(myHero, _R) + GetHitBox(myHero)

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

OnTick(function()

	target = GetCurrentTarget()
	local BORK = GetItemSlot(myHero, 3153)
	local Bilge = GetItemSlot(myHero, 3144)
	QSS = GetItemSlot(myHero, 3140)
	MercSkimm = GetItemSlot(myHero, 3139)
	local movePos = GetPrediction(target, Move).castPos
	mark = GetBuffData(myHero, "kindredmarkofthekindredstackcounter").Stacks
	QSS = GetItemSlot(myHero, 3140)
	MercSkimm = GetItemSlot(myHero, 3139)
	local smd = (({[1]=390,[2]=410,[3]=430,[4]=450,[5]=480,[6]=510,[7]=540,[8]=570,[9]=600,[10]=640,[11]=680,[12]=720,[13]=760,[14]=800,[15]=850,[16]=900,[17]=950,[18]=1000})[GetLevel(myHero)])
	
	--Auto Level
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
	
	--Combo
	if Mode() == "Combo" then
		
		if mainMenu.Combo.CW:Value() and Ready(_W) and ValidTarget(target, WRange) then
			if GetPercentMP(myHero) >= mainMenu.Combo.CMM:Value() then
				CastSpell(_W)
			end
		end

		if mainMenu.Combo.CE:Value() and Ready(_E) and ValidTarget(target, ERange) then
			if GetPercentMP(myHero) >= mainMenu.Combo.CMM:Value() then
				if GetTickCount() > nextAttack then
					CastTargetSpell(target, _E)
				end	
			end
		end

		if mainMenu.Combo.CR:Value() and Ready(_R) and GetCurrentHP(myHero) <= mainMenu.Combo.CRC:Value() then
			if EnemiesAround(myHero, 850) > 0 then
				CastSpell(_R)
			end
		end

		if mainMenu.Combo.BORK:Value() and Ready(BORK) and ValidTarget(target, 550) then
			if GetPercentHP(myHero) <= 90 and GetDistance(movePos) < GetDistance(target) then
				CastTargetSpell(target, BORK)
			end
		end
		
		if mainMenu.Combo.BORK:Value() and Ready(BORK) and ValidTarget(target, 550) then
			if GetPercentHP(myHero) <= 90 and GetDistance(movePos) > GetDistance(target) then
				CastTargetSpell(target, BORK)
			end
		end		

		if mainMenu.Combo.Bilge:Value() and Ready(Bilge) and ValidTarget(target, 550) then
			if GetPercentHP(myHero) <= 90 and GetDistance(movePos) > GetDistance(target) then
				CastTargetSpell(target, Bilge)
			end
		end

		if mainMenu.Combo.Bilge:Value() and Ready(Bilge) and ValidTarget(target, 550) then
			if GetPercentHP(myHero) <= 90 and GetDistance(movePos) < GetDistance(target) then
				CastTargetSpell(target, Bilge)
			end
		end
	end
	
	--Harass
	if Mode() == "Harass" then
	
		if mainMenu.Harass.HW:Value() and Ready(_W) and ValidTarget(target, WRange) then
			if GetPercentMP(myHero) >= mainMenu.Harass.HMM:Value() then
				CastSpell(_W)
			end
		end
		
		if mainMenu.Harass.HE:Value() and Ready(_E) and ValidTarget(target, ERange) then
			if GetPercentMP(myHero) >= mainMenu.Harass.HMM:Value() then
				if GetTickCount() > nextAttack then
					CastTargetSpell(target, _E)
				end	
			end
		end
	end

	--LaneClear	
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if mainMenu.LaneClear.LCW:Value() and Ready(_W) and ValidTarget(minion, WRange) then
					if GetPercentMP(myHero) >= mainMenu.LaneClear.LCMM:Value() then
						CastSpell(_W)
					end
				end
			
				if mainMenu.LaneClear.LCE:Value() and Ready(_E) and ValidTarget(minion, ERange) then
					if GetPercentMP(myHero) >= mainMenu.LaneClear.LCMM:Value() then
						CastTargetSpell(minion, _E)
					end	
				end
			end
	
	--JungleClear
			if GetTeam(minion) == MINION_JUNGLE and GetObjectName(minion):lower():find("sru") and not GetObjectName(minion):lower():find("mini") then
				if mainMenu.JungleClear.JCW:Value() and Ready(_W) and ValidTarget(minion, WRange) then
					if GetPercentMP(myHero) >= mainMenu.JungleClear.JCMM:Value() then
						CastSpell(_W)
					end
				end
		
				if mainMenu.JungleClear.JCE:Value() and Ready(_E) and ValidTarget(minion, ERange) then
					if GetPercentMP(myHero) >= mainMenu.JungleClear.JCMM:Value() then
						CastTargetSpell(minion, _E)
					end
				end	
			end
		end
	end		
	
	--KillSteal
	for _, enemy in pairs(GetEnemyHeroes()) do
		if mainMenu.KillSteal.KSQ:Value() and Ready(_Q) and ValidTarget(enemy, 840) then
			if GetCurrentHP(enemy) <= QDmg(enemy) then
				CastSkillShot(_Q, enemy)
			end
		end		
	end
	
	-- Auto R
	if mainMenu.Misc.AR:Value() and Ready(_R) and GetPercentHP(myHero) <= mainMenu.Misc.ARC:Value() then
		if EnemiesAround(myHero, 850) > 0 then
			CastSpell(_R)
		end
	end

	for _, ally in pairs(GetAllyHeroes()) do
		if mainMenu.Misc.ARA:Value() and Ready(_R) and ValidTarget(ally, RRange) and GetPercentHP(ally) <= mainMenu.Misc.ARAC:Value() then
			if EnemiesAround(ally, 800) > 0 then
				CastSpell(_R)
			end	
		end
	end

	--GapClose
	if mainMenu.GapClose.GCQ:Value() and Ready(_Q) and ValidTarget(target, 1000) and GetDistance(myHero, target) > 500 then
		if GetDistance(movePos) > GetDistance(target) then
			if Mode() == "Combo" or Mode() == "Harass" then
				CastSkillShot(_Q, target)
			end	
		end
	end

	--WallJump :/
	if mainMenu.WallJump.WJ:Value() then
		local jump1 = GetOrigin(myHero) + (Vector(mousePos) - GetOrigin(myHero)):normalized() * 75
		local jump2 =  GetOrigin(myHero) + (Vector(mousePos) - GetOrigin(myHero)):normalized() * 450
		if mainMenu.WallJump.WJQ:Value() then
			if not MapPosition:inWall(jump1) then
				MoveToXYZ(GetMousePos())
				else
				if not MapPosition:inWall(jump2) and Ready(_Q) then
					CastSkillShot(_Q, jump2)
				end
			end
		end	
	end

	-- Auto Smite
	for _, jung in pairs(minionManager.objects) do
		if GetCastName(myHero, SUMMONER_1):lower():find("summonersmite") then
			if mainMenu.AutoSmite.ASG:Value() and GetObjectName(jung):lower():find("sru_gromp") and Ready(SUMMONER_1) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_1)
			elseif mainMenu.AutoSmite.ASK:Value() and GetObjectName(jung):lower():find("sru_krug") and Ready(SUMMONER_1) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_1)
			elseif mainMenu.AutoSmite.ASD:Value() and GetObjectName(jung):lower():find("sru_dragon") and Ready(SUMMONER_1) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_1)
			elseif mainMenu.AutoSmite.ASB:Value() and GetObjectName(jung):lower():find("sru_blue") and Ready(SUMMONER_1) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_1)
			elseif mainMenu.AutoSmite.ASR:Value() and GetObjectName(jung):lower():find("sru_red") and Ready(SUMMONER_1) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_1)
			elseif mainMenu.AutoSmite.ASBA:Value() and GetObjectName(jung):lower():find("sru_baron") and Ready(SUMMONER_1) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_1)
			end
		end
		
		if GetCastName(myHero, SUMMONER_2):lower():find("summonersmite") then
			if mainMenu.AutoSmite.ASG:Value() and GetObjectName(jung):lower():find("sru_gromp") and Ready(SUMMONER_2) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_2)
			elseif mainMenu.AutoSmite.ASK:Value() and GetObjectName(jung):lower():find("sru_krug") and Ready(SUMMONER_2) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_2)
			elseif mainMenu.AutoSmite.ASD:Value() and GetObjectName(jung):lower():find("sru_dragon") and Ready(SUMMONER_2) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_2)
			elseif mainMenu.AutoSmite.ASB:Value() and GetObjectName(jung):lower():find("sru_blue") and Ready(SUMMONER_2) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_2)
			elseif mainMenu.AutoSmite.ASR:Value() and GetObjectName(jung):lower():find("sru_red") and Ready(SUMMONER_2) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_2)
			elseif mainMenu.AutoSmite.ASBA:Value() and GetObjectName(jung):lower():find("sru_baron") and Ready(SUMMONER_2) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_2)
			end
		end
	end	
end)

--Auto Attack Resets
OnProcessSpellComplete(function(unit, spell)
	if unit.isMe and spell.name:lower():find("attack") and spell.target.isHero then
		if Mode() == "Combo" then
			if mainMenu.Combo.CQ:Value() and Ready(_Q) and IsObjectAlive(spell.target) then
				CastSkillShot(_Q, GetMousePos())
			end
		end
	end

	if unit.isMe and spell.name:lower():find("attack") and spell.target.isHero then
		if Mode() == "Harass" then
			if mainMenu.Harass.HQ:Value() and Ready(_Q) and IsObjectAlive(spell.target) then
				CastSkillShot(_Q, GetMousePos())
			end
		end
	end

	if unit.isMe and spell.name:lower():find("attack") and spell.target.isMinion then
		if Mode() == "LaneClear" then
			if mainMenu.LaneClear.LCQ:Value() and Ready(_Q) and IsObjectAlive(spell.target) then
				CastSkillShot(_Q, GetMousePos())
			end
		end	
	end
end)

--Auto QSS
OnUpdateBuff(function(unit, buff)
	if unit.isMe and CCType[buff.Type] and mainMenu.Misc.QSS:Value() and QSS > 0 and Ready(QSS) then
		if GetPercentHP(myHero) <= 90 and EnemiesAround(myHero, 900) >= 1 then
			CastSpell(QSS)
		end	
	end
	
	if unit.isMe and CCType[buff.Type] and mainMenu.Misc.QSS:Value() and MercSkimm > 0 and Ready(MercSkimm) then
		if GetPercentHP(myHero) <= 90 and EnemiesAround(myHero, 900) >= 1 then
			CastSpell(MercSkimm)
		end
	end
end)

--Auto Attack Cancels
OnProcessSpell(function(unit, spell)
	if unit.isMe and spell.name:lower():find("attack") then
		nextAttack = GetTickCount() + spell.windUpTime * 1000
	end
	
--Animation Cancel	
	if unit.isMe and spell.name:lower():find("kindredq") then
		CastEmote(EMOTE_DANCE)
		ResetAA()
	end
end)	

print("Thanks For Using Eternal Kindred, Have Fun " ..myHero.name.. " :)")				
