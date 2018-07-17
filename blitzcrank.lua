if GetObjectName(GetMyHero()) ~= "Blitzcrank" then return end

require('Inspired')
require('DeftLib')
require('DamageLib')

local config = MenuConfig("Blitzcrank", "Blitzcrank")
config:Menu("Combo", "Combo")
config.Combo:Boolean("Q", "Use Q", true)
config.Combo:Boolean("W", "Use W", true)
config.Combo:Boolean("E", "Use E", true)
config.Combo:Boolean("AutoE", "Auto E after Grab", true)
config.Combo:Boolean("R", "Use R", true)

if Ignite ~= nil then 
config:Menu("Misc", "Misc")
config.Misc:Boolean("Autoignite", "Auto Ignite", true) 
end
	
config:Menu("Interrupt", "Interrupt")
config.Interrupt:Menu("SupportedSpells", "Supported Spells")
config.Interrupt.SupportedSpells:Boolean("Q", "Use Q", true)
config.Interrupt.SupportedSpells:Boolean("R", "Use R", true)

local MissedGrabs = 0
local SuccesfulGrabs = 0
local TotalGrabs = MissedGrabs + SuccesfulGrabs
local Percentage = ((SuccesfulGrabs*100)/TotalGrabs)

DelayAction(function()
	local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
	for i, spell in pairs(CHANELLING_SPELLS) do
		for _,k in pairs(GetEnemyHeroes()) do
			if spell["Name"] == GetObjectName(k) then
				config.Interrupt:Boolean(GetObjectName(k).."Inter", "On "..GetObjectName(k).." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
			end
		end
	end
end, 1)

ts = TargetSelector(myHero:GetSpellData(_Q).range, TARGET_LOW_HP, DAMAGE_MAGIC, true)
config:TargetSelector("ts", "Target Selector", ts)

OnProcessSpell(function(unit, spell)
	if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) then
		if CHANELLING_SPELLS[spell.name] then
			if ValidTarget(unit, 975) and IsReady(_Q) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and config.Interrupt[GetObjectName(unit).."Inter"]:Value() and config.Interrupt.SupportedSpells.Q:Value() then
				Cast(_Q, unit)
			elseif ValidTarget(unit, 600) and IsReady(_R) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and config.Interrupt[GetObjectName(unit).."Inter"]:Value() and config.Interrupt.SupportedSpells.R:Value() then
				CastSpell(_R)
			end
		end
	end

	if unit == myHero and spell.name == "RocketGrab" then
		MissedGrabs = MissedGrabs + 1
	end
end)

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
	local target = ts:GetTarget()
	if Mode() == "Combo" then
		if IsReady(_Q) and config.Combo.Q:Value() then
			Cast(_Q, target)
		end

		if IsReady(_W) and ValidTarget(target, 1275) and config.Combo.W:Value() then  
			if GetCurrentMana(myHero) >= 200 and IsReady(_Q) and GetDistance(target) >= 975 then
				CastSpell(_W)
			elseif GetDistance(target) <= 400 then
				CastSpell(_W)
			end
		end

		if IsReady(_E) and IsInDistance(target, 250) and config.Combo.E:Value() then
			CastSpell(_E)
		end
          
		if IsReady(_R) and ValidTarget(target, 600) and config.Combo.R:Value() and GetPercentHP(target) <= 60 then
			CastSpell(_R)
		end               
	end	

	for i,enemy in pairs(GetEnemyHeroes()) do
		if Ignite and config.Misc.Autoignite:Value() then
			if IsReady(Ignite) and 20*GetLevel(myHero)+50 > GetHP(enemy)+GetHPRegen(enemy)*3 and ValidTarget(enemy, 600) then
				CastTargetSpell(enemy, Ignite)
			end
		end
	end
end)

OnUpdateBuff(function(unit,buff)
	if buff.Name == "rocketgrab2" and GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) then
		SuccesfulGrabs = SuccesfulGrabs + 1
		MissedGrabs = MissedGrabs - 1

		if config.Combo.AutoE:Value() then
			CastSpell(_E)
		end
	end
end)
