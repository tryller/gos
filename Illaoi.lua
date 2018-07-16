
require("OpenPredict")
require("DamageLib")

	LevelUpTable={
			[1]={_Q,_W,_E,_W,_W,_R,_W,_Q,_W,_Q,_R,_Q,_Q,_W,_E,_R,_E,_E},

			[2]={_Q,_W,_Q,_E,_Q,_R,_Q,_E,_Q,_E,_R,_E,_E,_E,_E,_R,_W,_W},

			[3]={_Q,_E,_W,_Q,_Q,_R,_Q,_E,_Q,_E,_R,_E,_E,_W,_W,_R,_W,_W}
	}

	SpellRanges = 
	  {
	  [_Q] = {range = GetCastRange(myHero, 0)},
	  [_W] = {range = GetCastRange(myHero, 1)},
	  [_E] = {range = GetCastRange(myHero, 2)},
	  [_R] = {range = GetCastRange(myHero, 3)}
	  }

	Dmg = 
		{
		[0] = function(target, source) return getdmg("Q",GetCurrentTarget(), myHero, 3) end,
		[1] = function(target, source) return getdmg("W",GetCurrentTarget(), myHero, 3) end,
		[2] = function(target, source) return getdmg("E",GetCurrentTarget(), myHero, 3) end,
		[3] = function(target, source) return getdmg("R",GetCurrentTarget(), myHero, 3) end
	}

	turrets = {}
	IllaoiTentacles = {}
	Ignite = { name = "summonerdot", range = 600, slot = nil }
	local sAllies = GetAllyHeroes()
	function HealSlot()
		if GetCastName(myHero, SUMMONER_1):lower():find("summonerheal") then
			realheals = true
		end
		if GetCastName(myHero, SUMMONER_1):lower():find("summonerheal") then
			return SUMMONER_1
		elseif GetCastName(myHero, SUMMONER_2):lower():find("summonerheal")  then
			return SUMMONER_2
		end
	end

SummonerSlot = GetCastName(myHero, SUMMONER_1):lower() == "summonerboost" or GetCastName(myHero, SUMMONER_2):lower() == "summonerboost"
ignite = GetCastName(myHero, SUMMONER_1):lower() == "summonerdot" or GetCastName(myHero, SUMMONER_2):lower() == "summonerdot" or nil
heal = HealSlot()

local mainMenu = MenuConfig("Illaoi", "Illaoi")
mainMenu:Menu("Combo", "["..myHero.charName.."] - Combo Settings")
	mainMenu.Combo:KeyBinding("comboKey", "Combo Key", 32)
	mainMenu.Combo:Boolean("cYes", "Enable Combo", true)
	mainMenu.Combo:Boolean("rYes", "Use R in combo", true)
	mainMenu.Combo:Boolean("cTurret", "Use combo if enemy is underturret", true)
	mainMenu.Combo:Boolean("tyes", "Only combo if tentacles are in range", false)
	mainMenu.Combo:Slider("cEnemies", "Minimum enemies around to cast R", 1, 1, 5)
	mainMenu.Combo:Slider("cLife", "Minimum % of life to cast R", 50, 1, 100)
	PermaShow(mainMenu.Combo.tyes)

mainMenu:Menu("Harass", "["..myHero.charName.."] - Harass Settings")
	mainMenu.Harass:KeyBinding("harassKey", "Combo Key", string.byte("C"))
	mainMenu.Harass:Boolean("harassQ", "Use Q on Harass", true)
	mainMenu.Harass:Boolean("harassW", "Use W on Harass", true)
	mainMenu.Harass:Boolean("harassE", "Use E on Harass", false)

mainMenu:SubMenu("ks", "["..myHero.charName.."] - KillSteal Settings")
	mainMenu.ks:Boolean("killSteal", "Use Smart Kill Steal", true)
	mainMenu.ks:Boolean("autoIgnite", "Auto Ignite", true)

mainMenu:SubMenu("SubReq", "["..myHero.charName.."] - AutoLevel Settings")
    mainMenu.SubReq:Boolean("LevelUp", "Level Up Skills", true)
    mainMenu.SubReq:Slider("Start_Level", "Level to enable lvlUP", 1, 1, 17)
    mainMenu.SubReq:DropDown("autoLvl", "Skill order", 1, {"Q-W-E","Q-W-Q","Q-E-W",})
    mainMenu.SubReq:Boolean("Humanizer", "Enable Level Up Humanizer", true)

mainMenu:SubMenu("Awareness", "["..myHero.charName.."] - Awareness Settings")
    mainMenu.Awareness:Boolean("AwarenessON", "Enable Awareness", true)

if heal then
	mainMenu:SubMenu("heal", "["..myHero.charName.."] - Summoner Heal")
		mainMenu.heal:Boolean("enable", "Use Heal", true)
		mainMenu.heal:Slider("health", "If My Health % is Less Than", 10, 0, 100)
	if realheals then
		mainMenu.heal:Boolean("ally", "Also use on ally", false)
	end
end
if ignite then
	mainMenu:SubMenu("ignite", "["..myHero.charName.."] - Ignite Settings")
		mainMenu.ignite:DropDown("set", "Use Smart Ignite", 2, {"OFF", "Optimal", "Aggressive", "Very Aggressive"})	
end

	if GetCastName(myHero, SUMMONER_1):lower():find("summonerdot") then
			Ignite.slot = SUMMONER_1
		elseif GetCastName(myHero, SUMMONER_2):lower():find("summonerdot") then
			Ignite.slot = SUMMONER_2
		end

	function AutoSkillLevelUp()
		if GetLevel(myHero) ~= 18 then
			if mainMenu.SubReq.LevelUp:Value() and GetLevelPoints(myHero) >= 1 and GetLevel(myHero) >= mainMenu.SubReq.Start_Level:Value() then
		        if mainMenu.SubReq.Humanizer:Value() then
		            DelayAction(function() LevelSpell(LevelUpTable[mainMenu.SubReq.autoLvl:Value()][GetLevel(myHero)-GetLevelPoints(myHero)+1]) end, math.random(0.3286,1.33250))
		        else
		            LevelSpell(LevelUpTable[mainMenu.SubReq.autoLvl:Value()][GetLevel(myHero)-GetLevelPoints(myHero)+1])
		        end
		    end
		end
    end

	function findClosestAlly(obj)
	    local closestAlly = nil
	    local currentAlly = nil
		for i, currentAlly in pairs(sAllies) do
	        if currentAlly and not currentAlly.dead then
	            if closestAlly == nil then
	                closestAlly = currentAlly
				end
	            if GetDistanceSqr(currentAlly.pos, obj) < GetDistanceSqr(closestAlly.pos, obj) then
					closestAlly = currentAlly
	            end
	        end
	    end
		return closestAlly
	end

	function IgniteProperties(unit)
		if Ignite.ready and GetDistance(unit) < 600 then
			if mainMenu.ignite.set:Value() ~= 1 then 
				if mainMenu.ignite.set:Value() == 2 and KeyIsDown(mainMenu.Combo.comboKey:Key()) then
					if unit.health <= 50 + (20-0.03 * myHero.level) then
						CastTargetSpell(unit, Ignite.slot)
					end
				elseif mainMenu.ignite.set:Value() == 3 and KeyIsDown(mainMenu.Combo.comboKey:Key()) and GetPercentHP(unit) < 30 then
					CastTargetSpell(unit, Ignite.slot)
			    elseif  mainMenu.ignite.set:Value() == 4 and GetPercentHP(unit) < 70 then
			    	CastTargetSpell(unit, Ignite.slot)
			    end
			end
		end
	end

	function HealMeHealAlly()
		if heal then
			if ValidTarget(GetCurrentTarget(), 1000) then
				if Settings.heal.enable:Value() and CanUseSpell(myHero, heal) == READY then
					if GetLevel(myHero) > 5 and GetCurrentHP(myHero)/GetMaxHP(myHero) < Settings.heal.health:Value() /100 then
						CastSpell(heal)
					elseif  GetLevel(myHero) < 6 and GetCurrentHP(myHero)/GetMaxHP(myHero) < (Settings.heal.health:Value()/100)*.75 then
						CastSpell(heal)
					end
					
					if realheals and Settings.heal.ally:Value() then
						local ally = Teemo:findClosestAlly(myHero)
						if ally and not ally.dead and GetDistance(ally) < 850 then
							if  GetCurrentHP(ally)/GetMaxHP(ally) < Settings.heal.health:value()/100 then
								CastSpell(heal)
							end
						end
					end
				end
			end
		end
	end


	function CastQ(unit)
		if unit ~= nil and GetDistance(unit) <= GetCastRange(myHero, 0) and Ready(0) then
			local qPredInfo = { width = 170, delay = 0.75, speed = 3000, range = 850 }
			local qPred = GetPrediction(unit, qPredInfo)
			if qPred and qPred.hitChance >= 0.25 then
		    	CastSkillShot(0, qPred.castPos)
		    end
		end
	end

	function CastW(unit)
		if unit ~= nil and GetDistance(unit) <= GetCastRange(myHero, 1) and Ready(1) then
		    CastSpell(1)
		end
	end

	function CastE(unit)
		if unit ~= nil and GetDistance(unit) <= GetCastRange(myHero, 2) and Ready(2) then
			local ePredInfo = { width = 75, speed = 1600, range = 900, delay = 0.251 }
			local ePred = GetPrediction(unit, ePredInfo)
			if ePred and ePred.hitChance >= 0.15 and not ePred:mCollision(1) then
		    	CastSkillShot(2, ePred.castPos)
		    end
		end
	end

	function CastR(unit)
		if unit ~= nil and GetDistance(unit) <= GetCastRange(myHero, 3) and Ready(3) then
			CastSpell(3)
		end
	end

	function KillSteal()
		local target = GetCurrentTarget()
		for _, target in pairs(GetEnemyHeroes()) do
			if ValidTarget(target, 850) and target.visible then	
				if GetCurrentHP(GetCurrentTarget()) <= Dmg[0](target, myHero) then
					CastQ(target)
				elseif GetCurrentHP(GetCurrentTarget()) <= Dmg[1](target, myHero) then
					CastW(target)
				elseif GetCurrentHP(GetCurrentTarget()) <= Dmg[3](target, myHero) then
					CastR(target)
				elseif GetCurrentHP(GetCurrentTarget()) <= (Dmg[3](target, myHero) + Dmg[0](target, myHero)) then
					CastQ(target)
					CastR(target)
				end
				if mainMenu.ks.autoIgnite:Value() then
					IgniteProperties(target)
				end
			end
		end
	end

	function Harass(target)
		if mainMenu.Harass.harassQ:Value() then
			CastQ(target)
		end
		if mainMenu.Harass.harassW:Value() then
			CastW(target)
		end
		if mainMenu.Harass.harassE:Value() then
			CastE(target)
		end
	end

	OnCreateObj(function(Object)
		if GetObjectType(Object) == Obj_AI_Turret then
      			table.insert(turrets, Object)
    		end
    		if GetObjectName(Object) == "IllaoiMinion" then
    			table.insert(IllaoiTentacles, Object)
    		end
	end)

    OnObjectLoad(function(Object)
		if GetObjectType(Object) == Obj_AI_Turret then
      			table.insert(turrets, Object)
    		end
    		if GetObjectName(Object) == "IllaoiMinion" then
    			table.insert(IllaoiTentacles, Object)
    		end
    end)

    OnDeleteObj(function(Object)
    		if GetObjectType(Object) == Obj_AI_Turret then
	        	table.remove(turrets, 1)
	    	end
	    	if GetObjectName(Object) == "IllaoiMinion" then
    			table.remove(IllaoiTentacles, 1)
    		end
	end)

	OnTick(function(myHero)
		Ignite.ready = (Ignite.slot ~= nil and myHero:CanUseSpell(Ignite.slot) == READY)
		AutoSkillLevelUp()
		KillSteal()
		HealMeHealAlly()
		IgniteProperties(GetCurrentTarget())
		target = GetCurrentTarget()

		if KeyIsDown(mainMenu.Combo.comboKey:Key()) then
			if mainMenu.Combo.cYes:Value() then
				if not mainMenu.Combo.cTurret:Value() then
					for k,v in ipairs(turrets) do
						if GetDistance(target, v) < 1200 then
							if GetDistance(target) < 900 and GetDistance(target) > 450 then
								CastQ(target)
								DelayAction(function() 
									CastE(target)
								end, 0.0901)
							elseif GetDistance(target) < 450 then
								CastE(target)
								DelayAction(function() 
									CastQ(target)
										DelayAction(function()
											CastW(target)
										end, 0.10)
								end, 0.055)
								if GetLevel(myHero) > 6 and mainMenu.Combo.rYes:Value() then
									if Ready(3) and EnemiesAround(myHero, GetCastRange(myHero, 3)) >= mainMenu.Combo.cEnemies:Value() then
										for i,enemy in ipairs (GetEnemyHeroes()) do
											if not enemy.dead and GetPercentHP(enemy) < mainMenu.Combo.cLife:Value() then
												CastR(target)
											end
										end
									end
								end
							end 
						end
					end
				else
					if mainMenu.Combo.tyes:Value() then
						for i,v in ipairs(IllaoiTentacles) do
							if GetDistance(myHero, v) < 1200 then
								for k,v in ipairs(turrets) do
									if GetDistance(target, v) > 1200 then
										if GetDistance(target) < 900 and GetDistance(target) > 450 then
											CastQ(target)
											DelayAction(function()
												CastE(target)
											end, 0.0901)
										elseif GetDistance(target) < 450 then
											CastE(target)
											DelayAction(function()
												CastQ(target)
												DelayAction(function()
													CastW(target)
												end, 0.10)
											end, 0.055)
											if GetLevel(myHero) > 6 and mainMenu.Combo.rYes:Value() then
												if Ready(3) and EnemiesAround(myHero, GetCastRange(myHero, 3)) >= mainMenu.Combo.cEnemies:Value() then
													for i,enemy in ipairs (GetEnemyHeroes()) do
														if not enemy.dead and GetPercentHP(enemy) < mainMenu.Combo.cLife:Value() then
															CastR(target)
														end
													end
												end
											end
										end
									end
								end
							end
						end
					else
						for k,v in ipairs(turrets) do
							if GetDistance(target, v) > 1200 then
								if GetDistance(target) < 900 and GetDistance(target) > 450 then
									CastQ(target)
									DelayAction(function()
										CastE(target)
									end, 0.0901)
								elseif GetDistance(target) < 450 then
									CastE(target)
									DelayAction(function()
										CastQ(target)
											DelayAction(function()
												CastW(target)
											end, 0.10)
									end, 0.055)
									if GetLevel(myHero) > 6 and mainMenu.Combo.rYes:Value() then
										if Ready(3) and EnemiesAround(myHero, GetCastRange(myHero, 3)) >= mainMenu.Combo.cEnemies:Value() then
											for i,enemy in ipairs (GetEnemyHeroes()) do
												if not enemy.dead and GetPercentHP(enemy) < mainMenu.Combo.cLife:Value() then
													CastR(target)
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
		if KeyIsDown(mainMenu.Harass.harassKey:Key()) then
			Harass(target)
		end
	end)