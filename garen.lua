--Hero
if GetObjectName(GetMyHero()) ~= "Garen" then return end

--Load Libs
require ("DamageLib")

--Main Menu
mainMenu = Menu("Garen", "Garen")
mainMenu:SubMenu("c", "Combo")
mainMenu.c:Boolean("Q", "Use Q", true)
mainMenu.c:Slider("Qrange", "Min. range for use Q", 300, 0, 1000, 10)
mainMenu.c:Boolean("E", "Use E", true)

mainMenu:SubMenu("u", "Ultimate")
mainMenu.u:Boolean("R", "Use R")
mainMenu.u:SubMenu("black", "Ultimate White List")
DelayAction(function()
    for _, unit in pairs(GetEnemyHeroes()) do
        mainMenu.u.black:Boolean(unit.name, "Use R On: "..unit.charName, true)
    end
end, 0.01)

mainMenu:SubMenu("a", "Auto")
mainMenu.a:Boolean("W", "Use W", true)
mainMenu.a:Slider("Whp", "Use W if HP(%) <= X", 70, 0, 100, 5)
mainMenu.a:Slider("Wlim", "Use W if Enemy Count >= X", 1, 1, 5, 1)

mainMenu:SubMenu("l", "Last Hit")
mainMenu.l:Boolean("Q", "Use Q", true)

mainMenu:SubMenu("h", "Harass")
mainMenu.h:Boolean("Q", "Use Q", true)
mainMenu.h:Slider("Qrange", "Min. range for use Q", 300, 0, 1000, 10)
mainMenu.h:Boolean("E", "Use E", true)

mainMenu:SubMenu("cl", "Clear")
mainMenu.cl:SubMenu("l", "Lane Clear")
mainMenu.cl.l:Boolean("Q", "Use Q", true)
mainMenu.cl.l:Boolean("E", "Use E", true)
mainMenu.cl:SubMenu("j", "Jungle Clear")
mainMenu.cl.j:Boolean("Q", "Use Q", true)
mainMenu.cl.j:Boolean("E", "Use E", true)

local Garen_E = { range = 300 }
local Garen_R = { range = 400 }

--Mode
function Mode() --Deftsu
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
    elseif _G.SLW_Loaded then
        return SLW:Mode()
    elseif EOW_Loaded then
        return EOW:Mode()
    end
    return ""
end

--Start
OnTick(function (myHero)
	if not IsDead(myHero) then
		--Locals
		local target = GetCurrentTarget()
		--Functions
		OnCombo(target)
        OnLastHit()
        OnHarass(target)
        OnClear()
        CastR()
	end
end)

--Functions
function OnCombo(target)
	if Mode() == "Combo" then
		if Ready(_Q) and mainMenu.c.Q:Value() and ValidTarget(target, mainMenu.c.Qrange:Value()) then
			CastSpell(_Q)
		end

		if Ready(_E) and mainMenu.c.E:Value() and ValidTarget(target, Garen_E.range) and GetCastName(myHero, _E) == "GarenE" then
			CastSpell(_E)
		end
	end
end

function OnLastHit()
    if Mode() == "LastHit" then
        for _, minion in pairs(minionManager.objects) do
            if GetTeam(minion) == MINION_ENEMY then
                if mainMenu.l.Q:Value() and Ready(_Q) and ValidTarget(minion, 400) then
                    if getdmg("Q",minion,myHero) > GetCurrentHP(minion) then
                        CastSpell(_Q)
                        AttackUnit(minion)
                    end
                end
            end
        end
    end
end

function OnHarass(target)
    if Mode() == "Harass" then
        --Q
        if Ready(_Q) and mainMenu.h.Q:Value() and ValidTarget(target, mainMenu.h.Qrange:Value()) then
            CastSpell(_Q)
        end
        --E
        if Ready(_E) and mainMenu.h.E:Value() and ValidTarget(target, Garen_E.range) and GetCastName(myHero, _E) == "GarenE" then
            CastSpell(_E)
        end
    end
end

function OnClear()
    if Mode() == "LaneClear" then
        for _, minion in pairs(minionManager.objects) do
            if GetTeam(minion) == MINION_ENEMY then
                --Q
                if Ready(_Q) and mainMenu.cl.l.Q:Value() and ValidTarget(minion, 300) then
                    CastSpell(_Q)
                end
                --E
                if Ready(_E) and mainMenu.cl.l.E:Value() and ValidTarget(minion, Garen_E.range) and GetCastName(myHero, _E) == "GarenE" and MinionsAround(minion, 950) >= 3 then
                    CastSpell(_E)
                end
            end
        end
    end
    if Mode() == "LaneClear" then --[[JungleClear doesnt work :doge:]]
        for _, mob in pairs(minionManager.objects) do
            if GetTeam(mob) == MINION_JUNGLE then
                --Q
                if Ready(_Q) and mainMenu.cl.j.Q:Value() and ValidTarget(mob, 300) then
                    CastSpell(_Q)
                end
                --E
                if Ready(_E) and mainMenu.cl.j.E:Value() and ValidTarget(mob, Garen_E.range) and GetCastName(myHero, _E) == "GarenE" then
                    CastSpell(_E)
                end
            end
        end
    end
end

function CastR()
    for _,unit in pairs(GetEnemyHeroes()) do
        if mainMenu.u.R:Value() and Ready(_R) and ValidTarget(unit, Garen_R.range) and GetCurrentHP(unit) + GetDmgShield(unit) <  getdmg("R",unit,myHero) then
            if mainMenu.u.black[unit.name]:Value() then
                CastTargetSpell(unit,_R)
            end
        end
    end
end

OnProcessSpell(function(unit,spellProc)    
    if unit.isMe and spellProc.name:lower():find("attack") and EnemiesAround(myHero, 950) >= mainMenu.a.Wlim:Value() then     
        if mainMenu.a.W:Value() and Ready(_W) and GetPercentHP(myHero) < mainMenu.a.Whp:Value() then 
            CastSpell(_W)   
        end
    end
end)
