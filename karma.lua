if GetObjectName(GetMyHero()) ~= "Karma" then return end

if not pcall( require, "OpenPredict" ) then PrintChat("This script doesn't work without OpenPredict! Download it!") return end

-- Menu
mainMenu = Menu("Karma", "Karma")
mainMenu:SubMenu("c", "Combo")
mainMenu.c:Boolean("Q", "Use Q", true)
mainMenu.c:Boolean("W", "Use W", true)
mainMenu.c:Boolean("R", "Use R", true)
mainMenu.c:Slider("rW", "R-W if lower than %HP", 10, 0, 100, 1)

mainMenu:SubMenu("sh", "Shield")
mainMenu.sh:Slider("sP", "Shield ally under %HP", 50, 0, 100, 1)
mainMenu.sh:Boolean("sG", "Use shield as GapCloser", false)
mainMenu.sh:Boolean("sT", "Shield Turretshot", true)
mainMenu.sh:Boolean("sL", "Shield LowHealth", true)
mainMenu.sh:KeyBinding("sR", "Ult Shield" , string.byte("T"))


eHeroes = {}
DelayAction( function()
	eHeroes["Karma"] = "s1"
	mainMenu.sh:Boolean("s1", "Shield Yourself", true)
	for n,i in pairs(GetAllyHeroes()) do
		eHeroes[GetObjectName(i)] = "s"..n+1
		mainMenu.sh:Boolean(eHeroes[GetObjectName(i)], "Shield "..GetObjectName(i).." ("..GetObjectBaseName(i)..")", true)
	end
end, .01)

mainMenu:SubMenu("ks", "Killsteal")
mainMenu.ks:Boolean("KSQ","Killsteal with Q", true)
mainMenu.ks:Boolean("KSR","Killsteal with R", true)

mainMenu:SubMenu("p", "Prediction")
mainMenu.p:Slider("hQ", "HitChance Q", 20, 0, 100, 1)

mainMenu:SubMenu("i", "Items")
mainMenu.i:Boolean("iC","Use Items only in Combo", true)
mainMenu.i:Boolean("iO","Use offensive Items", true)

mainMenu:SubMenu("a", "AutoLvl")
mainMenu.a:Boolean("aL", "Use AutoLvl", false)
mainMenu.a:DropDown("aLS", "AutoLvL", 1, {"Q-W-E","Q-E-W"})
mainMenu.a:Slider("sL", "Start AutoLvl with LvL x", 1, 1, 18, 1)
mainMenu.a:Boolean("hL", "Humanize LvLUP", true)

mainMenu:SubMenu("s","Skin")
mainMenu.s:Boolean("uS", "Use Skin", false)
mainMenu.s:Slider("sV", "Skin Number", 0, 0, 7, 1)

--Locals
local qRange = 950
local wRange = 675
local eRange = 800
local KarmaQ = { delay = 0.1, speed = 1700, width = 100, range = qRange}
local Move = { delay = 0.5, speed = math.huge, width = 50, range = math.huge}
local cSkin = 0
local item = {3092,3142,3153}

--Lvlup table
local lTable={
[1]={_Q,_W,_E,_Q,_Q,_R,_Q,_W,_Q,_W,_R,_W,_W,_E,_E,_R,_E,_E},
[2]={_Q,_E,_W,_Q,_Q,_R,_Q,_E,_Q,_E,_R,_E,_E,_W,_W,_R,_W,_W}
}


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


-- Start
OnTick(function()
	if not IsDead(myHero) then
		local unit = GetCurrentTarget()
		ks()
		shield()
		combo(unit)
		items(unit)
		lvlUp()
		skin()
	end
end)

--Functions

function combo(unit)
	if Mode == "Combo" then
		local qRdy = Ready(_Q)
		local wRdy = Ready(_W)
		local rRdy = Ready(_R)
		
		--W
		if mainMenu.c.W:Value() and wRdy and ValidTarget(unit, wRange) then
			if rRdy and GetPercentHP(myHero) < mainMenu.c.rW:Value() then
				CastSpell(3)
				DelayAction( function() CastTargetSpell(unit,1) end,0.01)
			else
				CastTargetSpell(unit,1)			
			end
		end
		
		--RQ
		if mainMenu.c.Q:Value() and mainMenu.c.R:Value() and qRdy and rRdy and ValidTarget(unit, qRange) then
			local QPred = GetPrediction(unit, KarmaQ)
			if QPred and QPred.hitChance >= (mainMenu.p.hQ:Value()/100) and not QPred:mCollision(1) then
				CastSpell(3)
				DelayAction( function() CastSkillShot(_Q, QPred.castPos) end, .01)
			end
		end
		
		--Q
		if mainMenu.c.Q:Value() and qRdy and ValidTarget(unit, qRange) then
			local QPred = GetPrediction(unit, KarmaQ)
			
			if QPred and QPred.hitChance >= (mainMenu.p.hQ:Value()/100) and not QPred:mCollision(1) then
				CastSkillShot(_Q, QPred.castPos)
			end
		end	
	end
end

function shield()
	if not Ready(2) then return end
	if mainMenu.sh.sR:Value() and Ready(3) then
		CastSpell(3)
		DelayAction(function()
			CastTargetSpell(myHero,2)
		end,.5)
	end
	for _,i in pairs(GetAllyHeroes()) do
		local movePos = GetPrediction(i, Move).castPos
		local ePos = GetOrigin(ClosestEnemy(GetOrigin(i)))
		if Mode == "Combo" and mainMenu.sh.sG:Value() and mainMenu.sh[eHeroes[GetObjectName(i)]]:Value() and GetDistance(ePos,GetOrigin(i))>GetDistance(ePos,movePos) and GetDistance(GetOrigin(myHero),GetOrigin(i))< eRange then
			CastTargetSpell(i,2)
		end
	end
	local movePos = GetPrediction(myHero, Move).castPos
	local ePos = GetOrigin(ClosestEnemy(GetOrigin(myHero)))
	if Mode == "Combo" and mainMenu.sh.sG:Value() and mainMenu.sh[eHeroes[GetObjectName(myHero)]]:Value() and GetDistance(ePos,GetOrigin(myHero))>GetDistance(ePos,movePos) then
			CastTargetSpell(myHero,2)
	end
end

function ks()
	local qRdy = Ready(_Q)
	local rRdy = Ready(_R)
	for i,unit in pairs(GetEnemyHeroes()) do
		--Q
		local QPred = GetPrediction(unit, KarmaQ)
		if mainMenu.ks.KSQ:Value() and qRdy and ValidTarget(unit,qRange) and QPred and QPred.hitChance >= (mainMenu.p.hQ:Value()/100) and not QPred:mCollision(1) then
			if GetCurrentHP(unit) + GetDmgShield(unit) <  CalcDamage(myHero, unit, 0 ,dmgCalc("Q")) then
				CastSkillShot(0, QPred.castPos)				
			elseif rRy and GetCurrentHP(unit) + GetDmgShield(unit) <  CalcDamage(myHero, unit, 0 , dmgCalc("Q2")) then
				CastSpell(3)
				DelayAction(function() CastSkillShot(0,QPred.castPos) end,0.01)
			end
		end
	end
end

function items(unit)
	if mainMenu.i.iO:Value() and ValidTarget(unit,700) then
		if Mode == "Combo" or not mainMenu.i.iC:Value() then
			for _,i in pairs(item) do
				if GetItemSlot(myHero,i)>0 and Ready(GetItemSlot(myHero,i)) then
					CastTargetSpell(unit,GetItemSlot(myHero,i))
				end
			end
		end
	end
end

function lvlUp()
	if mainMenu.a.aL:Value() and GetLevelPoints(myHero) >= 1 and GetLevel(myHero) >= mainMenu.a.sL:Value() then
		if mainMenu.a.hL:Value() then
			DelayAction(function() LevelSpell(lTable[mainMenu.a.aLS:Value()][GetLevel(myHero)-GetLevelPoints(myHero)+1]) end, math.random(0.500,0.750))
		else
			LevelSpell(lTable[mainMenu.a.aLS:Value()][GetLevel(myHero)-GetLevelPoints(myHero)+1])
		end
	end
end

function skin()
	if mainMenu.s.uS:Value() and mainMenu.s.sV:Value() ~= cSkin then
		HeroSkinChanger(GetMyHero(),mainMenu.s.sV:Value()) 
		cSkin = mainMenu.s.sV:Value()
	end
end

--dmg table
function dmgCalc(spell)
	local dmg={ 
	["Q"] = 35 + 45*GetCastLevel(myHero,0) + GetBonusAP(myHero)*.6 , 
	["Q2"] = 10 + 45*GetCastLevel(myHero,0) + 50*GetCastLevel(myHero,3) + GetBonusAP(myHero)*.9 ,
	["Q3"] = -50 + 100*GetCastLevel(myHero,3) + GetBonusAP(myHero)*.6,
	["W"] = 10 + 50*GetCastLevel(myHero,1) + GetBonusAP(myHero)*.9
	}
	return dmg[spell]
end

--CALLBACKS
OnProcessSpell(function(unit,spellProc)
	if Ready(2) and mainMenu.sh.sT:Value() and GetObjectType(unit) == Obj_AI_Turret and GetDistance(GetOrigin(spellProc.target),GetOrigin(myHero))<eRange and GetObjectType(spellProc.target) == Obj_AI_Hero and GetTeam(spellProc.target) == MINION_ALLY and GetPercentHP(spellProc.target)<= mainMenu.sh.sP:Value() and mainMenu.sh[eHeroes[GetObjectName(spellProc.target)]]:Value() then
		CastTargetSpell(spellProc.target,2)
	end
end)

PrintChat("Karma Loaded - Enjoy your game - Logge")
