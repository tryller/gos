if GetObjectName(myHero) ~= "Teemo" then return end

local mainMenu = Menu("Teemo", "Teemo")
mainMenu:Menu("Combo", "Combo")
mainMenu.Combo:Boolean("useQ", "Use Q", true)
mainMenu.Combo:Slider("mana1", "minimum mana", 20, 10, 90)
mainMenu.Combo:Boolean("useR", "Use R", true)
mainMenu.Combo:Slider("mana2", "minimum mana", 20, 10, 90)
mainMenu.Combo:Boolean("useL1", "laneclear q", true)
mainMenu.Combo:Boolean("useL2", "laneclear r", true)

-- Orbwalker's
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
	if Mode() == "Combo" then
		q()
		r()
	end

	if Mode() == "LaneClear" then
		l()
	end
end)

function q()
	local enemy = GetCurrentTarget()
		if mainMenu.Combo.useQ:Value() and CanUseSpell(myHero,_Q) == READY and ValidTarget(enemy, 580) and mainMenu.combo.mana1:Value() < GetPercentMP(myHero) then
			CastTargetSpell(enemy, _Q)
		end
end

function r()
	local enemy = GetCurrentTarget()
		if mainMenu.Combo.useR:Value() and CanUseSpell(myHero,_R) == READY and ValidTarget(enemy, (250+ 150*GetCastLevel(myHero,_R))) and mainMenu.combo.mana2:Value() < GetPercentMP(myHero) then
			CastTargetSpell(enemy, _R)
		end
end

function l()
--ugh
	if KeyIsDown(86) == true then
		for i,dude in pairs(minionManager.objects) do
			if GetTeam(dude) == MINION_JUNGLE and IsReady(_Q) and ValidTarget(dude, GetCastRange(myHero, _Q)) and mainMenu.Combo.useL1:Value() and mainMenu.combo.mana1:Value() < GetPercentMP(myHero) then
				CastTargetSpell(dude, _Q)
			end
			if GetTeam(dude) == MINION_JUNGLE and IsReady(_R) and ValidTarget(dude, (250+ 150*GetCastLevel(myHero,_R))) and mainMenu.Combo.useL2:Value() and mainMenu.combo.mana2:Value() < GetPercentMP(myHero) then
				CastTargetSpell(dude, _R)
			end
			if GetTeam(dude) == MINION_ENEMY and IsReady(_Q) and ValidTarget(dude, GetCastRange(myHero, _Q))and mainMenu.Combo.useL1:Value() and mainMenu.combo.mana1:Value() < GetPercentMP(myHero) then
				CastTargetSpell(dude, _Q)
			end
			if GetTeam(dude) == MINION_ENEMY and IsReady(_R) and ValidTarget(dude, (250+ 150*GetCastLevel(myHero,_R))) and mainMenu.Combo.useL2:Value() and mainMenu.combo.mana2:Value() < GetPercentMP(myHero) then
				CastTargetSpell(dude, _R)
			end
		end	
	end
end
