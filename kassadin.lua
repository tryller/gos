if GetObjectName(GetMyHero()) ~= "Kassadin" then return end

require("OpenPredict")
local mainMenu = Menu("Kassadin", "Kassadin")
mainMenu:SubMenu("Combo", "Combo")
mainMenu:SubMenu("ksteal", "Killsteal")
mainMenu:SubMenu("SubReq", "["..myHero.charName.."] - AutoLevel Settings")
mainMenu.SubReq:Boolean("LevelUp", "Level Up Skills", true)
mainMenu.SubReq:Slider("Start_Level", "Level to enable lvlUP", 1, 1, 17)
mainMenu.SubReq:DropDown("autoLvl", "Skill order", 1, {"E-Q-W","Q-W-Q","Q-E-W",})
mainMenu.SubReq:Boolean("Humanizer", "Enable Level Up Humanizer", true)
mainMenu.Combo:Boolean("Q", "Use Q", true)
mainMenu.Combo:Boolean("W", "Use W", true)
mainMenu.Combo:Boolean("E", "Use E", true)
mainMenu.Combo:Boolean("R", "Use R", true)
mainMenu.Combo:Boolean("KSQ", "Killsteal with Q", true)
mainMenu.Combo:Boolean("KSE", "Killsteal with E", true)
mainMenu.Combo:Boolean("OnMana", "Combo if enough mana", true)
mainMenu.Combo:Slider("Rmana", "Choose mana to stop R", 800, 100, 2000)


local igniteFound = false
local summonerSpells = {ignite = {}, flash = {}, heal = {}, barrier = {}}
local KassadinE = {delay = 0.5, range = 700, width = 10, speed = math.huge}
local KassadinR = {delay = 0.5, range = 500, width = 150, speed = math.huge}   
local LevelUpTable={
			[1]={_Q,_W,_E,_E,_E,_R,_E,_Q,_E,_Q,_R,_Q,_Q,_W,_W,_R,_W,_W},

			[2]={_Q,_W,_E,_Q,_Q,_R,_Q,_E,_Q,_E,_R,_E,_E,_W,_W,_R,_W,_W},

			[3]={_Q,_E,_W,_Q,_Q,_R,_Q,_E,_Q,_E,_R,_E,_E,_W,_W,_R,_W,_W}
		}

	SpellRanges = 
	  {
	  [_Q] = {range = GetCastRange(myHero, 0)},
	  [_W] = {range = GetCastRange(myHero, 1)},
	  [_E] = {range = GetCastRange(myHero, 2)},
	  [_R] = {range = GetCastRange(myHero, 3)}
	  }
	  
OnLoad(function()
	if not igniteFound then
    	if GetCastName(myHero, SUMMONER_1):lower():find("summonerdot") then
      		igniteFound = true
      		summonerSpells.ignite = SUMMONER_1
      		mainMenu.ksteal:Boolean("ignite", "Auto Ignite", true)
    	elseif GetCastName(myHero, SUMMONER_2):lower():find("summonerdot") then
      		igniteFound = true
      		summonerSpells.ignite = SUMMONER_2
      		mainMenu.ksteal:Boolean("ignite", "Auto Ignite", true)
    	end
	end
end) 

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
	if mainMenu.SubReq.LevelUp:Value() and GetLevelPoints(myHero) >= 1 and GetLevel(myHero) >= mainMenu.SubReq.Start_Level:Value() then
	        if mainMenu.SubReq.Humanizer:Value() then
	            DelayAction(function() LevelSpell(LevelUpTable[mainMenu.SubReq.autoLvl:Value()][GetLevel(myHero)-GetLevelPoints(myHero)+1]) end, math.random(0.3286,1.33250))
	        else
	            LevelSpell(LevelUpTable[mainMenu.SubReq.autoLvl:Value()][GetLevel(myHero)-GetLevelPoints(myHero)+1])
	        end
	end

	Killsteal()

		local target = GetCurrentTarget()	
	if Mode() == "Combo" then
        
		if mainMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 650) then
			CastTargetSpell(target , _Q)
		end
		if mainMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, 150) then
			CastSpell(_W)
		end
		if mainMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, 700) then
		local EPred = GetPrediction(target,KassadinE)
			if EPred.hitChance > 0.2 then
				CastSkillShot(_E,EPred.castPos)
			end
		end

            if mainMenu.Combo.Rmana:Value() > GetCastMana(myHero, 3, GetCastLevel(myHero, 3)) then
		if mainMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target, 500) then
		local RPred = GetPrediction(target,KassadinR)
			if RPred.hitChance > 0.2 then
				CastSkillShot(_R,RPred.castPos)
			end
		end
            else return end
		for _, enemy in pairs(GetEnemyHeroes()) do 
			if mainMenu.Combo.Q:Value() and mainMenu.Combo.KSQ:Value() and Ready(_Q) and ValidTarget(enemy, 650) then 
				if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (45 + 25 * GetCastLevel(myHero,_Q) + GetBonusAP(myHero))) then 
					CastTargetSpell(target , _Q)
				end
			end
		end
		if mainMenu.Combo.E:Value() and mainMenu.Combo.KSE:Value() and Ready(_E) and ValidTarget(enemy, 700) then
                  if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (55 + 25 * GetCastLevel(myHero,_E) + GetBonusAP(myHero))) then
                    CastSkillShot(_E,EPred.castPos)
                  end
                end
              
	end	
end)

function Killsteal() 
	if igniteFound and mainMenu.ksteal.ignite:Value() and Ready(summonerSpells.ignite) then
    local iDamage = (50 + (20 * GetLevel(myHero)))
      	for _, enemy in pairs(GetEnemyHeroes()) do
        	if ValidTarget(enemy, 600) and (GetCurrentHP(enemy) + 5) <= iDamage then
          		CastTargetSpell(enemy, summonerSpells.ignite)
          	end
        end
	end
end
