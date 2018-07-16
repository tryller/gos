--[[ Rx Sona Version 0.35
     0.35: Update for Inspired_new, fix somethings
     Go to http://gamingonsteroids.com   To Download more script. 
------------------------------------------------------------------------------------

 ..######...#######..###.....##....###
 .##....##.##.....##.####....##...##.##
 .##.......##.....##.##.##...##..##...##
 ..######..##.....##.##..##..##.##.....##
 .......##.##.....##.##...##.##.#########
 .##....##.##.....##.##....####.##.....##
 ..######...#######..##.....###.##.....##

                                                
---------------------------------------------------]]

require('Inspired')
require('DeftLib')
PrintChat(string.format("<font color='#FFFFFF'>Credits to </font><font color='#54FF9F'>Deftsu, Inspired, Zypppy. </font>"))

class "RxSona"
function RxSona:__init()
Callback.Add("Load", function() self:Loading() end)
Callback.Add("Tick", function(myHero) self:Fight(myHero) end)
Callback.Add("Draw", function(myHero) self:Draws(myHero) end)
Callback.Add("ProcessSpell", function(unit, spell) self:AutoUseR(unit, spell) end)
end

local allies, enemies, HealWAlly, HealWMH, ShieldW = {}, {}, {}
function RxSona:Loading()
---- [[ CREATE MENU ]] ----
Sona = MenuConfig("Sona", "Rx Sona Version 0.35")

-- [[ Combo ]] --
Sona:Menu("cb", "Combo")
Sona.cb:Boolean("QCB", "Use Q", true)
Sona.cb:Boolean("WCB", "Use W", true)
Sona.cb:Boolean("ECB", "Use E", true)
Sona.cb:Boolean("RCB", "Enable use R in Combo", true)
Sona.cb:Slider("RCBxEnm", "Use R if can hit x enemy", 2, 1, 5, 1)
PermaShow(Sona.cb.RCB)

-- [[ Harass ]] --
Sona:Menu("hr", "Harass")
Sona.hr:Boolean("HrQ", "Use Q", true)
Sona.hr:Slider("HrMana", "Harass if %My MP >=", 20, 1, 100, 1)

-- [[ LastHit ]] --
Sona:Menu("lh", "Last Hit")
Sona.lh:Boolean("LasthitQ", "Q LastHit", true)
Sona.lh:Slider("LhMana", "LastHit if %My MP >=", 20, 1, 100, 1)

-- [[ Auto Spell ]] --
Sona:Menu("AtSpell", "Auto Spell")
Sona.AtSpell:Slider("ASMana", "Auto Spell if My %MP >=", 15, 1, 90, 1)
Sona.AtSpell:Menu("QAuto", "Auto Q")
Sona.AtSpell.QAuto:Boolean("ASQ", "Enable Auto Q", true)
Sona.AtSpell:Menu("WAuto", "Auto W")
Sona.AtSpell.WAuto:Menu("me", "Auto W My Hero")
Sona.AtSpell.WAuto.me:Boolean("ASW", "AutoW myHero", true)
Sona.AtSpell.WAuto.me:Slider("myHrHP", "Auto W if %My HP  =<", 55, 1, 100, 1)
Sona.AtSpell.WAuto:Menu("ally", "Auto W Ally")
Sona.AtSpell.WAuto.ally:Boolean("AllyEb", "AutoW ally", true)
Sona.AtSpell.WAuto.ally:Info("info0", "Setting %x HP ally in battle mode or normal mode") 
Sona.AtSpell.WAuto.ally:Slider("battlemode", "Battle Mode", 70, 2, 100, 1)
Sona.AtSpell.WAuto.ally:Info("info1", "Battle Mode: if Enemy Heroes in 1250 range then Auto W if %HP Ally <= %x HP")
Sona.AtSpell.WAuto.ally:Slider("normalmode", "Normal Mode", 50, 2, 100, 1)
Sona.AtSpell.WAuto.ally:Info("info2", "Normal Mode: if no Enemy Heroes in 1250 range then Auto W if %HP Ally <= %x HP")
Sona.AtSpell:Menu("Interrupt", "Auto R Stop Spell")
Sona.AtSpell.Interrupt:Info("InfoQ", "If you don't see any ON/OFF => No enemy can Interrupt.")
PermaShow(Sona.AtSpell.WAuto.ally.AllyEb)
PermaShow(Sona.AtSpell.QAuto.ASQ)

-- [[ Kill Steal ]] --
Sona:Menu("KS", "Kill Steal")
Sona.KS:Boolean("KSEb", "Enable KillSteal", true)
Sona.KS:Boolean("IgniteKS", "KS with Ignite", true)
Sona.KS:Boolean("QKS", "KS with Q", true)

-- [[ Auto LevelUp ]] --
Sona:Menu("AutoLvlUp", "Auto Level Up")
Sona.AutoLvlUp:Boolean("Enable", "Enable Auto Lvl Up", true)
Sona.AutoLvlUp:DropDown("Choose", "Settings", 1, {"Q-W-E", "W-Q-E"}) 

-- [[ Drawings ]] --
Sona:Menu("Draws", "Drawings")
Sona.Draws:Slider("QualiDraw", "Circle Quality ", 50, 1, 100, 1)
Sona.Draws:Menu("Range", "Skills Range")
Sona.Draws.Range:Boolean("DrawQ", "Range Q", true)
Sona.Draws.Range:ColorPick("Qcol", "Q Color", {180, 30, 144, 255})
Sona.Draws.Range:Boolean("DrawW", "Range W", true)
Sona.Draws.Range:ColorPick("Wcol", "W Color", {180, 124, 252, 0})
Sona.Draws.Range:Boolean("DrawE", "Range E", true)
Sona.Draws.Range:ColorPick("Ecol", "E Color", {180, 155, 48, 255})
Sona.Draws.Range:Boolean("DrawR", "Range R", true)
Sona.Draws.Range:ColorPick("Rcol", "R Color", {180, 248, 245, 120})
Sona.Draws:Menu("Texts", "Draw Text")
Sona.Draws.Texts:Boolean("HPAlly", "Draw HP Ally", true)
Sona.Draws.Texts:Boolean("WAlly", "Draw W Heal Ally", true)
Sona.Draws.Texts:Boolean("WSmyH", "Draw W Heal and W Shiled myHero", true)
Sona.Draws:Menu("CircleAlly", "Draw Circle Around Ally")
Sona.Draws.CircleAlly:Boolean("DrawCircleAlly", "Enable draw circle ally", true)
Sona.Draws.CircleAlly:Slider("HPAllies", "Draw if %HP Ally <= x%", 40, 6, 70, 2)
Sona.Draws.CircleAlly:ColorPick("Alcol", "Circle Around Ally Color", {140, 173, 255, 47})
Sona:Info("info3", "Use PActivator for Auto Items")

 for i, enemy in pairs(GetEnemyHeroes()) do
  table.insert(enemies, enemy)
 end
 for l, ally in pairs(GetAllyHeroes()) do
  table.insert(allies, ally)
 end
end

--- [[ Location ]] ---
local RPred = { name = "SonaR", speed = 2400, delay = 0.3, range = 1000, width = 150, collision = false, aoe = true, type = "linear"}
SonaR = IPrediction.Prediction(RPred)
local Ignite = (GetCastName(myHero, SUMMONER_1):lower():find("summonerdot") and SUMMONER_1 or (GetCastName(myHero, SUMMONER_2):lower():find("summonerdot") and SUMMONER_2 or nil))
local ANTI_SPELLS = { -- Deftsu CHANELLING_SPELLS but no stop Varus Q and Fidd W
    ["CaitlynAceintheHole"]         = {Name = "Caitlyn",      Spellslot = _R},
    ["KatarinaR"]                   = {Name = "Katarina",     Spellslot = _R},
    ["Crowstorm"]                   = {Name = "FiddleSticks", Spellslot = _R},
    ["GalioIdolOfDurand"]           = {Name = "Galio",        Spellslot = _R},
    ["LucianR"]                     = {Name = "Lucian",       Spellslot = _R},
    ["MissFortuneBulletTime"]       = {Name = "MissFortune",  Spellslot = _R},
    ["AbsoluteZero"]                = {Name = "Nunu",         Spellslot = _R}, 
    ["ShenStandUnited"]             = {Name = "Shen",         Spellslot = _R},
    ["KarthusFallenOne"]            = {Name = "Karthus",      Spellslot = _R},
    ["AlZaharNetherGrasp"]          = {Name = "Malzahar",     Spellslot = _R},
    ["Pantheon_GrandSkyfall_Jump"]  = {Name = "Pantheon",     Spellslot = _R},
    ["InfiniteDuress"]              = {Name = "Warwick",      Spellslot = _R}, 
    ["EzrealTrueshotBarrage"]       = {Name = "Ezreal",       Spellslot = _R}, 
    ["TahmKenchR"]                  = {Name = "TahmKench",    Spellslot = _R}, 
    ["VelKozR"]                     = {Name = "VelKoz",       Spellslot = _R}, 
    ["XerathR"]                     = {Name = "Xerath",       Spellslot = _R} 
}

local function IsInRange(unit, range)
    return unit.valid and IsInDistance(unit, range)
end

function RxSona:Fight(myHero)
 if IOW:Mode() == "Combo" then
  self:Combo()
 elseif IOW:Mode() == "Harass" then
  self:Harass()
 elseif IOW:Mode() == "LastHit" then
  self:LastHit()
 end
 if Sona.KS.KSEb:Value() then self:KillSteal() end
 if Sona.AutoLvlUp.Enable:Value() then self:AutoLvlUp() end
 if GetPercentMP(myHero) >= Sona.AtSpell.ASMana:Value() and GotBuff(myHero, "recall") <= 0 then self:AutoSpell() end
 self:GetWValue()
end

function RxSona:Combo()
local target = GetCurrentTarget()
 if IsReady(_Q) and IsInRange(target, 822) and Sona.cb.QCB:Value() then
  CastSpell(_Q)
 end

 if IsReady(_W) and IsInRange(target, 1000) and Sona.cb.WCB:Value() and (myHero.health + 10 + 20*GetCastLevel(myHero, _W)) < myHero.maxHealth then
  CastSpell(_W)
 end

 if IsReady(_E) and IsInRange(target, 1300) and Sona.cb.ECB:Value() then
  if AlliesAround(myHero.pos, GetCastRange(myHero, _E)) >= 1 or not IsInDistance(target, 850) then
   CastSpell(_E)
  end
 end

 for i, enemy in pairs(enemies) do
  if Sona.cb.RCB:Value() and IsInRange(enemy, 1000) and EnemiesAround2(enemy.pos, 150, 300) >= Sona.cb.RCBxEnm:Value() then
   local hitchance, pos = SonaR:Predict(enemy)
   if hitchance > 2 then
    CastSkillShot(_R, pos)
   end
  end
 end
end
	
function RxSona:Harass()
local target = GetCurrentTarget()
 if GetPercentMP(myHero) >= Sona.hr.HrMana:Value() and IsReady(_Q) and IsInRange(target, 822) and Sona.hr.HrQ:Value() then
  CastSpell(_Q)
 end	
end

function RxSona:LastHit()
 for I = 1, minionManager.maxObjects do
 local minion = minionManager.objects[I]
  if GetPercentMP(myHero) >= Sona.lh.LhMana:Value() and minion.team ~= myHero.team and IsReady(_Q) and IsInRange(minion, GetCastRange(myHero, _Q)) and Sona.lh.LasthitQ:Value() then 
   local mno1 = ClosestMinion(myHero.pos, MINION_ENEMY)
   local mno2 = ClosestMinion(mno1.pos, MINION_ENEMY)
   if EnemiesAround(myHero.pos, 825) == 1 and mno1.health < myHero:CalcMagicDamage(mno1, 40*GetCastLevel(myHero, _Q) + 0.5*myHero.ap) then
     if mno1.health > 0 then CastSpell(_Q) end
   elseif EnemiesAround(myHero.pos, 825) <= 0 then
    if mno1.health < myHero:CalcMagicDamage(mno1, 40*GetCastLevel(myHero, _Q) + 0.5*myHero.ap) or mno2.health < myHero:CalcMagicDamage(mno2, 40*GetCastLevel(myHero, _Q) + 0.5*myHero.ap) then
     if mno1.health > 0 and mno2.health > 0 then CastSpell(_Q) end
    end
   end
  end
 end
end
 
function RxSona:AutoSpell()
 for i, enemy in pairs(enemies) do
  if IsReady(_Q) and IsInRange(enemy, 823) and Sona.AtSpell.QAuto.ASQ:Value() then
   CastSpell(_Q)
  end

  if IsReady(_W) and GetPercentHP(myHero) <= Sona.AtSpell.WAuto.me.myHrHP:Value() and Sona.AtSpell.WAuto.me.ASW:Value() then
   CastSpell(_W)
  end

  for l, ally in pairs(allies) do
   if IsReady(_W) and Sona.AtSpell.WAuto.ally.AllyEb:Value() then
    if IsInRange(enemy, 1250) then	   
     if IsInRange(ally, GetCastRange(myHero, _W)) and GetPercentHP(ally) <= Sona.AtSpell.WAuto.ally.battlemode:Value() then
      CastSpell(_W)
     end
     else
     if IsInRange(ally, GetCastRange(myHero, _W)) and GetPercentHP(ally) <= Sona.AtSpell.WAuto.ally.normalmode:Value() then
      CastSpell(_W)
     end
    end
   end 
  end
 end
end

function RxSona:KillSteal()
 for i, enemy in pairs(enemies) do
  if Ignite and Zilean.KS.IgniteKS:Value() then
   if IsReady(Ignite) and 20*GetLevel(myHero)+50 >= enemy.health+enemy.shieldAD + enemy.hpRegen*2.5 and IsInRange(enemy, 600) then
	CastTargetSpell(enemy, Ignite)
   end
  end

  if IsReady(_Q) and IsInRange(enemy, 822) and Sona.KS.QKS:Value() and enemy.health+enemy.shieldAD+enemy.shieldAP < myHero:CalcMagicDamage(enemy, 40*GetCastLevel(myHero, _Q) + 0.5*myHero.ap) then
   local ks1 = ClosestEnemy(myHero.pos)
   local ks2 = ClosestEnemy(ks1.pos)
   if enemy.networkID == ks1.networkID or enemy.networkID == ks2.networkID then
    CastSpell(_Q)
   end
  end
 end
end

function RxSona:AutoLvlUp()
 if Sona.AutoLvlUp.Enable:Value() then
  if Sona.AutoLvlUp.Choose:Value() == 1 then leveltable = {_Q, _W, _E, _Q, _Q , _R, _Q , _Q, _W , _W, _R, _W, _W, _E, _E, _R, _E, _E} -- Full Q First
  elseif Sona.AutoLvlUp.Choose:Value() == 2 then leveltable = {_W, _Q, _E, _W, _W , _R, _W , _W, _Q , _Q, _R, _Q, _Q, _E, _E, _R, _E, _E} -- Full W First
  end
   LevelSpell(leveltable[GetLevel(myHero)])
 end
end

function RxSona:GetWValue()
local WDmg = 10 + 20*GetCastLevel(myHero,_W) + 0.2*myHero.ap
local WMax = 15 + 30*GetCastLevel(myHero,_W) + 0.3*myHero.ap
 for l, ally in pairs(allies) do
  if ally.alive then
   local WCheck = 100 - GetPercentHP(ally)
   local WHeal = WDmg + (WDmg*WCheck)/200
   HealWAlly[l] = math.min(WHeal, WMax)
  else
   HealWAlly[l] = 0
  end
 end
 
 if myHero.alive then
  local CheckW = 100 - GetPercentHP(myHero)
  local HealW = WDmg + (WDmg*CheckW)/200
  HealWMH = math.min(HealW, WMax)
  ShieldW = 15 + 20*GetCastLevel(myHero,_W) + 0.2*GetBonusAP(myHero)
 else
  HealWMH = 0
  ShieldW = 0
 end
end
 
function RxSona:Draws(myHero)
 self:SkillsRange()
 self:DrawTexts()
 self:HPBar()
end

function RxSona:SkillsRange()
local pos = myHero.pos
 if Sona.Draws.Range.DrawQ:Value() and IsReady(_Q) then DrawCircle3D(pos.x, pos.y, pos.z, GetCastRange(myHero, _Q), 1, Sona.Draws.Range.Qcol:Value(), Sona.Draws.QualiDraw:Value()) end
 if Sona.Draws.Range.DrawW:Value() and IsReady(_W) then DrawCircle3D(pos.x, pos.y, pos.z, GetCastRange(myHero, _W), 1, Sona.Draws.Range.Wcol:Value(), Sona.Draws.QualiDraw:Value()) end
 if Sona.Draws.Range.DrawE:Value() and IsReady(_E) then DrawCircle3D(pos.x, pos.y, pos.z, GetCastRange(myHero, _E), 1, Sona.Draws.Range.Ecol:Value(), Sona.Draws.QualiDraw:Value()) end
 if Sona.Draws.Range.DrawR:Value() and IsReady(_R) then DrawCircle3D(pos.x, pos.y, pos.z, GetCastRange(myHero, _R), 1, Sona.Draws.Range.Rcol:Value(), Sona.Draws.QualiDraw:Value()) end

  if Sona.Draws.CircleAlly.DrawCircleAlly:Value() then
   for l, ally in pairs(allies) do
    if IsInRange(ally, 2000) and GetPercentHP(ally) <= Sona.Draws.CircleAlly.HPAllies:Value() then	
     DrawCircle3D(ally.pos.x, ally.pos.y, ally.pos.z, 1000, 1, Sona.Draws.CircleAlly.Alcol:Value(), Sona.Draws.QualiDraw:Value())
    end
   end
  end
end

function RxSona:DrawTexts()
 for l, ally in pairs(allies) do
  if IsInRange(ally, 2500) then
   local pos = WorldToScreen(1, ally.pos)
   if Sona.Draws.Texts.HPAlly:Value() then DrawText(string.format("%s HP: %d / %d | %sHP = %d%s", ally.charName, ally.health, ally.maxHealth, '%', GetPercentHP(ally), '%'), 16, pos.x-80, pos.y, GoS.White) end 
   if GetCastLevel(myHero, _W) >= 1 and Sona.Draws.Texts.WAlly:Value() then DrawText(string.format("Heal W = %d HP", HealWAlly[l]), 18, pos.x-80, pos.y+20, GoS.White) end
  end
 end 

 if IsObjectAlive(myHero) then
  local pos = WorldToScreen(1, myHero.pos)
  if GetCastLevel(myHero, _W) >= 1 and Sona.Draws.Texts.WSmyH:Value() then DrawText(string.format("Heal W: %d HP | Shield W: %d Armor", HealWMH, ShieldW), 18, pos.x-80, pos.y, GoS.White) end
 end
end

function RxSona:HPBar()  
 for i, enemy in pairs(enemies) do
  if IsInRange(enemy, 4000) then
  local damage
   if IsReady(_R) and IsReady(_Q) then
    damage = myHero:CalcMagicDamage(enemy, 100*GetCastLevel(myHero, _R)+ 50+0.5*myHero.ap)
   elseif IsReady(_R) and not IsReady(_Q) then
    damage = myHero:CalcMagicDamage(enemy, 100*GetCastLevel(myHero, _R)+ 50+0.5*myHero.ap)
   elseif IsReady(_Q) and not IsReady(_R) then
    damage = myHero:CalcMagicDamage(enemy, 40*GetCastLevel(myHero, _Q) +0.5*myHero.ap)
   else
    damage = myHero:CalcDamage(enemy, myHero.damage)
   end
    DrawDmgOverHpBar(enemy, enemy.health, 0, math.min(enemy.health,damage), GoS.Green)
  end
 end
end

DelayAction(function()
local str = {[_Q] = "Q", [_W] = "W", [_E] = "E", [_R] = "R"}
 for i, spell in pairs(ANTI_SPELLS) do
  for _,k in pairs(enemies) do
   if spell["Name"] == k.charName then
    Sona.AtSpell.Interrupt:Boolean(k.charName.."Inter", "On "..k.charName.." "..(type(spell.Spellslot) == 'number' and str[spell.Spellslot]), true)
   end
  end
 end
end, 1)

function RxSona:AutoUseR(unit, spell)
 if unit.type == Obj_AI_Hero and unit.team ~= myHero.team and IsReady(_R) then
  if ANTI_SPELLS[spell.name] then
   if IsInRange(unit, 990) and unit.charName == ANTI_SPELLS[spell.name].Name and Sona.AtSpell.Interrupt[unit.charName.."Inter"]:Value() then 
    local hitchance, pos = SonaR:Predict(unit)
    if hitchance > 2 then
     CastSkillShot(_R, pos)
    end
   end
  end
 end
end

PrintChat(string.format("<font color='#FF0000'>Rx Sona by Rudo </font><font color='#FFFF00'>Version 0.35 Loaded Success </font><font color='#08F7F3'>Enjoy and Good Luck %s (%s)</font>",GetUser(), myHero.name))
if myHero.charName == "Sona" then RxSona() end
