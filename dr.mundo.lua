if GetObjectName(myHero) ~= "DrMundo" then return end

local config = Menu("DrMundo", "DrMundo")
config:SubMenu("Combo", "Combo")
config.Combo:Boolean("Q", "Use Q", true)
config.Combo:Boolean("W", "Use W", true)
config.Combo:Boolean("E", "Use E", true)

ts = TargetSelector(myHero:GetSpellData(_Q).range, TARGET_LOW_HP, DAMAGE_MAGIC, true)
ts = TargetSelector(myHero:GetSpellData(_W).range, TARGET_LOW_HP, DAMAGE_PHYSICAL, true)
config:TargetSelector("ts", "Target Selector", ts)

local WActive = false

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

function IsEnemyInRange(enemy, range)
	local result = 0
	if ValidTarget(enemy, range) then
		result = result + 1
	end

	return result
end

OnTick(function(myHero)
	local target = ts:GetTarget()
	if Mode() == "Combo" then
		if config.Combo.Q:Value() and ValidTarget(target, 975) then
			CastSkillShot(_Q, target.x, target.y, target.z)
		end

		if not WActive and config.Combo.W:Value() and EnemiesAround(myHeroPos(), 325) >= 1 then
			CastSpell(_W)
		else
			if WActive and EnemiesAround(myHeroPos(), 325) == 0 then
				CastSpell(_W)
			end
		end

		if config.Combo.E:Value() and ValidTarget(target, 300) then
			CastSpell(_E)
		end
	end
end)

OnUpdateBuff(function(unit,buff)
	if unit == myHero and buff.Name == "BurningAgony" then 
		WActive = true
	end
end)

OnRemoveBuff(function(unit,buff)
	if unit == myHero and buff.Name == "BurningAgony" then 
		WActive = false
	end
end)