-- changelog 1.0
-- by Savior
-- Please report any bugs you find ill fix it asap.
-- credits to GoS Scripting tuts ( very helpful )
-- dont hate my script, im just a begginer.

-- todo 
-- auto Harass
-- Laneclear and jungleclear




-- 
function Mode()
	if _G.IOW_Loaded and IOW:Mode() then
		return IOW:Mode()
	elseif GoSWalkLoaded and GoSWalk.CurrentMode then
		return ({"Combo", "Harass", "LaneClear", "LastHit"})[GoSWalk.CurrentMode+1]
	elseif _G.DAC_Loaded and DAC:Mode() then
		return DAC:Mode()
	elseif _G.AutoCarry_Loaded and DACR:Mode() then
		return DACR:Mode()
	end
end

OnProcessSpell(function(unit, spell)
	if unit == myHero then
		if spell.name:lower():find("attack") then
			DelayAction(function()
				AA = true
			end, GetWindUp(myHero)+0.01)
		else
			AA = false
		end
	end
end)


if GetObjectName(GetMyHero()) ~= "Darius" then return end

-- Combo
local mainMenu = Menu("Darius the Savior", "S-Darius")
mainMenu:Menu("Combo", "Combo")
mainMenu.Combo:Boolean("useQ", "Use Q", true)
mainMenu.Combo:Slider("mana1", "minimum mana", 20, 10, 90)
mainMenu.Combo:Boolean("useW", "Use W", true)
mainMenu.Combo:Slider("mana2", "minimum mana", 20, 10, 90)
mainMenu.Combo:Boolean("useE", "Use E", true)
mainMenu.Combo:Slider("mana3", "minimum mana", 20, 10, 90)
mainMenu.Combo:Boolean("useR", "Use R", true)
mainMenu.Combo:Slider("mana4", "minimum mana", 20, 10, 90) 



-- Rdmg
function GetRdmg()

	local totalDmg = 0

	local rLvl = myHero:GetSpellData(_R).level
	if rLvl > 0 then
		local baseDmg = ({ 100, 200, 300 })[rLvl]
		local bonusAd = 1.55
		totalDmg = baseDmg + (bonusAd * GetBonusDmg(myHero))
	end

	return totalDmg
end

-- autoattack
local lastaa = 0
local aawind = 0
local aaanim = 0
local lastmove = 0
local lastkillsteal = 0
local aarange = myHero.range + myHero.boundingRadius

OnProcessSpellAttack(function(unit, aa)
if unit.isMe then
lastaa = GetTickCount()
aawind = ( aa.windUpTime * 1000 ) - 30
aaanim = ( aa.animationTime * 1000 ) - 125
end
end)


-- func
OnTick(function(myHero)
	if KeyIsDown(32) == true then
		q()
		w()
		e()
		r()
	end
end)

function q()
	local enemy = GetCurrentTarget()
		if mainMenu.Combo.useQ:Value() and CanUseSpell(myHero,_Q) == READY and ValidTarget(enemy, 410) and mainMenu.Combo.mana1:Value() < GetPercentMP(myHero) then
			CastTargetSpell(enemy, _Q)
		end
end

function w()
	local enemy = GetCurrentTarget()
		if mainMenu.Combo.useW:Value() and CanUseSpell(myHero,_W) == READY and ValidTarget(enemy, 175) and mainMenu.Combo.mana2:Value() < GetPercentMP(myHero) then
			CastTargetSpell(enemy, _W)
			IOW:ResetAA()
		end
end

function e()
	local enemy = GetCurrentTarget()
		if mainMenu.Combo.useE:Value() and CanUseSpell(myHero,_E) == READY and ValidTarget(enemy, 520) and mainMenu.Combo.mana3:Value() < GetPercentMP(myHero) then
			CastTargetSpell(enemy, _E)
			IOW:ResetAA()
		end
end

function r()
	local enemy = GetCurrentTarget()
		if mainMenu.Combo.useR:Value() and CanUseSpell(myHero,_R) == READY and ValidTarget(enemy, myHero:GetSpellData(_R).range) and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, GetRdmg()) then
			CastTargetSpell(enemy,_R)
  end
end