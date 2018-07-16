if GetObjectName(GetMyHero()) ~= "Garen" then return end

local ultbase = 0
local percent = 0
local qActive = false
local eActive = false
local cVillian = nil
local igniteFound = false
local summonerSpells = {ignite = {}, flash = {}, heal = {}, barrier = {}}

GarenMenu = Menu("Garen", "Garen")
GarenMenu:SubMenu("combo", "Combo")
GarenMenu.Combo:Boolean("Q", "Use Q", true)
GarenMenu.Combo:Boolean("W", "Use Smart W", true)
GarenMenu.Combo:Boolean("E", "Use E", true)
GarenMenu.Combo:Boolean("R", "Use R if will kill enemy", true)
GarenMenu:SubMenu("laneclear", "Laneclear")
GarenMenu.laneclear:Boolean("E", "Use E", true)
GarenMenu:SubMenu("ksteal", "Killsteal")
GarenMenu.ksteal:Boolean("R", "Use R", true)

OnLoad(function()
	if not igniteFound then
    	if GetCastName(myHero, SUMMONER_1):lower():find("summonerdot") then
      		igniteFound = true
      		summonerSpells.ignite = SUMMONER_1
      		GarenMenu.ksteal:Boolean("ignite", "Auto Ignite", true)
    	elseif GetCastName(myHero, SUMMONER_2):lower():find("summonerdot") then
      		igniteFound = true
      		summonerSpells.ignite = SUMMONER_2
      		GarenMenu.ksteal:Boolean("ignite", "Auto Ignite", true)
    	end
	end
end)

DelayAction(function()
	for i, enemy in pairs(GetEnemyHeroes()) do
  		if GotBuff(enemy, "garenpassiveenemytarget") == 1 then
    		cVillian = GetNetworkID(enemy)
  		end
	end
end, 0.1)

function numbers()
	rLevel = GetSpellData(myHero, _R).level
	if (rLevel > 0) then 
		if rLevel == 1 then 
			ultbase = 175
			percent = 28.6
		elseif rLevel == 2 then
			ultbase = 350
			percent = 33.3
		elseif rLevel == 3 then
			ultbase = 525
			percent = 40
		end
	end
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

OnTick(function()
	--BlockAA()
	numbers()
	Killsteal()

	if Mode() == "Combo" then
		Combo()
	end
	
	if Mode() == "LaneClear" then
		Laneclear()
	end
end)

OnUpdateBuff(function(unit, buff)
	if not unit or not buff then
		return
	end
	if buff.Name:lower() == "garenpassiveenemytarget" then
      	cVillian = GetNetworkID(unit)
    end
  	if unit.isMe then
    	if buff.Name:lower() == "garene" then
      		eActive = true
      	end
      	if buff.Name:lower() == "garenq" then
      		qActive = true
      	end 
    end
end)

OnRemoveBuff(function(unit, buff)
	if not unit or not buff then
		return
	end
	if buff.Name:lower() == "garenpassiveenemytarget" then
      	cVillian = nil
    end  
  	if unit.isMe then
    	if buff.Name:lower() == "garene" then
      		eActive = false
      	end
      	if buff.Name:lower() == "garenq" then
      		qActive = false
      	end 
    end
end)

OnProcessSpellComplete(function(unit, spell)
	if not unit or not spell then
		return
	end
	if GarenMenu.Combo.W:Value() and unit.type == myHero.type and spell.target and spell.target.isMe and Ready(_W) and spell.name:lower() ~= "recall" and spell.name:lower() ~= "garenq" then 
		CastSpell(_W) 
	end
end)

function Combo()
	target = GetCurrentTarget()
	if cVillian == GetNetworkID(target) then
		rDamage = math.ceil((ultbase + ((GetMaxHP(target) - GetCurrentHP(target)) * (percent / 100))))
	elseif cVillian ~= GetNetworkID(target) then
		rDamage = math.ceil(CalcDamage(myHero, target, 0, (ultbase + ((GetMaxHP(target) - GetCurrentHP(target)) * (percent / 100)))))
	end
	if GarenMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 800) and not eActive then 
		CastSpell(_Q)
	end
	if GarenMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, 350) then 
		CastSpell(_W)
	end
	--
	if GarenMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, 350) and not eActive then
		CastSpell(_E)
	end
	if (rLevel ~= (nil or 0)) then
		if GarenMenu.Combo.R:Value() and (GetCurrentHP(target) <= rDamage) and Ready(_R) and ValidTarget(target, 400) then 
			CastTargetSpell(target, _R)
		end
	end 
end

function Laneclear()
	for i,minion in pairs(minionManager.objects) do
  		if minion.team ~= myHero.team and ValidTarget(minion, 350) and GarenMenu.laneclear.E:Value() and Ready(_E) and not eActive then
			CastSpell(_E)
		end
	end
end

function Killsteal()
	if igniteFound and GarenMenu.ksteal.ignite:Value() and Ready(summonerSpells.ignite) then
    local iDamage = (50 + (20 * GetLevel(myHero)))
      	for _, enemy in pairs(GetEnemyHeroes()) do
      		local realHPi = (GetCurrentHP(enemy) + GetDmgShield(enemy) + (GetHPRegen(enemy) * 0.05))
        	if ValidTarget(enemy, 600) and realHPi <= iDamage then
          		CastTargetSpell(enemy, summonerSpells.ignite)
          	end
        end
	end
	if igniteFound and GarenMenu.ksteal.ignite:Value() and Ready(summonerSpells.ignite) and (rLevel ~= (nil or 0)) and Ready(_R) and GarenMenu.ksteal.R:Value() then
    	for _, enemy in pairs(GetEnemyHeroes()) do
    		local realHPi = (GetCurrentHP(enemy) + GetDmgShield(enemy) + (GetHPRegen(enemy) * 0.05))
    		if cVillian == GetNetworkID(enemy) then 
    			riDamage = math.ceil((ultbase + ((GetMaxHP(enemy) - GetCurrentHP(enemy)) * (percent / 100))) + (50 + (20 * GetLevel(myHero))))
    		elseif cVillian ~= GetNetworkID(enemy) then
    			riDamage = math.ceil(CalcDamage(myHero, enemy, 0, (ultbase + ((GetMaxHP(enemy) - GetCurrentHP(enemy)) * (percent / 100)))) + (50 + (20 * GetLevel(myHero))))
    		end
    		if ValidTarget(enemy, 400) and (realHPi <= riDamage) then
    			CastTargetSpell(enemy, summonerSpells.ignite)
    			DelayAction(function() CastTargetSpell(enemy, _R) end, 0.02)
    		end
    	end
	end
	if (rLevel ~= (nil or 0)) and Ready(_R) and GarenMenu.ksteal.R:Value() then
		for _, enemy in pairs(GetEnemyHeroes()) do
			local realHPi = (GetCurrentHP(enemy) + GetDmgShield(enemy) + (GetHPRegen(enemy) * 0.05))
			if cVillian == GetNetworkID(enemy) then
				rDamage2 = math.ceil((ultbase + ((GetMaxHP(enemy) - GetCurrentHP(enemy)) * (percent / 100))))
			elseif cVillian ~= GetNetworkID(enemy) then
				rDamage2 = math.ceil(CalcDamage(myHero, enemy, 0, (ultbase + ((GetMaxHP(enemy) - GetCurrentHP(enemy)) * (percent / 100)))))
			end
			if (realHPi <= rDamage2) and Ready(_R) and ValidTarget(enemy, 400) then 
				CastTargetSpell(enemy, _R)
			end
		end
	end
end

function BlockAA()
	if eActive and IOW_Loaded then
		IOW.attacksEnabled = false
	elseif not eActive and IOW_Loaded then
		IOW.attacksEnabled = true
	end
	if eActive and DAC_Loaded then
		DAC.attacksEnabled = false
	elseif not eActive and DAC_Loaded then
		DAC.attacksEnabled = true
	end
	if eActive and PW_Loaded then
		PW.attacksEnabled = false
	elseif not eActive and PW_Loaded then
		PW.attacksEnabled = true
	end
	if eActive and GoSWalkLoaded then 
		GoSWalk:EnableAttack(false)
	elseif not eActive and GoSWalkLoaded then
		GoSWalk:EnableAttack(true)
	end
end

OnDraw(function()
	if not IsDead(myHero) then
		if GarenMenu.draws.edraw:Value() and Ready(_E) then
			DrawCircle(GetOrigin(myHero), 350, 2, 1, ARGB(255, 245, 86, 7))
		end
		if GarenMenu.draws.rdraw:Value() and Ready(_R) then
			DrawCircle(GetOrigin(myHero), 400, 2, 1, ARGB(255, 242, 0, 141))
		end
		if GarenMenu.draws.rhpdraw:Value() and Ready(_R) then
			for _, enemy in pairs(GetEnemyHeroes()) do
				if cVillian == GetNetworkID(enemy) then
					rDamage3 = math.ceil((ultbase + ((GetMaxHP(enemy) - GetCurrentHP(enemy)) * (percent / 100))))
				elseif cVillian ~= GetNetworkID(enemy) then
					rDamage3 = math.ceil(CalcDamage(myHero, enemy, 0, (ultbase + ((GetMaxHP(enemy) - GetCurrentHP(enemy)) * (percent / 100)))))
				end
				DrawDmgOverHpBar(enemy, GetCurrentHP(enemy), 0, rDamage3, ARGB(255, 0, 255, 0))
			end 
		end
	end
end)