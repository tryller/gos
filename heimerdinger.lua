if GetObjectName(GetMyHero()) ~= "Heimerdinger" then return end

require('Inspired')
require('IAC')
require('twgank')
myIAC = IAC()
local mainMenu = Menu("Heimerdinger", "Heimerdinger")
mainMenu:SubMenu("Combo", "Combo Settings")
mainMenu.Combo:Boolean("Q", "Use Q", true)
mainMenu.Combo:Boolean("W", "Use W", true)
mainMenu.Combo:Boolean("E", "Use E", true)
mainMenu.Combo:Boolean("R", "Use R", true)

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

OnTick(function()
	local myHero = GetMyHero()
	local myHeroPos = GetOrigin(myHero)
	local QRange = GetCastRange(myHero,_Q)
	local WRange = GetCastRange(myHero,_W)
	local ERange = GetCastRange(myHero,_E)
	local ERange = GetCastRange(myHero,_R)
	local target = GetCurrentTarget()
	local myAttackRange = GetRange(myHero)
	local tarAttackRange = GetRange(target)

	if Mode() == "Combo" then
		if mainMenu.Combo.Q:Value() and ValidTarget(target,QRange) and IsInDistance(myHero,QRange) then
			local QPred = GetPredictionForPlayer(myHeroPos, target,GetMoveSpeed(target),1400,250,QRange,55,true,true)
			if CanUseSpell(myHero,_Q) == READY then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		end

		if mainMenu.Combo.W:Value() and ValidTarget(target,WRange) and IsInDistance(myHero,WRange) then
			local WPred = GetPredictionForPlayer(myHeroPos, target,GetMoveSpeed(target),1400,250,WRange,55,true,true)
			if CanUseSpell(myHero,_Q) == READY then
				CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
			end
		end

		if mainMenu.Combo.E:Value() and ValidTarget(target,ERange) and IsInDistance(myHero,ERange) then
			local EPred = GetPredictionForPlayer(myHeroPos, target,GetMoveSpeed(target),1400,250,ERange,55,true,true)
			if CanUseSpell(myHero,_E) == READY then
				CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
			end
		end

		if mainMenu.Combo.R:Value() and ValidTarget(target,ERange) and IsInDistance(myHero,ERange) then
			if CanUseSpell(myHero,_R) == READY then
				CastSpell(_R)
			end
		end
	end
end)