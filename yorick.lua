if GetObjectName(GetMyHero()) ~= "Yorick" then return end

lasttick = 0

Table={_E,_Q,_W,_E,_E,_R,_E,_Q,_E,_Q,_R,_Q,_Q,_W,_W,_R,_W,_W}

local YorickMenu = MenuConfig("Yorick", "yorick")
YorickMenu:Menu("Combo", "Combo")
YorickMenu.Combo:Boolean("Q", "Use q", true)
YorickMenu.Combo:Boolean("W", "Use w", true)
YorickMenu.Combo:Boolean("E", "Use e", true)
YorickMenu.Combo:Boolean("R", "Use r", true)
YorickMenu.Combo:Slider("Rhp", "hp%", 20, 10, 90, 10)

YorickMenu:Menu("Stuff", "other stuff")
YorickMenu.Stuff:Boolean("items", "Use items", true)
YorickMenu.Stuff:Boolean("uselvl", "Use AutoLvl", true)
YorickMenu.Stuff:Slider("levelstart", "kill auto lvl till", 1, 1, 18, 1)

OnTick(function(myHero)
	local enemy = GetCurrentTarget()
	
	if GetPercentHP(myHero) <= YorickMenu.Combo.Rhp:Value() and YorickMenu.Combo.R:Value() and Ready(_R) and GetCastName(myHero, _R) ~= "yorickreviveallyguide" and EnemiesAround(GetOrigin(myHero), 1000)  then
		CastTargetSpell(myHero, _R)
	end
	local tick = GetTickCount()
	if GetCastName(myHero, _R) == "yorickreviveallyguide" and tick > lasttick  then
		CastTargetSpell(enemy, _R)
		lasttick = tick + math.random(1,3)
	end	
	if IOW:Mode() == "Combo" then
		if ValidTarget(enemy, GetCastRange(myHero, _E)) and Ready(_E) and YorickMenu.Combo.E:Value() then
			CastTargetSpell(enemy, _E)
		end	
		local Wpred = GetPredictionForPlayer(GetOrigin(myHero), enemy, GetMoveSpeed(enemy), math.huge, 50, GetCastRange(myHero, _W), 100, false, true)
		if ValidTarget(enemy, GetCastRange(myHero, _W)) and Ready(_W) and YorickMenu.Combo.W:Value() and Wpred.HitChance == 1 then
			CastSkillShot(_W, Wpred.PredPos)
		end
	end
	if YorickMenu.Stuff.uselvl:Value() and GetLevelPoints(myHero) >= 1 and GetLevel(myHero) >= YorickMenu.Stuff.levelstart:Value() then
		DelayAction(function() LevelSpell(Table[GetLevel(myHero)-GetLevelPoints(myHero)+1]) end, math.random(0.1,0.3))
	end
	if IOW:Mode() == "Combo" and YorickMenu.Stuff.items:Value()  then
		CastOffensiveItems(enemy)
	end
end)

OnProcessSpellComplete(function(unit, spell)
	if IOW:Mode() == "Combo" and YorickMenu.Combo.R:Value() and unit == myHero then
		if spell.name == "YorickBasicAttack" or spell.name == "YorickBasicAttack2" and EnemiesAround(GetOrigin(myHero), 500) then
			if Ready(_Q) and YorickMenu.c.Q:Value() then
				CastSpell(_Q)
			end
		end
	end
end )

print("spam :nod: for more features")
