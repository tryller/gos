if GetObjectName(GetMyHero()) ~= "Veigar" then return end

require("OpenPredict")

local config = Menu("Veigar", "Veigar")
config:SubMenu("c", "Combo")
config.c:Boolean("Q", "Use Q", true)
config.c:Boolean("W", "Use W", true)
config.c:Boolean("AW", "Auto W on immobile", true)
config.c:Boolean("E", "Use E", true)
config.c:Boolean("R", "Use R", true)

config:SubMenu("p", "Prediction")
config.p:Slider("hQ", "HitChance Q", 20, 0, 100, 1)
config.p:Slider("hW", "HitChance W", 20, 0, 100, 1)
config.p:Slider("hE", "HitChance E", 20, 0, 100, 1)

config:SubMenu("f", "Farm")
config.f:Boolean("AQ", "Auto Q farm", true)
config.f:Slider("mana", "Min Mana % to Auto Stack Q",60,0,100,10)

ts = TargetSelector(myHero:GetSpellData(_Q).range, TARGET_LOW_HP, DAMAGE_MAGIC, true)
config:TargetSelector("ts", "Target Selector", ts)

local myHero=GetMyHero()
local VeigarQ = { delay = 0.1, speed = 2000, width = 100, range = 900}
local VeigarW = { delay = 0.1, speed = math.huge, range = 900 , radius = 225}
local VeigarE = { delay = 0.6, speed = math.huge, range = 725 , radius = 400}
local Move = { delay = 0.1, speed = math.huge, width = 50, range = math.huge}

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

OnTick(function()
	AutoW()
	Combo()
	FarmQ()
end)

function Combo()
	if Mode() == "Combo" then
		local target = ts:GetTarget()
		if config.c.R:Value() and IsReady(_R) and ValidTarget(target, 650) then
			local RPercent=GetCurrentHP(target) / CalcDamage(myHero, target, 0, (125 * GetCastLevel(myHero, _R) + GetBonusAP(myHero) + 125 + GetBonusAP(target) * 0.8))
			if RPercent<1 and RPercent>0.2 then 
				CastTargetSpell(target, _R)
			end
		end	
	
		if config.c.Q:Value() and IsReady(_Q) and ValidTarget(target, GetCastRange(myHero,_Q)+10) then
			local QPred = GetPrediction(target,VeigarQ)
			if QPred.hitChance >= (config.p.hQ:Value()/100) and (not QPred:mCollision() or #QPred:mCollision() < 2) then				
				CastSkillShot(_Q, QPred.castPos)
			end
		end	
		
		if config.c.W:Value() and IsReady(_W) and ValidTarget(target, GetCastRange(myHero,_W)) then
			local WPred = GetCircularAOEPrediction(target, VeigarW)
			if WPred.hitChance >= (config.p.hW:Value()/100) then				
				CastSkillShot(_W,WPred.castPos)
			end
		end	
		castE()
	end
end

function AutoW()
	local target = ts:GetTarget()
	if config.c.AW:Value() and ValidTarget(unit,GetCastRange(myHero,_W)) and GotBuff(unit, "veigareventhorizonstun") > 0 and (GotBuff(unit, "snare") > 0 or GotBuff(unit, "taunt") > 0 or GotBuff(unit, "suppression") > 0 or GotBuff(unit, "stun")) then
		local WPred = GetCircularAOEPrediction(unit, VeigarW)
		if WPred.hitChance >= (config.p.hW:Value()/100) then			
			CastSkillShot(_W,WPred.castPos)
		end
	end
end

function castE()
	local target = ts:GetTarget()
	if config.c.E:Value() and Ready(2) and ValidTarget(unit, 725) then
		local EPred = GetCircularAOEPrediction(unit, VeigarE)
		local EMove = GetPrediction(unit, Move)
		if GetDistance(EMove.castPos , GetOrigin(myHero)) < GetDistance(GetOrigin(unit),GetOrigin(myHero)) then
			EPred.castPos = Vector(EPred.castPos)+((Vector(EPred.castPos)-GetOrigin(myHero)):normalized()*325)
		else
			EPred.castPos = Vector(EPred.castPos)+((GetOrigin(myHero)-Vector(EPred.castPos)):normalized()*325)
		end
		CastSkillShot(_E,EPred.castPos)
	end
end

function FarmQ()
	if Mode() == "Combo" then
		return
	end

	if config.f.AQ:Value() and Ready(_Q) and GetPercentMP(myHero) >= config.f.mana:Value() then
		for i,creep in pairs(minionManager.objects) do
			if GetTeam(creep) ~= MINION_ALLY and ValidTarget(creep,1000) and GetCurrentHP(creep)<CalcDamage(myHero, creep, 0, (40*GetCastLevel(myHero,_Q)+25+GetBonusAP(myHero)*0.6)) then
				local QPred = GetPrediction(creep,VeigarQ)			
				if not QPred:mCollision() or #QPred:mCollision() < 2 then
					CastSkillShot(_Q, QPred.castPos)
				end
			end
		end
	end
end
