PrintChat(string.format("<font color='#fdfd24'> Not Jarvin VI </font>"))
if GetObjectName(GetMyHero()) ~= "JarvanIV" then return end

require 'DamageLib'
require 'OpenPredict'

j = Menu("j", "Jarvan IV")
mainMenu:Menu("Combo", "Combo")
mainMenu.Combo:Boolean("Q", "Use Q", true)
mainMenu.Combo:Boolean("E", "Use E", true)
mainMenu.Combo:Boolean("R", "Use R", true)

mainMenu:Menu("Escape", "Hold T key Escape")
mainMenu.Escape:Key("EQ", "Hold T Escape", string.byte("Z"));

mainMenu:Menu("Shield", "Shield")
mainMenu.Shield:Key("W", "use W SelfBarrier", string.byte(" "));
mainMenu.Shield:Slider("Barrier", "Barrier % under hp", 30, 0, 100, 1)

mainMenu:Menu("killsteal", "killsteal")
mainMenu.killsteal:Boolean("E", "Killsteal E", true)
mainMenu.killsteal:Boolean("Q", "Killsteal Q", true)
mainMenu.killsteal:Boolean("R", "Killsteal R", true)

local DragonStrike = { delay = 0.25, speed = 1400, width = 70, range = GetCastRange(myHero,_Q)}
local DemacianStandard = { delay = 0.25, speed = 1450, width = 75, range = GetCastRange(myHero,_E), radius = 75}
local target = GetCurrentTarget()

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
	if Mode() == "Combo" then
		local target = GetCurrentTarget()
		if mainMenu.Combo.E:Value() then
			if Ready(_E) and ValidTarget(target, GetCastRange(myHero,_E)) then 
				local E = GetCircularAOEPrediction(target, DemacianStandard)
				if E and E.hitChance >= 0.20 then
					CastSkillShot(_E, E.castPos)end
				end
			end
,
		if mainMenu.Combo.Q:Value() then
			if Ready(_Q) and ValidTarget(target, GetCastRange(myHero,_Q)) then 
				local Q = GetLinearAOEPrediction(target, DragonStrike)
				if Q and Q.hitChance >= 0.20 then
					CastSkillShot(_Q, Q.castPos)end
				end
			end
		end
	end

	CastW()
	Escape()
	KillStealE()
	KillStealQ()
	KillStealR()
end)

function CastW()
DelayAction(function()
	if Ready(_W) and GetPercentHP(myHero) <= mainMenu.Shield.Barrier:Value() and mainMenu.Shield.W:Value() then
	Cast(_W)
	end
end, GetWindUp(myHero))
end

function Escape()
if not IsVisible(myHero) or not Ready(_E) then return end
if Ready(_Q) and mainMenu.Escape.EQ:Value() then 
	CastSkillShot(_E, GetMousePos()) end
if mainMenu.Escape.EQ:Value() then
	MoveToXYZ(GetMousePos())end
end	

function KillStealE()
if mainMenu.killsteal.E:Value() then
	for _, target in pairs(GetEnemyHeroes()) do
		if ValidTarget(target, GetCastRange(myHero,_Q)) and GetCurrentHP(target) <= getdmg("E", target) then
			local E = GetCircularAOEPrediction(target, DemacianStandard)
			if E and E.hitChance >= 0.20 then
			CastSkillShot(_E, E.castPos)end
			end
		end
	end
end

function KillStealQ()
if mainMenu.killsteal.Q:Value() then
	for _, target in pairs(GetEnemyHeroes()) do
		if ValidTarget(target, GetCastRange(myHero,_Q)) and GetCurrentHP(target) <= getdmg("Q", target) then
			local Q = GetLinearAOEPrediction(target, DragonStrike)
			if Q and Q.hitChance >= 0.20 then
			CastSkillShot(_Q, Q.castPos)end
			end
		end
	end
end

function KillStealR()
for _, target in pairs(GetEnemyHeroes()) do
	if Ready(_R) and ValidTarget(target, GetCastRange(myHero,_R)) and mainMenu.killsteal.R:Value() and GetCurrentHP(target) <= getdmg("R", target) then
		if GotBuff(target, "jarvanivmartialcadencecheck") == 0 then
			CastTargetSpell(target, _R)end
		end
	end
end

OnProcessSpell(function(unit, spell)
if Ready(_Q) and unit == myHero and spell.name == "JarvanIVDemacianStandard" and mainMenu.Combo.Q:Value() then
	DelayAction(function() CastSkillShot(_Q, GetMousePos()) end, 0)end
if Ready(_Q) and unit == myHero and spell.name == "JarvanIVDemacianStandard" and mainMenu.Escape.EQ:Value() then
	DelayAction(function() CastSkillShot(_Q, GetMousePos()) end, 0)end
end)
