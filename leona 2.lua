if GetObjectName(GetMyHero()) ~= "Leona" then return end

require 'OpenPredict'

l = Menu("l", "Leona")
l:Menu("Combo", "Combo")
l.Combo:Key("EQ", "E+Q Dash Stun", string.byte(" "));
l.Combo:Key("Q", "use Q", string.byte(" "));
l.Combo:Slider("QRange", "Q Range Distance ^", 245, 155, 245, 30)
l.Combo:Key("W", "use W", string.byte(" "));
l.Combo:Slider("WRange", "W Range Distance ^", 675, 275, 675, 50)
l.Combo:Key("R1", "Use R ult # of enemies", string.byte("T"));
l.Combo:Slider("R3", "Use R number of enemies", 2, 1, 5, 1)

local LeonaE = { delay = 0.25, speed = 2000, width = 70, range = 875}
local LeonaR = { delay = 0.25, speed = math.huge,  width = 250, range = 1200, radius = 100}

OnTick(function(myHero)
CastEQ()
CastW()
CastR()
end)

local E1 = TargetSelector(875,TARGET_NEAR_MOUSE,DAMAGE_MAGIC,true,false)

function CastEQ()
local E1 = E1:GetTarget()
	if E1 ~= nil then
		for _, E1 in pairs(GetEnemyHeroes()) do
		local E = GetCircularAOEPrediction(E1, LeonaE)
		if Ready(_Q) and l.Combo.EQ:Value() then
			local E = GetCircularAOEPrediction(E1, LeonaE)
			if E and E.hitChance >= 0.20 then
			CastSkillShot(_E, E.castPos)end
			end
		end
	end
end

function CastW()
if l.Combo.W:Value() then
	for _, target in pairs(GetEnemyHeroes()) do
		local WRange = (l.Combo.WRange:Value())
		if Ready(_W) and ValidTarget(target, WRange) then 	
		myHero:Cast(_W, myHero)end
		end
	end
end

local R5 = TargetSelector(1200,TARGET_NEAR_MOUSE,DAMAGE_MAGIC,true,false)

function CastR()
local R5 = R5:GetTarget()
	if R5 ~= nil then
	for _, R5 in pairs(GetEnemyHeroes()) do
		if Ready(_R) and l.Combo.R1:Value() and EnemiesAround(GetOrigin(R5), 1200) >= l.Combo.R3:Value() then
		local R = GetCircularAOEPrediction(R5, LeonaR)
		if R and R.hitChance >= 0.20 then
			CastSkillShot(_R, R.castPos)end
			end
		end
	end
end

OnProcessSpellAttack(function(unit, spell)
local QRange = (l.Combo.QRange:Value())
if unit == myHero and ValidTarget(spell.target,QRange) and l.Combo.Q:Value() then
	myHero:Cast(_Q,spell.target)end
end)
