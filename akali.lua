if GetObjectName(GetMyHero()) ~= "Akali" then return end

local config = Menu("Akali", "Akali")
config:SubMenu("Combo", "Combo")
config.Combo:Boolean("Q", "Use Q", true)
config.Combo:Boolean("E", "Use E", true)
config.Combo:Boolean("R", "Use R", true)
config.Combo:Boolean("TH", "Titanic Hydra AA Reset", true)
config.Combo:Boolean("HTGB", "Use Gunblade", true)
config.Combo:Boolean("BWC", "Use Bilgewater Cutlass", true)
config.Combo:Slider("HPHTGB", "Target's Hp to Use Items",85,5,100,2)
config.Combo:Slider("ComboEnergyManager", "Min Energy to Use Combo",0,0,200,10)

config:SubMenu("LaneClear", "LaneClear")
config.LaneClear:Boolean("Q", "Use Q", true)
config.LaneClear:Boolean("E", "Use E", true)
config.LaneClear:Slider("EnergyManager", "Min Energy to LaneClear",0,0,200,10)

config:SubMenu("LastHit","LastHit")
config.LastHit:Boolean("QLH", "Use Q", true)
config.LastHit:Boolean("ELH", "Use E", true)
config.LastHit:Slider("LHEnergyManager", "Min Energy to Use Last Hit",0,0,200,10)
config.LastHit:Boolean("ALHQ", "Auto Last Hit", true)
config.LastHit:Slider("ALHEnergyManager", "Min Energy to Use Auto Last Hit",0,0,200,10)

config:SubMenu("KillSteal", "KillSteal")
config.KillSteal:Boolean("KSQ", "KillSteal with Q", true)
config.KillSteal:Boolean("KSE", "KillSteal with E", true)
config.KillSteal:Boolean("KSR", "KillSteal with R", true)
config.KillSteal:Boolean("KSG", "KillSteal with Gunblade", true)
config.KillSteal:Boolean("KSC", "KillSteal with Cutlass", true)

config:SubMenu("Misc", "Misc")
config.Misc:SubMenu("AL", "Auto Level")
config.Misc.AL:Boolean("UAL", "Use Auto Level", false)
config.Misc.AL:Boolean("ALQ", "R>Q>E>W", false)
config.Misc.AL:Boolean("ALE", "R>E>Q>W", false)
config.Misc:Boolean("AutoW", "UseAutoW", true)
config.Misc:Slider("AutoWP", "Percent Health for Auto W",20,5,90,2)
config.Misc:Boolean("AutoWE", "Use Auto W on X Enemies", true)
config.Misc:Slider("AutoWX", "X Enemies to Cast AutoW",3,1,5,1)
config.Misc:Boolean("AutoI", "Auto Ignite", true)
config.Misc:Boolean("AZ", "Auto Zhonyas", true)
config.Misc:Slider("AZC", "HP to Auto Zhonyas",10,1,100,1)

config:SubMenu("Escape", "Escape Mode")
config.Escape:Key("Key", "Escape Key", string.byte("Z"))
config.Escape:Boolean("ESCR", "Use R", true)

ts = TargetSelector(myHero:GetSpellData(_Q).range, TARGET_LOW_HP, DAMAGE_MAGIC, true)
config:TargetSelector("ts", "Target Selector", ts)

local nextAttack = 0
local AnimationQ = 0

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

OnTick(function ()
	local IDamage = (50 + (20 * GetLevel(myHero)))
	local target = ts:GetTarget()
	
	if config.Misc.AL.UAL:Value() and config.Misc.AL.ALQ:Value() and not config.Misc.AL.ALE:Value() then
		spellorder = {_Q, _E, _Q, _W, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}	
		if GetLevelPoints(myHero) > 0 then
			LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
		end
	end    

	if config.Misc.AL.UAL:Value() and config.Misc.AL.ALE:Value() and not config.Misc.AL.ALQ:Value() then
		spellorder = {_E, _Q, _E, _W, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}	
		if GetLevelPoints(myHero) > 0 then
			LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
		end
	end	

	if Mode() == "Combo" then
		if GetCurrentMana(myHero) >= config.Combo.ComboEnergyManager:Value() then
			if config.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 600) then
				CastTargetSpell(target, _Q)
        	end

        	if GetCurrentMana(myHero) >= config.Combo.ComboEnergyManager:Value() then        
				if GetTickCount() > nextAttack then	
					if config.Combo.E:Value() and Ready(_E) and ValidTarget(target, 325) then
						CastSpell(_E)
					end
				end
			end
	
			if GetDistance(target, myHero) >= 325 or GetCurrentMana(myHero) < 40 then
				if GetTickCount() > nextAttack then	
					if config.Combo.R:Value() and Ready(_R) and ValidTarget(target, 700) then
						CastTargetSpell(target, _R)
					end
				end
			end	
	
			if config.Combo.HTGB:Value() and Ready(GetItemSlot(myHero, 3146)) and ValidTarget(target, 700) then
				if GetPercentHP(target) < config.Combo.HPHTGB:Value() then
					CastTargetSpell(target, GetItemSlot(myHero, 3146))
				end	
			end
	
			if config.Combo.BWC:Value() and Ready(GetItemSlot(myHero, 3144)) and ValidTarget(target, 550) then
				if GetPercentHP(target) < config.Combo.HPHTGB:Value() then
					CastTargetSpell(target, GetItemSlot(myHero, 3144))
				end
			end	
		end	
	end
	
	if Mode() == "LaneClear" then
		for _,closeminion in pairs(minionManager.objects) do
			if GetCurrentMana(myHero) >= config.LaneClear.EnergyManager:Value() then
				if config.LaneClear.Q:Value() and Ready(_Q) and ValidTarget(closeminion, 600) then
					CastTargetSpell(closeminion, _Q)
				end
			end	
					
			if GetCurrentMana(myHero) >= config.LaneClear.EnergyManager:Value() then
				if config.LaneClear.E:Value() and Ready(_E) and ValidTarget(closeminion, 325) and MinionsAround(myHero, 325) > 1 then
				    CastSpell(_E)
				end
			end
		end
	end

	if Mode() == "LastHit" then
		for _,closeminion in pairs(minionManager.objects) do
			if GetCurrentMana(myHero) > config.LastHit.LHEnergyManager:Value() then
				if config.LastHit.QLH:Value() and Ready(_Q) and ValidTarget(closeminion, 600) then
					if GetDistance(closeminion, myHero) > 125 then
						if GetCurrentHP(closeminion) < CalcDamage(myHero, closeminion, 0, 15 + 20 * GetCastLevel(myHero,_Q) + GetBonusAP(myHero) * 0.4) then
							CastTargetSpell(closeminion, _Q) 
						end
					end
				end
			end	
			
			if GetCurrentMana(myHero) > config.LastHit.LHEnergyManager:Value() then
				if GetTickCount() > nextAttack then
					if config.LastHit.ELH:Value() and Ready(_E) and ValidTarget(closeminion, 325) then
						if GetCurrentHP(closeminion) < CalcDamage(myHero, closeminion, 0, 5 + 25 * GetCastLevel(myHero,_E) + GetBonusAP(myHero) * 0.4 + (myHero.totalDamage) * 0.6) then
							CastSpell(_E)
						end	
					end
				end
			end
		end	
	end
	
	--AutoLastHit
	for _,closeminion in pairs(minionManager.objects) do
		if not KeyIsDown(32) then
			if config.LastHit.ALHQ:Value() then
				if GetCurrentMana(myHero) > config.LastHit.ALHEnergyManager:Value() and Ready(_Q) and ValidTarget(closeminion, 600) then
					if GetTickCount() > nextAttack then
						if GetCurrentHP(closeminion) < CalcDamage(myHero, closeminion, 0, 15 + 20 * GetCastLevel(myHero,_Q) + GetBonusAP(myHero) * 0.4) then
							CastTargetSpell(closeminion, _Q)
						end
					end
				end
			end
		end
	end	
	
	--Killsteal
	for _, enemy in pairs(GetEnemyHeroes()) do
		if config.KillSteal.KSQ:Value() and Ready(_Q) and ValidTarget(enemy, 600) then
			if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 15 + 20 * GetCastLevel(myHero, _Q) + GetBonusAP(myHero) * 0.4) then
				CastTargetSpell(enemy , _Q)
			end
		end
	
		if config.KillSteal.KSR:Value() and Ready(_R) and ValidTarget(enemy, 700) then
			if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 25 + 75 * GetCastLevel(myHero, _R) + GetBonusAP(myHero) * 0.5) then
				CastTargetSpell(enemy , _R)
			end
		end
	
		if config.KillSteal.KSE:Value() and Ready(_E) and ValidTarget(enemy, 325) then
			if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 5 + 25 * GetCastLevel(myHero, _E) + GetBonusAP(myHero) * 0.4 + (myHero.totalDamage) * 0.6) then
				CastSpell(_E)
			end
		end
		
		if config.KillSteal.KSC:Value() and Ready(GetItemSlot(myHero, 3144)) and ValidTarget(enemy, 550) then
			if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 100) then
				CastTargetSpell(target, GetItemSlot(myHero, 3144))
			end
		end
	
		if config.KillSteal.KSG:Value() and Ready(GetItemSlot(myHero, 3146)) and ValidTarget(enemy, 700) then
			if GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, 250 + GetBonusAP(myHero) * 0.3) then
			   CastTargetSpell(target, GetItemSlot(myHero, 3146))
			end
		end	
	end
	
	--AutoW
	if config.Misc.AutoW:Value() and Ready(_W) and EnemiesAround(myHeroPos(), 1000) >= 1 and (EnemiesAround(myHeroPos(), 1000) >= config.Misc.AutoWX:Value() or GetPercentHP(myHero) <= config.Misc.AutoWP:Value()) then
		CastSkillShot(_W, myHeroPos())
	end
	
	--Escape
	if config.Escape.Key:Value() then
		MoveToXYZ(GetMousePos())
		for _,closeminion in pairs(minionManager.objects) do	
			if config.Escape.ESCR:Value() and Ready(_R) and ValidTarget(closeminion,700) then	
				if EnemiesAround(closeminion, 700) < 1 then
						CastTargetSpell(closeminion, _R)
				end	
			end
		end	
	end
	
	--AutoIgnite
	for _, enemy in pairs(GetEnemyHeroes()) do
		if GetCastName(myHero, SUMMONER_1):lower():find("summonerdot") then
			if config.Misc.AutoI:Value() and Ready(SUMMONER_1) and ValidTarget(enemy, 600) then
				if GetCurrentHP(enemy) < IDamage then
					CastTargetSpell(enemy, SUMMONER_1)
				end
			end
		end
	
		if GetCastName(myHero, SUMMONER_2):lower():find("summonerdot") then
			if config.Misc.AutoI:Value() and Ready(SUMMONER_2) and ValidTarget(enemy, 600) then
				if GetCurrentHP(enemy) < IDamage then
					CastTargetSpell(enemy, SUMMONER_2)
				end
			end
		end
	end
	
	--Auto Zhonyas
	if config.Misc.AZ:Value() and Ready(GetItemSlot(myHero,3157)) then
		if GetPercentHP(myHero) <= config.Misc.AZC:Value() then
			if EnemiesAround(myHero, 1000) > 0 then
				CastSpell(GetItemSlot(myHero, 3157))
			end
		end
	end		
end)

OnProcessSpell(function(unit,spellProc)
	if unit.isMe and spellProc.name:lower():find("attack") and spellProc.target.isHero then
		nextAttack = GetTickCount() + spellProc.windUpTime * 1000
	end
	
	if unit.isMe and spellProc.name:lower():find("akalimota") and spellProc.target.isminion then
			AnimationQ = GetTickCount() + spellProc.windUpTime * 1000
	end
end)

OnProcessSpellComplete(function(unit,spell)
	if config.Combo.TH:Value() and unit.isMe and spell.name:lower():find("attack") and spell.target.isHero then
		if Mode() == "Combo" then
			local TH = GetItemSlot(myHero,3748)
			if TH > 0 then 
				if Ready(TH) and GetCurrentHP(target) > CalcDamage(myHero, target, myHero.totalDamage + (GetMaxHP(myHero) / 10), ((myHero.totalDamage / 100) * 6) + (GetBonusAP(myHero) / 6)) then
					CastSpell(TH)
					DelayAction(function()
						AttackUnit(spell.target)
					end, spell.windUpTime)
				end
			end
        	end
	end
end)	
