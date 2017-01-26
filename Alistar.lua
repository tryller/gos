if GetObjectName(GetMyHero()) ~= "Alistar" then return end

require('Inspired')
require('DeftLib')
require('DamageLib')

local menu = MenuConfig("Alistar", "Alistar")
menu:Menu("Combo", "Combo")
menu.Combo:Boolean("Q", "Use Q", true)
menu.Combo:Boolean("WQ", "Use W+Q Combo", true)
 
menu:Menu("Harass", "Harass")
menu.Harass:Boolean("Q", "Use Q", true)
menu.Harass:Boolean("WQ", "Use W+Q Combo", true)
menu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

menu:Menu("Killsteal", "Killsteal")
menu.Killsteal:Boolean("Q", "Killsteal with Q", true)
menu.Killsteal:Boolean("W", "Killsteal with W", true)
menu.Killsteal:Boolean("WQ", "Killsteal with W+Q", true)

menu:Menu("Misc", "Misc")
if Ignite ~= nil then
menu.Misc:Boolean("Autoignite", "Auto Ignite", true)
end

menu:Menu("Drawings", "Drawings")
menu.Drawings:Boolean("Q", "Draw Q Range", true)
menu.Drawings:Boolean("W", "Draw W Range", true)
menu.Drawings:Boolean("E", "Draw E Range", true)

menu:Menu("Interrupt", "Interrupt")
menu.Interrupt:Menu("SupportedSpells", "Supported Spells")
menu.Interrupt.SupportedSpells:Boolean("Q", "Use Q", true)
menu.Interrupt.SupportedSpells:Boolean("W", "Use W", true)

DelayAction(function()
  local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
  for i, spell in pairs(CHANELLING_SPELLS) do
    for _,k in pairs(GetEnemyHeroes()) do
        if spell["Name"] == GetObjectName(k) then
        menu.Interrupt:Boolean(GetObjectName(k).."Inter", "On "..GetObjectName(k).." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
        end
    end
  end
end, 0)

OnProcessSpell(function(unit, spell)
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) then
      if CHANELLING_SPELLS[spell.name] then
        if ValidTarget(unit, 650) and IsReady(_W) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and menu.Interrupt[GetObjectName(unit).."Inter"]:Value() and menu.Interrupt.SupportedSpells.W:Value() then
        CastTargetSpell(unit, _W)
        elseif ValidTarget(unit, 365) and IsReady(_Q) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and menu.Interrupt[GetObjectName(unit).."Inter"]:Value() and menu.Interrupt.SupportedSpells.Q:Value() then
        CastSpell(_Q)
        end
      end
    end
end)
  
OnDraw(function(myHero)
local pos = GetOrigin(myHero)
if menu.Drawings.Q:Value() then DrawCircle(pos,365,1,25,GoS.Pink) end
if menu.Drawings.W:Value() then DrawCircle(pos,650,1,25,GoS.Yellow) end
if menu.Drawings.E:Value() then DrawCircle(pos,575,1,25,GoS.Blue) end
end)

local target1 = TargetSelector(650,TARGET_LESS_CAST_PRIORITY,DAMAGE_MAGIC,true,false)

OnTick(function(myHero)
    local target = GetCurrentTarget()
    local Wtarget = target1:GetTarget()
	
    if IOW:Mode() == "Combo" then

	if IsReady(_Q) and menu.Combo.Q:Value() and ValidTarget(target,365) then
        CastSpell(_Q)
        end
		
        if IsReady(_W) and IsReady(_Q) and menu.Combo.WQ:Value() and ValidTarget(Wtarget,650) and GetCurrentMana(myHero) >= GetCastMana(myHero,_Q,GetCastLevel(myHero,_Q)) + GetCastMana(myHero,_W,GetCastLevel(myHero,_W)) then
        CastTargetSpell(Wtarget, _W)
	CastSpell(_Q)
        end

    end
    
    if IOW:Mode() == "Harass" and GetPercentMP(myHero) >= menu.Harass.Mana:Value() then

	if IsReady(_Q) and menu.Harass.Q:Value() and ValidTarget(target,365) then
        CastSpell(_Q)
        end
		
        if IsReady(_W) and IsReady(_Q) and menu.Harass.WQ:Value() and ValidTarget(Wtarget,650) and GetCurrentMana(myHero) >= GetCastMana(myHero,_Q,GetCastLevel(myHero,_Q)) + GetCastMana(myHero,_W,GetCastLevel(myHero,_W)) then
        CastTargetSpell(Wtarget, _W)
	CastSpell(_Q)
        end

    end
    
    for i,enemy in pairs(GetEnemyHeroes()) do
		
      if Ignite and menu.Misc.Autoignite:Value() then
        if IsReady(Ignite) and 20*GetLevel(myHero)+50 > GetHP(enemy)+GetHPRegen(enemy)*3 and ValidTarget(enemy, 600) then
        CastTargetSpell(enemy, Ignite)
        end
      end
		
      if IsReady(_Q) and ValidTarget(enemy, 365) and menu.Killsteal.Q:Value() and GetHP2(enemy) < getdmg("Q",enemy) then 
      CastSpell(_Q)
      elseif IsReady(_W) and ValidTarget(enemy, 650) and menu.Killsteal.W:Value() and GetHP2(enemy) < getdmg("W",enemy) then
      CastTargetSpell(enemy, _W)
      elseif IsReady(_W) and IsReady(_Q) and GetCurrentMana(myHero) >= GetCastMana(myHero,_Q,GetCastLevel(myHero,_Q)) + GetCastMana(myHero,_W,GetCastLevel(myHero,_W)) and ValidTarget(enemy, 650) and menu.Killsteal.WQ:Value() and GetHP2(enemy) < getdmg("Q",enemy)+getdmg("W",enemy) then
      CastTargetSpell(enemy, _W)
	CastSpell(_Q)
      end
		
    end

end)

AddGapcloseEvent(_Q, 365, false, menu)
AddGapcloseEvent(_W, 650, true, menu)
