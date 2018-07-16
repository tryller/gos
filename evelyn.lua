if GetObjectName(GetMyHero()) ~= "Evelynn" then return end

local ver = "2"

local mainMenu = MenuConfig("Evelynn", "Evelynn")
mainMenu:Menu("Combo", "combo stuff")
mainMenu.Combo:Boolean("Check1", "Check for invis?", true)
mainMenu.Combo:Boolean("Q", "Use q", true)
mainMenu.Combo:Boolean("E", "Use e", true)
mainMenu.Combo:Boolean("R1", "r if current hp<=hp% set", true)
mainMenu.Combo:Slider("Rhp", "hp%", 20, 10, 90)
mainMenu.Combo:Boolean("R2", "r can hit x or more enemies", true)
mainMenu.Combo:Slider("Renemy", "enemy count", 3, 1, 5, 1)

mainMenu:Menu("Stuff", "other stuff")
mainMenu.Stuff:Boolean("items", "Use items", true)
mainMenu.Stuff:Boolean("Qfarm", "Use q for ''last hitting''", true)
mainMenu.Stuff:Boolean("W", "Use w to remove slow", true)

mainMenu:Menu("morestuff", "clear spam stuff")
mainMenu.morestuff:Boolean("jungleq", "spam q on jungle mobs?", true)
mainMenu.morestuff:Boolean("junglee", "how about e?", true)
mainMenu.morestuff:Boolean("laneq", "spam q on creeps?", true)
mainMenu.morestuff:Boolean("lanee", "how about e?", true)

mainMenu:Menu("lvl", "AutoLvl")
mainMenu.lvl:Boolean("uselvl", "Use AutoLvl", false)
mainMenu.lvl:DropDown("lvlqwe", "first 3 spells", 1, {"q first","e first"})
mainMenu.lvl:Slider("levelstart", "kill auto lvl till", 1, 1, 18, 1)

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
	if GotBuff(myHero, "evelynnstealthmarker") == 1 and mainMenu.Combo.Check1:Value() then return end
lasthit()
lvlup()
laneclear()

	if Mode() == "Combo" then
		items()
		qcast()
		ecast()
		rcast1()
		rcast2()
	end
end)



--best slow removal with help from noddy
OnUpdateBuff(function(unit,buff)
	if unit == myHero and buff.Type == 10 and mainMenu.Stuff.W:Value() and IsReady(_W) then
		CastSpell(_W)
	end
end)

function qcast()
--most op q ever
local enemy = GetCurrentTarget()
	if ValidTarget(enemy, GetCastRange(myHero, _Q)) and IsReady(_Q) and mainMenu.Combo.Q:Value() then
		CastSpell(_Q)
	end
end


function ecast()
--flawless e
local enemy = GetCurrentTarget()
	if ValidTarget(enemy, GetCastRange(myHero, _E)) and IsReady(_E) and mainMenu.Combo.E:Value() then
		CastTargetSpell(enemy, _E)
	end
end


function rcast1()
--r enemy count based
local enemy = GetCurrentTarget()
	if ValidTarget(enemy, GetCastRange(myHero, _R)) and IsReady(_R) and EnemiesAround(GetOrigin(enemy),250) >= mainMenu.Combo.Renemy:Value()  and mainMenu.Combo.R2:Value() then
		CastTargetSpell(enemy, _R)
	end
end


function rcast2()
--r hp% based
local enemy = GetCurrentTarget()
	if ValidTarget(enemy, GetCastRange(myHero, _R)) and IsReady(_R) and mainMenu.Combo.R1:Value() and GetPercentHP(myHero) <= mainMenu.Combo.Rhp:Value() then
		CastTargetSpell(enemy, _R)
	end
end


function lasthit()
--last hit
local creep = ClosestMinion(GetOrigin(myHero), MINION_ENEMY)
	if ValidTarget(creep, GetCastRange(myHero, _Q)) then
local qdmg = CalcDamage(myHero, creep, 0, 30+GetCastLevel(myHero,_Q)*10+GetBonusAP(myHero)*(.30+.05*GetCastLevel(myHero,_Q))+GetBonusDmg(myHero)*(.45+.05*GetCastLevel(myHero,_Q)))
		if ValidTarget(creep, GetCastRange(myHero, _Q)) and GetCurrentHP(creep) <= qdmg and mainMenu.Stuff.Qfarm:Value() then
			CastSpell(_Q)
    		end
    	end
end


function items()
--items
local enemy = GetCurrentTarget()
	if mainMenu.Stuff.items:Value() and ValidTarget(enemy, GetCastRange(myHero, _Q)) then
		CastOffensiveItems(enemy)
	end
end


function lvlup()
--lvl up
Table=
{
[1]={_Q,_E,_W,_Q,_Q,_R,_Q,_E,_Q,_E,_R,_E,_E,_W,_W,_R,_W,_W},
[2]={_E,_Q,_W,_E,_E,_R,_E,_Q,_E,_Q,_R,_Q,_Q,_W,_W,_R,_W,_W} 
}
	if mainMenu.lvl.uselvl:Value() and GetLevelPoints(myHero) >= 1 and GetLevel(myHero) >= mainMenu.lvl.levelstart:Value() then
		DelayAction(function() LevelSpell(Table[mainMenu.lvl.lvlqwe:Value()][GetLevel(myHero)-GetLevelPoints(myHero)+1]) end, math.random(0.5,1.5))
	end
end


function laneclear()
--ugh
	if Mode() == "LaneClear" then
		for i,dude in pairs(minionManager.objects) do
			if GetTeam(dude) == MINION_JUNGLE and IsReady(_Q) and ValidTarget(dude, GetCastRange(myHero, _Q)) and mainMenu.morestuff.jungleq:Value() then
				CastSpell(_Q)
			end
			if GetTeam(dude) == MINION_JUNGLE and IsReady(_E) and ValidTarget(dude, GetCastRange(myHero, _E)) and mainMenu.morestuff.junglee:Value() then
				CastTargetSpell(dude, _E)
			end
			if GetTeam(dude) == MINION_ENEMY and IsReady(_Q) and ValidTarget(dude, GetCastRange(myHero, _Q))and mainMenu.morestuff.laneq:Value() then
				CastSpell(_Q)
			end
						if GetTeam(dude) == MINION_ENEMY and IsReady(_E) and ValidTarget(dude, GetCastRange(myHero, _E)) and mainMenu.morestuff.lanee:Value() then
				CastTargetSpell(dude, _E)
			end
		end	
	end
end
