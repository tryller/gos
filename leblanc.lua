if myHero.charName ~= "Leblanc" then return end

require('MapPositionGOS') 

local LoLVer = "6.24.0.0"
local ScrVer = 3

local mainMenu                     = MenumainMenu("LeBlanc", "LeBlanc")
local UltiOn                     = false
local RWReturn, WReturn, Passive = false, false, {}
local ETick, RTick, T, RT, Tick  = 0, 0, 0, 0, 0
local RW,NW                      = {}, {}
local Skin_Table                 = {["Leblanc"] = {"Classic", "Wicked", "Prestigious", "Mistletoe", "Ravenborn", "Elderwood"}}

mainMenu:KeyBinding("K", "2-Chain Combo", string.byte("Z")) 
mainMenu:KeyBinding("F", "Flee", string.byte("G")) 
mainMenu:SubMenu("P", "Priority mainMenu")
mainMenu.P:DropDown("P", "Prioritize", 1, {"Q","W","E"})
mainMenu.P:KeyBinding("K", "Priority Switcher", string.byte("T")) 

mainMenu:SubMenu("C", "Combo")
mainMenu.C:Boolean("Q", "Use Q", true)
mainMenu.C:Boolean("W", "Use W", true)
mainMenu.C:Boolean("E", "Use E", true)
mainMenu.C:Boolean("R", "Use R", true)

mainMenu:SubMenu("H", "Harass")
mainMenu.H:Boolean("Q", "Use Q", true)
mainMenu.H:Boolean("W", "Use W", true)
mainMenu.H:Boolean("E", "Use E", true)
mainMenu.H:Slider("Mana", "Min. Mana(%) For Harass", 50, 0, 100, 1)

mainMenu:SubMenu("L", "LastHit")
mainMenu.L:Boolean("Q", "Use Q", true)
mainMenu.L:Slider("Mana", "Min. Mana(%) For LastHit", 50, 0, 100, 1)

mainMenu:SubMenu("J", "Clear")
mainMenu.J:Boolean("Q", "Use Q", true)
mainMenu.J:Boolean("W", "Use W", true)
mainMenu.J:Slider("Mana", "Min. Mana(%) For Clear", 50, 0, 100, 1)

local Q = { range = 700 }
local W = { range = 600, delay = .6, speed = 1450, width = 220 }
local E = { range = 820, delay = .3, speed = 1650, width = 55  }

local function __MinionsAround(pos, range)
	local c = 0
	if pos == nil then return 0 end
	for k,v in pairs(minionManager.objects) do 
		if v and v.alive and GetDistanceSqr(pos,v) < range*range and v.team == MINION_ENEMY and GotBuff(v, "leblancpminion") > 0 then
			c = c + 1
		end
	end
	return c
end

local function Mode()
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

local function LB_CalcDmg(spell, target)
	local dmg={
	[_Q]  = 30 + 25*GetCastLevel(myHero, _Q) + GetBonusAP(myHero)*.5,
	[_W]  = 45 + 40*GetCastLevel(myHero, _W) + GetBonusAP(myHero)*.6,
	[_E]  = 25 + 15*GetCastLevel(myHero, _E) + GetBonusAP(myHero)*.5,
	["Q"] = 25 + 125*GetCastLevel(myHero, _R) + GetBonusAP(myHero)*.6,
	["W"] = 25 + 100*GetCastLevel(myHero, _R) + GetBonusAP(myHero)*.5,
	["E"] = 40 + 60*GetCastLevel(myHero, _R) + GetBonusAP(myHero)*.4,
	["P"] = 25 + 15*GetLevel(myHero) + GetBonusAP(myHero)*.8	
}
return dmg[spell]
end

local function LB_GetHPBarPos(enemy)
  local barPos = GetHPBarPos(enemy) 
  local BarPosOffsetX = -50
  local BarPosOffsetY = 46
  local CorrectionY = 39
  local StartHpPos = 31 
  local StartPos = Vector(barPos.x , barPos.y, 0)
  local EndPos = Vector(barPos.x + 108 , barPos.y , 0)    
  return Vector(StartPos.x, StartPos.y, 0), Vector(EndPos.x, EndPos.y, 0)
end


local function LB_UpdateBuff(unit, buff)
	if not unit or not buff then return end

	if unit.isMe then
		if buff.Name == "LeblancR"  then UltiOn   = true end

	    if buff.Name == "LeblancW"  then WReturn  = true end

	    if buff.Name == "LeblancRW" then RWReturn = true end
	end
end

local function LB_RemoveBuff(unit, buff)
	if not unit or not buff then return end

    if unit.isMe then
		if buff.Name == "LeblancR"  then UltiOn   = false end

	    if buff.Name == "LeblancW"  then WReturn  = false end

	    if buff.Name == "LeblancRW" then RWReturn = false end
	end
end

local function LB_CreateObj(Obj)
	if not Obj then return end

	if Obj.name == "LeBlanc_Base_W_return_indicator.troy" and not Obj.dead then
		table.insert(NW, Obj)
		T = GetTickCount()
	end

	if Obj.name == "LeBlanc_Base_RW_return_indicator.troy" and not Obj.dead then
		table.insert(RW, Obj)
		RT = GetTickCount()
	end

	if Obj.name == "LeBlanc_Base_P_Tar_Mark.troy" and not Obj.dead then
		DelayAction(function() table.insert(Passive, Obj) end, 1.5)
	end
end

local function LB_DeleteObj(Obj)
	if not Obj then return end

	for _, W in pairs(NW) do
		if W == Obj then
			table.remove(NW, _)
			T = 0
		end
	end

	for _, W in pairs(RW) do
		if W == Obj then
			table.remove(RW, _)
			RT = 0
		end
	end

	for _, P in pairs(Passive) do
		if P == Obj then
			table.remove(Passive, _)
		end
	end
end

local function LB_CastR(target)
	if Ready(_R) and UltiOn == false and ValidTarget(target, E.range) then
		CastSpell(_R)
		RTick = GetTickCount()
	end
end

local function LB_CastQ(target)
	if (UltiOn == false and RTick+1000 < GetTickCount()) or RWReturn == true then
		if Ready(_Q) and ValidTarget(target, Q.range) and myHero:GetSpellData(_Q).name:lower() == "leblancq" then
		    CastTargetSpell(target, _Q)
	    end
	elseif UltiOn == true and mainMenu.P.P:Value() == 1 then
		if mainMenu.P.P:Value() == 2 or mainMenu.P.P:Value() == 3 then return end
		if Ready(_Q) and ValidTarget(target, Q.range) and myHero:GetSpellData(_Q).name:lower() == "leblancq" then
		    CastTargetSpell(target, _Q)
	    end
	end
end

local function LB_CastW_1(target)
	if (UltiOn == false and RTick+1000 < GetTickCount()) or RWReturn == true then
		if Ready(_W) and ValidTarget(target, W.range) and myHero:GetSpellData(_W).name:lower() == "leblancw" then
		    local Prediction = GetPredictionForPlayer(myHero,target,GetMoveSpeed(target),W.speed,W.delay,W.range,W.width,false,true)
		    if Prediction.HitChance == 1 then CastSkillShot(_W, Prediction.PredPos) end
	    end
	elseif UltiOn == true and mainMenu.P.P:Value() == 2 then
		if mainMenu.P.P:Value() == 1 or mainMenu.P.P:Value() == 3 then return end
		if Ready(_W) and ValidTarget(target, W.range) and myHero:GetSpellData(_W).name:lower() == "leblancw" then
		    local Prediction = GetPredictionForPlayer(myHero,target,GetMoveSpeed(target),W.speed,W.delay,W.range,W.width,false,true)
		    if Prediction.HitChance == 1 then CastSkillShot(_W, Prediction.PredPos) end
	    end
	end
end

local function LB_CastE(target)
	if (UltiOn == false and RTick+1000 < GetTickCount()) or RWReturn == true then
		if Ready(_E) and ValidTarget(target, E.range) and myHero:GetSpellData(_E).name:lower() == "leblance" then
		    local Prediction = GetPredictionForPlayer(myHero,target,GetMoveSpeed(target),E.speed,E.delay,E.range,E.width,true,true)
		    if Prediction.HitChance == 1 then CastSkillShot(_E, Prediction.PredPos) ETick = GetTickCount() end
	    end
	elseif UltiOn == true and mainMenu.P.P:Value() == 3 then
		if mainMenu.P.P:Value() == 1 or mainMenu.P.P:Value() == 2 then return end
		if Ready(_E) and ValidTarget(target, E.range) and myHero:GetSpellData(_E).name:lower() == "leblance" then
		    local Prediction = GetPredictionForPlayer(myHero,target,GetMoveSpeed(target),E.speed,E.delay,E.range,E.width,true,true)
		    if Prediction.HitChance == 1 then CastSkillShot(_E, Prediction.PredPos) ETick = GetTickCount() end
	    end
	end
end

local function LB_CastW_2()
	if Ready(_W) and WReturn == true then
		CastSkillShot(_W, myHero)
	end
end

local function LB_CastW_3()
	if Ready(_R) and RWReturn == true then
		CastSkillShot(_R, myHero)
	end
end

local function LB_CastW_4(target)
	if (UltiOn == false and RTick+1000 < GetTickCount()) or RWReturn == true then
		if Ready(_W) and ValidTarget(target, W.range) and myHero:GetSpellData(_W).name:lower() == "leblancw" then
		    CastSkillShot(_W, target)
	    end
	end
end

local function LB_Switch()
	if mainMenu.P.K:Value() then
		if Tick+200 < GetTickCount() then
			if mainMenu.P.P:Value() == 1 then
				mainMenu.P.P:Value(2)
			elseif mainMenu.P.P:Value() == 2 then
				mainMenu.P.P:Value(3)
			elseif mainMenu.P.P:Value() == 3 then
				mainMenu.P.P:Value(1)
			end
			Tick = GetTickCount()
		end
	end

	if mainMenu.K:Value() then
		mainMenu.P.P:Value(3)
	end
end

local function LB_Return()
	if (RWReturn == true or WReturn == true) and Mode() == "Combo" then
		for _, Enemy in pairs(GetEnemyHeroes()) do
			for _, W in pairs(NW) do
                if GotBuff(Enemy, "LeblancE") > 0 or ValidTarget(Enemy, E.range) then return false end

				local EPos  = EnemiesAround(myHero, 650)
				local EWPos = EnemiesAround(W, 650)
				local APos  = AlliesAround(myHero, 650)
				local AWPos = AlliesAround(W, 650)

				if (EPos > APos) or (EWPos > AWPos) or UnderTurret(W, enemyTurret) then return false end

				LB_CastW_2()
				return true			
			end
			for _, W in pairs(RW) do
                if GotBuff(Enemy, "LeblancE") > 0 or ValidTarget(Enemy, E.range) then return false end

				local EPos  = EnemiesAround(myHero, 650)
				local EWPos = EnemiesAround(W, 650)
				local APos  = AlliesAround(myHero, 650)
				local AWPos = AlliesAround(W, 650)

				if (EPos < APos) or (EWPos < AWPos) or UnderTurret(W, enemyTurret) then return false end

				LB_CastW_3()
				return true		
			end
		end
	end
	return false
end

local function LB_Combo_InRange(target)
	if Mode() == "Combo" then
		if mainMenu.C.W:Value() then LB_CastW_1(target) end
		if mainMenu.C.Q:Value() then LB_CastQ(target)   end
		if mainMenu.C.E:Value() then LB_CastE(target)   end
		if mainMenu.C.R:Value() then LB_CastR(target)   end
	end
end

local function LB_Combo_OutRange(target)
	if Mode() == "Combo" and ValidTarget(target, W.range + Q.range - 50) and GetDistance(target) > W.range + 50 and Ready(_R) and mainMenu.P.P:Value() == 1 then
		if mainMenu.P.P:Value() == 2 or mainMenu.P.P:Value() == 3 then return end
		local EPos = Vector(myHero) + (Vector(target.pos) - Vector(myHero)):normalized() * W.range
		if WReturn == false and not MapPosition:inWall(EPos) then CastSkillShot(_W, EPos) end
		if mainMenu.C.R:Value() then LB_CastR(target)   end
		if mainMenu.C.Q:Value() then LB_CastQ(target)   end
	elseif Mode() == "Combo" and ValidTarget(target, ((W.range*2) - (W.width/2))) and GetDistance(target) > W.range + 50 and Ready(_R) and mainMenu.P.P:Value() == 2 then
		if mainMenu.P.P:Value() == 1 or mainMenu.P.P:Value() == 3 then return end
		local EPos = Vector(myHero) + (Vector(target.pos) - Vector(myHero)):normalized() * W.range
		if WReturn == false and not MapPosition:inWall(EPos) then CastSkillShot(_W, EPos) else if mainMenu.C.W:Value() then LB_CastW_1(target) end end
		if mainMenu.C.R:Value() then LB_CastR(target)   end
	elseif Mode() == "Combo" and ValidTarget(target, W.range + E.range - 50) and GetDistance(target) > W.range + 50 and Ready(_R) and mainMenu.P.P:Value() == 3 then
		if mainMenu.P.P:Value() == 1 or mainMenu.P.P:Value() == 2 then return end
		local EPos = Vector(myHero) + (Vector(target.pos) - Vector(myHero)):normalized() * W.range
		if WReturn == false and not MapPosition:inWall(EPos) then CastSkillShot(_W, EPos) else if mainMenu.C.W:Value() then LB_CastW_1(target) end end
		if mainMenu.C.R:Value() then LB_CastR(target)   end
		if mainMenu.C.E:Value() then LB_CastE(target)   end
	end
end

local function LB_ChainCombo(target)
	if mainMenu.K:Value() then
		MoveToXYZ(GetMousePos())

		if ValidTarget(target, W.range + E.range - 50) then
			local EPos = Vector(myHero) + (Vector(target.pos) - Vector(myHero)):normalized() * W.range
		    if WReturn == false and Ready(_W) and GetDistance(target) > W.range + 50 and not MapPosition:inWall(EPos) then CastSkillShot(_W, EPos) else LB_CastW_1(target) end

		    LB_CastE(target)

		    if ETick+1500 < GetTickCount() and Ready(_R) then
		        if not Ready(_E) then LB_CastR(target) end
		        LB_CastE(target)
		    end

		    LB_CastQ(target)
		end
	end
end

local function LB_Harass(target)
	if Mode() == "Harass" and GetPercentMP(myHero) >= mainMenu.H.Mana:Value() then
		if mainMenu.H.W:Value() then LB_CastW_1(target) end
		if mainMenu.H.Q:Value() then LB_CastQ(target)   end
		if mainMenu.H.E:Value() then LB_CastE(target)   end
	end
end

local function LB_LastHit()
	if Mode() == "LastHit" and GetPercentMP(myHero) >= mainMenu.L.Mana:Value() then
		for _, target in pairs(minionManager.objects) do
			if GetCurrentHP(target) < LB_CalcDmg(_Q, target) then LB_CastQ(target) end
		end
	end
end

local function LB_Clear()
	if Mode() == "LaneClear" and GetPercentMP(myHero) >= mainMenu.J.Mana:Value() then
		if Ready(_W) then
            local WPos, WHit = GetFarmPosition(W.range, W.width, MINION_ENEMY)
            if WHit >= 3 and mainMenu.J.W:Value() then 
                CastSkillShot(_W, WPos) 
            end
        end
        if Ready(_Q) and __MinionsAround(myHero, Q.range*2) > 2 and mainMenu.J.Q:Value() then
        	for _, M in pairs(minionManager.objects) do
        		if GotBuff(M, "leblancpminion") > 0 then DelayAction(function() CastTargetSpell(M, _Q) end, 1.550) end
        	end
        end
	end
end

local function LB_Flee()
	if mainMenu.F:Value() then
		MoveToXYZ(GetMousePos())
		local EPos = Vector(myHero) + (Vector(GetMousePos()) - Vector(myHero)):normalized() * W.range

		if WReturn == false and Ready(_W) and not MapPosition:inWall(EPos) then CastSkillShot(_W, EPos) end
		if RWReturn == false and Ready(_R) and not MapPosition:inWall(EPos) then CastSpell(_R) CastSkillShot(_W, EPos) end

	end
end

local function LB_Tick()
    LB_Switch()

	if not myHero.dead then
		local target = GetCurrentTarget()
		LB_Combo_InRange(target)
		LB_Combo_OutRange(target)
		LB_ChainCombo(target)
		LB_Harass(target)
		LB_LastHit()
		LB_Clear()
		LB_Flee()
		--LB_Return()
	end

	_T  = math.round((( T + 4200)/1000) - (GetTickCount()/1000))
	_RT = math.round(((RT + 4200)/1000) - (GetTickCount()/1000))
end

OnLoad(function()
	OnUpdateBuff(LB_UpdateBuff)
	OnRemoveBuff(LB_RemoveBuff)
	OnCreateObj(LB_CreateObj)
	OnDeleteObj(LB_DeleteObj)
	OnTick(LB_Tick)
end)
