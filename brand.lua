if GetObjectName(myHero) ~= "Brand" then return end

local config = MenuConfig("Brand", "Brand")
config:Menu("Spells", "Spells")
config.Spells:Boolean("QStunOnly", "Only Q to stun?", false)
config.Spells:Boolean("KR", "R to kill only", true)
config.Spells:Boolean("AutoStun", "Auto Stun", true)
config.Spells:Slider("StunRange", "Max. Range", 300, 100, 650, 50)

config:Menu("KS", "Kill Steal")
config.KS:Boolean("KS", "Killsteal", true)
config.KS:Boolean("KSNotes", "KS Notes", true)
config.KS:Boolean("Percent", "Percent Notes", true)
config.KS:Boolean("Ignite","Auto-Ignite", true)
config.KS:Boolean("KSR", "Long Ulti", true)

ts = TargetSelector(myHero:GetSpellData(_W).range, TARGET_LOW_HP, DAMAGE_MAGIC, true)
config:TargetSelector("ts", "Target Selector", ts)

local Enemies = {}
local myHero = GetMyHero()
local GotBlazed = {}
local BlazeEndTime = {}
local LS, WCharge = nil, false
local WEndTime, range = 0, 0
local WPos = nil
local QRDY, WRDY, ERDY, RRDY, IRDY = 0, 0, 0, 0, 0
local QDmg, WDmg, EDmg, RDmg, AP, xIgnite = 0, 0, 0, 0, 0, 0

function GetSpellCD()
	QRDY = GetCastLevel(myHero, _Q) > 0 and CanUseSpell(myHero, _Q) == 0 and 1 or 0
	WRDY = GetCastLevel(myHero, _W) > 0 and CanUseSpell(myHero, _W) == 0 and 1 or 0
	ERDY = GetCastLevel(myHero, _E) > 0 and CanUseSpell(myHero, _E) == 0 and 1 or 0
	RRDY = GetCastLevel(myHero, _R) > 0 and CanUseSpell(myHero, _R) == 0 and 1 or 0
end

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

function GetItemCD()
	IRDY = Ignite and CanUseSpell(myHero, Ignite) == 0 and 1 
	or 0
end

function Round(val, decimal)
	return decimal and math.floor( (val * 10 ^ decimal) + 0.5) / (10 ^ decimal) 
	or math.floor(val + 0.5)
end

function Damage()
	AP = GetBonusAP(myHero)
	QDmg = GetCastLevel(myHero,_Q) * 40 + 40 + .65 * AP
	WDmg = GetCastLevel(myHero,_W) * 45 + 30 + .6 * AP
	EDmg = GetCastLevel(myHero,_E) * 35 + 35 + .55 * AP
	RDmg = GetCastLevel(myHero,_R) * 150 + .5 * AP
	xIgnite = (GetLevel(myHero) * 20 + 50) * IRDY
end

function Mana(mq,mw,me,mr)
	local Qmana = 50
	local Wmana = 10 * GetCastLevel(myHero, _W) + 60
	local Emana = 5 * GetCastLevel(myHero, _E) + 65
	local Rmana = 100
	return Qmana * mq + Wmana * mw + Emana * me + Rmana * mr < GetCurrentMana(myHero) and 1 or 0
end

function CountEnemyHeroInRange(object, range)
	object = object or myHero
	local eEnemies = {}
	for i = 0, #Enemies do
		local enemy = Enemies[i]
		if enemy and enemy ~= object and not IsDead(enemy) and GetDistance(object, enemy) <= range then
			table.insert(eEnemies, enemy)
		end
	end
	return #eEnemies
end

function CountEnemyMinionInRange(object, range)
	object = object or myHero
	local eMinions = {}
	for aMinion = 0, #minionManager.objects do
		if minionManager.objects[aMinion] and not IsDead(minionManager.objects[aMinion]) and  GetTeam(minionManager.objects[aMinion]) ~= GetTeam(myHero) and GetDistance(minionManager.objects[aMinion], object) < range then --all living Minions that are not friendly into a list
			table.insert(eMinions, minionManager.objects[aMinion])
		end
	end
	return #eMinions
end

function CountEnemyObjectsInRange(Object, range)
	Object = Object or myHero
	range = range or 99999
	local a = CountEnemyHeroInRange(Object, range)
	local b = CountEnemyMinionInRange(Object, range)
	return a + b
end

function resetVariables()
	GetItemCD()
	Damage()
	if GetTickCount() > WEndTime then
		WEndTime = 0
		WCharge = false
		WPos = nil
	end
	GetSpellCD()
	for i = 1, #Enemies do
		local Enemy = Enemies[i]
		if BlazeEndTime[GetNetworkID(Enemy)] and (BlazeEndTime[GetNetworkID(Enemy)] < GetTickCount() or IsDead(Enemy)) then
			BlazeEndTime[GetNetworkID(Enemy)] = nil
			GotBlazed[GetNetworkID(Enemy)] = nil
		end
	end
end

function QCanHit(unit)
	local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1532,250 + GetLatency(),1044,75,true,false)
	if QPred.PredPos and QPred.HitChance == 1 then
		return true
	else
		return false
	end
end

function WCanHit(unit)
	if unit then
		local WPred = GetPredictionForPlayer(GetOrigin(myHero), unit, GetMoveSpeed(unit), 99999, 900 + GetLatency(), 875, 187, false, true)
		if WPred.HitChance == 1 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function GetWCharge()
	local time = 0
	if WCharge then
		time = ((WEndTime - GetTickCount())) * .001
		return time
	end
end

function TravelTime(spell, unit, tick)
	local time = 99999
	local speed = 1
	local Distance = GetDistance(unit)
	local ping = GetLatency()
	local extra = tick and GetTickCount() or 0
	if spell == "Q" then
		speed = 1600
		time = Distance / speed + extra
		return time
	elseif spell == "W" then
		time = GetWCharge() + extra
		return time
	elseif spell == "E" then
		speed = Distance * 4
		time = Distance / speed + extra
		return time
	elseif spell == "R" then
		speed = Distance * 2
		time = Distance / speed + extra
		return time
	else
		return time
	end
end

function IsTargetedBySpell(unit)
	if WPos and GetDistance(unit, WPos) < 187 + GetHitBox(unit) then --means he is standing in range, now we need to know if he can escape
		local MS = GetMoveSpeed(unit)
		local reactionTime = 1000
		local PossibleWay = (WEndTime - GetTickCount() - reactionTime) * MS
		if PossibleWay < GetDistance(unit, WPos) + GetHitBox(unit) then --means he cant escape, mostly if CC'ed or standing
			return true, "W"
		elseif PossibleWay < GetDistance(unit, WPos) + GetHitBox(unit) + 500 then --means he cant escape if he is noob
			return true, "W"
		else
			return false, nil
		end
	end
end

function TimeTillBurnIncoming(unit)
	local time = 99999
	state, spell = IsTargetedBySpell(unit)
	if state then
		time = TravelTime(spell, unit)
	else
		time = 99999
	end
	return time
end

function IsIgnited(o)
	return GotBuff(o, "summonerdot") ~= 0 and 1 
	or 0
end

function IsOrWillBeIgnited(o)
	return IRDY == 1 and 1 
	or IsIgnited(o) == 1 and 1 
	or 0
end

function IsBurning(unit, spell)
	local spell = spell or nil
	if not spell and (GotBlazed[GetNetworkID(unit)] or 0) > 0 then --if enemy is burning and no spell is given return true
		return true
	elseif spell and (GotBlazed[GetNetworkID(unit)] or 0) > 0 and (BlazeEndTime[GetNetworkID(unit)] or 0) > TravelTime(spell, unit, tick) then --if enemy is burning and the traveltime of given spell is shorter then his Burning is over return true
		return true
	elseif spell and TimeTillBurnIncoming(unit) < TravelTime(spell, unit) then --if enemy is not burning but any burn spell makes him burn in time before given spell reaches return true
		return true
	else
		return false
	end
end

function GetRBounce(o)
	local Speed = o and GetMoveSpeed(o) or 0
	local NumEnemies = (math.min(CountEnemyObjectsInRange(o, 400 - Speed * .25), 99)) --example: around the target is no unit RBounce returns: 1, 2 units: 2
	if IsBurning(o) or IsBurning(o, "R") then --it focuses on heroes, so we need to look if enemy heroes are there
		local NumHeroes = CountEnemyHeroInRange(o, 400 - Speed * .25)
		if NumHeroes > 0 then --so there are enemy heroes we need to take into account
			return o and NumHeroes == 1 and 3 or o and NumHeroes == 2 and 2 or o and NumHeroes >= 3 and 1 or 1
		else --so it jumps on hero after each minion
			return o and NumEnemies >= 1 and 3 or 1
		end
	else
		return o and NumEnemies == 1 and 3 or o and NumEnemies == 2 and 2 or o and NumEnemies >= 3 and 1 or 1
	end
end

function doQ(o)
	if GetDistance(o) < 1044 then
		local QPred = GetPredictionForPlayer(GetOrigin(myHero), o ,GetMoveSpeed(o) ,1532, 250 + GetLatency(), 1044, 75, true, false)
		if QPred.HitChance == 1 then
			CastSkillShot(_Q, QPred.PredPos)
		end
	end
end

function doW(o)
	if GetDistance(o) < 875 then
    	local WPred = GetPredictionForPlayer(GetOrigin(myHero), o, GetMoveSpeed(o), 99999, 900 + GetLatency(), 875, 187, false, true)
		if WPred.HitChance == 1 then
			CastSkillShot(_W, WPred.PredPos)
    	end
  	end
end

function doE(o)
	if GetDistance(o) < 650 then
		CastTargetSpell(o, _E)
	end
end

function dooR(o)
	if GetDistance(o) < 750 then
		CastTargetSpell(o, _R)
	end
end

function doEW(o)
	local WPred = GetPredictionForPlayer(GetOrigin(myHero), o, GetMoveSpeed(o), 99999, 900 + GetLatency(), 875, 187, false, true)
	if WPred.HitChance == 1 and GetDistance(o) < 650 then
		CastTargetSpell(o, _E)
		CastSkillShot(_W, WPred.PredPos)
	end
end

function doQE(o)
	local QPred = GetPredictionForPlayer(GetOrigin(myHero), o ,GetMoveSpeed(o) ,1532, 250 + GetLatency(), 1044, 75, true, false)
	if QPred.HitChance == 1 and GetDistance(o) < 650 then
		CastSkillShot(_Q, QPred.PredPos)
		CastTargetSpell(o, _E)
	end
end

function doWQ(o)
	local QPred = GetPredictionForPlayer(GetOrigin(myHero), o ,GetMoveSpeed(o) ,1532, 250 + GetLatency(), 1044, 75, true, false)
	local WPred = GetPredictionForPlayer(GetOrigin(myHero), o, GetMoveSpeed(o), 99999, 900 + GetLatency(), 875, 187, false, true)
	if WPred.HitChance == 1 and QPred.HitChance == 1 and GetDistance(o) < 875 then
		CastSkillShot(_W, WPred.PredPos)
		CastSkillShot(_Q, QPred.PredPos)
	end
end

function doQW(o)
	local QPred = GetPredictionForPlayer(GetOrigin(myHero), o ,GetMoveSpeed(o) ,1532, 250 + GetLatency(), 1044, 75, true, false)
	local WPred = GetPredictionForPlayer(GetOrigin(myHero), o, GetMoveSpeed(o), 99999, 900 + GetLatency(), 875, 187, false, true)
	if WPred.HitChance == 1 and QPred.HitChance == 1 and GetDistance(o) < 875 then
		CastSkillShot(_Q, QPred.PredPos)
		CastSkillShot(_W, WPred.PredPos)
	end
end

function doEQW(o)
	local QPred = GetPredictionForPlayer(GetOrigin(myHero), o ,GetMoveSpeed(o) ,1532, 250 + GetLatency(), 1044, 75, true, false)
	local WPred = GetPredictionForPlayer(GetOrigin(myHero), o, GetMoveSpeed(o), 99999, 900 + GetLatency(), 875, 187, false, true)
	if WPred.HitChance == 1 and QPred.HitChance == 1 and GetDistance(o) < 650 then
		CastTargetSpell(o, _E)
		CastSkillShot(_Q, QPred.PredPos)
		CastSkillShot(_W, WPred.PredPos)
	end
end

function AutoStun()
	for i = 1, #Enemies do
		local Enemy = Enemies[i]
		IsBurning(Enemy, "Q")
		if GetDistance(Enemy) < config.Spells.StunRange:Value() then
			if (QRDY == 1 and QCanHit(Enemy) and ERDY == 1) then
				doE(Enemy)
			elseif (IsBurning(Enemy, "Q") or IsBurning(Enemy)) and QRDY == 1 and QCanHit(Enemy) then
				doQ(Enemy)
			end
		end
	end
end

function AutoIgnite()
	for i = 1, #Enemies do
		local Target = Enemies[i]
		if ValidTarget(Target) then
			local HP = GetCurrentHP(Target)
			if HP <= xIgnite and GetDistance(Target) <= 600 then
				if QRDY == 1 and HP <= QDmg then
					doQ(Target)
				elseif WRDY == 1 and HP <= WDmg then
					doW(Target)
				elseif ERDY == 1 and HP <= EDmg then
					doE(Target)
				else
					if IRDY == 1 then
						CastTargetSpell(Target, Ignite)
					end
				end
			end
		end
	end
end

function Combo()
	if ValidTarget(target) then
		if GetDistance(target) < range then
			myRange = 1050
			local DIST = GetDistance(target)
			if DIST < range then
				local armor = GetMagicResist(target)
			  	local hp = GetCurrentHP(target)
			  	local mhp = GetMaxHP(target)
			  	local hpreg = GetHPRegen(target) * (1 - (IsOrWillBeIgnited(target) * .5))
				local Health = hp * ((100 + ((armor - GetMagicPenFlat(myHero)) * GetMagicPenPercent(myHero))) * .01) + hpreg * 6 + GetMagicShield(target)
				local maxHealth = mhp * ((100 + ((armor - GetMagicPenFlat(myHero)) * GetMagicPenPercent(myHero))) * .01) + hpreg * 6 + GetMagicShield(target)
				local care = GetBuffData(target, "configablaze")
				local burntime = care.ExpireTime - GetTickCount() > 0 and (care.ExpireTime - GetTickCount()) * .001 or 4
				local PDMG = ((maxHealth * .02 * burntime) - (hpreg * .2 * burntime)) * (IsBurning(target) and 1 or 0)
				local TotalDamage = xIgnite * IRDY + (QDmg * QRDY + WDmg * WRDY * (IsBurning(target) and 1.25 or 1) + EDmg * ERDY + RDmg * RRDY * GetRBounce(target) + PDMG) * Mana(QRDY, WRDY, ERDY, RRDY)
				local TotalDamageNoR = xIgnite * IRDY + (QDmg * QRDY + WDmg * WRDY * (IsBurning(target) and 1.25 or 1) + EDmg * ERDY + PDMG) * Mana(QRDY, WRDY, ERDY, RRDY)
				local TotalDamageNoIgnite = (QDmg * QRDY + WDmg * WRDY * (IsBurning(target) and 1.25 or 1) + EDmg * ERDY + RDmg * RRDY * GetRBounce(target) + PDMG) * Mana(QRDY, WRDY, ERDY, RRDY)
				local TotalDamageNoRNoIgnite = (QDmg * QRDY + WDmg * WRDY * (IsBurning(target) and 1.25 or 1) + EDmg * ERDY + PDMG) * Mana(QRDY, WRDY, ERDY, RRDY)
				if Health < TotalDamageNoR then
					if ERDY == 1 then doE(target) end
					if QRDY == 1 then doQ(target) end
					if WRDY == 1 then doW(target) end
					if not config.Spells.KR:Value() then
						if RRDY == 1 then
							dooR(target)
						end
					end
					if config.KS.Ignite:Value() and Health > TotalDamageNoRNoIgnite and DIST < 650 then
						CastTargetSpell(target, Ignite)
					end
				elseif Health < TotalDamage then
					if ERDY == 1 then doE(target) end
					if QRDY == 1 then doQ(target) end
					if WRDY == 1 then doW(target) end
					if RRDY == 1 and Health < TotalDamage and Health > TotalDamageNoR then
						dooR(target)
					end
					if config.KS.Ignite:Value() and Health > TotalDamageNoIgnite and DIST < 650 then
						CastTargetSpell(target, Ignite)
					end
				else
					if IsBurning(target) then
						if QRDY == 1 then
							if config.Spells.QStunOnly:Value() then
								doQ(target)
							elseif WRDY + ERDY == 0 or GetDistance(target) > 875 and GetDistance(target) < 1050 and GetMoveSpeed(target) > GetMoveSpeed(myHero) then
								doQ(target)
							end
						end
						if ERDY == 1 then doE(target) end
						if WRDY == 1 then doW(target) end
						if RRDY == 1 then
							if not config.Spells.KR:Value() then
								dooR(target)
							end
						end
					else
						if ERDY == 1 then doE(target) end
						if WRDY == 1 then doW(target) end
						if QRDY == 1 then
							if config.Spells.QStunOnly:Value() then
								if IsBurning(target) then
									doQ(target)
								end
							else
								if WRDY + ERDY == 0 or GetDistance(target) > 875 and GetDistance(target) < 1050 and GetMoveSpeed(target) > GetMoveSpeed(myHero) then
									doQ(target)
								end
							end
						end
						if RRDY == 1 then
							if not config.Spells.KR:Value() then
								dooR(target)
							end
						end
					end
				end
			end
		end
	end
end

function Kills()
	for i = 1, #Enemies do
		local Enemy = Enemies[i]
  		local DIST = GetDistance(Enemy)
    	if ValidTarget(Enemy) and DIST < 2000 then
      		local armor = GetMagicResist(Enemy)
	    	local hp = GetCurrentHP(Enemy)
	    	local mhp = GetMaxHP(Enemy)
	    	local hpreg = GetHPRegen(Enemy) * (1 - (IsOrWillBeIgnited(Enemy) * .5))
      		local Health = hp * ((100 + ((armor - GetMagicPenFlat(myHero)) * GetMagicPenPercent(myHero))) * .01) + hpreg * 6 + GetMagicShield(Enemy)
      		local maxHealth = mhp * ((100 + ((armor - GetMagicPenFlat(myHero)) * GetMagicPenPercent(myHero))) * .01) + hpreg * 6 + GetMagicShield(Enemy)
      		local PDMG = (maxHealth * .08 - hpreg * .8) * (IsBurning(Enemy) and 1 or 0)
    		local TotalDamage = xIgnite * IRDY + (QDmg * QRDY + WDmg * WRDY * (IsBurning(Enemy) and 1.25 or 1) + EDmg * ERDY + RDmg * RRDY * (GetRBounce(Enemy)) + PDMG) * Mana(QRDY, WRDY, ERDY, RRDY)
    		if DIST < range then
	      		if Health < QDmg + PDMG and QRDY == 1 and Mana(1,0,0,0) == 1 and QCanHit(Enemy) then
					doQ(Enemy)	
				elseif Health < WDmg + PDMG  and WRDY == 1 and Mana(0,1,0,0) == 1 and WCanHit(Enemy) then
					doW(Enemy)
				elseif Health < EDmg + PDMG  and ERDY == 1 and Mana(0,0,1,0) == 1 then
					doE(Enemy)
				elseif Health < EDmg + WDmg * 1.25 + PDMG and ERDY == 1 and WRDY == 1 and Mana(0,1,1,0) == 1 and WCanHit(Enemy) then
					doEW(Enemy)
				elseif Health < EDmg + QDmg + PDMG  and ERDY == 1 and QRDY == 1 and Mana(1,0,1,0) == 1 and QCanHit(Enemy) then
					doQE(Enemy)
				elseif Health < QDmg + WDmg + PDMG  and QRDY == 1 and WRDY == 1 and Mana(1,1,0,0) == 1 and QCanHit(Enemy) and WCanHit(Enemy) then
					doWQ(Enemy)
				elseif Health < QDmg + WDmg * 1.25 + PDMG  and QRDY == 1 and WRDY == 1 and Mana(1,1,0,0) == 1 and QCanHit(Enemy) and WCanHit(Enemy) then
					doQW(Enemy)
				elseif Health < QDmg + WDmg * 1.25 + EDmg + PDMG  and QRDY == 1 and WRDY == 1 and ERDY == 1 and Mana(1,1,1,0) == 1 and QCanHit(Enemy) and WCanHit(Enemy) then
					doEQW(Enemy)
				end
				for j = 1, #Enemies do
					local OtherEnemy = Enemies[j]
					if OtherEnemy and Enemy ~= OtherEnemy then
						local HP = GetCurrentHP(OtherEnemy)
						local MHP = GetMaxHP(Enemy)
						local ARMOR = GetMagicResist(OtherEnemy)
						local HPREG = GetHPRegen(OtherEnemy) * (1 - (IsOrWillBeIgnited(OtherEnemy) * .5))
						local HEALTH = HP * ((100 + ((ARMOR - GetMagicPenFlat(myHero)) * GetMagicPenPercent(myHero))) * .01) + HPREG * 6 + GetMagicShield(OtherEnemy)
						local MAXHEALTH = MHP * ((100 + ((ARMOR - GetMagicPenFlat(myHero)) * GetMagicPenPercent(myHero))) * .01) + HPREG * 6 + GetMagicShield(OtherEnemy)
						local pdmg = (MAXHEALTH * .08 - HPREG * .8) * (IsBurning(OtherEnemy) and 1 or 0)
						if HEALTH < (RDmg * RRDY + pdmg) and GetCurrentMana(myHero) >= 100 and config.KS.KSR:Value() and DIST < 750 and GetDistance(OtherEnemy) > 750 and GetDistance(Enemy, OtherEnemy) <= 400 - (GetMoveSpeed(OtherEnemy) + GetMoveSpeed(Enemy))* .5 * .25 then
							dooR(Enemy)
						end
					end
				end
			end
		end
	end
end

OnTick(function(myHero)
	Enemies = GetEnemyHeroes()
	target = ts:GetTarget()
	range = (QRDY == 1 and (target and QCanHit(target) or true) and QRDY * 1050) or (WRDY == 1 and (target and WCanHit(target) or true) and WRDY * 875) or (ERDY > 0 and ERDY * 650) or (RRDY > 0 and RRDY * 750) or (IRDY * 650) or 0 
	resetVariables()
	if Mode() == "Combo" then
		Combo()
	end

	if config.Spells.AutoStun:Value() then
		AutoStun()
	end

	if config.KS.KS:Value() then
		Kills()
	end

	if config.KS.Ignite:Value() then
		AutoIgnite()
	end
end)

OnUpdateBuff(function(unit,buff)
	if GetTeam(unit) ~= GetTeam(myHero) and buff.Name:lower():find("configablaze") then
		local ID = GetNetworkID(unit)
		DelayAction(function()
			GotBlazed[ID] = buff.Count
			BlazeEndTime[ID] = GetTickCount() + 4000
		end, .3)
	end
end)

OnRemoveBuff(function(unit,buff)
	if GetTeam(unit) ~= GetTeam(myHero) and buff.Name:lower():find("configablaze") then
		local ID = GetNetworkID(unit)
		DelayAction(function()
			GotBlazed[ID] = 0
			BlazeEndTime[ID] = 0
		end, .3)
	end
end)

OnProcessSpell(function(unit, spell)
	if unit == myHero and spell then
		if spell.name == "configFissure" then
			WCharge = true
			WPos = spell.endPos
			WEndTime = GetTickCount() + 1000
		end
	end
end)
