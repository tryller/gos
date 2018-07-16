if GetObjectName(GetMyHero()) ~= "Amumu" then return end

require ("DamageLib")

-- Menu
local mainMenu = Menu("Beta's Amumu", "Beta's Amumu")
-- Combo
mainMenu:SubMenu("Combo", "Combo Settings")
mainMenu.Combo:Boolean("Q", "Use Q", true)
mainMenu.Combo:Boolean("W", "Use W", true)
mainMenu.Combo:Boolean("E", "Use E", true)
mainMenu.Combo:Boolean("R", "Use R", true)
mainMenu.Combo:Slider("Mana", "Min. Mana For W", 50, 0, 100, 1)
mainMenu.Combo:Slider("MR", "Min. Enemy For R", 2, 1, 5, 1)

-- Orbwalker's
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

-- Tick
OnTick(function()

	local target = GetCurrentTarget()
	if Mode() == "Combo" then
		-- Q
		if mainMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 1100) then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), 2000, 0.25, 1100, 30, true, true)
			if QPred.HitChance == 1 then	
				CastSkillShot(_Q, QPred.PredPos)
			end
		end	
			-- E
		if mainMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, 350) then	
        	CastTargetSpell(target , _E)
		end
		
		-- W
		if (myHero.mana/myHero.maxMana >= mainMenu.Combo.Mana:Value() /100) then
		
				if ValidTarget(target, 300) and Ready(_W)  then
			CastSpell(_W)
		        end
		end
		-- R
				if Ready(_R) and EnemiesAround(myHero, 560) >= mainMenu.Combo.MR:Value() and mainMenu.Combo.R:Value() then
			CastSpell(_R)
		        end
		
    end
end)