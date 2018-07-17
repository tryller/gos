if GetObjectName(GetMyHero()) ~= "Ashe" then return end

require('Inspired') 
require('DeftLib')
require('DamageLib')

local config = MenuConfig("Ashe", "Ashe")
config:Menu("Combo", "Combo")
config.Combo:Boolean("Q", "Use Q", true)
config.Combo:Boolean("W", "Use W", true)
config.Combo:Boolean("R", "Use R", true)
config.Combo:Boolean("Items", "Use Items", true)
config.Combo:Slider("myHP", "if HP % <", 50, 0, 100, 1)
config.Combo:Slider("targetHP", "if Target HP % >", 20, 0, 100, 1)
config.Combo:Boolean("QSS", "Use QSS", true)
config.Combo:Slider("QSSHP", "if HP % <", 75, 0, 100, 1)

config:Menu("Interrupt", "Interrupt (R)")
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

OnProcessSpell(function(unit, spell)
	if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and IsReady(_R) then
		if CHANELLING_SPELLS[spell.name] then
			if ValidTarget(unit, 1000) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and config.Interrupt[GetObjectName(unit).."Inter"]:Value() then 
				Cast(_R, unit)
			end
		end
	end
end)

ts = TargetSelector(myHero:GetSpellData(_W).range, TARGET_LOW_HP, DAMAGE_PHYSICAL, true)
config:TargetSelector("ts", "Target Selector", ts)

local QReady = false

OnTick(function(myHero)
	local target = ts:GetTarget()
    local QSS = GetItemSlot(myHero,3140) > 0 and GetItemSlot(myHero,3140) or GetItemSlot(myHero,3139) > 0 and GetItemSlot(myHero,3139) or nil
    local BRK = GetItemSlot(myHero,3153) > 0 and GetItemSlot(myHero,3153) or GetItemSlot(myHero,3144) > 0 and GetItemSlot(myHero,3144) or nil
    local YMG = GetItemSlot(myHero,3142) > 0 and GetItemSlot(myHero,3142) or nil

	if Mode() == "Combo" then
		if BRK and IsReady(BRK) and config.Combo.Items:Value() and ValidTarget(target, 550) and GetPercentHP(myHero) < config.Combo.myHP:Value() and GetPercentHP(enemy) > config.Combo.targetHP:Value() then
			CastTargetSpell(target, BRK)
        end

		if YMG and IsReady(YMG) and config.Combo.Items:Value() and ValidTarget(target, 600) then
			CastSpell(YMG)
		end	

		if IsReady(_Q) and QReady and ValidTarget(target, 400) and config.Combo.Q:Value() then
			CastSpell(_Q)
		end
						
		if IsReady(_W) and ValidTarget(target, 1200) and config.Combo.W:Value() then
			Cast(_W, target)
		end
						
		if IsReady(_R) and ValidTarget(target, 2000) and GetPercentHP(target) <= 50 and config.Combo.R:Value() then
			Cast(_R, target)
		end
		
		if QSS and IsReady(QSS) and config.Combo.QSS:Value() and IsImmobile(myHero) or IsSlowed(myHero) or toQSS and GetPercentHP(myHero) < config.Combo.QSSHP:Value() then
			CastSpell(QSS)
		end

	end
end)

OnUpdateBuff(function(unit,buff)
	if unit == myHero and buff.Name == "asheqcastready" then 
		QReady = true
	end
end)

OnRemoveBuff(function(unit,buff)
	if unit == myHero and buff.Name == "asheqcastready" then 
		QReady = false
	end
end)

OnCreateObj(function(Object) 
	if GetObjectBaseName(Object) == "Ashe_Base_Q_ready.troy" and GetDistance(Object) < 100 then
		QReady = true
	end
end)

OnDeleteObj(function(Object) 
	if GetObjectBaseName(Object) == "Ashe_Base_Q_ready.troy" and GetDistance(Object) < 100 then
		QReady = false
	end
end)

AddGapcloseEvent(_R, 69, false, config)