if GetObjectName(GetMyHero()) ~= "Ziggs" then return end



StickyBombs = Menu("Ziggs", "Ziggs")
StickyBombs:SubMenu("Combo", "Combo")
StickyBombs.Combo:Boolean("Q", "Use Q", true)
StickyBombs.Combo:Boolean("W", "Use W", false)
StickyBombs.Combo:Boolean("E", "Use E", true)
StickyBombs.Combo:Boolean("R", "Use R", true)

StickyBombs:SubMenu("Jungleclear", "Jungleclear")
StickyBombs.Jungleclear:Boolean("useQ", "Use Q", true)
StickyBombs.Jungleclear:Boolean("useE", "Use E", true)
StickyBombs.Jungleclear:Key("JungleQE", "Jungle Clear Key", string.byte("V"))

StickyBombs:SubMenu("Misc", "Misc")
StickyBombs.Misc:Boolean("KS", "Killsteal", true)
StickyBombs.Misc:Boolean("Autolvl", "Auto level", true) 
StickyBombs.Misc:DropDown("Autolvltable", "Priority", 1, {"Q-E-W", "Q-W-E"})

OnTick(function(myHero)
	if not IsDead(myHero) then
		local unit = GetCurrentTarget()
		KS()
		Combo(unit)
		JungleClear()
	end
end)

local lastlevel = GetLevel(myHero)-1

function Combo(unit)
	if IOW:Mode() == "Combo" then
			
			--Q Logic
			if StickyBombs.Combo.Q:Value() and CanUseSpell(myHero,_Q) == READY and ValidTarget(unit, GetCastRange(myHero,_Q)) then
				local QPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1700,100,GetCastRange(myHero,_Q),150,false,true)
				if QPred.HitChance == 1 then				
					CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
				end
			end
			
			--E Logic
			if StickyBombs.Combo.E:Value() and CanUseSpell (myHero,_E) == READY and ValidTarget(unit, GetCastRange(myHero,_E)) then
				local EPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),1300,100,GetCastRange(myHero,_E),325,false,true)
				if EPred.HitChance == 1 then
					CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)
				end
			end
			
			--W Logic
			if StickyBombs.Combo.W:Value() and CanUseSpell(myHero,_W) == READY and ValidTarget(unit,GetCastRange(myHero,_W)) then
				local WPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit)*1.2,1500,100,GetCastRange(myHero,_W),325,false,true)
				if WPred.HitChance == 1 then
					CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
				end		
			end
			
			--Kill Ult
			local RDmg= 100+100*GetCastLevel(myHero,_R)+GetBonusAP(myHero)*0.72
			
			if StickyBombs.Combo.R:Value() and CanUseSpell(myHero,_R) == READY and ValidTarget(unit,GetCastRange(myHero,_R)) and CalcDamage(myHero, unit, 0, RDmg)>GetCurrentHP(unit) then
				local RPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),2000,550,GetCastRange(myHero,_R),550,false,true)
				if RPred.HitChance == 1 then
					CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
				end	
			end			
	end
end

function KS()
	local RDmg= 100+100*GetCastLevel(myHero,_R)+GetBonusAP(myHero)*0.72
	for _,Enemy in pairs(GetEnemyHeroes()) do
		--R KS
		if StickyBombs.Misc.KS:Value() and CanUseSpell(myHero,_R) == READY and ValidTarget(Enemy,GetCastRange(myHero,_R)) and CalcDamage(myHero, Enemy, 0, RDmg)>GetCurrentHP(Enemy) then
			local RPred = GetPredictionForPlayer(GetOrigin(myHero),Enemy,GetMoveSpeed(Enemy),2000,550,GetCastRange(myHero,_R),550,false,true)
			if RPred.HitChance == 1 then
				CastSkillShot(_R,RPred.PredPos.x,RPred.PredPos.y,RPred.PredPos.z)
			end	
		end	
	end
end	

function JungleClear()
if StickyBombs.Jungleclear.JungleQE:Value() then
	for i,minion in pairs(minionManager.objects) do
		if MINION_JUNGLE == GetTeam(minion) then
			if ValidTarget(minion, 1150) then
				if StickyBombs.Jungleclear.useQ:Value() and CanUseSpell(myHero,_Q) == READY and ValidTarget(minion, 1150) then
					CastSkillShot(_Q,GetOrigin(minion))
				end
				if StickyBombs.Jungleclear.useE:Value() and CanUseSpell(myHero,_E) == READY and ValidTarget(minion, 900) then
					CastSkillShot(_E,GetOrigin(minion))
				end				
			end
		end
	end
end
end

if StickyBombs.Misc.Autolvl:Value() then  
	if GetLevel(myHero) > lastlevel then
    if StickyBombs.Misc.Autolvltable:Value() == 1 then leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _Q, _E , _E, _R, _E, _E, _W, _W, _R, _W, _W}
    elseif StickyBombs.Misc.Autolvltable:Value() == 2 then leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W, _E, _E, _R, _E, _E}
    end
    DelayAction(function() LevelSpell(leveltable[GetLevel(myHero)]) end, math.random(1000,3000))
    lastlevel = GetLevel(myHero)
	end
end
	
print("Welcome To |ELO|Hell| Credits to Logge,Deftsu and Noddy for their time and codes<3")
