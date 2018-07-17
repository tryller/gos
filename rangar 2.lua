--  ───────────────────────────────────────────────────  --
--                                                       --
--   ██▀███  ▓█████  ███▄    █   ▄████  ▒█████  ▓█████▄  --
--  ▓██ ▒ ██▒▓█   ▀  ██ ▀█   █  ██▒ ▀█▒▒██▒  ██▒▒██▀ ██▌ --
--  ▓██ ░▄█ ▒▒███   ▓██  ▀█ ██▒▒██░▄▄▄░▒██░  ██▒░██   █▌ --
--  ▒██▀▀█▄  ▒▓█  ▄ ▓██▒  ▐▌██▒░▓█  ██▓▒██   ██░░▓█▄   ▌ --
--  ░██▓ ▒██▒░▒████▒▒██░   ▓██░░▒▓███▀▒░ ████▓▒░░▒████▓  --
--  ░ ▒▓ ░▒▓░░░ ▒░ ░░ ▒░   ▒ ▒  ░▒   ▒ ░ ▒░▒░▒░  ▒▒▓  ▒  --
--    ░▒ ░ ▒░ ░ ░  ░░ ░░   ░ ▒░  ░   ░   ░ ▒ ▒░  ░ ▒  ▒  --
--    ░░   ░    ░      ░   ░ ░ ░ ░   ░ ░ ░ ░ ▒   ░ ░  ░  --
--     ░        ░  ░         ░       ░     ░ ░     ░     --
--                                               ░       --
--  ───────────────────────────────────────────────────  --
	  if myHero.charName ~= "Rengar" then return end
--  ───────────────────────────────────────────────────  --

require ("OpenPredict")

-- Autoupdater
local ver = "0.5"

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
		PrintChat("<font color='#af0000'>Rengar - the Pridestalker</font> | <font color='#00d12d'>New version available. Updating...</font>")
        DownloadFileAsync("https://raw.githubusercontent.com/Blaconix/GamingOnSteroids/master/Rengar%20-%20the%20Pridestalker.lua", SCRIPT_PATH .. "Rengar - the Pridestalker", function() PrintChat("<font color='#af0000'>Update Complete!</font> <font color='#00d12d'>Reload with 2x F6!</font>") return end)
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/Blaconix/GamingOnSteroids/master/Rengar%20-%20the%20Pridestalker.version", AutoUpdate)
---


-- Variables
local isJumping 	= false
local isStealthed 	= false
local empTable 		= { "[Q]", "[W]", "[E]" }
local comboTable 	= { "[Q-E-W]", "[E-Q-W]" }
local empPriority 	= empTable[1]
local currCombo 	= comboTable[1]
local target 		= nil
local magnet_target = nil
local Ferocity 		= nil
local RengarE 		= { delay = 0.25, speed = 1500, width = 80, range = 1000 }
local minionTable	= {  }

-- Menu
local RENGOD = Menu("RENGOD", "Rengar - The Pridestalker")
----
RENGOD:SubMenu("Combo", "Combo")

RENGOD.Combo:Boolean("cast_e_fail", "Cast Q when E fails to cast", true)

RENGOD.Combo:Boolean("change_emp_chat", "Empowered Changes in Chat")
RENGOD.Combo:DropDown("emp", "Empowered Prioritize", 1, empTable,
function(priority)
	empPriority = empTable[priority]
	if RENGOD.Combo.change_emp_chat:Value() then PrintChat("<font color='#f3f3f3'>Empowered Priority changed to </font><font color='#af0000'>"..empPriority.."</font>") end
end)
RENGOD.Combo:KeyBinding("change_emp", "Change Empowered Priority", string.byte("G"), false,
function()
	if RENGOD.Combo.emp:Value() == 3 then RENGOD.Combo.emp:Value(1) return end
	RENGOD.Combo.emp:Value(RENGOD.Combo.emp:Value() + 1)
end)

RENGOD.Combo:Boolean("change_combo_chat", "Combo Changes in Chat")
RENGOD.Combo:DropDown("combo_mode", "Combo Mode", 1, comboTable,
function(combo)
	currCombo = comboTable[combo]
	if RENGOD.Combo.change_combo_chat:Value() then PrintChat("<font color='#f3f3f3'>Combo Mode changed to </font><font color='#af0000'>"..currCombo.."</font>") end
end)
RENGOD.Combo:KeyBinding("change_combo", "Change Combo Mode", string.byte("T"), false,
function()
	if RENGOD.Combo.combo_mode:Value() == 2 then RENGOD.Combo.combo_mode:Value(1) return end
	RENGOD.Combo.combo_mode:Value(RENGOD.Combo.combo_mode:Value() + 1)
end)
----
RENGOD:SubMenu("m_t", "Magnet Targeting")
RENGOD.m_t:Boolean("select", "Click to select a Target", true)
RENGOD.m_t:Boolean("deselect", "Deselect when Target dies", false)
RENGOD.m_t:Slider("range", "Magnet Target Range", 4000, 100, 6000, 50)
----
RENGOD:DropDown("skin_changer", "Skin changer", 1, {"Default","Headhunter Rengar", "Night Hunter Rengar", "SSW Rengar"},
function(skin)
	ModelChanger(myHero, skin-1, "Rengar")
end)
ModelChanger(myHero, RENGOD.skin_changer:Value()-1, "Rengar")
RENGOD.Combo.change_emp:Toggle(true)
RENGOD.Combo.change_combo:Toggle(true)
BlockF7OrbWalk(true)


-- Functions
OnProcessSpellAttack(function(unit, spell) 
	if unit.isMe and spell.name:find("RengarBasicAttack") then
		BlockCast()
	end
end)

OnWndMsg(function(msg, key)
	if RENGOD.m_t.select:Value() and msg == WM_LBUTTONDOWN then
		for _, enemy in pairs(GetEnemyHeroes()) do
			if ValidTarget(enemy, RENGOD.m_t.range:Value()) then
				if GetDistance(enemy, GetMousePos()) <= 150 then
					magnet_target = enemy
				else
					magnet_target = nil
				end
			end
		end
	end
end)

OnAnimation(function(unit, animation)
	if unit.isMe and animation == "Spell5" then
		isJumping = true
	end
end)

OnUpdateBuff(function(unit, buff)
	if unit.isMe and buff.Name == "rengarpassivebuff" or buff.Name == "RengaR" then
		isStealthed = true
	end
end)

OnRemoveBuff(function(unit, buff)
	if unit.isMe and buff.Name == "rengarpassivebuff" or buff.Name == "RengaR" then
		isStealthed = false
	end
end)

OnCreateObj(function(obj)
	if obj.team == MINION_ENEMY or obj.team == MINION_JUNGLE then
		table.insert(minionTable, obj)
	end
end)
 
OnDeleteObj(function(obj)
    for _, minion in pairs(minionTable) do
        if minion == obj then
            table.remove(minionTable, _)
        end
    end
end)

function Mode()
  if IOW_Loaded then
    return IOW:Mode()
  elseif DAC_Loaded then
    return DAC:Mode()
  elseif PW_Loaded then
    return PW:Mode()
  elseif GoSWalkLoaded and GoSWalk.CurrentMode then
    return ({"Combo", "Harass", "LaneClear", "LastHit"})[GoSWalk.CurrentMode+1]
  elseif AutoCarry_Loaded then
    return DACR:Mode()
  end
  return ""
end

OnTick(function()
	if magnet_target ~= nil then
		if RENGOD.m_t.deselect:Value() and IsDead(magnet_target) then
			magnet_target = nil
		end
		target = magnet_target
	else
		target = GetCurrentTarget()
	end

	if Mode() == "Combo" then
		Combo()
	end
	if Mode() == "LaneClear" then
		Lane_Jungle_Clear()
	end

	Ferocity = GetCurrentMana(myHero)

	if isJumping == true then
		DelayAction(function() isJumping = false end, .1)
	end

end)

OnDraw(function()
	DrawText("Combo: " ..currCombo, 14, myHero.pos2D.x-50, myHero.pos2D.y+30, GoS.White)
	DrawText("Priority: " ..empPriority, 14, myHero.pos2D.x-50, myHero.pos2D.y+50, GoS.White)
	if magnet_target ~= nil then
		DrawCircle(magnet_target.pos, 75, 3, 3, GoS.Red)
		DrawText("Target: " ..magnet_target.charName, 14, myHero.pos2D.x-50, myHero.pos2D.y+70, GoS.White)
	end
end)


-- Casts
function AutoQ(unit)
	if ValidTarget(unit, myHero.range) and Ready(_Q) then
		CastSpell(_Q)
	end
end

function CastE(unit, validrange)
	local EPred = GetPrediction(unit, RengarE)
	if Ready(_E) and ValidTarget(unit, validrange) and EPred.hitChance >= 0.25 and not EPred:mCollision(1) then
		CastSkillShot(_E, EPred.castPos)
	elseif RENGOD.Combo.cast_e_fail:Value() and (EPred.hitChance < 0.25 or EPred:mCollision(1)) then
		AutoQ(unit)
	end
end

function CastW(unit, validrange)
	if ValidTarget(unit, validrange) and Ready(_W) then
		CastSpell(_W)
	end
end

function CastTH(unit, validrange)
	local Hydra = GetItemSlot(myHero, 3074)
	local Tiamat = GetItemSlot(myHero, 3077)
	if ValidTarget(unit, validrange) then
		if Hydra and Ready(Hydra) then
			CastSpell(Hydra)
		elseif Tiamat and Ready(Tiamat) then
			CastSpell(Tiamat)
		end
	end
end

function CastYG()
	local YG = GetItemSlot(myHero, 3142)
	if YG and Ready(YG) then
		CastSpell(YG)
	end
end


-- Combo
function Combo()
	if isStealthed == true and isJumping == true then
		CastYG()
		if RENGOD.Combo.combo_mode:Value() == 1 then
			CastSpell(_Q)
		elseif RENGOD.Combo.combo_mode:Value() == 2 then
			CastE(target, 1000)
		end
	end
	if (isStealthed == false and isJumping == false) or ((isStealthed == true and isJumping == false) and target.distance < 200) then
		if Ferocity == 5 then
			if RENGOD.Combo.emp:Value() == 1 then
				AutoQ(target)
			elseif RENGOD.Combo.emp:Value() == 2 then
				CastW(target, 400)
			elseif RENGOD.Combo.emp:Value() == 3 then
				CastE(target, 1000)
			end
		elseif Ferocity < 5 then
			AutoQ(target)
			CastTH(target, 400)
			CastW(target, 400)
			CastE(target, 1000)
		end
	end
end

function Lane_Jungle_Clear()
	for _, mob in pairs(minionTable) do
		if Ferocity < 5 then
			AutoQ(mob)
			CastTH(mob, 400)
			CastW(mob, 400)
			CastE(mob, 1000)
		end
	end
end

PrintChat("<font color='#af0000'>Rengar - the Pridestalker</font> | <font color='#00d12d'>Loaded v"..ver)
