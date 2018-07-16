if GetObjectName(GetMyHero()) ~= "Blitzcrank" then return end

require('Inspired')
require('DeftLib')
require('DamageLib')

local mainMenu = MenuConfig("Blitzcrank", "Blitzcrank")
mainMenu:Menu("Combo", "Combo")
mainMenu.Combo:Boolean("Q", "Use Q", true)
mainMenu.Combo:Boolean("W", "Use W", true)
mainMenu.Combo:Boolean("E", "Use E", true)
mainMenu.Combo:Boolean("AutoE", "Auto E after Grab", true)
mainMenu.Combo:Boolean("R", "Use R", true)

mainMenu:Menu("AutoGrab", "Auto Grab")
mainMenu.AutoGrab:Slider("min", "Min Distance", 200, 100, 400, 1)
mainMenu.AutoGrab:Slider("max", "Max Distance", 975, 400, 975, 1)
mainMenu.AutoGrab:Menu("Enemies", "Enemies to Auto-Grab")

mainMenu:Menu("Harass", "Harass")
mainMenu.Harass:Boolean("Q", "Use Q", true)
mainMenu.Harass:Boolean("E", "Use E", true)
mainMenu.Harass:Slider("Mana", "if Mana % is More than", 30, 0, 80, 1)

mainMenu:Menu("Killsteal", "Killsteal")
mainMenu.Killsteal:Boolean("Q", "Killsteal with Q", true)
mainMenu.Killsteal:Boolean("R", "Killsteal with R", true)

if Ignite ~= nil then 
mainMenu:Menu("Misc", "Misc")
mainMenu.Misc:Boolean("Autoignite", "Auto Ignite", true) 
end
	
mainMenu:Menu("Interrupt", "Interrupt")
mainMenu.Interrupt:Menu("SupportedSpells", "Supported Spells")
mainMenu.Interrupt.SupportedSpells:Boolean("Q", "Use Q", true)
mainMenu.Interrupt.SupportedSpells:Boolean("R", "Use R", true)

local MissedGrabs = 0
local SuccesfulGrabs = 0
local TotalGrabs = MissedGrabs + SuccesfulGrabs
local Percentage = ((SuccesfulGrabs*100)/TotalGrabs)

DelayAction(function()
  local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
  for i, spell in pairs(CHANELLING_SPELLS) do
    for _,k in pairs(GetEnemyHeroes()) do
        if spell["Name"] == GetObjectName(k) then
        mainMenu.Interrupt:Boolean(GetObjectName(k).."Inter", "On "..GetObjectName(k).." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
        end
    end
  end
  for _,k in pairs(GetEnemyHeroes()) do
  mainMenu.AutoGrab.Enemies:Boolean(GetObjectName(k).."AutoGrab", "On "..GetObjectName(k).." ", false)
  end
end, 1)

OnProcessSpell(function(unit, spell)
    if GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) then
      if CHANELLING_SPELLS[spell.name] then
        if ValidTarget(unit, 975) and IsReady(_Q) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and mainMenu.Interrupt[GetObjectName(unit).."Inter"]:Value() and mainMenu.Interrupt.SupportedSpells.Q:Value() then
        Cast(_Q,unit)
        elseif ValidTarget(unit, 600) and IsReady(_R) and GetObjectName(unit) == CHANELLING_SPELLS[spell.name].Name and mainMenu.Interrupt[GetObjectName(unit).."Inter"]:Value() and mainMenu.Interrupt.SupportedSpells.R:Value() then
        CastSpell(_R)
        end
      end
    end
	
    if unit == myHero and spell.name == "RocketGrab" then
    MissedGrabs = MissedGrabs + 1
    end
end)

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

local target1 = TargetSelector(1010,TARGET_LESS_CAST_PRIORITY,DAMAGE_MAGIC,true,false)
OnTick(function(myHero)
    local target = GetCurrentTarget()
    local Qtarget = target1:GetTarget()
	if Mode() == "Combo" then
	
                if IsReady(_Q) and mainMenu.Combo.Q:Value() then
                Cast(_Q,Qtarget)
	        end
                
                if IsReady(_W) and ValidTarget(target, 1275) and mainMenu.Combo.W:Value() then  
                  if GetCurrentMana(myHero) >= 200 and IsReady(_Q) and GetDistance(target) >= 975 then
                  CastSpell(_W)
                  elseif GetDistance(target) <= 400 then
		  CastSpell(_W)
		  end
		end
		
                if IsReady(_E) and IsInDistance(target, 250) and mainMenu.Combo.E:Value() then
                CastSpell(_E)
		end
		              
		if IsReady(_R) and ValidTarget(target, 600) and mainMenu.Combo.R:Value() and GetPercentHP(target) < 60 then
                CastSpell(_R)
	        end
	                      
	end	
	
	if Mode() == "Harass" and GetPercentMP(myHero) >= mainMenu.Harass.Mana:Value() then
	
                if IsReady(_Q) and mainMenu.Harass.Q:Value() then
                Cast(_Q,Qtarget)
	        end
		
		if IsReady(_E) and IsInDistance(target, 250) and mainMenu.Harass.E:Value() then
                CastSpell(_E)
		end
		
	end
	
	for i,enemy in pairs(GetEnemyHeroes()) do
		
		if mainMenu.AutoGrab.Enemies[GetObjectName(enemy).."AutoGrab"]:Value() and ValidTarget(enemy) then
		  if IsReady(_Q) and GetDistance(enemy) <= mainMenu.AutoGrab.max:Value() and GetDistance(enemy) >= mainMenu.AutoGrab.min:Value() then
		  Cast(_Q,enemy)
		  end
		end
		
		if Ignite and mainMenu.Misc.Autoignite:Value() then
                  if IsReady(Ignite) and 20*GetLevel(myHero)+50 > GetHP(enemy)+GetHPRegen(enemy)*3 and ValidTarget(enemy, 600) then
                  CastTargetSpell(enemy, Ignite)
                  end
                end
		
  	        if IsReady(_Q) and ValidTarget(enemy, 1010) and mainMenu.Killsteal.Q:Value() and GetHP2(enemy) < getdmg("Q",enemy) then 
                Cast(_Q,enemy)
                elseif IsReady(_R) and ValidTarget(enemy, 600) and mainMenu.Killsteal.R:Value() and GetHP2(enemy) < getdmg("R",enemy) then
                CastSpell(_R)
	        end
		
	end

end)

OnUpdateBuff(function(unit,buff)
  if buff.Name == "rocketgrab2" and GetObjectType(unit) == Obj_AI_Hero and GetTeam(unit) ~= GetTeam(myHero) then
    SuccesfulGrabs = SuccesfulGrabs + 1
    MissedGrabs = MissedGrabs - 1
		
    if mainMenu.Combo.AutoE:Value() then
    CastSpell(_E)
    end
  end
end)
