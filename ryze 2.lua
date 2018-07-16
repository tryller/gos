if GetObjectName(GetMyHero()) ~= "Ryze" then return end

 ver = "0.9"

--MENU
 mainMenu = Menu('Ryze', 'Ryze')

mainMenu:SubMenu('Combo', 'Combo')
mainMenu.Combo:DropDown('ComboMode', 'Combo mode', 1, {'QEQW', 'QWQE', 'EQWQ'})
mainMenu.Combo:Boolean('Q', 'Use Q', true)
mainMenu.Combo:Boolean('W', 'Use W', true)
mainMenu.Combo:Boolean('E', 'Use E', true)

mainMenu:SubMenu('Killsteal', 'Killsteal')
mainMenu.Killsteal:Boolean('KQ', 'Killsteal with Q', true)
mainMenu.Killsteal:Boolean('KW', 'Killsteal with W', true)
mainMenu.Killsteal:Boolean('KE', 'Killsteal with E', true)

mainMenu:SubMenu('Farm', 'Farm')
mainMenu.Farm:Boolean('LH', 'Last hit minions AA', false)
mainMenu.Farm:Boolean('LHQ', 'Last hit Q small minions', false)
mainMenu.Farm:Boolean('LHBQ', 'Last hit Q big minions', false)
mainMenu.Farm:Slider('MQ', 'If mana % is higher than', 50, 10, 100, 5)
mainMenu.Farm:Boolean('LHW', 'Last hit W small minions', false)
mainMenu.Farm:Boolean('LHBW', 'Last hit W big minions', false)
mainMenu.Farm:Slider('MW', 'If mana % is higher than', 50, 10, 100, 5)

mainMenu:SubMenu('Misc', 'Misc')
mainMenu.Misc:Boolean('Ignite', 'Ignite if killable', true)
mainMenu.Misc:Boolean('Level', 'Auto level', false)
mainMenu.Misc:Boolean('JT', 'Enemy jungler tracker', true)
mainMenu.Misc:Boolean('AW', 'Auto W on gap close', true)
mainMenu.Misc:Boolean('Seraph', 'Seraph shield on low HP', true)
mainMenu.Misc:Boolean('Tear', 'Auto stack Tear', false)
mainMenu.Misc:SubMenu('Skin', 'Skin Changer')
mainMenu.Misc.Skin:Slider('SC', 'Select skin', 1, 1, 10)

--COMBO FUNCTIONS

	--SPELL FUNCTIONS
	function ComboQ()
		if mainMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, QRange) then
			if QPredTarget.HitChance == 1 then
				CastSkillShot(_Q, QPredTarget.PredPos)
			end
		end
	end

	function ComboW()
		if mainMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, WRange) then
			CastTargetSpell(target, _W)
		end
	end

	function ComboE()
		if mainMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, ERange) then
			CastTargetSpell(target, _E)
		end
	end

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


OnTick(function (myHero)

	--VARIABLES
	target = GetCurrentTarget()
	MaxMana = GetMaxMana(myHero)
	MaxHP = GetMaxHP(myHero)
	CurrentHP = GetCurrentHP(myHero)
	BaseAD = GetBaseDamage(myHero)
	BonusAD = GetBonusDmg(myHero)
	BonusAP = GetBonusAP(myHero)
	MeleeRange = 550
	QRange = 900
	WRange = 600
	ERange = 600
	QDmg = 35 + 25 * GetCastLevel(myHero, _Q) + BonusAP * 0.45 + MaxMana * 0.03
	WDmg = 60 + 20 * GetCastLevel(myHero, _W) + BonusAP * 0.2 + MaxMana * 0.01
	EDmg = 25 + 25 * GetCastLevel(myHero, _E) + BonusAP * 0.3 + MaxMana * 0.02
	QPredTarget = GetPredictionForPlayer(myHeroPos(), target, GetMoveSpeed(target), 1700, 250, 900, 50, false, true)
	BigMinionBlue = 'SRU_OrderMinionSiege'
	BigMinionRed = 'SRU_ChaosMinionSiege'
	SuperMinionBlue = 'SRU_OrderMinionSuper'
	SuperMinionRed = 'SRU_ChaosMinionSuper'

	--COMBO
	if Mode() == 'Combo' then

		--QEQW
		if mainMenu.Combo.ComboMode:Value() == 1 then
			ComboQ()
			ComboE()
			ComboQ()
			ComboW()
		end

		--QWQE
		if mainMenu.Combo.ComboMode:Value() == 2 then
			ComboQ()
			ComboW()
			ComboQ()
			ComboE()
		end

		--EQWQ
		if mainMenu.Combo.ComboMode:Value() == 3 then
			ComboE()
			ComboQ()
			ComboW()
			ComboQ()
		end

	else

		--LAST HIT BIG MINIONS W
		if mainMenu.Farm.LHBW:Value() then
			if GetCurrentMana(myHero) > GetMaxMana(myHero) * mainMenu.Farm.MW:Value() / 100 then
				if not UnderTurret(GetOrigin(myHero), enemyTurret) then
					if IsObjectAlive(myHero) then
						for _, minion in pairs(minionManager.objects) do
							if ValidTarget(minion, WRange) and GetCurrentHP(minion) < WDmg then

								if GetTeam(myHero) == 100 then

									if GetObjectName(minion) == SuperMinionRed then
										if Ready(_W) then
											CastTargetSpell(minion, _W)
										end
									end

									if GetObjectName(minion) == BigMinionRed then
										if Ready(_W) then
											CastTargetSpell(minion, _W)
										end
									end

								end

								if GetTeam(myHero) == 200 then

									if GetObjectName(minion) == SuperMinionBlue then
										if Ready(_W) then
											CastTargetSpell(minion, _W)
										end
									end

									if GetObjectName(minion) == BigMinionBlue then
										if Ready(_W) then
											CastTargetSpell(minion, _W)
										end
									end

								end

							end
						end
					end
				end
			end
		end

		--LAST HIT BIG MINIONS Q
		if mainMenu.Farm.LHBQ:Value() then
			if GetCurrentMana(myHero) > GetMaxMana(myHero) * mainMenu.Farm.MQ:Value() / 100 then
				if not UnderTurret(GetOrigin(myHero), enemyTurret) then
					if IsObjectAlive(myHero) then

						for _, minion in pairs(minionManager.objects) do

							if ValidTarget(minion, QRange) and GetCurrentHP(minion) < QDmg then
								if GetTeam(myHero) == 100 then

									if GetObjectName(minion) == SuperMinionRed then
										if Ready(_Q) then
											CastSkillShot(_Q, minion)
										end
									end

									if GetObjectName(minion) == BigMinionRed then
										if Ready(_Q) then
											CastSkillShot(_Q, minion)
										end
									end

								end

								if GetTeam(myHero) == 200 then

									if GetObjectName(minion) == SuperMinionBlue then
										if Ready(_Q) then
											CastSkillShot(_Q, minion)
										end
									end

									if GetObjectName(minion) == BigMinionBlue then
										if Ready(_Q) then
											CastSkillShot(_Q, minion)
										end
									end

								end

							end
						end

					end
				end
			end
		end

		--LAST HIT SMALL MINIONS W
		if mainMenu.Farm.LHW:Value() then
			if GetCurrentMana(myHero) > GetMaxMana(myHero) * mainMenu.Farm.MW:Value() / 100 then
				if not UnderTurret(GetOrigin(myHero), enemyTurret) then
					if IsObjectAlive(myHero) then
						for _, minion in pairs(minionManager.objects) do
							if GetObjectName(minion) ~= BigMinionBlue and GetObjectName(minion) ~= BigMinionRed and GetObjectName(minion) ~= SuperMinionBlue and GetObjectName(minion) ~= SuperMinionRed then
								if ValidTarget(minion, WRange) and GetCurrentHP(minion) < WDmg then
									if Ready(_W) then
										CastTargetSpell(minion, _W)
									end
								end
							end
						end
					end
				end
			end
		end

		--LAST HIT SMALL MINIONS Q
		if mainMenu.Farm.LHQ:Value() then
			if GetCurrentMana(myHero) > GetMaxMana(myHero) * mainMenu.Farm.MQ:Value() / 100 then
				if not UnderTurret(GetOrigin(myHero), enemyTurret) then
					if IsObjectAlive(myHero) then
						for _, minion in pairs(minionManager.objects) do
							if GetObjectName(minion) ~= BigMinionBlue and GetObjectName(minion) ~= BigMinionRed and GetObjectName(minion) ~= SuperMinionBlue and GetObjectName(minion) ~= SuperMinionRed then
								if ValidTarget(minion, QRange) and GetCurrentHP(minion) < QDmg then
									if Ready(_Q) then
										CastSkillShot(_Q, minion)
									end
								end
							end
						end
					end
				end
			end
		end

		--LAST HIT MINIONS AA
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

	--LANE CLEAR / JUNGLE CLEAR
	x = 0
	closestJungle = ClosestMinion(myHero, 300)
	closestMinion = ClosestMinion(myHero, 300 - GetTeam(myHero))
	if Mode() == 'LaneClear' then
		for _, minion in pairs(minionManager.objects) do
			if GotBuff(minion, 'RyzeE') > 0 then
				ResetAA()
				buffData = GetBuffData(minion, 'RyzeE')
				if buffData.Count > 0 then
					x = x + 1
				end
				if Ready(_E) and ValidTarget(minion, ERange) then
					CastTargetSpell(minion, _E)
				end
				if GetCurrentHP(minion) < (QDmg + QDmg * 0.4) then
					if Ready(_Q) and ValidTarget(minion, QRange) then
						CastSkillShot(_Q, minion)
					end
				end
				if x > 1 then
					if Ready(_W) and ValidTarget(minion, WRange) then
						if GetCurrentHP(minion) <= WDmg then
							CastTargetSpell(minion, _W)
						end
					end
				end
			else
				if Ready(_E) and ValidTarget(minion, ERange) and GetCurrentHP(minion) <= EDmg then
					CastTargetSpell(minion, _E)
				elseif Ready(_E) and ValidTarget(closestMinion, ERange) then
					CastTargetSpell(closestMinion, _E)
				elseif Ready(_E) and ValidTarget(closestJungle, ERange) then
					CastTargetSpell(closestJungle, _E)
				end
			end
		end
	end

	--KILLSTEAL
	for _, enemy in pairs(GetEnemyHeroes()) do

		 QPredEnemy = GetPredictionForPlayer(myHeroPos(), enemy, GetMoveSpeed(enemy), 1700, 250, 900, 50, true, true)
		
		if mainMenu.Killsteal.KQ:Value() and Ready(_Q) and ValidTarget(enemy, QRange) then
			if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, QDmg) then
				if QPredEnemy.HitChance == 1 then
					CastSkillShot(_Q, QPredEnemy.PredPos)
				end
			end
		end

		if mainMenu.Killsteal.KW:Value() and Ready(_W) and ValidTarget(enemy, WRange) then
			if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, WDmg) then
				CastTargetSpell(enemy, _W)
			end
		end

		if mainMenu.Killsteal.KE:Value() and Ready(_E) and ValidTarget(enemy, ERange) then
			if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, EDmg) then
				CastTargetSpell(enemy, _E)
			end
		end

	end

	--AUTO IGNITE
	for _, enemy in pairs(GetEnemyHeroes()) do
		
		if GetCastName(myHero, SUMMONER_1) == 'SummonerDot' then
			 Ignite = SUMMONER_1
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end

		elseif GetCastName(myHero, SUMMONER_2) == 'SummonerDot' then
			 Ignite = SUMMONER_2
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end
		end

	end

	--AUTO LEVEL
	if mainMenu.Misc.Level:Value() then
		spellorder = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _Q, _E, _E}
		if GetLevelPoints(myHero) > 0 then
			LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
		end
	end

	--AUTO W ON GAP CLOSER
	if mainMenu.Misc.AW:Value() then
		if IsObjectAlive(myHero) then
			for _, enemy in pairs(GetEnemyHeroes()) do
				if IsObjectAlive(enemy) then
					if Ready(_W) then
						if GetDistance(myHero, enemy) < 200 then
							CastTargetSpell(enemy, _W)
						end
					end
				end
			end
		end
	end

	--SERAPH'S EMBRACE SHIELD
	if mainMenu.Misc.Seraph:Value() then
		if IsObjectAlive(myHero) then
			for _, enemy in pairs(GetEnemyHeroes()) do
				if GetDistance(myHero, enemy) < 605 then
					if CurrentHP < MaxHP * 0.20 then
						if GetItemSlot(myHero, 3040) > 0 then
							CastSpell(GetItemSlot(myHero, 3040))
						end
					end
				end

				if UnderTurret(myHero, enemyTurret) then
					if CurrentHP < MaxHP * 0.20 then
						if GetItemSlot(myHero, 3040) > 0 then
							CastSpell(GetItemSlot(myHero, 3040))
						end
					end
				end
			end
		end
	end

	--TEAR OF THE GODESS STACKING
	if mainMenu.Misc.Tear:Value() then
		if IsObjectAlive(myHero) then
			for _, enemy in pairs(GetEnemyHeroes()) do
				if GetDistance(myHero, enemy) > 3000 then
					if not UnderTurret(myHero, enemyTurret) then
						if GetItemSlot(myHero, 3070) > 0 then
							if Ready(_Q) then
								CastSkillShot(_Q, GetOrigin(myHero))
							end
						end
					end
				end
			end
		end
	end

end)