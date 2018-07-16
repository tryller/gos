if GetObjectName(GetMyHero()) ~= "LeeSin" then return end

require("Inspired")
require("DamageLib")


-- Menu
config = Menu("LeeSin", "LeeSin")
config:SubMenu("c", "Combo")
config.c:Boolean("Q1", "Use Q1", true)
config.c:Boolean("Q2", "Use Q2", true)
config.c:Slider("Q2P", "%HP for Q", 10, 0, 100, 5)
--config.c:Boolean("W1", "Use W1", true)
--config.c:Boolean("W2", "Use W2", true)
config.c:Boolean("E1", "Use E1", true)
config.c:Boolean("E2", "Use E2", true)


config:SubMenu("ks", "Killsteal")
config.ks:Boolean("KSQ1","Killsteal with Q1", true)
config.ks:Boolean("KSR","Killsteal with R", true)

-- Start
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
	if not IsDead(myHero) then
		local unit = GetCurrentTarget()
		combo(unit)
		ks()
	end
end)

function combo(unit)
	if Mode() == "Combo" then
		if GetCastName(myHero,0)=="BlindMonkQOne" and config.c.Q1:Value() and ValidTarget(unit, GetCastRange(myHero,_Q)) then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1780,250,1000,70,true,false)
			if QPred.HitChance==1 then
				CastSkillShot(_Q,QPred.PredPos)
			end
		end
		if GetCastName(myHero,0)~="BlindMonkQOne" and config.c.Q2:Value() and ValidTarget(unit, 1300) then
			CastSpell(_Q)
		end
		if GetCastName(myHero,2)=="BlindMonkEOne" and config.c.E1:Value() and ValidTarget(unit, GetCastRange(myHero,_E)) then
			CastSpell(_E)
		end		
		if GetCastName(myHero,2)~="BlindMonkEOne" and config.c.E2:Value() and ValidTarget(unit, 500) then
			CastSpell(_E)
		end
	end
end

function jump2creep()
	creep=ClosestMinion(GetOrigin(myHero), MINION_ALLY)
	if GetDistance(creep,myHero)<GetCastRange(myHero,_W) then
		CastTargetSpell(creep,_W)
	end
end

function ks()
	for i,unit in pairs(GetEnemyHeroes()) do
		if config.ks.KSR:Value() and Ready(_R) and ValidTarget(unit,GetCastRange(myHero,_R)) and GetCurrentHP(unit)+GetDmgShield(unit) < getdmg("R",unit ,myHero) then 
			CastTargetSpell(unit,_R)
		end
		local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1780,250,1000,70,true,false)
		if config.ks.KSQ1:Value() and Ready(_Q) and ValidTarget(unit,GetCastRange(myHero,_Q)) and GetCurrentHP(unit)+GetDmgShield(unit) < getdmg("Q",unit ,myHero) then 
			CastSkillShot(_Q,QPred.PredPos)
		end
	end
end
