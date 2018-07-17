if GetObjectName(GetMyHero()) ~= "Anivia" then return end

if not pcall( require, "MapPositionGOS" ) then PrintChat("You are missing Walls Library - Go download it and save it Common!") return end
if not pcall( require, "Inspired" ) then PrintChat("You are missing Inspired.lua - Go download it and save it Common!") return end
if not pcall( require, "Deftlib" ) then PrintChat("You are missing Deftlib.lua - Go download it and save it in Common!") return end
if not pcall( require, "DamageLib" ) then PrintChat("You are missing DamageLib.lua - Go download it and save it in Common!") return end

require("MapPositionGOS")
require("Inspired")
require("Deftlib")
require("DamageLib")

local config = MenuConfig("Anivia", "Anivia")
config:SubMenu("Combo", "Combo")
config.Combo:Boolean("Q","Use Q",true)
config.Combo:Boolean("QS","Use Q AutoStun in Combo?",true)
config.Combo:Boolean("QS2","Always AutoStun if possible?",true)
config.Combo:Boolean("W","Use W Auto Wall",false)
config.Combo:Key("CW", "Create Wall", string.byte("z"))
config.Combo:Boolean("E","Use E",true)
config.Combo:Boolean("ES","E only with Debuff?",true)
config.Combo:Boolean("R","Use R ",true)
config.Combo:Boolean("RS","Auto Turn off R if no Enemy inside? ",true)
config.Combo:Info("AniviaMoT141", "Delay for Turn Off R")
config.Combo:Slider("Imin", "Delay min.", 632, 10, 3500, 1)
config.Combo:Slider("Imax", "Delay max.", 1055, 100, 3500, 1) 

config:SubMenu("Items", "Items & Ignite")
config.Items:Boolean("Ignite","AutoIgnite if OOR and Q/E NotReady",true)
config.Items:Boolean("Zhonya", "Always Use Zhonyas", true)
config.Items:Slider("ZhonyaHP", "if My Health < x% (Def.30)", 30, 0, 90, 1)

ts = TargetSelector(1200, TARGET_LOW_HP, DAMAGE_MAGIC)
config:TargetSelector("ts", "Target Selector", ts)

local Qattack = myHero
local Rattack = myHero  
local Eattack = myHero
local Wattack = myHero
local unitname = myHero
local minW = 1
local maxW = 2
local gametimeQ = 0
local gametimeW = 0
local gametimeE = 0
local gametimeR = 0
local OverAllDmgAnivia = 0

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
		Combo()
	end

	local target = config.ts:GetTarget()
	if config.Combo.CW:Value() then
		CastW(target)
	end

	QRProcess()
	CastIgnite()
	Zhonyas()
end)

function CastQ(target) 
	if ValidTarget(target, 1075) then 
		local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),1000,120,1175,75,false,true) 
		if GotBuff(myHero,"FlashFrost") == 0 and IsReady(_Q) and QPred.HitChance == 1 then 
			CastSkillShot(_Q, QPred.PredPos.x, QPred.PredPos.y, QPred.PredPos.z) 
		end

		if GotBuff(myHero,"FlashFrost") == 1 and GetDistance(target) <= 175 then 
			CastSpell(_Q)
		end  
	end 
end

function CastE2(target)  
	if ValidTarget(target, 650) and IsReady(_E) then
		for i,unit in pairs(GetEnemyHeroes()) do 
			if GotBuff(unit,"chilled") == 1 and NameCheck() == GetObjectName(unit) then
				CastTargetSpell(unit, _E)
			elseif (gametimeQ+(1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_Q,GetCastLevel(myHero,_Q)))-GetGameTimer() > (1-(GetCDR(myHero)*-1))*GetCastCooldown(myHero,_E,GetCastLevel(myHero,_E)) and NameCheck() == GetObjectName(unit) and ((CanUseSpell(myHero,_R) ~= READY and GotBuff(myHero,"GlacialStorm") == 0) or (GetCastLevel(myHero,_R) == 0)) then
				CastTargetSpell(unit, _E)
			elseif GetCastLevel(myHero,_Q) == 0 and NameCheck() == GetObjectName(unit) then 
				CastTargetSpell(unit, _E)
			elseif GetCastLevel(myHero,_R) == 0 and NameCheck() == GetObjectName(unit) then 
				CastTargetSpell(unit, _E)  
			elseif GotBuff(unit,"chilled") == 1 and NameCheck() ~= GetObjectName(unit) then
				CastTargetSpell(unit, _E)  
			end
		end
	end
end

function CastE(target) 
	if ValidTarget(target, 650) and IsReady(_E) then
		CastTargetSpell(target, _E)
	end 
end

function CastR(target)
	if ValidTarget(target, 750) then
		local RPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),2500,0,615,400,false,false) 
		local RPredX=RPred.PredPos.x+math.random(-55,55)
		local RPredY=RPred.PredPos.y+math.random(-55,55)
		local RPredZ=RPred.PredPos.z+math.random(-55,55)
		local RPredRnDNor = math.random(175,275)
		local MyVectorHero = Vector(GetOrigin(myHero))
		local RPred2 = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),2500,0,615,400,false,false) 
		RPred2.PredPos = Vector(RPred2.PredPos)+((MyVectorHero-Vector(RPred2.PredPos)):normalized()*RPredRnDNor)

		if GetDistance(target) < 625 and GotBuff(myHero,"GlacialStorm") == 0 and IsReady(_R) and RPred.HitChance == 1 then  
			CastSkillShot(_R, RPredX, RPredY, RPredZ)
		elseif GetDistance(target) > 625 and GotBuff(myHero,"GlacialStorm") == 0 and IsReady(_R) then  --and RPred2.HitChance == 1
			CastSkillShot(_R,RPred2.PredPos.x,RPred2.PredPos.y,RPred2.PredPos.z) 
		end  
	end
end
  
function Combo()
	local target = ts:GetTarget()
	if config.Combo.Q:Value() then
		CastQ(target) 
	end 

	if config.Combo.E:Value() and config.Combo.ES:Value() then
		CastE2(target) 
	end

	if config.Combo.E:Value() and config.Combo.ES:Value() == false then
		CastE(target)
	end

	if config.Combo.R:Value() then
		CastR(target)
	end

	if config.Combo.W:Value() then
		CastW(target)
	end
end

function NameCheck()
	local target = ts:GetTarget()
	if target ~= nil then
		return GetObjectName(target)
	else
		return GetObjectName(myHero)
	end 
end

function CastIgnite()  
	for i,enemy in pairs(GetEnemyHeroes()) do
		if Ignite and config.Items.Ignite:Value() and CanUseSpell(myHero,_Q) ~= READY and CanUseSpell(myHero,_E) ~= READY and GetDistance(enemy)>=525 then
			if CanUseSpell(myHero, Ignite) == READY and 20*GetLevel(myHero)+50 > GetCurrentHP(enemy)+GetHPRegen(enemy)*2.5 and GetDistanceSqr(GetOrigin(enemy)) < 600*600 then
				CastTargetSpell(enemy, Ignite)
			end
		end
	end          
end

function Zhonyas()
	if config.Items.Zhonya:Value() and GetItemSlot(myHero,3157) > 0 and ValidTarget(target, 1000) and GetPercentHP(myHero) <= config.Items.ZhonyaHP:Value()  then
		CastSpell(GetItemSlot(myHero,3157))
	end
end                  

function RangeW()
	local wrangetable = {400,500,600,700,800}
	if GetCastLevel(myHero,_W) > 0 then
		return wrangetable[GetCastLevel(myHero,_W)]/2
	end
end

function CastW(target)
	if GetCastLevel(myHero,_W) > 0 then  
		local WallMax = 0
		local WallMaxEC = 0
		local MaxRangeHero = GetHitBox(myHero) + GetRange(myHero)
		local extrarange = 0
		if ValidTarget(target, MaxRangeHero) then 
			local MyVectorHero = Vector(GetOrigin(myHero))
			local MyVectorEnemy = Vector(GetOrigin(target))

			if GetDistance(target) <= MaxRangeHero then
				WallMax = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized() * (910-GetDistance(target)-(extrarange * 2)))
				WallMaxEC = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized() * (910-GetDistance(target) + 250))
			else
				WallMax = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized() * (250))
				WallMaxEC = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized() * (250 + 250))
			end

			local Wall = MyVectorEnemy-((MyVectorHero-MyVectorEnemy):normalized() * (250))
			local WallR = (Wall-((Wall-MyVectorEnemy):normalized()*RangeW()):perpendicular())
			local WallL = (Wall-((Wall-MyVectorEnemy):normalized()*RangeW()):perpendicular2())
			local WallRMax = (WallMax-((WallMax-MyVectorEnemy):normalized()*RangeW()):perpendicular())
			local WallLMax = (WallMax-((WallMax-MyVectorEnemy):normalized()*RangeW()):perpendicular2())
			local WallRMax2 = (WallMax-((WallMax-MyVectorEnemy):normalized() * (RangeW()/2)):perpendicular())
			local WallLMax2 = (WallMax-((WallMax-MyVectorEnemy):normalized() * (RangeW()/2)):perpendicular2())
			local LineR = Line(Point(WallRMax.x, WallRMax.y, WallRMax.z), Point(WallRMax2.x, WallRMax2.y, WallRMax2.z))
			local LineL = Line(Point(WallLMax.x, WallLMax.y, WallLMax.z), Point(WallLMax2.x, WallLMax2.y, WallLMax2.z))
			local LineMid = Line(Point(WallLMax2.x, WallLMax2.y, WallLMax2.z), Point(WallRMax2.x, WallRMax2.y, WallRMax2.z))

			for i, Rpos in pairs(LineR:__getPoints()) do
				for i, Lpos in pairs(LineL:__getPoints()) do  
					for i, Mpos in pairs(LineMid:__getPoints()) do      
						if MapPosition:inWall(Mpos) == true then return end
							if CountObjectsOnLineSegment(WallMax, WallMaxEC, RangeW()+10, GetEnemyHeroes()) < 1 then --and GetDistance(target) < GetPredictedPos(target,250) then--EnemiesAround(WallMax,RangeW()) < 2 then GetDistance(target) < GetPredictedPos(target,250) then --and 
							if MapPosition:inWall(Lpos) and MapPosition:inWall(Rpos) and MapPosition:inWall(Mpos) == false then 
								CastSkillShot(_W,WallMax.x,WallMax.y,WallMax.z) 
							elseif MapPosition:inWall(Lpos) == false and MapPosition:inWall(Rpos) and MapPosition:inWall(Mpos) == false then 
								CastSkillShot(_W,WallMax.x,WallMax.y,WallMax.z) 
							elseif MapPosition:inWall(Lpos) and MapPosition:inWall(Rpos) == false and MapPosition:inWall(Mpos) == false then
								CastSkillShot(_W,WallMax.x,WallMax.y,WallMax.z) 
							end  
						end
					end
				end
			end
		end
	end
end

function QRProcess()
	for i,unit in pairs(GetEnemyHeroes()) do
		if (config.Combo.QS:Value() and Mode() == "Combo" and config.Combo.QS2:Value() == false) then  
			if GotBuff(myHero,"FlashFrost") == 1 and Qattack ~= myHero then
				if EnemiesAround(GetOrigin(Qattack), 175) >= 1 and NameCheck() == GetObjectName(unit) then
					CastSpell(_Q) 
				elseif EnemiesAround(GetOrigin(Qattack), 175) >= 1 and NameCheck() ~= GetObjectName(unit) then
					CastSpell(_Q) 
				end    
			end
		end

		if config.Combo.QS2:Value() or config.Harass.QS2:Value() then  
			if GotBuff(myHero,"FlashFrost") == 1 and Qattack ~= myHero  then
				if EnemiesAround(GetOrigin(Qattack), 180) >= 1 and NameCheck() == GetObjectName(unit) then
					CastSpell(_Q) 
				elseif EnemiesAround(GetOrigin(Qattack), 180) >= 1 and NameCheck() ~= GetObjectName(unit) then
					CastSpell(_Q) 
				end 
			end
		end

		if (Mode() == "Combo" and config.Combo.RS:Value()) or (Mode() == "Harass" and config.Harass.RS:Value()) then  
			if GotBuff(myHero,"GlacialStorm") == 1 and Rattack ~= myHero then
				if EnemiesAround(GetOrigin(Rattack), 420) <= 0 then
					if Mode() == "Combo" then  
						DelayAction(function() CastSpell(_R) end, math.random(config.Combo.Imin:Value(),config.Combo.Imax:Value()))
					elseif Mode() == "Harass" then 
						DelayAction(function() CastSpell(_R) end, math.random(config.Harass.Imin:Value(),config.Harass.Imax:Value()))
					end
				end  
			end
		end
	end

	if IsReady(_Q) and IsReady(_E) then
		gametimeQ = GetGameTimer()+1
	end
end

OnCreateObj(function(Object)
	if GetObjectBaseName(Object) == "cryo_FlashFrost_Player_mis.troy" then
		Qattack = Object
		gametimeQ = 0
	end

	if GetObjectBaseName(Object) == "cryo_storm_green_team.troy" then
		Rattack = Object
		gametimeR = 0
	end

	if GetObjectBaseName(Object) == "cryo_FrostBite_mis.troy" then
		Eattack = Object
		gametimeE = 0
	end
end)

OnDeleteObj(function(Object)
	if GetObjectBaseName(Object) == "cryo_FlashFrost_Player_mis.troy" then
		Qattack = myHero
		gametimeQ = GetGameTimer()
	end

	if GetObjectBaseName(Object) == "cryo_storm_green_team.troy" then
		Rattack = myHero
		gametimeR = GetGameTimer()
	end

	if GetObjectBaseName(Object) == "cryo_FrostBite_mis.troy" then
		Eattack = myHero
		gametimeE = GetGameTimer()
	end
end)