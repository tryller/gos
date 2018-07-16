if GetObjectName(GetMyHero()) ~= "Taric" then return end

require 'OpenPredict'

Taric = Menu("Taric", "Taric Bae")
Taric:Menu("Combo", "Combo")
Taric.Combo:Key("E1", "Use E SkillShot Stun", string.byte(" "));
Taric.Combo:Slider("E2", "E SkillShot Mana Stop % under ^", 20, 0, 100, 5)
Taric.Combo:Key("E3", "Ally E SkillShot Stun", string.byte(" "));
----------------------------------------------------------------
Taric:Menu("Combo2", "Combo 2")
Taric.Combo2:Key("QC1", "Bravado AA Passive", string.byte(" "));
Taric.Combo2:Boolean("FN", "Q AA Passive On or Off", true)
Taric.Combo2:Slider("QC2", "Q AA Passive Mana Stop % under ^", 60, 0, 100, 5)
----------------------------------------------------------------
Taric:Menu("HB", "Heal and Barrier")
Taric.HB:KeyBinding("HBAlly1", "Heal Ally", string.byte(" "));
Taric.HB:Slider("HB1", "Heal Ally % under hp", 35, 0, 100, 5)
Taric.HB:KeyBinding("HBSelf2", "Heal Self", string.byte(" "));
Taric.HB:Slider("HB2", "Heal Self % under hp", 15, 0, 100, 5)
----------------------------------------------------------------

--Taric:Menu("QHealCharge", "Heal Charge Check")
--Taric.QHealCharge:Slider("QHeal1", "Ally Q heal Charge #", 3, 1, 3, 1)
--Taric.QHealCharge:Slider("QHeal2", "Self Q heal Charge #", 3, 1, 3, 1)

----------------------------------------------------------------
Taric.HB:KeyBinding("HBAlly3", "Barrier Ally", string.byte(" "));
Taric.HB:Slider("HB3", "Barrier Ally % under hp", 40, 0, 100, 5)
Taric.HB:KeyBinding("HBSelf4", "Barrier Self", string.byte(" "));
Taric.HB:Slider("HB4", "Barrier Self % under hp", 15, 0, 100, 5)
----------------------------------------------------------------
Taric:Menu("Zhonye", "Cosmic Radiance Ult")
Taric.Zhonye:KeyBinding("Zhonye1", "Ult Ally", string.byte(" "));
Taric.Zhonye:Slider("Zhonye2", "Cosmic Radiance Ally % under hp", 15, 0, 100, 5)
Taric.Zhonye:KeyBinding("Zhonye3", "Ult Self", string.byte(" "));
Taric.Zhonye:Slider("Zhonye4", "Cosmic Radiance Self % under hp", 10, 0, 100, 5)
----------------------------------------------------------------
Taric:Menu("Jungle", "Jungle LaneClear only")
Taric.Jungle:Key("QWJ2", "Bravado Passive QW AA", string.byte("V"));
Taric.Jungle:Slider("QJ2", "Q AA reduce 1 cd Mana Stop % under ^", 60, 0, 100, 5)
Taric.Jungle:Slider("WJ2", "W AA reduce 1 cd Mana Stop % under ^", 60, 0, 100, 5)
----------------------------------------------------------------
Taric:Menu("LaneClear", "Minion LaneClear only")
Taric.LaneClear:Key("LQ1", "Bravado AA Passive", string.byte("V"));
Taric.LaneClear:Boolean("LFN", "Q AA Passive On or Off", true)
Taric.LaneClear:Slider("LQ2", "Q AA Passive Mana Stop % under ^", 60, 0, 100, 5)

local TaricE = { delay = 0.25, speed = 1000, width = 145, GetCastRange(myHero,_E)}

local PassiveAttack1 = false
local PassiveAttack2 = false

OnUpdateBuff(function(unit,buff) 
	if unit == myHero and buff.Name == "taricpassiveattackparticle" then
	PassiveAttack1 = true end
	if unit == myHero and buff.Name == "TaricPassiveAttack" then
	PassiveAttack2 = true end
end)

OnRemoveBuff(function(unit,buff)
	if unit == myHero and buff.Name == "taricpassiveattackparticle" then
	PassiveAttack1 = false end
	if unit == myHero and buff.Name == "TaricPassiveAttack" then
	PassiveAttack2 = false end
end)

OnTick(function(myHero)
if IsDead(myHero) then return end
CastE()
CastEAlly()
CastW()
CastQ()
CastR()
end)

OnProcessSpellAttack(function(unit,spell)
DelayAction(function()
	if Taric.Combo2.FN:Value() then
		if unit == myHero then
			if spell.name:lower():find("attack") then 
				if IOW:Mode() == "Combo" then 
					local targetQ = GetCurrentTarget()
					if ValidTarget(targetQ, 355) and Taric.Combo2.QC1:Value() and GetPercentMP(myHero) >= Taric.Combo2.QC2:Value() and not PassiveAttack1 and not PassiveAttack2 then
						myHero:Cast(_Q, targetQ)end
						
					end
				end
			end
		end
	end, GetWindUp(myHero))
end)

function CastE()
local targetE = GetCurrentTarget()
if IOW:Mode() == "Combo" and Taric.Combo.E1:Value() then
	if Ready(_E) and ValidTarget(targetE, GetCastRange(myHero,_E)) and GetPercentMP(myHero) >= Taric.Combo.E2:Value() and not IsDead(targetE) then
		local E = GetLinearAOEPrediction(targetE, TaricE)
		if E and E.hitChance >= 0.20 then
		myHero:CastSpell(_E, E.castPos)end
		end
	end
end

function CastEAlly()
if Taric.Combo.E3:Value() then
	for _, ally in pairs(GetAllyHeroes()) do
		if GotBuff(ally, "taricwleashactive") == 1 then
		for _, target in pairs(GetEnemyHeroes()) do
			if Ready(_E) and GetDistance(myHero, target) <= 1500 and not IsDead(target) and not IsDead(ally) then
				local E = GetLinearAOEPrediction(target, TaricE, GetOrigin(ally))
				if E and E.hitChance >= 0.20 then
					myHero:Cast(_E, E.castPos)end
					end
				end
			end
		end
	end
end

function CastQ() 
if Taric.HB.HBAlly1:Value() then
	for _, ally in pairs(GetAllyHeroes()) do
		if Ready(_Q) and GetDistance(myHero, ally) <= 1000 and GetPercentHP(ally) <= Taric.HB.HB1:Value() and not IsDead(ally)then
		ally:Cast(_Q, GetOrigin(ally))end
end
if Ready(_Q) and GetPercentHP(myHero) <= Taric.HB.HB2:Value() and Taric.HB.HBSelf2:Value() then
	myHero:Cast(_Q, GetOrigin(myHero))end
	end
end

function CastW()
if Taric.HB.HBAlly3:Value() then
for _, ally in pairs(GetAllyHeroes()) do
if Ready(_W) and GetDistance(myHero, ally) <= 1000 and GetPercentHP(ally) <= Taric.HB.HB3:Value() and not IsDead(ally)then
	ally:Cast(_W, GetOrigin(ally))end
end
if Ready(_W) and GetPercentHP(myHero) <= Taric.HB.HB4:Value() and Taric.HB.HBSelf4:Value() then
	myHero:Cast(_W, GetOrigin(myHero))end
	end
end

function CastR()
if Taric.Zhonye.Zhonye1:Value() and not IsDead(myHero)then
	for _, ally in pairs(GetAllyHeroes()) do
		if Ready(_R) and GetDistance(myHero, ally) <= 1000 and GetPercentHP(ally) <= Taric.Zhonye.Zhonye2:Value() and not IsDead(ally)then
		ally:Cast(_R, GetOrigin(ally))end
end
if Ready(_R) and GetPercentHP(myHero) <= Taric.Zhonye.Zhonye4:Value() and Taric.Zhonye.Zhonye3:Value() then
	myHero:Cast(_R, GetOrigin(myHero))end
	end
end

OnProcessSpellAttack(function(unit,spell)
DelayAction(function()
	if unit == myHero then
		if spell.name:lower():find("attack") then 
			if IOW:Mode() == "LaneClear" then 
			for _, Jungle in pairs(minionManager.objects) do	
			if ValidTarget(Jungle, 355) and GetTeam(Jungle) == MINION_JUNGLE and Taric.Jungle.QWJ2:Value() and GetPercentMP(myHero) >= Taric.Jungle.QJ2:Value() and not PassiveAttac1 and not PassiveAttack2 then
				myHero:Cast(_Q, Jungle)end
				end
			end
		end
	end
end, GetWindUp(myHero))
DelayAction(function()
	if unit == myHero then
		if spell.name:lower():find("attack") then 
			if IOW:Mode() == "LaneClear" then 
			for _, Jungle in pairs(minionManager.objects) do	
			if ValidTarget(Jungle, 355) and GetTeam(Jungle) == MINION_JUNGLE and Taric.Jungle.QWJ2:Value() and GetPercentMP(myHero) >= Taric.Jungle.WJ2:Value() and not PassiveAttack1 and not PassiveAttack2 then
				myHero:Cast(_W, Jungle)end
				end
			end
		end
	end
end, 2.4)
end)

OnProcessSpellAttack(function(unit,spell)
DelayAction(function()
if Taric.LaneClear.LFN:Value() then
	if unit == myHero then
		if spell.name:lower():find("attack") then 
			if IOW:Mode() == "LaneClear" then 
			for _, minion in pairs(minionManager.objects) do	
				if ValidTarget(minion, 355) and GetTeam(minion) == MINION_ENEMY and Taric.LaneClear.LQ1:Value() and GetPercentMP(myHero) >= Taric.LaneClear.LQ2:Value() and not PassiveAttac1 and not PassiveAttack2 then
					myHero:Cast(_Q, minion)end
					end
				end
			end
		end
	end
end, GetWindUp(myHero))
end)

