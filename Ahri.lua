if GetObjectName(GetMyHero()) ~= "Ahri" then return end

require('Inspired')
require('DeftLib')
require('DamageLib')

local menu = MenuConfig("Ahri", "Ahri")
menu:Menu("Combo", "Combo")
menu.Combo:Boolean("Q", "Use Q", true)
menu.Combo:Boolean("W", "Use W", true)
menu.Combo:Boolean("E", "Use E", true)
menu.Combo:Boolean("R", "Use R", false)
menu.Combo:DropDown("RMode", "R Mode", 1, {"Logic", "to mouse"})

menu:Menu("Harass", "Harass")
menu.Harass:Boolean("Q", "Use Q", true)
menu.Harass:Boolean("W", "Use W", true)
menu.Harass:Boolean("E", "Use E", true)
menu.Harass:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

menu:Menu("Killsteal", "Killsteal")
menu.Killsteal:Boolean("Q", "Killsteal with Q", true)
menu.Killsteal:Boolean("W", "Killsteal with W", true)
menu.Killsteal:Boolean("E", "Killsteal with E", true)

if Ignite ~= nil then 
menu:Menu("Misc", "Misc")
menu.Misc:Boolean("Autoignite", "Auto Ignite", true) 
end

menu:Menu("Lasthit", "Lasthit")
menu.Lasthit:Boolean("Q", "Use Q", true)
menu.Lasthit:Slider("Mana", "if Mana % >", 50, 0, 80, 1)

menu:Menu("LaneClear", "LaneClear")
menu.LaneClear:Boolean("Q", "Use Q", true)
menu.LaneClear:Boolean("W", "Use W", false)
menu.LaneClear:Boolean("E", "Use E", false)
menu.LaneClear:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

menu:Menu("JungleClear", "JungleClear")
menu.JungleClear:Boolean("Q", "Use Q", true)
menu.JungleClear:Boolean("W", "Use W", true)
menu.JungleClear:Boolean("E", "Use E", true)
menu.JungleClear:Slider("Mana", "if Mana % >", 30, 0, 80, 1)

menu:Menu("Interrupt", "Interrupt (E)")
DelayAction(function()
  local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
  for i, spell in pairs(CHANELLING_SPELLS) do
    for _,k in pairs(GetEnemyHeroes()) do
        if spell["Name"] == GetObjectName(k) then
        menu.Interrupt:Boolean(GetObjectName(k).."Inter", "On "..GetObjectName(k).." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
        end
    end
  end
end, 1)

OnProcessSpell(function(unit, spell)
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) and IsReady(_E) then
      if CHANELLING_SPELLS[spell.name] then
        if ValidTarget(unit, 1000) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and menu.Interrupt[GetObjectName(unit).."Inter"]:Value() then 
        Cast(_E,unit)
        end
      end
    end
end)

local target1 = TargetSelector(930,TARGET_LESS_CAST_PRIORITY,DAMAGE_MAGIC,true,false)
local target2 = TargetSelector(1030,TARGET_LESS_CAST_PRIORITY,DAMAGE_MAGIC,true,false)
local target3 = TargetSelector(900,TARGET_LESS_CAST_PRIORITY,DAMAGE_MAGIC,true,false)
local UltOn = false
local Missiles = {}

OnCreateObj(function(Object) 
  if GetObjectBaseName(Object) == "missile" then
  table.insert(Missiles,Object) 
  end
end)

OnDeleteObj(function(Object)
  if GetObjectBaseName(Object) == "missile" then
    for i,rip in pairs(Missiles) do
      if GetNetworkID(Object) == GetNetworkID(rip) then
      table.remove(Missiles,i) 
      end
    end
  end
end)

OnTick(function(myHero)

    local target = GetCurrentTarget()
    local Qtarget = target1:GetTarget()
    local Etarget = target2:GetTarget()
    local Rtarget = target3:GetTarget()
    local mousePos = GetMousePos()
    
    if IOW:Mode() == "Combo" then

        if IsReady(_E) and menu.Combo.E:Value() then
        Cast(_E,Etarget)
        end
	
        if menu.Combo.RMode:Value() == 1 and menu.Combo.R:Value() and ValidTarget(Rtarget,900) then
          local BestPos = Vector(Rtarget) - (Vector(Rtarget) - Vector(myHero)):perpendicular():normalized() * 350
	  if UltOn and BestPos then
          CastSkillShot(_R,BestPos)
          elseif IsReady(_R) and BestPos and getdmg("Q",Rtarget)+getdmg("W",Rtarget,myHero,3)+getdmg("E",Rtarget)+getdmg("R",Rtarget) > GetHP2(Rtarget) then
	  CastSkillShot(_R,BestPos)
	  end
	end

        if menu.Combo.RMode:Value() == 2 and menu.Combo.R:Value() and ValidTarget(Rtarget,900)then
          local AfterTumblePos = GetOrigin(myHero) + (Vector(mousePos) - GetOrigin(myHero)):normalized() * 550
          local DistanceAfterTumble = GetDistance(AfterTumblePos, Rtarget)
   	  if UltOn and DistanceAfterTumble < 550 then
	  CastSkillShot(_R,mousePos)
          elseif IsReady(_R) and getdmg("Q",Rtarget)+getdmg("W",Rtarget,myHero,3)+getdmg("E",Rtarget)+getdmg("R",Rtarget) > GetHP2(Rtarget) then
	  CastSkillShot(_R,mousePos) 
          end
	end
			
	if IsReady(_W) and ValidTarget(target,700) and menu.Combo.W:Value() then
	CastSpell(_W)
	end
		
	if IsReady(_Q) and menu.Combo.Q:Value() then
        Cast(_Q,Qtarget)
        end
					
    end
	
    if IOW:Mode() == "Harass" and GetPercentMP(myHero) >= menu.Harass.Mana:Value() then

        if IsReady(_E) and menu.Harass.E:Value() then
        Cast(_E,target)
        end
				
        if IsReady(_W) and ValidTarget(target, 700) and menu.Harass.W:Value() then
	CastSpell(_W)
	end
		
	if IsReady(_Q) and menu.Harass.Q:Value() then
        Cast(_Q,target)
        end
		
    end
	
    for i,enemy in pairs(GetEnemyHeroes()) do
    	
	if Ignite and menu.Misc.Autoignite:Value() then
          if IsReady(Ignite) and 20*GetLevel(myHero)+50 > GetHP(enemy)+GetHPRegen(enemy)*3 and ValidTarget(enemy, 600) then
          CastTargetSpell(enemy, Ignite)
          end
        end
                
	if IsReady(_W) and ValidTarget(enemy, 930) and menu.Killsteal.W:Value() and GetHP2(enemy) < getdmg("W",enemy,myHero,3) then
	CastSpell(_W)
	elseif IsReady(_Q) and ValidTarget(enemy, 700) and menu.Killsteal.Q:Value() and GetHP2(enemy) < getdmg("Q",enemy) then 
	Cast(_Q,enemy)
	elseif IsReady(_E) and ValidTarget(enemy, 1030) and menu.Killsteal.E:Value() and GetHP2(enemy) < getdmg("E",enemy) then
	Cast(_E,enemy)
        end

    end
     
    if IOW:Mode() == "LaneClear" then
     	
        local closeminion = ClosestMinion(GetOrigin(myHero), MINION_ENEMY)
        if GetPercentMP(myHero) >= menu.LaneClear.Mana:Value() then
       	
         if IsReady(_Q) and menu.LaneClear.Q:Value() then
           local BestPos, BestHit = GetLineFarmPosition(880, 50, MINION_ENEMY)
           if BestPos and BestHit > 2 then 
           CastSkillShot(_Q, BestPos)
           end
	 end

         if IsReady(_W) and menu.LaneClear.W:Value() then
           if GetCurrentHP(closeminion) < getdmg("W",closeminion,myHero,3) and ValidTarget(closestminion, 700) then
           CastSpell(_W)
           end
         end

         if IsReady(_E) and menu.LaneClear.E:Value() then
           if GetCurrentHP(closeminion) < getdmg("E",closeminion) and ValidTarget(closestminion, 1000) then
           CastSkillShot(_E, GetOrigin(closeminion))
           end
         end
        
        end

    end
         
    for i,mobs in pairs(minionManager.objects) do
        if IOW:Mode() == "LaneClear" and GetTeam(mobs) == 300 and GetPercentMP(myHero) >= menu.JungleClear.Mana:Value() then
          if IsReady(_Q) and menu.JungleClear.Q:Value() and ValidTarget(mobs, 880) then
          CastSkillShot(_Q,GetOrigin(mobs))
	  end
		
	  if IsReady(_W) and menu.JungleClear.W:Value() and ValidTarget(mobs, 700) then
	  CastSpell(_W)
	  end
		
	  if IsReady(_E) and menu.JungleClear.E:Value() and ValidTarget(mobs, 1000) then
	  CastSkillShot(_E,GetOrigin(mobs))
          end
        end
     	
	if IOW:Mode() == "LastHit" and GetTeam(mobs) == MINION_ENEMY and GetPercentMP(myHero) >= menu.Lasthit.Mana:Value() then
	  if IsReady(_Q) and ValidTarget(mobs, 880) and menu.Lasthit.Q:Value() and GetCurrentHP(mobs)-GetDamagePrediction(mobs, 250+GetDistance(mobs)/2500) < getdmg("Q",mobs) and GetCurrentHP(mobs)-GetDamagePrediction(mobs, 250+GetDistance(mobs)/2500) > 0 then
          CastSkillShot(_Q, GetOrigin(mobs))
       	  end
        end
    end       

end)
 
OnUpdateBuff(function(unit,buff)
  if buff.Name == "ahritumble" then 
  UltOn = true
  end
end)

OnRemoveBuff(function(unit,buff)
  if buff.Name == "ahritumble" then 
  UltOn = false
  end
end)

AddGapcloseEvent(_E, 666, false, menu)
