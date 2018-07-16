if GetObjectName(GetMyHero()) ~= "KhaZix" then return end


require("OpenPredict")
local mainMenu = MenuConfig("KhaZix", "KhaZix") 
mainMenu:SubMenu("Combo", "Combo")
mainMenu.Combo:Boolean("Q", "Use Q", true)
mainMenu.Combo:Boolean("W", "Use W", true)
mainMenu.Combo:Boolean("E", "Use E", true)
mainMenu.Combo:Boolean("R", "Use R", true)
mainMenu.Combo:Boolean("KSQ", "Killsteal with Q", true) 
mainMenu.Combo:Boolean("KSW", "Killsteal with W", true)
mainMenu.Combo:Slider("RM", "R only when enemy more than", 3, 1, 5, 1)

local KhaZixW = {delay = .5, range = 1000, width = 250, speed = 828.5}
local KhaZixE = {delay = .5, range = 900, width = 300, speed = 1300}

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

OnTick(function () 
 local target = GetCurrentTarget()     
 if Mode() == "Combo" then
            if mainMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 375) then 
              CastTargetSpell(target , _Q)
            end
            if mainMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, 1000) then 
            local WPred = GetPrediction(target,KhaZixW)
                if WPred.hitChance > 0.2 and not WPred:mCollision(1) then 
     CastSkillShot(_W,WPred.castPos)
                end
            end 
            if mainMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, 900) then
            local EPred = GetPrediction(target,KhaZixE)
                if EPred.hitChance > 0.2 then 
     CastSkillShot(_E,EPred.castPos)
                 end
            end
            if Ready(_R) and EnemiesAround(myHero, 200) >= mainMenu.Combo.RM:Value() and mainMenu.Combo.R:Value() then
              CastSpell(_R)
          end
      end
 
 for _, enemy in pairs(GetEnemyHeroes()) do
            if mainMenu.Combo.Q:Value() and mainMenu.Combo.KSQ:Value() and Ready(_Q) and ValidTarget(enemy, 375) then
				if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 45 + 25 * GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) * 1.2, 0) then
					CastTargetSpell(enemy , _Q)    
				end
			end
        if mainMenu.Combo.W:Value() and mainMenu.Combo.KSW:Value() and Ready(_W) and ValidTarget(enemy, 1000) then
            if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 80 + 30 * GetCastLevel(myHero,_W) + GetBonusDmg(myHero) * 1.0, 0) then
                CastSkillShot(enemy , _W)   				
          end
      end
   end 
end)
