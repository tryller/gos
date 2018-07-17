if GetObjectName(myHero) ~= "Malzahar" then return end

require "Inspired"

local ver = "0.05"

-- Menu
mainMenu = Menu("Malzahar", "Malzahar")
-- mainMenu Combo Menu
mainMenu:SubMenu("Combo", "Combo")
mainMenu.Combo:Boolean("Q", "Use Q", true)
mainMenu.Combo:Boolean("W", "Use W", true)
mainMenu.Combo:Boolean("E", "Use E", true)
mainMenu.Combo:Boolean("R", "Use R", true)
mainMenu.Combo:Boolean("KO", "Only Combo if Kileable", false)
-- Harass Menu
mainMenu:SubMenu("Harass", "Harass")
mainMenu.Harass:SubMenu("HMode","Mode")
mainMenu.Harass.HMode:Boolean("QandE","Q and E",true)
mainMenu.Harass.HMode:Boolean("E", "Use E", false)

-- Misc
mainMenu:SubMenu("Misc", "Misc")
mainMenu.Misc:Boolean("MControl", "Mana Control", false)
-- Killsteal
mainMenu:SubMenu("KS", "Killsteal")
mainMenu.KS:Boolean("Q", "Use Q", true)
mainMenu.KS:Boolean("E", "Use E", true)


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

OnTick (function()
if isCastingR == true then return end
	Killsteal()
	if Mode() == "Combo" then
		Combo()
	end
	if Mode() == "Harass" then
		if mainMenu.Harass.HMode.QandE:Value() then
			QE()
		else
			E()
		end
	end
end)

OnUpdateBuff (function(unit, buff)
	if not unit or not buff then
		return
	end
	if buff.Name == "AlZaharNetherGrasp" then
		print("R Casting spells and movements blocked!")
		BlockOrder()
		BlockCast()
		--IOW.movementEnabled = false
		--IOW.attacksEnabled = false
		--BlockF7OrbWalk(true)
		--BlockF7Dodge(true)
      	isCastingR = true
    end
end)

OnRemoveBuff (function(unit, buff)
	if not unit or not buff then
		return
	end
	if buff.Name == "AlZaharNetherGrasp" then
		print("R Casting spells and movements unblocked!")
		--IOW.movementEnabled = true
		--IOW.attacksEnabled = true
		--BlockF7OrbWalk(false)
		--BlockF7Dodge(false)
      	isCastingR = false
    end
end)

function Combo()
	local unit = GetCurrentTarget()
	local dmg = 0
	if CanUseSpell(myHero, _Q) == READY then
	 dmg = dmg + CalcDamage(myHero, unit, 0, (55*GetCastLevel(myHero,_Q)+25+0.8*GetBonusAP(myHero)))
	end
	if CanUseSpell(myHero, _W) == READY then
	 dmg = dmg + CalcDamage(myHero, unit, 0, (3+1*GetCastLevel(myHero, _W)+0.1*GetBonusAP(myHero)*GetMaxHP(unit)/100))
	end
	if CanUseSpell(myHero, _E) == READY then
	 dmg = dmg + CalcDamage(myHero, unit, 0, (60*GetCastLevel(myHero,_E)+20+.8*GetBonusAP(myHero)))
	end
	if CanUseSpell(myHero, _R) == READY then
	 dmg = dmg + CalcDamage(myHero, unit, 0, (150*GetCastLevel(myHero, _R)+100+1.3*GetBonusAP(myHero)))
	end
	if mainMenu.Misc.MControl:Value() and GetCurrentMana(myHero) >= qcost + wcost + ecost + rcost or mainMenu.Misc.MControl:Value() == false then
		if mainMenu.Combo.KO:Value() and dmg > GetCurrentHP(unit) or mainMenu.Combo.KO:Value() == false then
			if mainMenu.Combo.E:Value() then
				if CanUseSpell(myHero, _E) == READY and ValidTarget(unit, GetCastRange(myHero,_E)) then
						CastTargetSpell(unit, _E)
				end
			end
			if CanUseSpell(myHero, _Q) == READY and mainMenu.Combo.Q:Value() then
-- GetPredictionForPlayer(startPosition, targetUnit, targetUnitMoveSpeed, spellTravelSpeed, spellDelay, spellRange, spellWidth, collision, addHitBox)-- GetPredictionForPlayer(startPosition, targetUnit, targetUnitMoveSpeed, spellTravelSpeed, spellDelay, spellRange, spellWidth, collision, addHitBox)
				local QPred = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),math.huge,1000,GetCastRange(myHero, _Q),85,false,true)
				if ValidTarget(unit, GetCastRange(myHero,_Q)) and QPred.HitChance == 1 then
					CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
				end
			end
			if CanUseSpell(myHero, _W) == READY and mainMenu.Combo.W:Value() then
				local WPred = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),math.huge,1000,GetCastRange(myHero, _W),250,false,true)
				if ValidTarget(unit, GetCastRange(myHero,_W)) and WPred.HitChance == 1 then
					CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
				end
			end
			if mainMenu.Combo.R:Value() then
				if GetCastRange(myHero, _R) and CanUseSpell(myHero, _Q) ~= READY and CanUseSpell(myHero, _W) ~= READY and CanUseSpell(myHero, _E) ~= READY and CanUseSpell(myHero, _R) ~= ONCOOLDOWN and ValidTarget(unit, GetCastRange(myHero,_R)) then
					CastTargetSpell(unit, _R)
				end
			end

		elseif mainMenu.Combo.KO:Value() ~= false then
			if mainMenu.Combo.E:Value() then
				if CanUseSpell(myHero, _E) == READY and ValidTarget(unit, GetCastRange(myHero,_E)) then
					CastTargetSpell(unit, _E)
				end
			end
			if CanUseSpell(myHero, _Q) == READY and mainMenu.Combo.Q:Value() then
				local QPred = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),math.huge,1000,GetCastRange(myHero, _Q),85,false,true)
				if ValidTarget(unit, GetCastRange(myHero,_Q)) and QPred.HitChance == 1 then
					CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
				end
			end
		end
	end
	if Ignite then
		if CanUseSpell(myHero, Ignite) and 50 + (20  * GetLevel(myHero)) > GetCurrentHP(unit) then
			CastTargetSpell(unit, Ignite)
		end
	end
end

function QE()
if mainMenu.Harass.HMode.QandE:Value() then
	local unit = GetCurrentTarget()
	if Ready(_E) and ValidTarget(unit, GetCastRange(myHero, _E)) and not isCastingR then
		CastTargetSpell(unit, _E)
	end
	if Ready(_Q) and ValidTarget(unit, GetCastRange(myHero, _Q)) and not isCastingR then
		local QPred = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),math.huge,1000,GetCastRange(myHero, _Q),85,false,true)
		if QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
		end
	end
end
end

function E()
if mainMenu.Harass.HMode.E:Value() then
	local unit = GetCurrentTarget()
	if Ready(_E) and ValidTarget(unit, GetCastRange(myHero, _E)) and not isCastingR then
		CastTargetSpell(unit, _E)
	end
end
end

function Killsteal()
    for i,enemy in pairs(GetEnemyHeroes()) do
		local QPred = GetPredictionForPlayer(myHeroPos(),enemy,GetMoveSpeed(enemy),math.huge,1000,GetCastRange(myHero, _Q),85,false,true)
		local ExtraDmg = 0
		if GotBuff(myHero, "itemmagicshankcharge") > 99 then
			ExtraDmg = ExtraDmg + 0.1*GetBonusAP(myHero) + 100
		end
		if Ready(_Q) and not isCastingR and ValidTarget(enemy,GetCastRange(myHero,_Q)) and mainMenu.KS.Q:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 55*GetCastLevel(myHero,_Q)+25+0.8*GetBonusAP(myHero) + ExtraDmg) then
			if QPred.HitChance == 1 then
				CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		end
		if Ready(_E) and not isCastingR and ValidTarget(enemy,GetCastRange(myHero,_E)) and mainMenu.KS.E:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0, 60*GetCastLevel(myHero,_E)+20+.8*GetBonusAP(myHero) + ExtraDmg) then
			CastTargetSpell(enemy, _E)
		end
	end
end