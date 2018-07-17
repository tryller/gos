if GetObjectName(GetMyHero()) ~= "Amumu" then return end

require ("DamageLib")
local config = Menu("Amumu", "Amumu")
config:SubMenu("Combo", "Combo Settings")
config.Combo:Boolean("Q", "Use Q", true)
config.Combo:Boolean("W", "Use W", true)
config.Combo:Boolean("E", "Use E", true)
config.Combo:Boolean("R", "Use R", true)
config.Combo:Slider("Mana", "Min. Mana For W", 50, 0, 100, 1)
config.Combo:Slider("MR", "Min. Enemy For R", 2, 1, 5, 1)

ts = TargetSelector(myHero:GetSpellData(_Q).range, TARGET_LOW_HP, DAMAGE_MAGIC, true)
config:TargetSelector("ts", "Target Selector", ts)

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
	local target = ts:GetTarget()
	if Mode() == "Combo" then
		if config.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 1100) then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero), target, GetMoveSpeed(target), 2000, 0.25, 1100, 30, true, true)
			if QPred.HitChance == 1 then	
				CastSkillShot(_Q, QPred.PredPos)
			end
		end	

		if config.Combo.E:Value() and Ready(_E) and ValidTarget(target, 350) then	
        	CastTargetSpell(target , _E)
		end

		if (myHero.mana/myHero.maxMana >= config.Combo.Mana:Value() /100) then
			if ValidTarget(target, 300) and Ready(_W)  then
				CastSpell(_W)
			end
		end

		if Ready(_R) and EnemiesAround(myHero, 550) >= config.Combo.MR:Value() and config.Combo.R:Value() then
			CastSpell(_R)
		end
	end
end)