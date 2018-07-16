if GetObjectName(GetMyHero()) ~= "MissFortune" then
	return
end

if not pcall( require, "Inspired" ) then
	PrintChat("You are missing Inspired.lua!")
	return
end

local myHitBox = GetHitBox(myHero)
local baseAS = GetBaseAttackSpeed(myHero)
local passiveMinion = nil

local mainMenu = Menu("Miss Fortune", "MissFortune")
mainMenu:Menu("Combo", "Combo")
mainMenu.Combo:Boolean("useQ", "Use Q", true)
mainMenu.Combo:Boolean("useQminion", "Use Q through minion", true)
mainMenu.Combo:Boolean("useAutoQ", "Use auto Q through dead minion", true)
mainMenu.Combo:Boolean("useW", "Use W", true)
mainMenu.Combo:Boolean("useE", "Use E", true)

mainMenu:Menu("Keys", "Keys")
mainMenu.Keys:Key("comboKey", "Combo Key", string.byte("32"))

mainMenu:Menu("Items", "Items")
mainMenu.Items:Boolean("useCut", "Bilgewater Cutlass", true)
mainMenu.Items:Boolean("useBork", "Blade of the Ruined King", true)
mainMenu.Items:Boolean("useGhost", "Youmuu's Ghostblade", true)
mainMenu.Items:Boolean("useElixir", "Elixir of Wrath", true)

OnProcessSpell(function(unit,spell)
	if unit == myHero and spell.name:lower():find("attack") and spell.target == GetCurrentTarget() and mainMenu.Keys.comboKey:Value() and mainMenu.Combo.useW:Value() and CanUseSpell(myHero,_W) == READY then
		CastSpell(_W)
	end

	if unit == myHero and spell.name == "MissFortuneBulletTime" then
		-- TODO CANCEL ORBWALKING
	end
end)

OnProcessSpellComplete(function(unit, spell)

end)

OnCreateObj(function(Object)
	if GetObjectBaseName(Object) == "MissFortune_Base_P_Mark.troy" then
		passive = Object
	end
end)

OnUpdateBuff(function(unit,buff)
	if unit == myHero and buff.Name == "missfortunebulletsound" then
		-- TODO CANCEL ORBWALKING
	end
end)

OnRemoveBuff(function(unit,buff)
	if unit == myHero and buff.Name == "missfortunebulletsound" then
		-- TODO CANCEL ORBWALKING
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
	if passive ~= nil then
		passiveMinion = ClosestMinion((GetOrigin(passive)), ENEMY)
		if GetDistance(passiveMinion,passive) > 10 then
			passiveMinion = nil
		end
	end

	target = GetCurrentTarget()
	local myHeroPos = GetOrigin(myHero)
	local myHeroRange = GetRange(myHero)

	-- Items
	local CutBlade = GetItemSlot(myHero,3144)
	local bork = GetItemSlot(myHero,3153)
	local ghost = GetItemSlot(myHero,3142)
	local redpot = GetItemSlot(myHero,2140)

	if Mode() == "Combo" then
		if CutBlade >= 1 and ValidTarget(target,550) and mainMenu.Items.useCut:Value() then
			if CanUseSpell(myHero,GetItemSlot(myHero,3144)) == READY then
				CastTargetSpell(target, GetItemSlot(myHero,3144))
			end	
		elseif bork >= 1 and ValidTarget(target,550) and (GetMaxHP(myHero) / GetCurrentHP(myHero)) >= 1.25 and mainMenu.Items.useBork:Value() then 
			if CanUseSpell(myHero,GetItemSlot(myHero,3153)) == READY then
				CastTargetSpell(target,GetItemSlot(myHero,3153))
			end
		end

		if ghost >= 1 and ValidTarget(target,550+myHitBox) and mainMenu.Items.useGhost:Value() then
			if CanUseSpell(myHero,GetItemSlot(myHero,3142)) == READY then
				CastSpell(GetItemSlot(myHero,3142))
			end
		end
	
		if redpot >= 1 and ValidTarget(target,550+myHitBox) and mainMenu.Items.useElixir:Value() then
			if CanUseSpell(myHero,GetItemSlot(myHero,2140)) == READY then
				CastSpell(GetItemSlot(myHero,2140))
			end
		end

		if CanUseSpell(myHero,_Q) == READY and mainMenu.Combo.useQ then
			CastSpell(_W)
			CastTargetSpell(target,_Q)
		end


		if CanUseSpell(myHero,_E) == READY and ValidTarget(target, 1000) and not IsInDistance(target, 550 + myHitBox) and mainMenu.Combo.useE:Value() then
			local EPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),math.huge, 250, 1000, 1000, false, true)
			if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
			end
		elseif CanUseSpell(myHero,_E) == READY and ValidTarget(target, 600) and mainMenu.Combo.useE:Value() then
			local EPred = GetPredictionForPlayer(myHeroPos, target, GetMoveSpeed(target),math.huge, 250, 1000, 1000, false, true)
			if EPred.HitChance == 1 and GetDistance(myHero, Vector(EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)) < 200 then
				CastSkillShot(_E, EPred.PredPos)
			end
		end
	end
end)

function VectorWay(A,B)
	WayX = B.x - A.x
	WayY = B.y - A.y
	WayZ = B.z - A.z
	return Vector(WayX, WayY, WayZ)
end