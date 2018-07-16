if GetObjectName(GetMyHero()) ~= "Trundle" then return end
	
local ver = "0.02"

require("DamageLib")
require("OpenPredict")
require("ChallengerCommon")

local mainMenu = Menu("Trundle", "Trundle")
mainMenu:SubMenu("Combo", "Combo")
mainMenu.Combo:Boolean("CQ", "Use Q", true)
mainMenu.Combo:Boolean("CW", "Use W", true)		
mainMenu.Combo:Boolean("CE", "Use E", true)
mainMenu.Combo:Boolean("CR", "Use R", true)
mainMenu.Combo:Slider("CRC", "Min HP To Use R",80,1,100,1)
mainMenu.Combo:Slider("CRTC", "Min Target HP To Use R",60,1,100,1)
mainMenu.Combo:Slider("CC", "Min Mana To Combo",60,1,100,1)
mainMenu.Combo:Boolean("CTH", "Use T Hydra", true)
mainMenu.Combo:Boolean("CRH", "Use R Hydra", true)

mainMenu:SubMenu("Harass", "Harass")
mainMenu.Harass:Boolean("HQ", "Use Q", true)
mainMenu.Harass:Boolean("HW", "Use W", true)
mainMenu.Harass:Boolean("HE", "Use E", true)
mainMenu.Harass:Slider("HC", "Min Mana To Harass",60,1,100,1)
mainMenu.Harass:Boolean("HTH", "Use T Hydra", true)
mainMenu.Harass:Boolean("HRH", "Use R Hydra", true)

mainMenu:SubMenu("LaneClear", "LaneClear")
mainMenu.LaneClear:Boolean("LCQ", "Use Q", true)
mainMenu.LaneClear:Boolean("LCW", "Use W", true)
mainMenu.LaneClear:Slider("LCC", "Min Mana To LaneClear",60,1,100,1)
mainMenu.LaneClear:Boolean("LCTH", "Use T Hydra", true)
mainMenu.LaneClear:Boolean("LCRH", "Use R Hydra", true)

mainMenu:SubMenu("JungleClear", "JungleClear")
mainMenu.JungleClear:Boolean("JCQ", "Use Q", true)
mainMenu.JungleClear:Boolean("JCW", "Use W", true)
mainMenu.JungleClear:Slider("JCC", "Min Mana To JungleClear",60,1,100,1)
mainMenu.JungleClear:Boolean("JCTH", "Use T Hydra", true)
mainMenu.JungleClear:Boolean("JCRH", "Use R Hydra", true)

mainMenu:SubMenu("Misc", "Misc")
mainMenu.Misc:Boolean("AutoLevel", "AutoLevel", false)
mainMenu.Misc:Boolean("AR", "Auto R On X HP", true)
mainMenu.Misc:Slider("ARC", "Min HP To Auto R",20,1,100,1)

mainMenu:SubMenu("AntiGapCloser", "AntiGapCloser")
mainMenu:SubMenu("Interrupter", "Interrupter")

mainMenu:SubMenu("Gapclose", "Gapclose")
mainMenu.Gapclose:Boolean("GCW", "Use W", true)
mainMenu.Gapclose:Boolean("GCE", "Use E", true)

local target = GetCurrentTarget
local Move = { delay = 0.5, speed = math.huge, width = 50, range = math.huge}
local EStats = { delay = 0.025, speed = math.huge, width = 225, range = 1000}	
local QDmg = nil
local nextAttack = 0
local AARange = 175 + GetHitBox(myHero)
local ERange = GetCastRange(myHero, _E) + GetHitBox(myHero)
local WRange = GetCastRange(myHero, _W) + GetHitBox(myHero)
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

	local target = GetCurrentTarget()
	local movePos = GetPrediction(target,Move).castPos
	QDmg = getdmg("Q",target,myHero,GetCastLevel(myHero, _Q))
	local TH = GetItemSlot(myHero, 3748)
	local T = GetItemSlot(myHero, 3077)
	local RH = GetItemSlot(myHero, 3074)

	if mainMenu.Misc.AutoLevel:Value() then
		spellorder = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}	
		if GetLevelPoints(myHero) > 0 then
			LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
		end
	end

	--Combo
	if Mode() == "Combo" then
	
		if mainMenu.Combo.CW:Value() and GetPercentMP(myHero) >= mainMenu.Combo.CC:Value() then
			if Ready(_W) and ValidTarget(target, 380) then
				CastSkillShot(_W, target)
			end	
		end	

		if mainMenu.Combo.CE:Value() and GetPercentMP(myHero) >= mainMenu.Combo.CC:Value() then
			if Ready(_E) and ValidTarget(target, 1000) and GetDistance(movePos) > GetDistance(target) then
				if GetDistance(myHero, target) >= 300 then
					local EPredE = GetCircularAOEPrediction(target, EStats)
					CastSkillShot(_E, EPredE.castPos)
				end
			end
		end
		
		if mainMenu.Combo.CR:Value() and GetPercentMP(myHero) >= mainMenu.Combo.CC:Value()then
			if Ready(_R) and ValidTarget(target, 400) and GetPercentHP(myHero) <= mainMenu.Combo.CRC:Value() and GetCurrentHP(target) >= mainMenu.Combo.CRTC:Value() then 
				CastTargetSpell(target, _R)
			end	
		end
	end	
	
	--Harass
	if Mode() == "Harass" then
	
		if mainMenu.Harass.HW:Value() and GetPercentMP(myHero) >= mainMenu.Harass.HC:Value() then
			if Ready(_W) and ValidTarget(target, 300) then
				CastSkillShot(_W, target)
			end	
		end	

		if mainMenu.Harass.HE:Value() and GetPercentMP(myHero) >= mainMenu.Harass.HC:Value() then
			if Ready(_E) and ValidTarget(target, 1000) and GetDistance(movePos) > GetDistance(target) then
				if GetDistance(myHero, target) >= 300 then
					local EPredE = GetCircularAOEPrediction(target, EStats)
					CastSkillShot(_E, EPredE.castPos)
				end
			end
		end
	end
	
	--LaneClear
	if Mode() == "LaneClear" then
		if GetPercentMP(myHero) >= mainMenu.LaneClear.LCC:Value() then
			if mainMenu.LaneClear.LCW:Value() and Ready(_W) and MinionsAround(myHero, 400, MINION_ENEMY) > 2 then
				CastSkillShot(_W, myHero)
			end	
		end
	end	

	--JungleClear
	if Mode() == "LaneClear" then
		if GetPercentMP(myHero) >= mainMenu.JungleClear.JCC:Value() then
			if mainMenu.JungleClear.JCW:Value() and Ready(_W) and MinionsAround(myHero, 300, MINION_JUNGLE) > 0 then
				CastSkillShot(_W, myHero)
			end
		end			
	
		if mainMenu.JungleClear.JCRH:Value() and RH > 0 and Ready(RH) then
			if MinionsAround(myHero, 400, MINION_JUNGLE) > 0 then
				if nextAttack < GetTickCount() then
					CastSpell(RH)
				end
			end		
		end
		
		if mainMenu.JungleClear.JCRH:Value() and T > 0 and Ready(T) then
			if MinionsAround(myHero, 400, MINION_JUNGLE) > 0 then
				if nextAttack < GetTickCount() then
					CastSpell(T)
				end
			end		
		end
	end
	
	--AutoR
	if mainMenu.Misc.AR:Value() and Ready(_R) and ValidTarget(target, 700) then
		if GetPercentHP(myHero) <= mainMenu.Misc.ARC:Value() then
			CastTargetSpell(target, _R)
		end
	end
	
	-- Gapclose
	if Mode() == "Combo" then	
		if mainMenu.Gapclose.GCW:Value() and Ready(_W) and ValidTarget(target, 1000) then
			if GetDistance(myHero, target) > 340 and GetDistance(myHero, target) < 1000 and GetDistance(movePos) > GetDistance(target) then
				CastSkillShot(_W, target)
			end	
		end
	
		if mainMenu.Gapclose.GCE:Value() and Ready(_E) and ValidTarget(target, 1000) then
			if GetDistance(myHero, target) > 360 and GetDistance(myHero, Target) < 800 and GetDistance(movePos) > GetDistance(target) then
				local EPredE = GetCircularAOEPrediction(target, EStats)
				CastSkillShot(_E, EPredE.castPos)
			end
		end		
	end	
end)

OnProcessSpellComplete(function(unit,spell)
	local target = GetCurrentTarget()
	local RH = GetItemSlot(myHero, 3074)
	local TH = GetItemSlot(myHero, 3748)
	local T = GetItemSlot(myHero, 3077)
	
	if mainMenu.Combo.CTH:Value() and unit.isMe and spell.name:lower():find("trundleq") and spell.target.isHero then
		if Mode() == "Combo" then
			local TH = GetItemSlot(myHero, 3748)
			if TH > 0 then 
				if Ready(TH) and GetCurrentHP(target) > CalcDamage(myHero, target, myHero.totalDamage + (GetMaxHP(myHero) / 10), 0) then
					CastSpell(TH)
					DelayAction(function()
						AttackUnit(spell.target)
					end, spell.windUpTime)
				end
			end
		end
	end
	
	if mainMenu.Combo.CTH:Value() and unit.isMe and spell.name:lower():find("attack") and spell.target.isHero and not Ready(_Q) then
		if Mode() == "Combo" then
			if TH > 0 then 
				if Ready(TH) and GetCurrentHP(target) > CalcDamage(myHero, target, myHero.totalDamage + (GetMaxHP(myHero) / 10), 0) then
					CastSpell(TH)
					DelayAction(function()
						AttackUnit(spell.target)
					end, spell.windUpTime)
				end
			end
		end
	end
	
	if mainMenu.Combo.CQ:Value() and unit.isMe and spell.name:lower():find("attack") and spell.target.isHero then
		if Mode() == "Combo" then
			if Ready(_Q) and GetCurrentHP(target) > QDmg then
				CastSpell(_Q)
				DelayAction(function()
					AttackUnit(spell.target)
				end, spell.windUpTime)
			end
		end
	end
	
	if mainMenu.Combo.CRH:Value() and unit.isMe and spell.name:lower():find("attack") and spell.target.isHero then
		if Mode() == "Combo" then
			if T > 0 then 
				if Ready(T) then
					CastSpell(T)
				end
			end
		end
	end	
	
	if mainMenu.Combo.CRH:Value() and unit.isMe and spell.name:lower():find("attack") and spell.target.isHero then
		if Mode() == "Combo" then
			if RH > 0 then 
				if Ready(RH) then
					CastSpell(RH)
				end
			end
		end
	end

	if mainMenu.LaneClear.LCQ:Value() and unit.isMe and spell.name:lower():find("attack") and spell.target.isMinion then
		if Mode() == "LaneClear" then
			if Ready(_Q) then
				CastSpell(_Q)
			end
		end	
	end
	
	if mainMenu.LaneClear.LCRH:Value() and unit.isMe and spell.name:lower():find("attack") and spell.target.isMinion then
		if Mode() == "LaneClear" then
			if RH > 0 then
				if Ready(RH) and MinionsAround(myHero, 400, MINION_ENEMY) > 1 then
					CastSpell(RH)
				end	
			end	
		end
	end
	
	if mainMenu.LaneClear.LCRH:Value() and unit.isMe and spell.name:lower():find("attack") and spell.target.isMinion and spell.target.team == 300 - GetTeam(myHero) then
		if Mode() == "LaneClear" then
			if T > 0 then
				if Ready(T) and MinionsAround(myHero, 400, MINION_ENEMY) > 1 then
					CastSpell(T)
				end
			end
		end
	end	
	
	if mainMenu.JungleClear.JCQ:Value() and unit.isMe and spell.name:lower():find("attack") and spell.target.team == 300 then
		if Mode() == "LaneClear" then
			if GetPercentMP(myHero) >= mainMenu.JungleClear.JCC:Value() and Ready(_Q) then
				CastSpell(_Q)
			end	
		end
	end

	if mainMenu.JungleClear.JCTH:Value() and unit.isMe and spell.name:lower():find("trundleq") and spell.target.team == 300 then
		if Mode() == "LaneClear" then
			if TH > 0 and Ready(TH) then
				CastSpell(TH)
			end
		end
	end		
end)	

OnProcessSpell(function(unit, spell)
	if unit.isMe and spell.name:lower():find("tiamatcleave") then
		ResetAA()
	end
end)	

OnProcessSpell(function(unit,spellProc)
	if unit.isMe and spellProc.name:lower():find("attack") and spellProc.target.isHero then
		nextAttack = GetTickCount() + spellProc.windUpTime * 1000
	end
end)	

OnLoad(function()
	ChallengerCommon.Interrupter(mainMenu.Interrupter, function(unit, spell)
		if unit.team == MINION_ENEMY and Ready(_E) and GetDistance(myHero, unit) <= ERange then
			CastSkillShot(_E, unit)
		end
	end)
	
	ChallengerCommon.AntiGapcloser(mainMenu.AntiGapCloser, function(unit, spell)
		if unit.team == MINION_ENEMY and Ready(_E) and GetDistance(myHero, unit) <= ERange then
			local IQPred = GetPrediction(unit, EStats)
			if IQPred.hitChance >= 0.1 then
				CastSkillShot(_E, IQPred.castPos)
			end	
		end	
	end)
end)
