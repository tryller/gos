BlockOrder()
BlockCast()

ts = TargetSelector(myHero:GetSpellData(_Q).range, TARGET_LOW_HP, DAMAGE_MAGIC, true)
config:TargetSelector("ts", "Target Selector", ts)
local target = ts:GetTarget()

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

function ResetAA()
    if _G.IOW_Loaded then
        return IOW:ResetAA()
	elseif _G.PW_Loaded then
        return PW:ResetAA()
	elseif _G.DAC_Loaded then
        return DAC:ResetAA()
	elseif _G.AutoCarry_Loaded then
		return DACR:ResetAA()
	elseif _G.SLW_Loaded then
        return SLW:ResetAA()
    end
end

function SetAttack(boolean)
	if _G.IOW_Loaded then
		return IOW.attacksEnabled == (boolean)
	elseif _G.PW_Loaded then
        return PW.attacksEnabled == (boolean)
	elseif _G.DAC_Loaded then
        return DAC.attacksEnabled == (boolean)
	elseif _G.AutoCarry_Loaded then
        return DACR.attacksEnabled == (boolean)
	elseif _G.SLW_Loaded then
        return SLW.attacksEnabled == (boolean)
    end
end
