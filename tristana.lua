if GetObjectName(GetMyHero()) ~= "Tristana" then return end

local mainMenu = Menu("Tristana", "BNN Tristana")

mainMenu:SubMenu("Combo", "Combo")
mainMenu.Combo:Boolean("Q", "Use Q in combo", true)
mainMenu.Combo:Boolean("W", "Use W in combo", true)
mainMenu.Combo:Boolean("E", "Use E in combo", true)

mainMenu:SubMenu("Killsteal", "Killsteal")
mainMenu.Killsteal:Boolean("KW", "Killsteal with W", true)
mainMenu.Killsteal:Boolean("KE", "Killsteal with E", true)
mainMenu.Killsteal:Boolean("KR", "Killsteal with R", true)

mainMenu:SubMenu("Farm", "Farm")
mainMenu.Farm:Boolean("LH", "Last hit minions", true)
mainMenu.Farm:Boolean("MC", "Last hit circle", true)

mainMenu:SubMenu("Misc", "Misc")
mainMenu.Misc:Boolean("Level", "Auto level spells", false)
mainMenu.Misc:Boolean("Ignite", "Auto Ignite if killable", true)

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

OnTick(function (myHero)

	local target = GetCurrentTarget()
	local BaseHPHero = GetMaxHP(myHero)
	local CurrentHPHero = GetCurrentHP(myHero)
	local BaseHPTarget = GetMaxHP(target)
	local CurrentHPTarget = GetCurrentHP(target)
	local MeleeRange = 543 + 7 * GetLevel(myHero)
	local BaseAD = GetBaseDamage(myHero)
	local BonusAD = GetBonusDmg(myHero)
	local BonusAP = GetBonusAP(myHero)
	local WRange = 900
	local ERange = 543 + 7 * GetLevel(myHero)
	local RRange = 543 + 7 * GetLevel(myHero)
	local WDmg = 10 + 50 * GetCastLevel(myHero, _W) + BonusAP * 0.5
	local EDmg = 50 + 10 * GetCastLevel(myHero, _E) + (((35 + 15 * GetCastLevel(myHero, _E)) / 100 * BonusAD) + 0.5 * BonusAP)
	local RDmg = 200 + 100 * GetCastLevel(myHero, _R) + BonusAP
	local WPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), 1100, 500, 900, 120, false, true)

	--AUTO LEVEL UP
	if mainMenu.Misc.Level:Value() then

		spellorder = {_E, _W, _Q, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
		if GetLevelPoints(myHero) > 0 then
			LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
		end

	end

	--COMBO
	if Mode() == "Combo" then

		if mainMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, ERange) then
			CastTargetSpell(target, _E)
		end

		if mainMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, MeleeRange) then
			CastSpell(_Q)
		end

		if mainMenu.Combo.W:Value() and Ready(_W) and GetDistance(myHero, target) < WRange and GetDistance(myHero, target) > RRange and EnemiesAround(target, 800) < 2 then
			if WPred.HitChance == 1 then
				CastSkillShot(_W, target)
			end
		end

	else

		--LAST HIT MINIONS
		if not UnderTurret(GetOrigin(myHero), enemyTurret) then
			if mainMenu.Farm.LH:Value() then
				for _, minion in pairs(minionManager.objects) do
					if ValidTarget(minion, MeleeRange) and GetCurrentHP(minion) < BaseAD + BonusAD then
						AttackUnit(minion)
					end
				end
			end
		end

	end

	--KILLSTEAL
	for _, enemy in pairs(GetEnemyHeroes()) do
		local WPredKillsteal = GetPredictionForPlayer(GetOrigin(myHero), enemy, GetMoveSpeed(target), 1100, 500, 900, 120, false, true)

		if mainMenu.Killsteal.KR:Value() and Ready(_R) and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, RDmg) and ValidTarget(enemy, RRange) then
			CastTargetSpell(enemy, _R)
		end

		if mainMenu.Killsteal.KE:Value() and Ready(_E) and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, EDmg, 0) and ValidTarget(enemy, ERange) then
			CastTargetSpell(enemy, _E)
		end

		if mainMenu.Killsteal.KW:Value() and Ready(_W) and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, WDmg) and ValidTarget(enemy, WRange - 15) then
			if WPredKillsteal.HitChance == 1 then
				CastSkillShot(_W, enemy)
			end
		end

	end

	--AUTO IGNITE
	if mainMenu.Misc.Ignite:Value() then

		for _, enemy in pairs(GetEnemyHeroes()) do
		
			if GetCastName(myHero, SUMMONER_1) == "SummonerDot" then
				local Ignite = SUMMONER_1
				if ValidTarget(enemy, 600) then
					if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
						CastTargetSpell(enemy, Ignite)
					end
				end

			elseif GetCastName(myHero, SUMMONER_2) == "SummonerDot" then
				local Ignite = SUMMONER_2
				if ValidTarget(enemy, 600) then
					if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
						CastTargetSpell(enemy, Ignite)
					end
				end
			end

		end

	end

end)