if GetObjectName(GetMyHero()) ~= "Kayn" then return end

if not pcall( require, "Inspired" ) then PrintChat("You are missing Inspired.lua!") return end

local mainMenu = Menu("Kayn", "Kayn")
mainMenu:Menu("Combo", "To combo press Space Bar")
function GetRdmg()

	local totalDmg = 0

	local rLvl = myHero:GetSpellData(_R).level
	if rLvl > 0 then
		local baseDmg = ({ 150, 250, 350 })[rLvl]
		local bonusAd = 1.75
		totalDmg = baseDmg + (bonusAd * GetBonusDmg(myHero))
	end

	return totalDmg
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

OnTick(function(myHero)
	local enemy = GetCurrentTarget()

	if Mode() == "Combo" then
		if CanUseSpell(myHero,_Q) == READY and ValidTarget(enemy, myHero:GetSpellData(_Q).range) then
			CastTargetSpell(enemy,_Q)
		elseif CanUseSpell(myHero,_W) == READY and ValidTarget(enemy, myHero:GetSpellData(_W).range) then
			CastTargetSpell(enemy,_W)
		elseif CanUseSpell(myHero,_R) == READY and ValidTarget(enemy, myHero:GetSpellData(_R).range) and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, GetRdmg()) then
			CastTargetSpell(enemy,_R)
		end
	end
end)