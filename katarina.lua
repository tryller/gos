if GetObjectName(GetMyHero()) ~= "Katarina" then return end

require ("DamageLib")

local kataR = false

-- Menu
local config = Menu("Katarina", "Katarina")
config:SubMenu("Combo", "Combo Settings")
config.Combo:Boolean("Q", "Use Q", true)
config.Combo:Boolean("W", "Use W", true)
config.Combo:Boolean("E", "Use E", true)
config.Combo:Boolean("R", "Use R", true)
config.Combo:Boolean("Items", "Use Offensive Items", true)
if Ignite ~= nil then config.Combo:Boolean("AutoIgnite", "Auto Ignite", true) end

ts = TargetSelector(myHero:GetSpellData(_Q).range, TARGET_LOW_HP, DAMAGE_MAGIC, true)
config:TargetSelector("ts", "Target Selector", ts)

function CastIgnite()
	for _, enemy in pairs(GetEnemyHeroes()) do
		if Ignite and config.Combo.AutoIgnite:Value() then
			if IsReady(Ignite) and 20*GetLevel(myHero)+50 > GetHP(enemy)+GetHPRegen(enemy)*3 and ValidTarget(enemy, 600) then
				CastTargetSpell(enemy, Ignite)
			end 
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

-- Tick
OnTick(function()
	local target = ts:GetTarget()
	CastIgnite()
	
	if Mode() == "Combo" then
		-- Use Items
		if config.Combo.Items:Value() and Ready(GetItemSlot(myHero, 3146)) and ValidTarget(target, 700) and not kataR == true then
			CastTargetSpell(target, GetItemSlot(myHero, 3146))
		end	

		if config.Combo.Items:Value() and Ready(GetItemSlot(myHero, 3144)) and ValidTarget(target, 550) and not kataR == true then
			CastTargetSpell(target, GetItemSlot(myHero, 3144))
		end	

		-- Combo EQWR
		-- E
		if config.Combo.E:Value() and IsReady(_E) and ValidTarget(target, 725) and not kataR == true then	
        	CastSkillShot(_E, target.x, target.y, target.z)
		end

		-- Q
		if config.Combo.Q:Value() and IsReady(_Q) and ValidTarget(target, 625) and not kataR == true  then
			CastTargetSpell(target, _Q)
		end	
		
		-- W
		if ValidTarget(target, 300) and IsReady(_W) and not kataR == true then
			CastSpell(_W)
		end

		-- R
		if config.Combo.R:Value() and IsReady(_R) and not IsReady(_Q) and not IsReady(_W) and not IsReady(_E) then
			CastSpell(_R)
		end
    end
end)

OnProcessSpell(function(unit,spell)
	if unit == myHero and spell.name == "KatarinaR" then
		kataR = true
	end
end)

OnUpdateBuff(function(unit,buff)
	if unit == myHero and buff.Name == "katarinarsound" then
		kataR = true
	end
end)

OnRemoveBuff(function(unit,buff)
	if unit == myHero and buff.Name == "katarinarsound" then
		kataR = false
	end
end)

OnIssueOrder(function(orderProc)
	if (orderProc.flag == 2 or orderProc.flag == 3) and kataR == true and ValidTarget(GetCurrentTarget(),550) and Mode() == "Combo" then
		BlockOrder()
	end
end)

OnSpellCast(function(castProc)
	if kataR == true and castProc.spellID == 1 then
		BlockCast()
	end
end)