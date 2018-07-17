if GetObjectName(GetMyHero()) ~= "Malphite" then return end

local ver = "0.03"

local mainMenu = Menu("Malphite", "Malphite")
mainMenu:SubMenu("Combo","Combo")
mainMenu.Combo:Boolean("CQ", "Use Q", true)
mainMenu.Combo:Boolean("CW", "Use W", true)
mainMenu.Combo:Boolean("CE", "Use E", true)
mainMenu.Combo:Boolean("CR", "Use R", true)
mainMenu.Combo:Boolean("CI", "Use Items", true)
mainMenu.Combo:Slider("MMC", "Min Mana % To Combo",60,0,100,1)

mainMenu:SubMenu("Harass", "Harass")
mainMenu.Harass:Boolean("HQ", "Use Q")
mainMenu.Harass:Boolean("HW", "Use W")
mainMenu.Harass:Boolean("HE", "Use E")
mainMenu.Harass:Slider("MMH", "Min Mana % To Harass",60,0,100,1)

mainMenu:SubMenu("LastHit", "LastHit")
mainMenu.LastHit:Boolean("LHQ", "Use Q", true)
mainMenu.LastHit:Boolean("LHE", "Use E", true)
mainMenu.LastHit:Slider("MMLH", "Min Mana % To LastHit",60,0,100,1)

mainMenu:SubMenu("LaneClear", "LaneClear")
mainMenu.LaneClear:Boolean("LCQ", "Use Q", true)
mainMenu.LaneClear:Boolean("LCW", "Use W", true)
mainMenu.LaneClear:Boolean("LCE", "Use E", true)
mainMenu.LaneClear:Slider("MMLC", "Min Mana % To LaneClear",60,0,100,1)

mainMenu:SubMenu("KillSteal", "Killsteal")
mainMenu.KillSteal:Boolean("KSQ", "Use Q", true)
mainMenu.KillSteal:Boolean("KSE", "Use E", true)
mainMenu.Killsteal:Boolean("KSR", "Use R", true)

mainMenu:SubMenu("Misc", "Misc")
mainMenu.Misc:Boolean("AutoLevel", "Use Auto Level", true)
mainMenu.Misc:Boolean("AutoI", "Use Auto Ignite", true)
mainMenu.Misc:Boolean("AR", "Auto R on X Enemies", true)
mainMenu.Misc:Slider("ARC", "Min Enemies to Auto R",3,1,6,1)
mainMenu.Misc:Boolean("UI", "Use Items", true)
mainMenu.Misc:Boolean("ARO", "Auto Randuins", true)
mainMenu.Misc:Slider("AROC", "Min Enemies to Randuins",3,1,6,1)

local AnimationQ = 0
local AnimationE = 0
local nextAttack = 0
function QDmg(unit) return CalcDamage(myHero,unit, 20 + 50 * GetCastLevel(myHero,_Q) + GetBonusAP(myHero) * 0.6) end
function EDmg(unit) return CalcDamage(myHero, unit, 0, 25 + 35 * GetCastLevel(myHero,_E) + GetBonusAP(myHero) * 0.2 + (GetArmor(myHero) * 0.3)) end
function RDmg(unit) return CalcDamage(myHero, unit, 0, 100 + 100 * GetCastLevel(myHero,_R) + GetBonusAP(myHero) * 1) end

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
	local RStats = {delay = 0.050, range = 1000, radius = 300, speed = 1500 + GetMoveSpeed(myHero)}
	local GetPercentMana = (GetCurrentMana(myHero) / GetMaxMana(myHero)) * 100
	local target = GetCurrentTarget()
	
	if mainMenu.Misc.AutoLevel:Value() then
		spellorder = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}	
		if GetLevelPoints(myHero) > 0 then
			LevelSpell(spellorder[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
		end
	end
	
	if Mode() == "Combo" then
		
		if mainMenu.Combo.CQ:Value() and Ready(_Q) and ValidTarget(target, 625) then
			if GetTickCount() > AnimationE and GetTickCount() > nextAttack then
				if mainMenu.Combo.MMC:Value() <= GetPercentMana then 
					CastTargetSpell(target, _Q)	
				end
			end
		end	
		
		if mainMenu.Combo.CE:Value() and Ready(_E) and ValidTarget(target, 400) then
			if mainMenu.Combo.MMC:Value() <= GetPercentMana then
				if GetTickCount() > nextAttack and GetTickCount() > AnimationQ then	
					CastSpell(_E)
				end	
			end
		end	
		
		if mainMenu.Combo.CW:Value() and Ready(_W) and ValidTarget(target, 125) then
			if mainMenu.Combo.MMC:Value() <= GetPercentMana and GetTickCount() < nextAttack then
				CastSpell(_W)
			end
		end
		
		if mainMenu.Combo.CR:Value() and Ready(_R) and ValidTarget(target, 1000) then
			if mainMenu.Combo.MMC:Value() <= GetPercentMana then
				local RPred = GetCircularAOEPrediction(target,RStats)
				if RPred.hitChance >= 0.3 then
					CastSkillShot(_R,RPred.castPos)
				end
			end
		end		
	end
	
	if Mode() == "Harass" then
		
		if mainMenu.Harass.HQ:Value() and Ready(_Q) and ValidTarget(target, 625) then
			if mainMenu.Harass.MMH:Value() <= GetPercentMana and GetTickCount() > nextAttack and GetTickCount() > AnimationE then
				CastTargetSpell(target, _Q)
			end
		end		
		
		for _,closeminion in pairs(minionManager.objects) do	
			if mainMenu.Harass.HW:Value() and Ready(_W) and ValidTarget(closeminion, 125) and EnemiesAround(closeminion,225) > 0 then
				if mainMenu.Harass.MMH:Value() <= GetPercentMana and GetTickCount() < nextAttack then
					CastSpell(_W)
				end
			end
		end
		
		if mainMenu.Harass.HW:Value() and Ready(_W) and ValidTarget(closeminion, 125) then
			if mainMenu.Harass.MMH:Value() <= GetPercentMana and GetTickCount() < nextAttack then
				CastSpell(_W)
			end
		end	

		if mainMenu.Harass.HE:Value() and Ready(_E) and ValidTarget(closeminion, 400) then
			if mainMenu.Harass.MMH:Value() <= GetPercentMana and GetTickCount() > AnimationQ and GetTickCount() > nextAttack then
				CastSpell(_E)
			end	
		end
	end

	if Mode() == "LaneClear" then
		
		for _,closeminion in pairs(minionManager.objects) do
			if mainMenu.LaneClear.LCQ:Value() and Ready(_Q) and ValidTarget(closeminion, 625) then
				if mainMenu.LaneClear.MMLC:Value() <= GetPercentMana then
					CastTargetSpell(closeminion, _Q)
				end
			end
				
			if mainMenu.LaneClear.LCW:Value() and Ready(_W) and ValidTarget(closeminion, 125) and MinionsAround(closeminion, 225) > 1 then
				if mainMenu.LaneClear.MMLC:Value() <= GetPercentMana then
					CastSpell(_W)
				end
			end
					
			if mainMenu.LaneClear.LCE:Value() and Ready(_E) and ValidTarget(closeminion, 400) and MinionsAround(myHero, 400) > 1 then
				if mainMenu.LaneClear.MMLC:Value() <= GetPercentMana then
					CastSpell(_E)
				end
			end
		end	
	end
	
	if Mode() == "LastHit" then
		for _,closeminion in pairs(minionManager.objects) do
			if mainMenu.LastHit.LHQ:Value() and Ready(_Q) and ValidTarget(closeminion, 625) then 
				if mainMenu.LastHit.MMLH:Value() <= GetPercentMana then
					if GetDistance(closeminion, myHero) > 125 then	
						if QDmg(closeminion) >= GetCurrentHP(closeminion) then
							CastTargetSpell(closeminion, _Q)
						end
					end		
				end
			end

			if mainMenu.LastHit.LHE:Value() and Ready(_E) and ValidTarget(closeminion, 400) then
				if mainMenu.LastHit.MMLH:Value() <= GetPercentMana then
					if EDmg(closeminion) >= GetCurrentHP(closeminion) then
						CastSpell(_E)
					end
				end
			end		
		end
	end	
	
	--KillSteal
	for _, enemy in pairs(GetEnemyHeroes()) do
		if mainMenu.KillSteal.KSQ:Value() and Ready(_Q) and ValidTarget(enemy, 625) then
			if QDmg(enemy) >= GetCurrentHP(enemy) then
				CastTargetSpell(enemy, _Q)
			end
		end

		if mainMenu.KillSteal.KSE:Value() and Ready(_E) and ValidTarget(enemy, 200) then
			if EDmg(enemy) >= GetCurrentHP(enemy) then
				CastSpell(_E)
			end
		end
		
		if mainMenu.KillSteal.KSR:Value() and Ready(_R) and ValidTarget(enemy, 1000) then
			local RPred = GetCircularAOEPrediction(target,RStats)
			if RPred.hitChance >= 0.3 then
				if RDmg(enemy) >= GetCurrentHP(enemy) then
					CastSkillShot(_R,RPred.castPos)
				end
			end		
		end
	end

	--AutoR
	for _, enemy in pairs(GetEnemyHeroes()) do
		if mainMenu.Misc.AR:Value() and Ready(_R) and ValidTarget(enemy, 1000) and EnemiesAround(enemy, 300) >= mainMenu.Misc.ARC:Value() then
			local RPred = GetCircularAOEPrediction(target,RStats)
			if RPred.hitChance >= 0.3 then 
				CastSkillShot(_R,RPred.castPos)
			end	
		end
	end

	--AutoIgnite
	for _, enemy in pairs(GetEnemyHeroes()) do
		if GetCastName(myHero, SUMMONER_1):lower():find("summonerdot") then
			if mainMenu.Misc.AutoI:Value() and Ready(SUMMONER_1) and ValidTarget(enemy, 600) then
				if GetCurrentHP(enemy) < IDamage then
					CastTargetSpell(enemy, SUMMONER_1)
				end
			end
		end
	
		if GetCastName(myHero, SUMMONER_2):lower():find("summonerdot") then
			if mainMenu.Misc.AutoI:Value() and Ready(SUMMONER_2) and ValidTarget(enemy, 600) then
				if GetCurrentHP(enemy) < IDamage then
					CastTargetSpell(enemy, SUMMONER_2)
				end
			end
		end
	end
	
	--ItemUsage
	for _, enemy in pairs(GetEnemyHeroes()) do
		if mainMenu.Misc.UI:Value() and Ready(GetItemSlot(myHero, 3143)) and ValidTarget(enemy, 500) then
			if GetDistance(myHero, enemy) > 240 and GetPercentHP(enemy) < 80 then
				CastSpell(GetItemSlot(myHero, 3143))
			end
		end

		if mainMenu.Misc.ARO:Value() and Ready(GetItemSlot(myHero, 3143)) and EnemiesAround(myHero, 500) > mainMenu.Misc.AROC:Value() then
			CastSpell(GetItemSlot(myHero, 3143))
		end		
	end	
end)

OnProcessSpell(function(unit,spellProc)
	if unit.isMe and spellProc.name:lower():find("attack") and spellProc.target.isHero then
		nextAttack = GetTickCount() + spellProc.windUpTime * 1000
	end
	
	if unit.isMe and spellProc.name:lower():find("SeismicShard") and spellProc.target.isHero then
		AnimationQ = GetTickCount() + spellProc.windUpTime * 1000
	end	

	if unit.isMe and spellProc.name:lower():find("LandSlide") and spellProc.target.isHero then
		AnimationE = GetTickCount() + spellProc.windUpTime * 1000	
	end	
end)
