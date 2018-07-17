if GetObjectName(GetMyHero()) ~= "Lulu" then return end

require 'DamageLib'
require 'OpenPredict'

lulu = Menu("lulu", "lulu")
lulu:Menu("Combo", "Combo")
lulu.Combo:Key("Q", "Cast Skillshot Q", string.byte(" "));
lulu.Combo:Boolean("Qpix", "Cast SkillShot Qpix", true)
lulu.Combo:Boolean("Epix", "CastTarget E", true)

lulu:Menu("hitchance", "hitchance")
lulu.hitchance:Slider("HitchanceQ", "Hitchance Q 1 to 50",  0.25, 0.01, 0.50, 0.01)

lulu:Menu("Farm", "Minion/Jungle")
lulu.Farm:Boolean("E", "Lane Clear E", true) 
lulu.Farm:Boolean("Q", "Lane Clear Q", true) 
lulu.Farm:Slider("E1", "LaneClear E Mana", 80, 10, 100, 10)
lulu.Farm:Slider("Q1", "LaneClear Q Mana", 70, 10, 100, 10)

lulu:Menu("KillSteal", "KillSteal")
lulu.KillSteal:Boolean("KSQ", "KillSteal Q", true)
lulu.KillSteal:Boolean("KSE", "Killsteal E", true)

lulu:Menu("polymorphing", "polymorphing")
lulu.polymorphing:Key("disarm", "polymorphing disarm", string.byte(" "));

lulu:Menu("Escape", "Escape")
lulu.Escape:Key("WE", "cast self speed movement", string.byte("T"));

lulu:Menu("Heal", "Wild Growth ult")
lulu:Slider("Heal1", "WildGrowth Ally health % under hp", 30, 0, 100, 5)
lulu:Slider("Heal2", "WildGrowth Me health % under hp", 20, 0, 100, 5)
lulu.Heal:Key("WildGrowthAlly", "use R ally", string.byte(" "));
lulu.Heal:Key("WildGrowthMe", "use R me", string.byte(" "));

lulu:Menu("Shield", "Shield use E")
lulu:Slider("Shield1", "Ally Shield % under hp", 40, 0, 100, 5)
lulu:Slider("Shield2", "Me Shield % under hp", 25, 0, 100, 5)
lulu.Shield:Key("ShieldAlly", "ShieldAlly", string.byte(" "));
lulu.Shield:Key("ShieldMe", "ShieldMe", string.byte(" "));

local targetQ = TargetSelector(925, TARGET_NEAR_MOUSE or TARGET_PRIORITY, DAMAGE_MAGIC,true,false)
local targetE = TargetSelector(650, TARGET_NEAR_MOUSE or TARGET_PRIORITY, DAMAGE_MAGIC,true,false)
local targetW = TargetSelector(650, TARGET_NEAR_MOUSE or TARGET_PRIORITY, DAMAGE_MAGIC,true,false)

local hitchanceQ = lulu.hitchance.HitchanceQ:Value()

local target = GetCurrentTarget()
local LuluQ = { delay = 0.25, speed = 1500, width = 65, range = 925}
local LuluQPix = { delay = 0.25, speed = 1500, width = 65, range = 925}

OnTick(function(myHero)
CastQ()
CastQpix()
E()
KillSteal()
KillSteal2()
Ally()
Ally2()
polymorphing()
Escape()
LaneClear()
LaneClear2()
end)

function CastQ()
local targetQ = GetCurrentTarget()
if IOW:Mode() == "Combo" and lulu.Combo.Q:Value() then
	if Ready(_Q) and ValidTarget(targetQ, 945) then 
		local Q = GetLinearAOEPrediction(targetQ, LuluQ)
		if Q and Q.hitChance >= hitchanceQ then
			CastSkillShot(_Q, Q.castPos)end
		end
	end
end

function CastQpix()
local target = GetCurrentTarget()
if IOW:Mode() == "Combo" and lulu.Combo.Qpix:Value() then
	if Ready(_Q) and ValidTarget(target, 945) then 
		local Q = GetLinearAOEPrediction(target, LuluQPix)
		if Q and Q.hitChance >= hitchanceQ then
		CastSkillShot(_Q, Q.castPos)end
		end
	end
end

function polymorphing()
DelayAction(function()
local targetW = GetCurrentTarget()
	if IOW:Mode() == "Combo" and Ready(_W) and ValidTarget(targetW, GetCastRange(myHero,_W)) and lulu.polymorphing.disarm:Value() then 
		CastTargetSpell(targetW, _W)end
end, GetWindUp(myHero))
end

function E()
local targetE = GetCurrentTarget()
if IOW:Mode() == "Combo" and lulu.Combo.Epix:Value() then
	if Ready(_E) and ValidTarget(targetE, 650) then
		CastTargetSpell(targetE, _E)end
	end
end

function KillSteal2()
local target = GetCurrentTarget()
	for _, target in pairs(GetEnemyHeroes()) do		
		if ValidTarget(target, 650) and GetCurrentHP(target) <= getdmg("E", target) then
			if Ready(_E) and lulu.KillSteal.KSE:Value() then
			CastTargetSpell(target, _E)
			end
		end
	end
end

function KillSteal()
if lulu.KillSteal.KSQ:Value() then
	for _, target in pairs(GetEnemyHeroes()) do	
		if Ready(_Q) and ValidTarget(target, 945) and GetCurrentHP(target) < getdmg("Q",target) then
			local Q = GetLinearAOEPrediction(target, LuluQ)
			if Q and Q.hitChance >= 0.25 then
			CastSkillShot(_Q, Q.castPos)end
			end
		end
	end
end

function Ally()
DelayAction(function()
	for _, ally in pairs(GetAllyHeroes()) do
	if Ready(_E) and GetDistance(myHero, ally) <= 650 and GetPercentHP(ally) <= lulu.Shield1:Value() and lulu.Shield.ShieldAlly:Value() then
	ally:Cast(_E, ally)
	end
end
	if Ready(_E) and GetPercentHP(myHero) <= lulu.Shield2:Value() and lulu.Shield.ShieldMe:Value() then
	myHero:Cast(_E, myHero)
	end
end, GetWindUp(myHero))
end

function Ally2()
DelayAction(function()
for _, ally in pairs(GetAllyHeroes()) do
	if Ready(_R) and GetDistance(myHero, ally) <= 900 and GetPercentHP(ally) <= lulu.Heal1:Value() and lulu.Heal.WildGrowthAlly:Value() then
	ally:Cast(_R, ally)
	end
end
	if Ready(_R) and GetPercentHP(myHero) <= lulu.Heal2:Value() and lulu.Heal.WildGrowthMe:Value() then
	myHero:Cast(_R, myHero)
	end
end, GetWindUp(myHero))
end

function Escape()
DelayAction(function()
if Ready(_W) and lulu.Escape.WE:Value() then
	myHero:Cast(_W, myHero) 
end
	if lulu.Escape.WE:Value() then MoveToXYZ(GetMousePos())
	end
end, GetWindUp(myHero))
end

function LaneClear()
if IOW:Mode() == "LaneClear" then
for _,minion in pairs (minionManager.objects) do
	if GetTeam(minion) ~= MINION_ALLY then
		if Ready(_E) and ValidTarget(minion, 650) and lulu.Farm.E:Value() then
			if GetPercentMP(myHero) >= lulu.Farm.E1:Value() then
				if GetHP(minion) < getdmg("E",minion) then
					CastTargetSpell(minion, _E)end
					end
				end
			end
		end
	end
end

function LaneClear2()
if IOW:Mode() == "LaneClear" then
for _,minion in pairs (minionManager.objects) do
	if GetTeam(minion) ~= MINION_ALLY then
		if Ready(_Q) and ValidTarget(minion, 945) and lulu.Farm.Q:Value() then
			if GetPercentMP(myHero) >= lulu.Farm.Q1:Value() then
				if GetHP(minion) < getdmg("Q",minion) then
					CastSkillShot(_Q, GetOrigin(minion))end
					end
				end
			end
		end
	end
end

AddGapcloseEvent(_W, 650, true)
