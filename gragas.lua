if GetObjectName(GetMyHero()) ~= "Gragas" then return end

require('DamageLib')

local mainMenu = Menu("Gragas", "Gragas")
mainMenu:SubMenu("Combo", "Combo")
mainMenu.Combo:Boolean("Q", "Use Q", true)
mainMenu.Combo:Boolean("W", "Use W", true)
mainMenu.Combo:Boolean("E", "Use E", true)
mainMenu.Combo:Boolean("R", "Use R", true)

mainMenu:Menu("Harass", "Harass")
mainMenu.Harass:Boolean("Q", "Use Q", true)
mainMenu.Harass:Boolean("E", "Use E", true)
mainMenu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

mainMenu:Menu("JungleClear", "JungleClear")
mainMenu.JungleClear:Boolean("Q", "Use Q", true)
mainMenu.JungleClear:Boolean("E", "Use E", true)
mainMenu.JungleClear:Boolean("W", "Use W", true)

mainMenu:Menu("Killsteal", "Killsteal")
mainMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)

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
	
OnTick(function (myHero)
	 
	local target = GetCurrentTarget()
	
	if Mode() == "Combo" then
		if mainMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, 550) then
			CastSpell(_W)
		end
			
		if mainMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target,850) then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), 1200, 132, 850, 100, false, true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q,QPred.PredPos)
			end
		end

		if mainMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target,1150) then
		
			local rpos = Vector(target) + Vector(target):normalized()*1250
			CastSkillShot(_R,rpos)
		end
			--local RPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), 1200, 132, 1150, 100, false, true)
			--if RPred.HitChance == 1 then
				--CastSkillShot(_R,RPred.PredPos)
			--end
		--end
		
		if mainMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target,600) then
			CastSkillShot(_E,GetOrigin(target))
		end	
	end

	if Mode() == "Harass" and GetPercentMP(myHero) >= mainMenu.Harass.Mana:Value() then
		if mainMenu.Harass.Q:Value() and Ready(_Q) and ValidTarget(target,850) then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), 1200, 132, 850, 100, false, true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q,QPred.PredPos)
			end
		end
		
		if mainMenu.Harass.E:Value() and Ready(_E) and ValidTarget(target,600) then
			CastSkillShot(_E,GetOrigin(target))
		end
	end
	
	for i,enemy in pairs(GetEnemyHeroes()) do

		if mainMenu.Killsteal.Q:Value() and Ready(_Q) and ValidTarget(enemy, 850) and GetCurrentHP(enemy)+GetDmgShield(enemy) < getdmg("Q",enemy ,myHero) then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), 1200, 132, 850, 100, false, true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q,QPred.PredPos)
			end
		end
		
	end
	
	for i,mobs in pairs(minionManager.objects) do
		if Mode() == "JungleClear" then
			if mainMenu.JungleClear.W:Value() and Ready(_W) and ValidTarget(mobs, 550) then
			CastSpell(_W)
			end
			
			if mainMenu.JungleClear.Q:Value() and Ready(_Q) and ValidTarget(mobs, 850) then
				CastSkillShot(_Q, mobs.pos)
			end
			
			if mainMenu.JungleClear.E:Value() and Ready(_E) and ValidTarget(mobs, 600) then
			CastSkillShot(_E, mobs.pos)
			end
		end
	end
	
end)
