if GetObjectName(GetMyHero()) ~= "Darius" then return end

require "OpenPredict"

local rDebuff        = {}
local aaCD           = false
local qCasting       = false
local igniteFound    = false
local summonerSpells = {ignite = {}, flash = {}, heal = {}, barrier = {}, smite = {}}

local attackItems = {
  ["Tiamat"] = {
    itemID = 3077
  },
  ["Titanic Hydra"] = {
    itemID = 3748
  },
  ["Ravenous Hydra"] = {
    itemID = 3074
  },
  ["Youmuu's Ghostblade"] = {
    itemID = 3142
  },
  ["Bilgewater Cutlass"] = {
    itemID = 3144,
    requiresTarget = true,
    spellRange = 550
  },
  ["Hextech Gunblade"] = {
    itemID = 3146,
    requiresTarget = true,
    spellRange = 550
  },
  ["Blade of the Ruined King"] = {
    itemID = 3153,
    requiresTarget = true,
    spellRange = 550
  }
}

mainMenu = Menu("Darius", "Darius")
mainMenu:SubMenu("Combo", "Combo")
mainMenu.Combo:Boolean("useItems", "Use Items", true)
mainMenu.Combo:Boolean("Q", "Use Q", true)
mainMenu.Combo:Boolean("W", "Use W", true)
mainMenu.Combo:Boolean("E", "Use Smart E", true)
mainMenu:SubMenu("Harass", "Harass")
mainMenu.Harass:Boolean("Q", "Use Q", true)
mainMenu.Harass:Boolean("W", "Use W", true)
mainMenu:SubMenu("Laneclear", "Laneclear")
mainMenu.Laneclear:Boolean("Q", "Use Q", true)
mainMenu.Laneclear:Boolean("W", "Use W", true)
mainMenu:SubMenu("ksteal", "Killsteal")
mainMenu.ksteal:Boolean("R", "Use R", true)

OnLoad(function()
  if not igniteFound then
      if GetCastName(myHero, SUMMONER_1):lower():find("summonerdot") then
          igniteFound = true
          summonerSpells.ignite = SUMMONER_1
          mainMenu.ksteal:Boolean("ignite", "Auto Ignite", true)
      elseif GetCastName(myHero, SUMMONER_2):lower():find("summonerdot") then
          igniteFound = true
          summonerSpells.ignite = SUMMONER_2
          mainMenu.ksteal:Boolean("ignite", "Auto Ignite", true)
      end
  end
end)

OnUpdateBuffd(function(unit, buff)
  if not unit or not buff then
    return
  end
  if buff.Name:lower() == "dariushemo" and GetTeam(buff) ~= (GetTeam(myHero)) and myHero.type == unit.type then
        rDebuff[unit.networkID] = buff.Count
    end
end)

OnRemoveBuff(function(unit, buff)
  if not unit or not buff then
    return
  end
  if buff.Name:lower() == "dariushemo" and GetTeam(buff) ~= (GetTeam(myHero)) and myHero.type == unit.type then
        rDebuff[unit.networkID] = 0
    end
end)

OnProcessSpellComplete(function(unit, spell)
  if unit and spell and unit.isMe and spell.name:lower():find("attack") then
        aaCD = true
        DelayAction(function() aaCD = false end, (1/(GetBaseAttackSpeed(myHero) * GetAttackSpeed(myHero))))
    end
end)

OnAnimation(function(unit, action)
  if unit.isMe and action:lower() == "spell1windup" then
    qCasting = true
  elseif unit.isMe and action:lower() == "spell1" then
    qCasting = false
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

OnTick(function()
  Killsteal()

    if Mode() == "Combo" then
      Combo()
      Qorb()
    end

    if Mode() == "Harass" then
      Harass()
      Qorb()
    end
	
    if Mode() == "LaneClear" then
      Laneclear()
    end
end)

function Combo()
  local target = GetCurrentTarget()
  if ValidTarget(target, 540) and mainMenu.Combo.E:Value() and not IsInDistance(target, GetRange(myHero)+GetHitBox(myHero)+GetHitBox(target)) and Ready(_E) then
    local Apprehend = { delay = 0.25, speed = math.huge, width = 300, range = 540, angle = 35 }
    local pI = GetConicAOEPrediction(target, Apprehend)
    if pI and pI.hitChance >= 0.25 then
        CastSkillShot(_E, pI.castPos)
      end
    end
  if ValidTarget(target, 255) and not aaCD then
    AttackUnit(target)
  elseif ValidTarget(target, 255) and aaCD and mainMenu.Combo.W:Value() and Ready(_W) then
    CastSpell(_W)
    aaCD = false
    AttackUnit(target)
  elseif ValidTarget(target, 255) and aaCD and mainMenu.Combo.useItems:Value() then 
    Items(nil, {["Tiamat"] = true, ["Titanic Hydra"] = true, ["Ravenous Hydra"] = true})
    aaCD = false
    AttackUnit(target)
  elseif ValidTarget(target, 425) and mainMenu.Combo.Q:Value() and Ready(_Q) then
    CastSpell(_Q)
  end
  if ValidTarget(target, 700) and mainMenu.Combo.useItems:Value() then
    Items(nil, {["Youmuu's Ghostblade"] = true})
  end
  if ValidTarget(target, 550) and mainMenu.Combo.useItems:Value() then
    Items(target, {["Bilgewater Cutlass"] = true, ["Hextech Gunblade"] = true, ["Blade of the Ruined King"] = true})
  end
end

function Harass()
  local target = GetCurrentTarget()
  if ValidTarget(target, 255) and not aaCD then
    AttackUnit(target)
  elseif ValidTarget(target, 255) and aaCD and mainMenu.Harass.W:Value() and Ready(_W) then
    CastSpell(_W)
    aaCD = false
    AttackUnit(target)
  elseif ValidTarget(target, 255) and aaCD and mainMenu.Combo.useItems:Value() then 
    Items(nil, {["Tiamat"] = true, ["Titanic Hydra"] = true, ["Ravenous Hydra"] = true})
    aaCD = false
    AttackUnit(target)
  elseif ValidTarget(target, 425) and mainMenu.Harass.Q:Value() and Ready(_Q) then
    CastSpell(_Q)
  end
end

function Laneclear()
  for _, minion in pairs(minionManager.objects) do
    if ValidTarget(minion, 255) and not aaCD then
      --AttackUnit(minion)
    elseif ValidTarget(minion, 255) and aaCD and mainMenu.Laneclear.W:Value() and Ready(_W) then
      CastSpell(_W)
      aaCD = false
      --AttackUnit(minion)
    elseif ValidTarget(minion, 255) and aaCD and mainMenu.Combo.useItems:Value() then 
      Items(nil, {["Tiamat"] = true, ["Titanic Hydra"] = true, ["Ravenous Hydra"] = true})
      aaCD = false
      --AttackUnit(minion)
    elseif ValidTarget(minion, 425) and mainMenu.Laneclear.Q:Value() and Ready(_Q) then
      CastSpell(_Q)
    end
  end
end

function Killsteal()
  for _, enemy in pairs(GetEnemyHeroes()) do
    if rDebuff ~= nil then 
      local realHP = (GetCurrentHP(enemy) + GetDmgShield(enemy) + (GetHPRegen(enemy) * 0.25))
      local rStacks = rDebuff[enemy.networkID] or 0
      local rDamage = (((GetSpellData(myHero, _R).level * 100) + (GetBonusDmg(myHero) * 0.75)) + (rStacks * ((GetSpellData(myHero, _R).level * 20) + (GetBonusDmg(myHero) * 0.15))))
      if ValidTarget(enemy, 460) and rDamage >= realHP and Ready(_R) and mainMenu.ksteal.R:Value() then 
        CastTargetSpell(enemy, _R)
      end
    end
    if igniteFound and mainMenu.ksteal.ignite:Value() and Ready(summonerSpells.ignite) then
        local iDamage = (50 + (20 * GetLevel(myHero)))
        local realHPi = (GetCurrentHP(enemy) + GetDmgShield(enemy) + (GetHPRegen(enemy) * 0.05))
        if ValidTarget(enemy, 600) and realHPi <= iDamage then
          CastTargetSpell(enemy, summonerSpells.ignite)
        end
    end
  end
end

function Qorb()
  local target = GetCurrentTarget()
  if target ~= nil and qCasting then
    local pos = myHero - (Vector(target) - myHero):normalized() * 307.5 
    if GetDistance(myHero, target) >= 307.5 then
      MoveToXYZ(GetOrigin(target))
    elseif GetDistance(myHero, target) <= 307.5 then
      MoveToXYZ(pos)
    end
  end
end

function Items(target, list)
  for itemName, attackItem in pairs(attackItems) do
    if (list ~= nil) then
      if (list[itemName] == true) then
        CastItem(target, attackItem)
      end
    else
      CastItem(target, attackItem)
    end
  end
end

function CastItem(target, theItem)
  local itemSlot = GetItemSlot(myHero, theItem.itemID)
  if (itemSlot ~= 0) then
    if ((theItem.spellRange == nil) or ((target ~= nil) and (GetDistance(myHero, target) <= theItem.spellRange))) then
      if (Ready(itemSlot)) then
        if ((theItem.requiresTarget == true) and (target ~= nil)) then
          CastTargetSpell(target, itemSlot)
        else
          CastSpell(itemSlot)
        end
      end
    end
  end
end

