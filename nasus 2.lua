if GetObjectName(GetMyHero()) ~= "Nasus" then return end


if GetCastName(myHero,SUMMONER_1):lower() == "summonerdot" then
	Ignite = SUMMONER_1
elseif GetCastName(myHero,SUMMONER_2):lower() == "summonerdot" then
	Ignite = SUMMONER_2
else
	print("Auto Ignite not available!")
end

local mainMenu = Menu("Nasus", "Nasus")

mainMenu:SubMenu("Combo", "Combo")
mainMenu.Combo:Boolean("Q", "Use Q in combo", true)
mainMenu.Combo:Boolean("W", "Use W in combo", true)
mainMenu.Combo:Boolean("E", "Use E in combo", true)

mainMenu:SubMenu("Killsteal", "Killsteal")
mainMenu.Killsteal:Boolean("KQ", "Killsteal with Q", true)
mainMenu.Killsteal:Boolean("KE", "Killsteal with E", true)

mainMenu:SubMenu("LaneClear", "Lane Clear")
mainMenu.LaneClear:Boolean("LQ", "Last hit minions with Q", true)
mainMenu.LaneClear:Boolean("LE", "Last hit minions with E", false)

mainMenu:SubMenu("Misc", "Misc")
mainMenu.Misc:Boolean("AR", "Auto R if HP < 25%", true)
mainMenu.Misc:Boolean("Ignite", "Ignite if killable", true)

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
	local MeleeRange = 125
	local BaseAD = GetBaseDamage(myHero)
	local BonusAD = GetBonusDmg(myHero)
	local BonusAP = GetBonusAP(myHero)
	local BuffData = GetBuffData(myHero, "NasusQStacks")
	local BuffStacks = BuffData.Stacks
	local QDmg = 10 + 20 * GetCastLevel(myHero, _Q) + BaseAD + BonusAD + BuffStacks
	local QRange = 500
	local WRange = 600
	local EDmg = 15 * GetCastLevel(myHero, _E) + BonusAP * 0.6
	local ERange = 650

	if Mode() == "Combo" then

		--Combo
		if mainMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, QRange) then
			CastSpell(_Q)
			AttackUnit(target)
		end

		if mainMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, ERange) then
			CastSkillShot(_E, target)
		end

		if mainMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, WRange) then
			CastTargetSpell(target, _W)
		end

	end

	--Killsteal
	for _, enemy in pairs(GetEnemyHeroes()) do
		if mainMenu.Killsteal.KQ:Value() and Ready(_Q) and ValidTarget(enemy, QRange) then
			if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, QDmg, 0) then
				if Ready(_W) then
					CastTargetSpell(enemy, _W)
				end
				CastSpell(_Q)
				AttackUnit(enemy)
			end
		end

		if mainMenu.Killsteal.KE:Value() and Ready(_E) and ValidTarget(enemy, ERange) then
			if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, EDmg) then
				CastSkillShot(_E, enemy)
			end
		end

		if mainMenu.Misc.Ignite:Value() and ValidTarget(enemy, 600) then
			if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
				CastTargetSpell(enemy, Ignite)
			end
		end
	end

	--Auto R
	if mainMenu.Misc.AR:Value() and Ready(_R) and GetDistance(myHero, ClosestEnemy()) < 750 then
		if CurrentHPHero < BaseHPHero * 0.25 then
			CastSpell(_R)
		end
	end

	--Auto Q on minions
	for _, minion in pairs(minionManager.objects) do
		if mainMenu.LaneClear.LQ:Value() and Ready(_Q) and ValidTarget(minion, QRange) and GetCurrentHP(minion) < QDmg then
			CastSpell(_Q)
			AttackUnit(minion)
		end

		if mainMenu.LaneClear.LE:Value() and Ready(_E) and ValidTarget(minion, ERange) and GetCurrentHP(minion) < EDmg then
			CastSkillShot(_E, GetOrigin(minion))
		end
	end
end)