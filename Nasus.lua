if GetObjectName(GetMyHero()) ~= "Nasus" then return end

local QStack = 0 
local mainMenu = Menu("Nasus", "Nasus")
mainMenu:SubMenu("Combo", "Combo")
mainMenu.Combo:Boolean("Q","Use Q",true)
mainMenu.Combo:Boolean("W","Use W",true)
mainMenu.Combo:Boolean("E","Use E",true)
mainMenu.Combo:Boolean("R","Use R",true)
mainMenu.Combo:Slider("RHP", "Use R if my HP < x%", 20, 5, 80, 1)
mainMenu:SubMenu("Harass", "Harass")
mainMenu.Harass:Boolean("Q","Use Q",true)
mainMenu.Harass:Boolean("W","Use W",true)
mainMenu.Harass:Boolean("E","Use E",false)
mainMenu.Harass:Boolean("R","Use R",true)
mainMenu.Harass:Slider("RHP", "Use R if my HP < x%", 20, 5, 80, 1)
mainMenu:SubMenu("Stacks", "LastHit/LaneClear/Jungle")
mainMenu.Stacks:Boolean("Q","Use LastHit Q",true)
mainMenu.Stacks:Boolean("AQ","Auto LastHit Q if",true)
mainMenu.Stacks:Slider("AQR", "Minion Range < x (Def.250)", 250, 50, 1500, 1)
mainMenu.Stacks:Boolean("QLC","Use LaneClear Q",true)
mainMenu:SubMenu("Items", "Items & Ignite")
mainMenu.Items:Info("Nasus", "Only in Combo and Harass")
mainMenu.Items:Boolean("Ignite","AutoIgnite if OOR and W+E NotReady",true)
mainMenu.Items:Boolean("useTiamat", "Tiamat", true)
mainMenu.Items:Boolean("useHydra", "Hydra", true)
mainMenu.Items:Info("Nasus", " ")
mainMenu.Items:Boolean("CutBlade", "Bilgewater Cutlass", true)  
mainMenu.Items:Slider("CutBlademyhp", "if My Health < x%", 50, 5, 100, 1)
mainMenu.Items:Slider("CutBladeehp", "if Enemy Health < x%", 20, 5, 100, 1)
mainMenu.Items:Info("Nasus", " ")
mainMenu.Items:Boolean("bork", "Blade of the Ruined King", true)
mainMenu.Items:Slider("borkmyhp", "if My Health < x%", 50, 5, 100, 1)
mainMenu.Items:Slider("borkehp", "if Enemy Health < x%", 20, 5, 100, 1)
mainMenu.Items:Info("Nasus", " ")
mainMenu.Items:Boolean("ghostblade", "Youmuu's Ghostblade", true)
mainMenu.Items:Slider("ghostbladeR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
mainMenu.Items:Info("Nasus", " ")
mainMenu.Items:Boolean("useRedPot", "Elixir of Wrath(REDPOT)", true)
mainMenu.Items:Slider("useRedPotR", "If Enemy in Range (def: 600)", 600, 100, 2000, 1)
mainMenu.Items:Info("Nasus", " ")
mainMenu.Items:Boolean("QSS", "Always Use QSS", true)
mainMenu.Items:Slider("QSSHP", "if My Health < x%", 75, 0, 100, 1)
mainMenu:SubMenu("KS", "KillSteal")
mainMenu.KS:Boolean("Q","Use Q KS",true)
mainMenu.KS:Boolean("E","Use E KS",true)
mainMenu.KS:Boolean("WQ","Use W+Q KS",false)
mainMenu.KS:Boolean("WEQ","Use W+E+Q KS",false)
mainMenu:SubMenu("Misc", "Misc")
mainMenu.Misc:Boolean("QAA","Draw QAA",true)
mainMenu.Misc:Boolean("DMG","Draw DMG over HP",true)
mainMenu.Misc:Info("Nasus", " ")
mainMenu.Misc:Boolean("MGUN","Ultimate Notifier", true)
mainMenu.Misc:Boolean("MGUNDEB","TEXT DEBUG", false)
mainMenu.Misc:Slider("MGUNSIZE", "UN Text Size", 25, 5, 60, 1)
mainMenu.Misc:Slider("MGUNX", "UN X POS", 35, 0, 1600, 1)
mainMenu.Misc:Slider("MGUNY", "UN Y POS", 394, 0, 1055, 1)

function Stacking()
  nasusQstacks = GetBuffData(myHero,"nasusqstacks")
  QStack = nasusQstacks.Stacks
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
    target = GetCurrentTarget()
    Stacking() 
    ItemUse()
    Ignite()
    Killsteal()    
    
  if mainMenu.Misc.DMG:Value() then     
    DMGOHP()
  end  
  if mainMenu.Misc.QAA:Value() then  
    QAA()
  end  
	if Mode() == "Combo" then 
    	Combo()
  end  
	if Mode() == "Harass" then 
    	Harass()
  end   
	if Mode() == "LastHit" and mainMenu.Stacks.Q:Value() then 
		LastHit(minion)
      JungleClear(jminion)
  end
  	if Mode() == "LastClear" and mainMenu.Stacks.QLC:Value() then 
    	LastHit(minion)
      JungleClear(jminion)
  end
  if not (Mode() == "Combo" or Mode() == "Harass") and mainMenu.Stacks.AQ:Value() then 
      AutoLastHit(minion)
      AutoJungleClear(jminion)
  end

  if mainMenu.Misc.MGUNDEB:Value() then
  GLOBALULTNOTICEDEBUG()
end
  if mainMenu.Misc.MGUN:Value() then
GLOBALULTNOTICE()
end
end)


function Combo()
    local unit = GetCurrentTarget()
  local target = GetCurrentTarget()
if target == nil or GetOrigin(target) == nil or IsImmune(target,myHero) or IsDead(target) or not IsVisible(target) or GetTeam(target) == GetTeam(myHero) then return false end
if ValidTarget(target, 1000) then
  if mainMenu.Combo.W:Value() then
    if IsReady(_W) and IsInDistance(target, 600) then --and IsObjectAlive(target) 
      CastTargetSpell(target, _W)
    end
  end  
  if mainMenu.Combo.E:Value() then           
    local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),1700,250,650,70,true,false)
    if IsReady(_E)  and IsInDistance(target, 650) then --and IsObjectAlive(target)
      CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
    end
  end  
  if mainMenu.Combo.Q:Value() then
    if IsReady(_Q) and IsInDistance(target, 300) then --and IsObjectAlive(target) 
      CastSpell(_Q)
    end  
  end
  if mainMenu.Combo.R:Value() then
    if IsReady(_R)  and (GetCurrentHP(myHero)/GetMaxHP(myHero)) < (mainMenu.Combo.RHP:Value()/100) then --and IsObjectAlive(target)
      CastSpell(_R)
    end  
  end
end
end

function Harass()
    local unit = GetCurrentTarget()
  local target = GetCurrentTarget()
if target == nil or GetOrigin(target) == nil or IsImmune(target,myHero) or IsDead(target) or not IsVisible(target) or GetTeam(target) == GetTeam(myHero) then return false end
if ValidTarget(target, 1000) then
  if mainMenu.Harass.W:Value() then
    if IsReady(_W) and IsInDistance(target, 600) then --and IsObjectAlive(target) 
      CastTargetSpell(target, _W)
    end
  end  
  if mainMenu.Harass.E:Value() then           
    local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),1700,250,650,70,true,false)
    if IsReady(_E)  and IsInDistance(target, 650) then --and IsObjectAlive(target)
      CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
    end
  end  
  if mainMenu.Harass.Q:Value() then
    if IsReady(_Q)  and IsInDistance(target, 300) then --and IsObjectAlive(target)
      CastSpell(_Q)
    end  
  end
  if mainMenu.Combo.R:Value() then
    if IsReady(_R) and IsObjectAlive(target) and (GetCurrentHP(myHero)/GetMaxHP(myHero)) < (mainMenu.Harass.RHP:Value()/100) then
      CastSpell(_R)
    end  
  end
end
end

function Ignite()
    for _, k in pairs(GetEnemyHeroes()) do
    if ValidTarget(k, 700) and Ignite and mainMenu.Items.Ignite:Value() and not IsReady(_E) and not IsReady(_W) and  GetDistance(k) > 460 then --and IsObjectAlive(unit) and not IsImmune(unit) and IsTargetable(unit) and
        
            if IsReady(Ignite) and (20*GetLevel(GetMyHero())+50) > GetCurrentHP(k)+GetHPRegen(k)*2.5 and GetDistanceSqr(GetOrigin(k)) < 600*600 then
                CastTargetSpell(k, Ignite)
            end
        end
     end
end

function ItemUse()
	for _, target in pairs(GetEnemyHeroes()) do
  	if GetItemSlot(myHero,3153) > 0 and mainMenu.Items.bork:Value() and ValidTarget(target, 550) and (Mode() == "Combo" or Mode() == "Harass") and GetCurrentHP(myHero)/GetMaxHP(myHero) < (mainMenu.Items.borkmyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (mainMenu.Items.borkehp:Value()/100) then
        CastTargetSpell(target, GetItemSlot(myHero,3153)) --bork
        end

        if GetItemSlot(myHero,3144) > 0 and mainMenu.Items.CutBlade:Value() and ValidTarget(target, 550) and (Mode() == "Combo" or Mode() == "Harass") and GetCurrentHP(myHero)/GetMaxHP(myHero) < (mainMenu.Items.CutBlademyhp:Value()/100) and GetCurrentHP(target)/GetMaxHP(target) > (mainMenu.Items.CutBladeehp:Value()/100) then 
        CastTargetSpell(target, GetItemSlot(myHero,3144)) --CutBlade
        end

        if GetItemSlot(myHero,3142) > 0 and mainMenu.Items.ghostblade:Value() and (Mode() == "Combo" or Mode() == "Harass") and ValidTarget(target, mainMenu.Items.ghostbladeR:Value()) then --ghostblade
        CastTargetSpell(myHero, GetItemSlot(myHero,3142))
        end
		
	if GetItemSlot(myHero,3140) > 0 and mainMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < mainMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end

        if GetItemSlot(myHero,3139) > 0 and mainMenu.Items.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < mainMenu.Items.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
      end
   
     if mainMenu.Items.useRedPot:Value() and GetItemSlot(myHero,2140) >= 1 and ValidTarget(target,mainMenu.Items.useRedPotR:Value()) and (Mode() == "Combo" or Mode() == "Harass") then --redpot
        if IsReady(GetItemSlot(myHero,2140)) then
          CastSpell(GetItemSlot(myHero,2140))
        end
      end
  if Mode() == "Combo" or Mode() == "Harass" then
   if mainMenu.Items.useTiamat:Value() and GetItemSlot(myHero, 3077) >= 1 and ValidTarget(target, 550) then --tiamat
        if GetDistance(target) < 400 then
         CastTargetSpell(myHero, GetItemSlot(myHero, 3077))
        end       
    elseif mainMenu.Items.useHydra:Value() and GetItemSlot(myHero, 3074) >= 1 and ValidTarget(target, 550) then --hydra
      if GetDistance(target) < 385 then
        CastTargetSpell(myHero, GetItemSlot(myHero, 3074))
      end
    end
  end       
end
end      

function QAA()
	for i,unit in pairs(GetEnemyHeroes()) do
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0  
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = sheendmg2 + 1
      end    
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end         
		local unitPos = GetOrigin(unit)
		local dmgQ = 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack
		local dmg = CalcDamage(myHero, unit, dmgQ, lichbane)
		local hp = GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit)
		local hPos = GetHPBarPos(unit)
end
end

function DMGOHP()
  	for _,unit in pairs(GetEnemyHeroes()) do    
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0   
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GetItemSlot(myHero,3078) then
        sheendmg2 = sheendmg2 + 1
      end
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end        
  local Qdmg = 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack
	if ValidTarget(unit,20000) and (IsReady(_Q) or GotBuff(myHero,"NasusQ") == 1) then
		DrawDmgOverHpBar(unit,GetCurrentHP(unit) + GetMagicShield(unit) + GetDmgShield(unit),0,CalcDamage(myHero, unit, Qdmg, lichbane),0xffffffff)	
  end  
  end
end

function LastHit(minion)
 for _,minion in pairs(GetAllMinions(MINION_ENEMY)) do
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0   
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = sheendmg2 + 1
      end    
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end  
  local minionpos = GetOrigin(minion)
    if ValidTarget(minion, GetRange(myHero)+100) and CalcDamage(myHero, minion, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane) > GetCurrentHP(minion) and (IsReady(_Q) or GotBuff(myHero,"NasusQ") == 1) then
        CastSpell(_Q) DelayAction(function() AttackUnit(minion) end, 100)
    end
  end
end

function AutoLastHit(minion)
 for _,minion in pairs(GetAllMinions(MINION_ENEMY)) do
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0   
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = sheendmg2 + 1
      end    
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end   
  local minionpos = GetOrigin(minion)
    if ValidTarget(minion, mainMenu.Stacks.AQR:Value()) and CalcDamage(myHero, minion, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane) > GetCurrentHP(minion) and (IsReady(_Q) or GotBuff(myHero,"NasusQ") == 1) and GotBuff(myHero,"recall") == 0 then
        CastSpell(_Q) DelayAction(function() AttackUnit(minion) end, 100)
    end
  end
end
 
function AutoJungleClear(jminion)
 for _,jminion in pairs(GetAllMinions(MINION_JUNGLE)) do
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0   
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = sheendmg2 + 1
      end    
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end   
  local minionpos = GetOrigin(jminion)
    if ValidTarget(jminion, mainMenu.Stacks.AQR:Value()) and CalcDamage(myHero, jminion, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane) > GetCurrentHP(jminion) and (IsReady(_Q) or GotBuff(myHero,"NasusQ") == 1) then
        CastSpell(_Q) DelayAction(function() AttackUnit(jminion) end, 100)
    end
  end
end

function JungleClear(jminion)
 for _,jminion in pairs(GetAllMinions(MINION_JUNGLE)) do
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0   
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = sheendmg2 + 1
      end    
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end   
  local minionpos = GetOrigin(jminion)
    if ValidTarget(jminion, GetRange(myHero)+100) and CalcDamage(myHero, jminion, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane) > GetCurrentHP(jminion) and (IsReady(_Q) or GotBuff(myHero,"NasusQ") == 1) then
        CastSpell(_Q) DelayAction(function() AttackUnit(jminion) end, 100)
    end
  end
end

function Killsteal()
    local target = GetCurrentTarget()
  if target == nil or GetOrigin(target) == nil or IsImmune(target,myHero) or IsDead(target) or not IsVisible(target) or GetTeam(target) == GetTeam(myHero) then return false end
	for i,enemy in pairs(GetEnemyHeroes()) do
	local enemyhp = GetCurrentHP(enemy) + GetHPRegen(enemy) + GetMagicShield(enemy) + GetDmgShield(enemy)
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0   
    local Edmg = (15 + 40*GetCastLevel(myHero,_E) + 0.6*GetBonusDmg(myHero))
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = sheendmg2 + 1
      end    
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end   
      if mainMenu.KS.Q:Value() and ValidTarget(enemy, GetRange(myHero)+50) and CalcDamage(myHero, enemy, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane) > enemyhp and (IsReady(_Q) or GotBuff(myHero,"NasusQ") == 1) and IsInDistance(enemy, GetRange(myHero)+50) and GetDistance(myHero, enemy) <= (GetRange(myHero)+50) and GetDistance(myHero, enemy) >= 10 and IsInDistance(target, GetRange(myHero)+50) then
        CastSpell(_Q) DelayAction(function() AttackUnit(enemy) end, 100)
      end
      local EPred = GetPredictionForPlayer(GetOrigin(myHero),enemy,GetMoveSpeed(enemy),1700,250,650,70,true,false)
      if mainMenu.KS.E:Value() and ValidTarget(enemy, 650) and CalcDamage(myHero, enemy, 0, Edmg) > enemyhp and (IsReady(_E)) and IsInDistance(enemy, 650) then
      CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
      end
    if mainMenu.KS.WEQ:Value() and ValidTarget(enemy, 500) and CalcDamage(myHero, enemy, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane + Edmg) > enemyhp and (IsReady(_Q) or GotBuff(myHero,"NasusQ") == 1) and IsReady(_W) and IsInDistance(enemy, GetRange(myHero)+50) and GetDistance(myHero, enemy) <= 500 and GetDistance(myHero, enemy) >= 10 and IsInDistance(target, 500) and IsObjectAlive(enemy) then
        CastTargetSpell(enemy, _W) DelayAction(function() CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z) DelayAction(function() CastSpell(_Q) DelayAction(function() AttackUnit(enemy) end, 100) end, 200) end, 300)
    end
    if mainMenu.KS.WQ:Value() and ValidTarget(enemy, 500) and CalcDamage(myHero, enemy, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane) > enemyhp and (IsReady(_Q) or GotBuff(myHero,"NasusQ") == 1) and IsReady(_W) and IsInDistance(enemy, GetRange(myHero)+50) and GetDistance(myHero, enemy) <= 500 and GetDistance(myHero, enemy) >= 10 and IsInDistance(target, 500) then
        CastTargetSpell(enemy, _W) DelayAction(function() CastSpell(_Q) DelayAction(function() AttackUnit(enemy) end, 100) end, 200)
    end    
  end
end    

function GLOBALULTNOTICE()
      if not (IsReady(_Q) or GotBuff(myHero,"NasusQ") == 1) then return end
    local sheendmg = 0
    local sheendmg2 = 1
    local frozendmg = 0
    local lichbane = 0   
      if GetItemSlot(myHero,3078) > 0 then
        sheendmg2 = sheendmg2 + 1
      end    
      if GotBuff(myHero, "sheen") >= 1 then
        sheendmg = sheendmg + GetBaseDamage(myHero)*sheendmg2
      end 
      if GotBuff(myHero, "itemfrozenfist") >= 1 and GetItemSlot(myHero,3025) > 0 then
        frozendmg = frozendmg + GetBaseDamage(myHero)*1.25
      end 
      if GotBuff(myHero, "lichbane") >= 1 and GetItemSlot(myHero,3100) > 0 then
        lichbane = lichbane + GetBaseDamage(myHero)*0.75 + GetBonusAP(myHero)*0.5
      end  
        info = ""
        if (IsReady(_Q) or GotBuff(myHero,"NasusQ") == 1) then
       		for _,unit in pairs(GetEnemyHeroes()) do
                if  IsObjectAlive(unit) then
                        realdmg = CalcDamage(myHero, unit, 10 + 20*GetCastLevel(myHero,_Q) + GetBonusDmg(myHero) + GetBaseDamage(myHero) + sheendmg + frozendmg + QStack, lichbane)
                        hp =  GetCurrentHP(unit) + GetHPRegen(unit) + GetMagicShield(unit) + GetDmgShield(unit)
                        if realdmg > hp then
                                info = info..GetObjectName(unit)
                                if not IsVisible(unit) then
                                        info = info.." not Visible but maybe" 
                                elseif not ValidTarget(unit, GetRange(myHero)+50) then
                                        info = info.." not in Range but"                                                                               
                                end
                                info = info.." killable\n"
                        end
        		 end               
			end
		end		 
    DrawText(info,mainMenu.Misc.MGUNSIZE:Value(),mainMenu.Misc.MGUNX:Value(),mainMenu.Misc.MGUNY:Value(),0xffff0000)   
end

function GLOBALULTNOTICEDEBUG()	 
    DrawText("I am in Range but not killable - TESTMODE ON",mainMenu.Misc.MGUNSIZE:Value(),mainMenu.Misc.MGUNX:Value(),mainMenu.Misc.MGUNY:Value(),0xffff0000)   
end

--OnLoop(function(myHero)
--local capspress = KeyIsDown(0x14); --Caps Lock key
--if capspress then
--	local itemid = GetItemID(myHero,ITEM_1);
--	local itemammo = GetItemAmmo(myHero,ITEM_1);
--	local itemstack = GetItemStack(myHero,ITEM_1);
--	PrintChat(string.format("itemID in Slot 1 is = %d", itemid));
--	PrintChat(string.format("AMMO! in Slot 1 is = %d", itemammo));
--	PrintChat(string.format("STACK in Slot 1 is = %d", itemstack));
--	end
--end)