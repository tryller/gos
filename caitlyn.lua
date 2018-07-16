if GetObjectName(GetMyHero()) ~= "Caitlyn" then return end

if not pcall( require, "Inspired" ) then PrintChat("You are missing Inspired.lua!") return end

mainMenu = MenuConfig("Caitlyn", "Caitlyn")

mainMenu:Menu("Combo", "Combo")
mainMenu.Combo:Boolean("Q", "Use Q", true)
mainMenu.Combo:Boolean("W", "Use W", true)
mainMenu.Combo:Boolean("E", "Use E", true)
mainMenu.Combo:Slider("Hp", "Hp to use E", 20, 0, 100, 1)

mainMenu:Menu("Harass", "Harass")
mainMenu.Harass:Boolean("Q", "Use Q", true)
mainMenu.Harass:Boolean("W", "Use W", true)

mainMenu:Menu("KS", "Killsteal")
mainMenu.KS:Boolean("R", "Ks with R", true)

OnUpdateBuff(function(unit, buff)
if mainMenu.Harass.W:Value() then
	if GetTeam(unit) ~= GetTeam(myHero) and GetObjectType(unit) == Obj_AI_Hero then
		if buff.Type == 11  and IsInDistance(unit, 825+GetHitBox(unit)) then
			snaredtarget = unit
			snared = true
			bufftimesnared = buff.ExpireTime
			if snared == true then
				DelayAction(function()
					snared = false
				end, (bufftimesnared - GetGameTimer())*1000)
			end
		end
		if buff.Type == 5  and IsInDistance(unit, 825+GetHitBox(unit)) then
			stunedtarget = unit
			stuned = true
			bufftimestuned = buff.ExpireTime
			if stuned == true then
				DelayAction(function()
					stuned = false
				end, (bufftimestuned - GetGameTimer())*1000)
			end
		end
		if buff.Type == 29  and IsInDistance(unit, 800+GetHitBox(unit)) then
			uptarget = unit
			up = true
			bufftimeup = buff.ExpireTime
			if up == true then
				DelayAction(function()
					up = false
				end, (bufftimeup - GetGameTimer())*1000)
			end
		end
		if buff.Type == 28  and IsInDistance(unit, 850+GetHitBox(unit)) then
			fleetarget = unit
			flee = true
			bufftimeflee = buff.ExpireTime
			if flee == true then
				DelayAction(function()
					flee = false
				end, (bufftimeflee - GetGameTimer())*1000)
			end
		end
		if buff.Type == 8  and IsInDistance(unit, 850+GetHitBox(unit)) then
			taunttarget = unit
			taunt = true
			bufftimetaunt = buff.ExpireTime
			if taunt == true then
				DelayAction(function()
					taunt = false
				end, (bufftimetaunt - GetGameTimer())*1000)
			end
		end
		if buff.Type == 22  and IsInDistance(unit, 825+GetHitBox(unit)) then
			charmtarget = unit
			charm = true
			bufftimecharm = buff.ExpireTime
			if charm == true then
				DelayAction(function()
					charm = false
				end, (bufftimecharm - GetGameTimer())*1000)
			end
		end
	end
end
end)

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

OnTick(function(myHero)
Killsteal()

	if Mode() == "Combo" then
local unit = GetCurrentTarget()
	if ValidTarget(unit, 2000) then

		if GotBuff(unit, "caitlynyordlletrapdebuff") then
			if ValidTarget(unit, GetRange(myHero)) then
			AttackUnit(unit)
			end
		end

		if mainMenu.Combo.Q:Value() then
			local QPred = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),2200,625,1250,90,false,false)
			if CanUseSpell(myHero,_Q) == READY and ValidTarget(unit, GetCastRange(myHero,_Q)) and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		end

		if mainMenu.Combo.W:Value() then
				local WPred = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),0,250,800,70,false,false)
				if CanUseSpell(myHero,_W) == READY and ValidTarget(unit, GetCastRange(myHero,_W)) and WPred.HitChance == 1 then
				CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
				end

		end

		if mainMenu.Combo.E:Value() then
			 local EPred = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),2000,250,950,80,false,false)
			if CanUseSpell(myHero, _E) == READY and ValidTarget(unit, GetCastRange(myHero,_E)) and (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 < mainMenu.Combo.Hp:Value() then
			CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
			end
		end

end
end
end)

OnTick(function(myHero)

	if Mode() == "Harass" then
local unit = GetCurrentTarget()
	if ValidTarget(unit, 2000) then
		if mainMenu.Harass.Q:Value() then
			local QPred = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),2200,625,1250,90,false,false)
			if CanUseSpell(myHero,_Q) == READY and ValidTarget(unit, GetCastRange(myHero,_Q)) and snared == true and QPred.HitChance == 1 then
			CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
			end
		end

		if mainMenu.Harass.W:Value() then
				local WPred = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),0,250,800,70,false,false)
				if CanUseSpell(myHero,_W) == READY and ValidTarget(unit, GetCastRange(myHero,_W)) and snared ~= true and WPred.HitChance == 1 then
				CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
				end
		end
	end
		end
end)


function Killsteal()
 for i,enemy in pairs(GetEnemyHeroes()) do
      -- GetPredictionForPlayer(startPosition, targetUnit, targetUnitMoveSpeed, spellTravelSpeed, spellDelay, spellRange, spellWidth, collision, addHitBox)
            if CanUseSpell(myHero, _R) == READY and ValidTarget(enemy,GetCastRange(myHero,_R)) and mainMenu.KS.R:Value() and GetCurrentHP(enemy)+GetMagicShield(enemy)+GetDmgShield(enemy) < CalcDamage(myHero, enemy, 0,  (225*GetCastLevel(myHero, _R)+25+2.0*GetBonusDmg(myHero))) then
    CastTargetSpell(enemy, _R)
            end
        end
end