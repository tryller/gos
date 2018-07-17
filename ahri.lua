if GetObjectName(GetMyHero()) ~= "Ahri" then return end

require('Inspired')
require('DeftLib')
require('DamageLib')

local config = MenuConfig("Ahri", "Ahri")
config:Menu("Combo", "Combo")
config.Combo:Boolean("Q", "Use Q", true)
config.Combo:Boolean("W", "Use W", true)
config.Combo:Boolean("E", "Use E", true)
config.Combo:Boolean("R", "Use R", false)
config.Combo:DropDown("RMode", "R Mode", 1, {"Logic", "to mouse"})

config:Menu("Killsteal", "Killsteal")
config.Killsteal:Boolean("Q", "Killsteal with Q", true)
config.Killsteal:Boolean("W", "Killsteal with W", true)
config.Killsteal:Boolean("E", "Killsteal with E", true)
if Ignite ~= nil then 
config.Killsteal:Boolean("Autoignite", "Auto Ignite", true) 
end

config:Menu("Interrupt", "Interrupt (E)")
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
	if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and IsReady(_E) then
		if CHANELLING_SPELLS[spell.name] then
			if ValidTarget(unit, 1000) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and config.Interrupt[GetObjectName(unit).."Inter"]:Value() then 
				Cast(_E, unit)
			end
		end
	end
end)

local UltOn = false
local Missiles = {}

OnCreateObj(function(Object) 
	if GetObjectBaseName(Object) == "missile" then
		table.insert(Missiles,Object) 
	end
end)

OnDeleteObj(function(Object)
	if GetObjectBaseName(Object) == "missile" then
		for i,rip in pairs(Missiles) do
			if GetNetworkID(Object) == GetNetworkID(rip) then
				table.remove(Missiles, i) 
			end
		end
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
	local mousePos = GetMousePos()

	-- Combo
	if Mode() == "Combo" then
		if IsReady(_E) and config.Combo.E:Value() then
			Cast(_E, target)
		end

		local BestPos = Vector(target) - (Vector(target) - Vector(myHero)):perpendicular():normalized() * 350
		if config.Combo.RMode:Value() == 1 and config.Combo.R:Value() and ValidTarget(target,900) then
			if UltOn and BestPos then
				CastSkillShot(_R, BestPos)
			elseif IsReady(_R) and BestPos and getdmg("Q", target) + getdmg("W", target, myHero, 3) + getdmg("E", target) + getdmg("R", target) > GetHP2(target) then
				CastSkillShot(_R, BestPos)
			end
		end
	
		local AfterTumblePos = GetOrigin(myHero) + (Vector(mousePos) - GetOrigin(myHero)):normalized() * 550
		local DistanceAfterTumble = GetDistance(AfterTumblePos, target)
		if config.Combo.RMode:Value() == 2 and config.Combo.R:Value() and ValidTarget(target, 900)then
			if UltOn and DistanceAfterTumble < 550 then
				CastSkillShot(_R, mousePos)
			elseif IsReady(_R) and getdmg("Q", target) + getdmg("W", target, myHero, 3) + getdmg("E", target) + getdmg("R", target) > GetHP2(target) then
				CastSkillShot(_R, mousePos) 
			end
		end

		if IsReady(_W) and ValidTarget(target, 700) and config.Combo.W:Value() then
			CastSpell(_W)
		end
		
		if IsReady(_Q) and config.Combo.Q:Value() then
			Cast(_Q, target)
        end
					
    end
	
	-- Kill Steal
	for i,enemy in pairs(GetEnemyHeroes()) do
		if Ignite and config.Killsteal.Autoignite:Value() then
			if IsReady(Ignite) and 20 * GetLevel(myHero) + 50 > GetHP(enemy)+GetHPRegen(enemy) * 3 and ValidTarget(enemy, 600) then
				CastTargetSpell(enemy, Ignite)
			end
		end
                
		if IsReady(_W) and ValidTarget(enemy, 930) and config.Killsteal.W:Value() and GetHP2(enemy) < getdmg("W", enemy, myHero, 3) then
			CastSpell(_W)
		elseif IsReady(_Q) and ValidTarget(enemy, 700) and config.Killsteal.Q:Value() and GetHP2(enemy) < getdmg("Q", enemy) then 
			Cast(_Q, enemy)
		elseif IsReady(_E) and ValidTarget(enemy, 1030) and config.Killsteal.E:Value() and GetHP2(enemy) < getdmg("E", enemy) then
			Cast(_E, enemy)
		end
    end 
end)
 
OnUpdateBuff(function(unit,buff)
	if buff.Name == "ahritumble" then 
		UltOn = true
	end
end)

OnRemoveBuff(function(unit,buff)
	if buff.Name == "ahritumble" then 
		UltOn = false
	end
end)

AddGapcloseEvent(_E, 666, false, config)