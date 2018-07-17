--
-- ████████╗ ██████╗  ██╗    ███████╗███████╗██████╗ ██╗███████╗███████╗
-- ╚══██╔══╝██╔═████╗███║    ██╔════╝██╔════╝██╔══██╗██║██╔════╝██╔════╝
--    ██║   ██║██╔██║╚██║    ███████╗█████╗  ██████╔╝██║█████╗  ███████╗
--    ██║   ████╔╝██║ ██║    ╚════██║██╔══╝  ██╔══██╗██║██╔══╝  ╚════██║
--    ██║   ╚██████╔╝ ██║    ███████║███████╗██║  ██║██║███████╗███████║
--    ╚═╝    ╚═════╝  ╚═╝    ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝
-- ==================
-- == Introduction ==
-- ==================
-- Current version: 1.2.3.2
-- Intermediate GoS script which supports currently 21 champions.
-- Features:
-- + Supports Ahri, Annie, Brand, Cassiopeia, Fizz, Gnar, Jayce, Katarina, Leblanc, MasterYi,
--   Orianna, Riven, Ryze, Syndra, TwistedFate, Veigar, Viktor, Vladimir, Xerath, Yasuo, Zed
-- + 4 choosable predictions (GoS, IPrediction, GPrediction, OpenPredict) + CurrentPos casting,
-- + 3 managers (Enemies-around, Mana, HP),
-- + Configurable casting settings (Auto, Combo, Harass),
-- + Different types of making combat,
-- + Advanced farm logic (LastHit, LaneClear, JungleClear).
-- + Additional Anti-Gapcloser and Interrupter,
-- + Special damage indicator over HP bar of enemy,
-- + Offensive items usage & stacking tear,
-- + Includes Auto Level-Up with table selection.
-- ==================
-- == Requirements ==
-- ==================
-- + Additional dangerous spells library: 'AntiDangerousSpells.lua'
-- + Orbwalker: IOW/GosWalk
-- ===============
-- == Changelog ==
-- ===============
-- 1.2.3.2
-- + Added DAC & DAC:R support
-- + Corrected spell data
-- 1.2.3.1
-- + Fixed TwistedFate's card picking
-- 1.2.3
-- + Added Leblanc
-- 1.2.2.1
-- + Corrected Ahri's damage calc
-- 1.2.2
-- + Optimized code & data
-- + Removed Vayne
-- 1.2.1.7
-- + Added Kaisa's & Ornn's spells to windwall database
-- 1.2.1.6
-- + Corrected damage calc for Zed
-- 1.2.1.5
-- + Corrected Ryze's E damage
-- 1.2.1.4
-- + Fixed Ryze's Auto Q
-- 1.2.1.3
-- + Corrected Gnar's E damage
-- 1.2.1.2
-- + Minor changes in Riven's Q
-- 1.2.1.1
-- + Improved damage calculation for KS
-- 1.2.1
-- + Added Riven
-- + Fixed Veigar's R damage
-- 1.2 BETA
-- + Removed outdated Interrupter / Integrated a new one
-- 1.1.8
-- + Added Gnar
-- 1.1.7
-- + Added Brand
-- 1.1.6.5
-- + Improved Xerath's KillSteal
-- 1.1.6.4
-- + Yet another improvement for Yasuo
-- 1.1.6.3
-- + Corrected spells data
-- 1.1.6.2
-- + Minor changes for Orianna
-- 1.1.6.1
-- + Removed LastHit from TwistedFate
-- 1.1.6
-- + Added Orianna
-- 1.1.5.4
-- + Improved Syndra's Q+E & R
-- 1.1.5.3
-- + Improved Yasuo
-- + Minor code optimization
-- 1.1.5.2
-- + Fixed Xerath's Q LaneClear
-- 1.1.5.1
-- + Added spell blocking while AA for some champs
-- 1.1.5
-- + Added Cassiopeia
-- + Improved LaneClear mode
-- 1.1.4.2
-- + Improved Xerath's spell database
-- 1.1.4.1
-- + Rebuilt Mana-Manager
-- 1.1.4
-- + Added Ahri
-- + Fixed Auto & LaneClear mode
-- 1.1.3
-- + Added TwistedFate
-- 1.1.2.3
-- + Changes in Zed again...
-- 1.1.2.2
-- + Minor changes in Zed
-- 1.1.2.1
-- + Fixed Annie's W
-- 1.1.2
-- + Fixed Auto Level-up option
-- 1.1.1
-- + Added Anti-Gapcloser to some champions
-- + Corrected Xerath's R damage
-- 1.1
-- + Added Jayce
-- + Fixed Vayne's E
-- 1.0.9
-- + Added MasterYi
-- + Improved files auto-update
-- 1.0.8
-- + Added Vayne
-- 1.0.7
-- + Added Ryze
-- 1.0.6
-- + Added Auto-Update
-- 1.0.5
-- + Added Fizz
-- 1.0.4.2
-- + Fixed Vladimir's W & E
-- 1.0.4.1
-- + Some minor changes
-- 1.0.4
-- + Added Zed
-- 1.0.3.1
-- + Improved Viktor's E logic & Xerath's R
-- 1.0.3
-- + Added Veigar
-- 1.0.2
-- + Added Annie
-- 1.0.1.2
-- + Removed OpenPredict from Syndra's W
-- 1.0.1.1
-- + Improved Syndra's Q+E
-- + Corrected delays
-- 1.0.1
-- + Added Syndra
-- 1.0
-- + Initial release
-- + Imported Katarina, Viktor, Vladimir, Xerath, Yasuo

OnLoad(function()
	if FileExist(COMMON_PATH.."AntiDangerousSpells.lua") then
		PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>AntiDangerousSpells loaded successfully!")
	else
		DownloadFileAsync("https://raw.githubusercontent.com/Ark223/GoS-Scripts/master/AntiDangerousSpells.lua", COMMON_PATH .. "AntiDangerousSpells.lua", function() PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>AntiDangerousSpells downloaded. Please 2x F6!") return end)
	end
end)

require('Inspired')
require('IPrediction')
require('OpenPredict')

local TSVer = 1.232

function Mode()
	if _G.IOW_Loaded and IOW:Mode() then
		return IOW:Mode()
	elseif GoSWalkLoaded and GoSWalk.CurrentMode then
		return ({"Combo", "Harass", "LaneClear", "LastHit"})[GoSWalk.CurrentMode+1]
	elseif _G.DAC_Loaded and DAC:Mode() then
		return DAC:Mode()
	elseif _G.AutoCarry_Loaded and DACR:Mode() then
		return DACR:Mode()
	end
end

OnProcessSpell(function(unit, spell)
	if unit == myHero then
		if spell.name:lower():find("attack") then
			DelayAction(function()
				AA = true
			end, GetWindUp(myHero)+0.01)
		else
			AA = false
		end
	end
end)

CHANELLING_SPELLS = {
    ["Caitlyn"]                     = {_R},
    ["Darius"]                      = {_R},
    ["FiddleSticks"]                = {_W, _R},
    ["Galio"]                       = {_W},
    ["Gragas"]                      = {_W},
    ["Janna"]                       = {_R},
    ["Karthus"]                     = {_R},
    ["Katarina"]                    = {_R},
    ["Lucian"]                      = {_R},
    ["Malzahar"]                    = {_R},
    ["MasterYi"]                    = {_W},
    ["MissFortune"]                 = {_R},
    ["Nunu"]                        = {_R},
    ["Pantheon"]                    = {_E, _R},
    ["Shen"]                        = {_R},
    ["Sion"]                        = {_Q},
    ["TahmKench"]                   = {_R},
    ["TwistedFate"]                 = {_R},
    ["Warwick"]                     = {_R},
    ["Varus"]                       = {_Q},
    ["VelKoz"]                      = {_R},
    ["Vi"]                          = {_Q},
    ["Xerath"]                      = {_Q, _R},
    ["Zac"]                         = {_E},
}

GAPCLOSER_SPELLS = {
    ["Aatrox"]                      = {_Q},
    ["Akali"]                       = {_R},
    ["Alistar"]                     = {_W},
    ["Amumu"]                       = {_Q},
    ["Corki"]                       = {_W},
    ["Diana"]                       = {_R},
    ["Elise"]                       = {_Q, _E},
    ["FiddleSticks"]                = {_R},
    ["Ezreal"]                      = {_E},
    ["Fiora"]                       = {_Q},
    ["Fizz"]                        = {_Q},
    ["Galio"]                       = {_E},
    ["Gnar"]                        = {_E},
    ["Gragas"]                      = {_E},
    ["Graves"]                      = {_E},
    ["Hecarim"]                     = {_R},
    ["Irelia"]                      = {_Q},
    ["JarvanIV"]                    = {_Q, _R},
    ["Jax"]                         = {_Q},
    ["Jayce"]                       = {_Q},
    ["Kaisa"]                       = {_E, _R},
    ["Katarina"]                    = {_E},
    ["Kassadin"]                    = {_R},
    ["Kayn"]                        = {_Q},
    ["Kennen"]                      = {_E},
    ["KhaZix"]                      = {_E},
    ["Lissandra"]                   = {_E},
    ["Leblanc"]                     = {_W, _R},
    ["LeeSin"]                      = {_Q, _W},
    ["Leona"]                       = {_E},
    ["Lucian"]                      = {_E},
    ["Malphite"]                    = {_R},
    ["MasterYi"]                    = {_Q},
    ["MonkeyKing"]                  = {_E},
    ["Nautilus"]                    = {_Q},
    ["Nocturne"]                    = {_R},
    ["Olaf"]                        = {_R},
    ["Ornn"]                        = {_E},
    ["Pantheon"]                    = {_W, _R},
    ["Poppy"]                       = {_E},
    ["RekSai"]                      = {_E},
    ["Renekton"]                    = {_E},
    ["Riven"]                       = {_Q, _E},
    ["Rengar"]                      = {_R},
    ["Sejuani"]                     = {_Q},
    ["Sion"]                        = {_R},
    ["Shen"]                        = {_E},
    ["Shyvana"]                     = {_R},
    ["Talon"]                       = {_E},
    ["Thresh"]                      = {_Q},
    ["Tristana"]                    = {_W},
    ["Tryndamere"]                  = {_E},
    ["Udyr"]                        = {_E},
    ["Urgot"]                       = {_E},
    ["Volibear"]                    = {_Q},
    ["Vi"]                          = {_Q},
    ["XinZhao"]                     = {_E},
    ["Yasuo"]                       = {_E},
    ["Zac"]                         = {_E},
    ["Ziggs"]                       = {_W},
    ["Zoe"]                         = {_R},
}

-- Ahri

if "Ahri" == GetObjectName(myHero) then

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Ahri loaded successfully!")
local AhriMenu = Menu("[T01] Ahri", "[T01] Ahri")
AhriMenu:Menu("Auto", "Auto")
AhriMenu.Auto:Boolean('UseQ', 'Use Q [Orb of Deception]', true)
AhriMenu.Auto:Boolean('UseE', 'Use E [Charm]', true)
AhriMenu.Auto:Slider("MP","Mana-Manager", 40, 0, 100, 5)
AhriMenu:Menu("Combo", "Combo")
AhriMenu.Combo:Boolean('UseQ', 'Use Q [Orb of Deception]', true)
AhriMenu.Combo:Boolean('UseW', 'Use W [Fox-Fire]', true)
AhriMenu.Combo:Boolean('UseE', 'Use E [Charm]', true)
AhriMenu.Combo:Boolean('UseR', 'Use R [Spirit Rush]', true)
AhriMenu.Combo:DropDown("ModeR", "Cast Mode: R", 2, {"Gapclose To Target", "Mouse Position"})
AhriMenu:Menu("Harass", "Harass")
AhriMenu.Harass:Boolean('UseQ', 'Use Q [Orb of Deception]', true)
AhriMenu.Harass:Boolean('UseW', 'Use W [Fox-Fire]', true)
AhriMenu.Harass:Boolean('UseE', 'Use E [Charm]', true)
AhriMenu.Harass:Slider("MP","Mana-Manager", 40, 0, 100, 5)
AhriMenu:Menu("LaneClear", "LaneClear")
AhriMenu.LaneClear:Boolean('UseQ', 'Use Q [Orb of Deception]', true)
AhriMenu.LaneClear:Boolean('UseW', 'Use W [Fox-Fire]', true)
AhriMenu.LaneClear:Boolean('UseE', 'Use E [Charm]', false)
AhriMenu.LaneClear:Slider("MP","Mana-Manager", 40, 0, 100, 5)
AhriMenu:Menu("JungleClear", "JungleClear")
AhriMenu.JungleClear:Boolean('UseQ', 'Use Q [Orb of Deception]', true)
AhriMenu.JungleClear:Boolean('UseW', 'Use W [Fox-Fire]', true)
AhriMenu.JungleClear:Boolean('UseE', 'Use E [Charm]', true)
AhriMenu:Menu("AntiGapcloser", "Anti-Gapcloser")
AhriMenu.AntiGapcloser:Boolean('UseE', 'Use E [Charm]', true)
AhriMenu:Menu("Interrupter", "Interrupter")
AhriMenu.Interrupter:Boolean('UseE', 'Use E [Charm]', true)
AhriMenu:Menu("Prediction", "Prediction")
AhriMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
AhriMenu.Prediction:DropDown("PredictionE", "Prediction: E", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
AhriMenu:Menu("Misc", "Misc")
AhriMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
AhriMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 1, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
AhriMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
AhriMenu.Misc:Slider('HP','HP-Manager: R', 40, 0, 100, 5)

local AhriQ = { range = 880, radius = 100, width = 100, speed = 2500, delay = 0.25, type = "line", collision = true, source = myHero, col = {"yasuowall"}}
local AhriW = { range = 700 }
local AhriE = { range = 975, radius = 60, width = 60, speed = 1550, delay = 0.25, type = "line", collision = true, source = myHero, col = {"minion","champion","yasuowall"}}
local AhriR = { range = 450 }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	LaneClear()
	JungleClear()
	AntiGapcloser()
	LevelUp()
end)

function useQ(target)
	if GetDistance(target) < AhriQ.range then
		if AhriMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif AhriMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),AhriQ.speed,AhriQ.delay*1000,AhriQ.range,AhriQ.width,false,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif AhriMenu.Prediction.PredictionQ:Value() == 3 then
			local qPred = _G.gPred:GetPrediction(target,myHero,AhriQ,true,false)
			if qPred and qPred.HitChance >= 3 then
				CastSkillShot(_Q, qPred.CastPosition)
			end
		elseif AhriMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="AhriOrbofDeception", range=AhriQ.range, speed=AhriQ.speed, delay=AhriQ.delay, width=AhriQ.width, type="linear", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(AhriQ.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif AhriMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetLinearAOEPrediction(target,AhriQ)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useW(target)
	CastTargetSpell(target, _W)
end
function useE(target)
	if GetDistance(target) < AhriE.range then
		if AhriMenu.Prediction.PredictionE:Value() == 1 then
			CastSkillShot(_E,GetOrigin(target))
		elseif AhriMenu.Prediction.PredictionE:Value() == 2 then
			local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),AhriE.speed,AhriE.delay*1000,AhriE.range,AhriE.width,true,false)
			if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
			end
		elseif AhriMenu.Prediction.PredictionE:Value() == 3 then
			local EPred = _G.gPred:GetPrediction(target,myHero,AhriE,false,true)
			if EPred and EPred.HitChance >= 3 then
				CastSkillShot(_E, EPred.CastPosition)
			end
		elseif AhriMenu.Prediction.PredictionE:Value() == 4 then
			local ESpell = IPrediction.Prediction({name="AhriSeduce", range=AhriE.range, speed=AhriE.speed, delay=AhriE.delay, width=AhriE.width, type="linear", collision=true})
			ts = TargetSelector()
			target = ts:GetTarget(AhriE.range)
			local x, y = ESpell:Predict(target)
			if x > 2 then
				CastSkillShot(_E, y.x, y.y, y.z)
			end
		elseif AhriMenu.Prediction.PredictionE:Value() == 5 then
			local EPrediction = GetLinearAOEPrediction(target,AhriE)
			if EPrediction.hitChance > 0.9 then
				CastSkillShot(_E, EPrediction.castPos)
			end
		end
	end
end

-- Auto

function Auto()
	if AhriMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AhriMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, AhriQ.range) then
					useQ(target)
				end
			end
		end
	end
	if AhriMenu.Auto.UseE:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AhriMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, AhriE.range) then
					useE(target)
				end
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if AhriMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, AhriQ.range) then
					useQ(target)
				end
			end
		end
		if AhriMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, AhriW.range) then
					useW(target)
				end
			end
		end
		if AhriMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, AhriE.range) then
					useE(target)
				end
			end
		end
		if AhriMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, AhriR.range+GetRange(myHero)) then
					if 100*GetCurrentHP(target)/GetMaxHP(target) < AhriMenu.Misc.HP:Value() then
						if EnemiesAround(myHero, AhriR.range+GetRange(myHero)) >= AhriMenu.Misc.X:Value() then
							if AhriMenu.Combo.ModeR:Value() == 1 then
								CastSkillShot(_R, GetOrigin(target))
							elseif AhriMenu.Combo.ModeR:Value() == 2 then
								CastSkillShot(_R, GetMousePos())
							end
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if AhriMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AhriMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, AhriQ.range) then
						useQ(target)
					end
				end
			end
		end
		if AhriMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AhriMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, AhriW.range) then
						useW(target)
					end
				end
			end
		end
		if AhriMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AhriMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, AhriE.range) then
						useE(target)
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if AhriMenu.LaneClear.UseW:Value() then
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AhriMenu.LaneClear.MP:Value() then
						if ValidTarget(minion, AhriW.range) then
							if AhriMenu.LaneClear.UseW:Value() then
								if CanUseSpell(myHero,_W) == READY then
									CastTargetSpell(minion, _W)
								end
							end
						end
					end
				end
				if AhriMenu.LaneClear.UseE:Value() then
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AhriMenu.LaneClear.MP:Value() then
						if ValidTarget(minion, AhriE.range) then
							if AhriMenu.LaneClear.UseE:Value() then
								if CanUseSpell(myHero,_E) == READY then
									CastSkillShot(_E,GetOrigin(minion))
								end
							end
						end
					end
				end
				if AhriMenu.LaneClear.UseW:Value() then
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AhriMenu.LaneClear.MP:Value() then
						if CanUseSpell(myHero,_Q) == READY then
							local BestPos, BestHit = GetLineFarmPosition(AhriQ.range, AhriQ.radius, MINION_ENEMY)
							if BestPos and BestHit > 3 then  
								CastSkillShot(_Q, BestPos)
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, AhriQ.range) then
						if AhriMenu.JungleClear.UseQ:Value() then
							CastSkillShot(_Q,GetOrigin(mob))
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, AhriW.range) then
						if AhriMenu.JungleClear.UseW:Value() then	   
							CastTargetSpell(mob, _W)
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, AhriE.range) then
						if AhriMenu.JungleClear.UseE:Value() then
							CastSkillShot(_E,GetOrigin(mob))
						end
					end
				end
			end
		end
	end
end

-- Interrupter

OnProcessSpell(function(unit, spell)
	if AhriMenu.Interrupter.UseE:Value() then
		for _, enemy in pairs(GetEnemyHeroes()) do
			if ValidTarget(enemy, AhriE.range) then
				if CanUseSpell(myHero,_E) == READY then
					local UnitName = GetObjectName(enemy)
					local UnitChanellingSpells = CHANELLING_SPELLS[UnitName]
					local UnitGapcloserSpells = GAPCLOSER_SPELLS[UnitName]
					if UnitChanellingSpells then
						for _, slot in pairs(UnitChanellingSpells) do
							if spell.name == GetCastName(enemy, slot) then useE(enemy) end
						end
					elseif UnitGapcloserSpells then
						for _, slot in pairs(UnitGapcloserSpells) do
							if spell.name == GetCastName(enemy, slot) then useE(enemy) end
						end
					end
				end
			end
		end
    end
end)

-- Anti-Gapcloser

function AntiGapcloser()
	for i,antigap in pairs(GetEnemyHeroes()) do
		if AhriMenu.AntiGapcloser.UseE:Value() then
			if ValidTarget(antigap, 350) then
				if CanUseSpell(myHero,_E) == READY then
					useE(antigap)
				end
			end
		end
	end
end

-- Misc

function LevelUp()
	if AhriMenu.Misc.LvlUp:Value() then
		if AhriMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif AhriMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif AhriMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif AhriMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif AhriMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif AhriMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Annie

elseif "Annie" == GetObjectName(myHero) then

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Annie loaded successfully!")
local AnnieMenu = Menu("[T01] Annie", "[T01] Annie")
AnnieMenu:Menu("Auto", "Auto")
AnnieMenu.Auto:Boolean('UseQ', 'Use Q [Disintegrate]', true)
AnnieMenu.Auto:Boolean('UseW', 'Use W [Incinerate]', true)
AnnieMenu.Auto:Boolean('UseE', 'Use E [Molten Shield]', false)
AnnieMenu.Auto:Slider("MP","Mana-Manager", 40, 0, 100, 5)
AnnieMenu:Menu("Combo", "Combo")
AnnieMenu.Combo:Boolean('UseQ', 'Use Q [Disintegrate]', true)
AnnieMenu.Combo:Boolean('UseW', 'Use W [Incinerate]', true)
AnnieMenu.Combo:Boolean('UseE', 'Use E [Molten Shield]', true)
AnnieMenu.Combo:Boolean('UseR', 'Use R [Summon Tibbers]', true)
AnnieMenu:Menu("Harass", "Harass")
AnnieMenu.Harass:Boolean('UseQ', 'Use Q [Disintegrate]', true)
AnnieMenu.Harass:Boolean('UseW', 'Use W [Incinerate]', true)
AnnieMenu.Harass:Boolean('UseE', 'Use E [Molten Shield]', true)
AnnieMenu.Harass:Slider("MP","Mana-Manager", 40, 0, 100, 5)
AnnieMenu:Menu("KillSteal", "KillSteal")
AnnieMenu.KillSteal:Boolean('UseR', 'Use R [Summon Tibbers]', true)
AnnieMenu:Menu("LastHit", "LastHit")
AnnieMenu.LastHit:Boolean('UseQ', 'Use Q [Disintegrate]', true)
AnnieMenu:Menu("LaneClear", "LaneClear")
AnnieMenu.LaneClear:Boolean('UseQ', 'Use Q [Disintegrate]', false)
AnnieMenu.LaneClear:Boolean('UseW', 'Use W [Incinerate]', true)
AnnieMenu.LaneClear:Slider("MP","Mana-Manager", 40, 0, 100, 5)
AnnieMenu:Menu("JungleClear", "JungleClear")
AnnieMenu.JungleClear:Boolean('UseQ', 'Use Q [Disintegrate]', true)
AnnieMenu.JungleClear:Boolean('UseW', 'Use W [Incinerate]', true)
AnnieMenu.JungleClear:Boolean('UseE', 'Use E [Molten Shield]', true)
AnnieMenu:Menu("Prediction", "Prediction")
AnnieMenu.Prediction:DropDown("PredictionW", "Prediction: W", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
AnnieMenu.Prediction:DropDown("PredictionR", "Prediction: R", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
AnnieMenu:Menu("Misc", "Misc")
AnnieMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
AnnieMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 1, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
AnnieMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
AnnieMenu.Misc:Slider('HP','HP-Manager: R', 40, 0, 100, 5)

local AnnieQ = { range = 625 }
local AnnieW = { range = 600, angle = 50, radius = 50, width = 100, speed = math.huge, delay = 0.25, type = "cone", collision = false, source = myHero }
local AnnieR = { range = 600, radius = 290, width = 290, speed = math.huge, delay = 0.25, type = "circular", collision = false, source = myHero }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	KillSteal()
	LastHit()
	LaneClear()
	JungleClear()
	LevelUp()
end)

function useQ(target)
	CastTargetSpell(target, _Q)
end
function useW(target)
	if GetDistance(target) < AnnieW.range then
		if AnnieMenu.Prediction.PredictionW:Value() == 1 then
			CastSkillShot(_W,GetOrigin(target))
		elseif AnnieMenu.Prediction.PredictionW:Value() == 2 then
			local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),AnnieW.speed,AnnieW.delay*1000,AnnieW.range,AnnieW.width,false,true)
			if WPred.HitChance == 1 then
				CastSkillShot(_W, WPred.PredPos)
			end
		elseif AnnieMenu.Prediction.PredictionW:Value() == 3 then
			local WPred = _G.gPred:GetPrediction(target,myHero,AnnieW,true,false)
			if WPred and WPred.HitChance >= 3 then
				CastSkillShot(_W, WPred.CastPosition)
			end
		elseif AnnieMenu.Prediction.PredictionW:Value() == 4 then
			local WSpell = IPrediction.Prediction({name="Incinerate", range=AnnieW.range, speed=AnnieW.speed, delay=AnnieW.delay, width=AnnieW.width, type="conic", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(AnnieW.range)
			local x, y = WSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_W, y.x, y.y, y.z)
			end
		elseif AnnieMenu.Prediction.PredictionW:Value() == 5 then
			local WPrediction = GetConicAOEPrediction(target,AnnieW)
			if WPrediction.hitChance > 0.9 then
				CastSkillShot(_W, WPrediction.castPos)
			end
		end
	end
end
function useE(target)
	CastSpell(_E)
end
function useR(target)
	if GetDistance(target) < AnnieR.range then
		if AnnieMenu.Prediction.PredictionR:Value() == 1 then
			CastSkillShot(_R,GetOrigin(target))
		elseif AnnieMenu.Prediction.PredictionR:Value() == 2 then
			local RPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),AnnieR.speed,AnnieR.delay*1000,AnnieR.range,AnnieR.width,false,true)
			if RPred.HitChance == 1 then
				CastSkillShot(_R, RPred.PredPos)
			end
		elseif AnnieMenu.Prediction.PredictionR:Value() == 3 then
			local RPred = _G.gPred:GetPrediction(target,myHero,AnnieR,true,false)
			if RPred and RPred.HitChance >= 3 then
				CastSkillShot(_R, RPred.CastPosition)
			end
		elseif AnnieMenu.Prediction.PredictionR:Value() == 4 then
			local RSpell = IPrediction.Prediction({name="InfernalGuardian", range=AnnieR.range, speed=AnnieR.speed, delay=AnnieR.delay, width=AnnieR.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(AnnieR.range)
			local x, y = RSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_R, y.x, y.y, y.z)
			end
		elseif AnnieMenu.Prediction.PredictionR:Value() == 5 then
			local RPrediction = GetCircularAOEPrediction(target,AnnieR)
			if RPrediction.hitChance > 0.9 then
				CastSkillShot(_R, RPrediction.castPos)
			end
		end
	end
end

-- Auto

function Auto()
	if AnnieMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, AnnieQ.range) then
					useQ(target)
				end
			end
		end
	end
	if AnnieMenu.Auto.UseW:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, AnnieW.range) then
					useW(target)
				end
			end
		end
	end
	if AnnieMenu.Auto.UseE:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, 1000) then
					useE(target)
				end
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if AnnieMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY and AA == true then
				if ValidTarget(target, AnnieQ.range) then
					useQ(target)
				end
			end
		end
		if AnnieMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY and AA == true then
				if ValidTarget(target, AnnieW.range) then
					useW(target)
				end
			end
		end
		if AnnieMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, 1000) then
					useE(target)
				end
			end
		end
		if AnnieMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, AnnieR.range) then
					if 100*GetCurrentHP(target)/GetMaxHP(target) < AnnieMenu.Misc.HP:Value() then
						if EnemiesAround(myHero, AnnieR.range) >= AnnieMenu.Misc.X:Value() then
							useR(target)
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if AnnieMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY and AA == true then
					if ValidTarget(target, AnnieQ.range) then
						useQ(target)
					end
				end
			end
		end
		if AnnieMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_W) == READY and AA == true then
					if ValidTarget(target, AnnieW.range) then
						useW(target)
					end
				end
			end
		end
		if AnnieMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, 1000) then
						useE(target)
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if AnnieMenu.KillSteal.UseR:Value() then
			if ValidTarget(enemy, AnnieR.range) then
				if CanUseSpell(myHero,_R) == READY then
					if AlliesAround(myHero, 1000) == 0 then
						local AnnieRDmg = (125*GetCastLevel(myHero,_R)+25)+(0.65*GetBonusAP(myHero))
						if GetCurrentHP(enemy)+GetArmor(enemy)+GetDmgShield(enemy)+GetMagicResist(enemy)+GetMagicShield(enemy)+GetHPRegen(enemy)*2 < AnnieRDmg then
							useR(enemy)
						end
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, AnnieQ.range) then
					if AnnieMenu.LastHit.UseQ:Value() then
						if CanUseSpell(myHero,_Q) == READY and AA == true then
							local AnnieQDmg = (20*GetCastLevel(myHero,_Q)+60)+(0.6*GetBonusAP(myHero))
							if GetCurrentHP(minion) < AnnieQDmg then
								useQ(minion)
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		for _,minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if AnnieMenu.LaneClear.UseQ:Value() then
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.LaneClear.MP:Value() then
						if ValidTarget(minion, AnnieQ.range) then
							if CanUseSpell(myHero,_Q) == READY and AA == true then
								useQ(minion)
							end
						end
					end
				end
				if AnnieMenu.LaneClear.UseW:Value() then
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > AnnieMenu.LaneClear.MP:Value() then
						if ValidTarget(minion, AnnieW.range) then
							if CanUseSpell(myHero,_W) == READY and AA == true then
								if MinionsAround(myHero, AnnieW.range) >= 3 then
									CastSkillShot(_W,GetOrigin(minion))
								end
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY and AA == true then
					if ValidTarget(mob, AnnieQ.range) then
						if AnnieMenu.JungleClear.UseQ:Value() then
							useQ(mob)
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY and AA == true then
					if ValidTarget(mob, AnnieW.range) then
						if AnnieMenu.JungleClear.UseW:Value() then
							useW(mob)
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, 500) then
						if AnnieMenu.JungleClear.UseE:Value() then
							useE(mob)
						end
					end
				end
			end
		end
	end
end

-- Misc

function LevelUp()
	if AnnieMenu.Misc.LvlUp:Value() then
		if AnnieMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif AnnieMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif AnnieMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif AnnieMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif AnnieMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif AnnieMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Brand

elseif "Brand" == GetObjectName(myHero) then

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Brand loaded successfully!")
local BrandMenu = Menu("[T01] Brand", "[T01] Brand")
BrandMenu:Menu("Auto", "Auto")
BrandMenu.Auto:Boolean('UseQ', 'Use Q [Sear]', false)
BrandMenu.Auto:Boolean('UseW', 'Use W [Pillar of Flame]', true)
BrandMenu.Auto:Boolean('UseE', 'Use E [Conflagration]', false)
BrandMenu.Auto:Slider("MP","Mana-Manager", 40, 0, 100, 5)
BrandMenu:Menu("Combo", "Combo")
BrandMenu.Combo:Boolean('UseQ', 'Use Q [Sear]', true)
BrandMenu.Combo:Boolean('UseW', 'Use W [Pillar of Flame]', true)
BrandMenu.Combo:Boolean('UseE', 'Use E [Conflagration]', true)
BrandMenu.Combo:Boolean('UseR', 'Use R [Pyroclasm]', true)
BrandMenu.Combo:DropDown("ModeC", "Priority", 1, {"E>Q>W", "E>W>Q"})
BrandMenu:Menu("Harass", "Harass")
BrandMenu.Harass:Boolean('UseQ', 'Use Q [Sear]', true)
BrandMenu.Harass:Boolean('UseW', 'Use W [Pillar of Flame]', true)
BrandMenu.Harass:Boolean('UseE', 'Use E [Conflagration]', true)
BrandMenu.Harass:DropDown("ModeH", "Priority", 2, {"E>Q>W", "E>W>Q"})
BrandMenu.Harass:Slider("MP","Mana-Manager", 40, 0, 100, 5)
BrandMenu:Menu("KillSteal", "KillSteal")
BrandMenu.KillSteal:Boolean('UseW', 'Use W [Pillar of Flame]', true)
BrandMenu:Menu("LaneClear", "LaneClear")
BrandMenu.LaneClear:Boolean('UseQ', 'Use Q [Sear]', false)
BrandMenu.LaneClear:Boolean('UseW', 'Use W [Pillar of Flame]', true)
BrandMenu.LaneClear:Slider("MP","Mana-Manager", 40, 0, 100, 5)
BrandMenu:Menu("JungleClear", "JungleClear")
BrandMenu.JungleClear:Boolean('UseQ', 'Use Q [Sear]', true)
BrandMenu.JungleClear:Boolean('UseW', 'Use W [Pillar of Flame]', true)
BrandMenu.JungleClear:Boolean('UseE', 'Use E [Conflagration]', true)
BrandMenu:Menu("Prediction", "Prediction")
BrandMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
BrandMenu.Prediction:DropDown("PredictionW", "Prediction: W", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
BrandMenu:Menu("Misc", "Misc")
BrandMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
BrandMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 3, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
BrandMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
BrandMenu.Misc:Slider('HP','HP-Manager: R', 40, 0, 100, 5)

local BrandQ = { range = 1050, radius = 60, width = 60, speed = 1600, delay = 0.25, type = "line", collision = true, source = myHero, col = {"minion","champion","yasuowall"}}
local BrandW = { range = 900, radius = 250, width = 250, speed = math.huge, delay = 0.625, type = "circular", collision = false, source = myHero }
local BrandE = { range = 625 }
local BrandR = { range = 750 }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	KillSteal()
	LaneClear()
	JungleClear()
	LevelUp()
end)

function useQ(target)
	if GetDistance(target) < BrandQ.range then
		if BrandMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif BrandMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),BrandQ.speed,BrandQ.delay*1000,BrandQ.range,BrandQ.radius,true,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif BrandMenu.Prediction.PredictionQ:Value() == 3 then
			local qPred = _G.gPred:GetPrediction(target,myHero,BrandQ,false,true)
			if qPred and qPred.HitChance >= 3 then
				CastSkillShot(_Q, qPred.CastPosition)
			end
		elseif BrandMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="BrandQ", range=BrandQ.range, speed=BrandQ.speed, delay=BrandQ.delay, width=BrandQ.radius, type="linear", collision=true})
			ts = TargetSelector()
			target = ts:GetTarget(BrandQ.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif BrandMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetPrediction(target,BrandQ)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useW(target)
	if GetDistance(target) < BrandW.range then
		if BrandMenu.Prediction.PredictionW:Value() == 1 then
			CastSkillShot(_W,GetOrigin(target))
		elseif BrandMenu.Prediction.PredictionW:Value() == 2 then
			local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),BrandW.speed,BrandW.delay*1000,BrandW.range,BrandW.width,false,true)
			if WPred.HitChance == 1 then
				CastSkillShot(_W, WPred.PredPos)
			end
		elseif BrandMenu.Prediction.PredictionW:Value() == 3 then
			local WPred = _G.gPred:GetPrediction(target,myHero,BrandW,true,false)
			if WPred and WPred.HitChance >= 3 then
				CastSkillShot(_W, WPred.CastPosition)
			end
		elseif BrandMenu.Prediction.PredictionW:Value() == 4 then
			local WSpell = IPrediction.Prediction({name="BrandW", range=BrandW.range, speed=BrandW.speed, delay=BrandW.delay, width=BrandW.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(BrandW.range)
			local x, y = WSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_W, y.x, y.y, y.z)
			end
		elseif BrandMenu.Prediction.PredictionW:Value() == 5 then
			local WPrediction = GetCircularAOEPrediction(target,BrandW)
			if WPrediction.hitChance > 0.9 then
				CastSkillShot(_W, WPrediction.castPos)
			end
		end
	end
end
function useE(target)
	CastTargetSpell(target, _E)
end
function useR(target)
	CastTargetSpell(target, _R)
end

-- Auto

function Auto()
	if BrandMenu.Auto.UseE:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > BrandMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, BrandE.range) then
					useE(target)
				end
			end
		end
	end
	if BrandMenu.Auto.UseW:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > BrandMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, BrandW.range) then
					useW(target)
				end
			end
		end
	end
	if BrandMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > BrandMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, BrandQ.range) then
					useQ(target)
				end
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if BrandMenu.Combo.ModeC:Value() == 1 then
			if BrandMenu.Combo.UseE:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, BrandE.range) then
						useE(target)
					end
				end
			end
			if BrandMenu.Combo.UseQ:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, BrandQ.range) then
						useQ(target)
					end
				end
			end
			if BrandMenu.Combo.UseW:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, BrandW.range) then
						useW(target)
					end
				end
			end
		elseif BrandMenu.Combo.ModeC:Value() == 2 then
			if BrandMenu.Combo.UseE:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, BrandE.range) then
						useE(target)
					end
				end
			end
			if BrandMenu.Combo.UseW:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, BrandW.range) then
						useW(target)
					end
				end
			end
			if BrandMenu.Combo.UseQ:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, BrandQ.range) then
						useQ(target)
					end
				end
			end
		end
		if BrandMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, BrandR.range) then
					if 100*GetCurrentHP(target)/GetMaxHP(target) < BrandMenu.Misc.HP:Value() then
						if EnemiesAround(myHero, BrandR.range) >= BrandMenu.Misc.X:Value() then
							if MinionsAround(target, BrandR.range) >= 1 then
								useR(target)
							end
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if BrandMenu.Harass.ModeH:Value() == 1 then
			if BrandMenu.Harass.UseE:Value() then
				if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > BrandMenu.Harass.MP:Value() then
					if CanUseSpell(myHero,_E) == READY then
						if ValidTarget(target, BrandE.range) then
							useE(target)
						end
					end
				end
			end
			if BrandMenu.Harass.UseQ:Value() then
				if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > BrandMenu.Harass.MP:Value() then
					if CanUseSpell(myHero,_Q) == READY then
						if ValidTarget(target, BrandQ.range) then
							useQ(target)
						end
					end
				end
			end
			if BrandMenu.Harass.UseW:Value() then
				if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > BrandMenu.Harass.MP:Value() then
					if CanUseSpell(myHero,_W) == READY then
						if ValidTarget(target, BrandW.range) then
							useW(target)
						end
					end
				end
			end
		elseif BrandMenu.Harass.ModeH:Value() == 2 then
			if BrandMenu.Harass.UseE:Value() then
				if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > BrandMenu.Harass.MP:Value() then
					if CanUseSpell(myHero,_E) == READY then
						if ValidTarget(target, BrandE.range) then
							useE(target)
						end
					end
				end
			end
			if BrandMenu.Harass.UseW:Value() then
				if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > BrandMenu.Harass.MP:Value() then
					if CanUseSpell(myHero,_W) == READY then
						if ValidTarget(target, BrandW.range) then
							useW(target)
						end
					end
				end
			end
			if BrandMenu.Harass.UseQ:Value() then
				if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > BrandMenu.Harass.MP:Value() then
					if CanUseSpell(myHero,_Q) == READY then
						if ValidTarget(target, BrandQ.range) then
							useQ(target)
						end
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if BrandMenu.KillSteal.UseW:Value() then
			if ValidTarget(enemy, BrandW.range) then
				if CanUseSpell(myHero,_W) == READY then
					local BrandWDmg = (45*GetCastLevel(myHero,_W)+30)+(0.6*GetBonusAP(myHero))
					if GetCurrentHP(enemy)+GetArmor(enemy)+GetDmgShield(enemy)+GetMagicResist(enemy)+GetMagicShield(enemy)+GetHPRegen(enemy)*2 < BrandWDmg then
						useW(enemy)
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if BrandMenu.LaneClear.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > BrandMenu.LaneClear.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					local BestPos, BestHit = GetLineFarmPosition(BrandW.range, BrandW.radius, MINION_ENEMY)
					if BestPos and BestHit > 3 then
						CastSkillShot(_W, BestPos)
					end
				end
			end
		end
		if BrandMenu.LaneClear.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > BrandMenu.LaneClear.MP:Value() then
				for _, minion in pairs(minionManager.objects) do
					if GetTeam(minion) == MINION_ENEMY then
						if ValidTarget(minion, BrandQ.range) then
							if BrandMenu.LaneClear.UseQ:Value() then
								if CanUseSpell(myHero,_Q) == READY then
									useQ(minion)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, BrandE.range) then
						if BrandMenu.JungleClear.UseE:Value() then	   
							useE(mob)
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, BrandW.range) then
						if BrandMenu.JungleClear.UseW:Value() then	   
							CastSkillShot(_W,GetOrigin(mob))
						end
					end
				end
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, BrandQ.range) then
						if BrandMenu.JungleClear.UseQ:Value() then
							CastSkillShot(_Q,GetOrigin(mob))
						end
					end
				end
			end
		end
	end
end

-- Misc

function LevelUp()
	if BrandMenu.Misc.LvlUp:Value() then
		if BrandMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif BrandMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif BrandMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif BrandMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif BrandMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif BrandMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Cassiopeia

elseif "Cassiopeia" == GetObjectName(myHero) then

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Cassiopeia loaded successfully!")
local CassiopeiaMenu = Menu("[T01] Cassiopeia", "[T01] Cassiopeia")
CassiopeiaMenu:Menu("Auto", "Auto")
CassiopeiaMenu.Auto:Boolean('UseQ', 'Use Q [Noxious Blast]', true)
CassiopeiaMenu.Auto:Boolean('UseE', 'Use E [Twin Fang]', true)
CassiopeiaMenu.Auto:DropDown("ModeE", "Cast Mode: E", 2, {"Standard", "On Poisoned"})
CassiopeiaMenu.Auto:Slider("MP","Mana-Manager", 40, 0, 100, 5)
CassiopeiaMenu:Menu("Combo", "Combo")
CassiopeiaMenu.Combo:Boolean('UseQ', 'Use Q [Noxious Blast]', true)
CassiopeiaMenu.Combo:Boolean('UseW', 'Use W [Miasma]', true)
CassiopeiaMenu.Combo:Boolean('UseE', 'Use E [Twin Fang]', true)
CassiopeiaMenu.Combo:Boolean('UseR', 'Use R [Petrifying Gaze]', true)
CassiopeiaMenu.Combo:DropDown("ModeE", "Cast Mode: E", 2, {"Standard", "On Poisoned"})
CassiopeiaMenu:Menu("Harass", "Harass")
CassiopeiaMenu.Harass:Boolean('UseQ', 'Use Q [Noxious Blast]', true)
CassiopeiaMenu.Harass:Boolean('UseW', 'Use W [Miasma]', true)
CassiopeiaMenu.Harass:Boolean('UseE', 'Use E [Twin Fang]', true)
CassiopeiaMenu.Harass:DropDown("ModeE", "Cast Mode: E", 2, {"Standard", "On Poisoned"})
CassiopeiaMenu.Harass:Slider("MP","Mana-Manager", 40, 0, 100, 5)
CassiopeiaMenu:Menu("KillSteal", "KillSteal")
CassiopeiaMenu.KillSteal:Boolean('UseE', 'Use E [Twin Fang]', true)
CassiopeiaMenu:Menu("LastHit", "LastHit")
CassiopeiaMenu.LastHit:Boolean('UseE', 'Use E [Twin Fang]', true)
CassiopeiaMenu:Menu("LaneClear", "LaneClear")
CassiopeiaMenu.LaneClear:Boolean('UseQ', 'Use Q [Noxious Blast]', true)
CassiopeiaMenu.LaneClear:Boolean('UseW', 'Use W [Miasma]', false)
CassiopeiaMenu.LaneClear:Boolean('UseE', 'Use E [Twin Fang]', false)
CassiopeiaMenu.LaneClear:Slider("MP","Mana-Manager", 40, 0, 100, 5)
CassiopeiaMenu:Menu("JungleClear", "JungleClear")
CassiopeiaMenu.JungleClear:Boolean('UseQ', 'Use Q [Noxious Blast]', true)
CassiopeiaMenu.JungleClear:Boolean('UseW', 'Use W [Miasma]', true)
CassiopeiaMenu.JungleClear:Boolean('UseE', 'Use E [Twin Fang]', true)
CassiopeiaMenu:Menu("AntiGapcloser", "Anti-Gapcloser")
CassiopeiaMenu.AntiGapcloser:Boolean('UseW', 'Use W [Miasma]', true)
CassiopeiaMenu.AntiGapcloser:Boolean('UseR', 'Use R [Petrifying Gaze]', true)
CassiopeiaMenu:Menu("Interrupter", "Interrupter")
CassiopeiaMenu.Interrupter:Boolean('UseR', 'Use R [Petrifying Gaze]', true)
CassiopeiaMenu:Menu("Prediction", "Prediction")
CassiopeiaMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
CassiopeiaMenu.Prediction:DropDown("PredictionW", "Prediction: W", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
CassiopeiaMenu.Prediction:DropDown("PredictionR", "Prediction: R", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
CassiopeiaMenu:Menu("Misc", "Misc")
CassiopeiaMenu.Misc:Boolean('ST', 'Stack Tear', true)
CassiopeiaMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
CassiopeiaMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 5, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
CassiopeiaMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
CassiopeiaMenu.Misc:Slider('HP','HP-Manager: R', 40, 0, 100, 5)
CassiopeiaMenu.Misc:Slider("MPT","Mana-Manager: Tear", 80, 0, 100, 5)

local CassiopeiaQ = { range = 850, radius = 150, width = 150, speed = math.huge, delay = 0.4, type = "circular", collision = false, source = myHero }
local CassiopeiaW = { range = 800, radius = 160, width = 160, speed = math.huge, delay = 0.25, type = "circular", collision = false, source = myHero }
local CassiopeiaE = { range = 700 }
local CassiopeiaR = { range = 825, angle = 80, radius = 80, width = 160, speed = math.huge, delay = 0.5, type = "cone", collision = false, source = myHero }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	KillSteal()
	LastHit()
	LaneClear()
	JungleClear()
	AntiGapcloser()
	LevelUp()
end)

function useQ(target)
	if GetDistance(target) < CassiopeiaQ.range then
		if CassiopeiaMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif CassiopeiaMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),CassiopeiaQ.speed,CassiopeiaQ.delay*1000,CassiopeiaQ.range,CassiopeiaQ.radius,false,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif CassiopeiaMenu.Prediction.PredictionQ:Value() == 3 then
			local qPred = _G.gPred:GetPrediction(target,myHero,CassiopeiaQ,true,false)
			if qPred and qPred.HitChance >= 3 then
				CastSkillShot(_Q, qPred.CastPosition)
			end
		elseif CassiopeiaMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="CassiopeiaQ", range=CassiopeiaQ.range, speed=CassiopeiaQ.speed, delay=CassiopeiaQ.delay, width=CassiopeiaQ.radius, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(CassiopeiaQ.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif CassiopeiaMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetCircularAOEPrediction(target,CassiopeiaQ)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useW(target)
	if GetDistance(target) < CassiopeiaW.range then
		if CassiopeiaMenu.Prediction.PredictionW:Value() == 1 then
			CastSkillShot(_W,GetOrigin(target))
		elseif CassiopeiaMenu.Prediction.PredictionW:Value() == 2 then
			local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),CassiopeiaW.speed,CassiopeiaW.delay*1000,CassiopeiaW.range,CassiopeiaW.width,false,true)
			if WPred.HitChance == 1 then
				CastSkillShot(_W, WPred.PredPos)
			end
		elseif CassiopeiaMenu.Prediction.PredictionW:Value() == 3 then
			local WPred = _G.gPred:GetPrediction(target,myHero,CassiopeiaW,true,false)
			if WPred and WPred.HitChance >= 3 then
				CastSkillShot(_W, WPred.CastPosition)
			end
		elseif CassiopeiaMenu.Prediction.PredictionW:Value() == 4 then
			local WSpell = IPrediction.Prediction({name="CassiopeiaW", range=CassiopeiaW.range, speed=CassiopeiaW.speed, delay=CassiopeiaW.delay, width=CassiopeiaW.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(CassiopeiaW.range)
			local x, y = WSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_W, y.x, y.y, y.z)
			end
		elseif CassiopeiaMenu.Prediction.PredictionW:Value() == 5 then
			local WPrediction = GetCircularAOEPrediction(target,CassiopeiaW)
			if WPrediction.hitChance > 0.9 then
				CastSkillShot(_W, WPrediction.castPos)
			end
		end
	end
end
function useE(target)
	CastTargetSpell(target, _E)
end
function useR(target)
	if GetDistance(target) < CassiopeiaR.range then
		if CassiopeiaMenu.Prediction.PredictionR:Value() == 1 then
			CastSkillShot(_R,GetOrigin(target))
		elseif CassiopeiaMenu.Prediction.PredictionR:Value() == 2 then
			local RPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),CassiopeiaR.speed,CassiopeiaR.delay*1000,CassiopeiaR.range,CassiopeiaR.width,false,true)
			if RPred.HitChance == 1 then
				CastSkillShot(_R, RPred.PredPos)
			end
		elseif CassiopeiaMenu.Prediction.PredictionR:Value() == 3 then
			local RPred = _G.gPred:GetPrediction(target,myHero,CassiopeiaR,true,false)
			if RPred and RPred.HitChance >= 3 then
				CastSkillShot(_R, RPred.CastPosition)
			end
		elseif CassiopeiaMenu.Prediction.PredictionR:Value() == 4 then
			local RSpell = IPrediction.Prediction({name="CassiopeiaR", range=CassiopeiaR.range, speed=CassiopeiaR.speed, delay=CassiopeiaR.delay, width=CassiopeiaR.width, type="conic", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(CassiopeiaR.range)
			local x, y = RSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_R, y.x, y.y, y.z)
			end
		elseif CassiopeiaMenu.Prediction.PredictionR:Value() == 5 then
			local RPrediction = GetConicAOEPrediction(target,CassiopeiaR)
			if RPrediction.hitChance > 0.9 then
				CastSkillShot(_R, RPrediction.castPos)
			end
		end
	end
end

-- Auto

function Auto()
	if CassiopeiaMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > CassiopeiaMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, CassiopeiaQ.range) then
					useQ(target)
				end
			end
		end
	end
	if CassiopeiaMenu.Auto.UseE:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > CassiopeiaMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, CassiopeiaE.range) then
					if CassiopeiaMenu.Auto.ModeE:Value() == 1 then
						useE(target)
					elseif CassiopeiaMenu.Auto.ModeE:Value() == 2 then
						if GotBuff(target, "cassiopeiaqdebuff") > 0 or GotBuff(target, "cassiopeiawpoison") > 0 then
							useE(target)
						end
					end
				end
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if CassiopeiaMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, CassiopeiaQ.range) then
					useQ(target)
				end
			end
		end
		if CassiopeiaMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, CassiopeiaW.range) then
					useW(target)
				end
			end
		end
		if CassiopeiaMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, CassiopeiaE.range) then
					if CassiopeiaMenu.Combo.ModeE:Value() == 1 then
						useE(target)
					elseif CassiopeiaMenu.Combo.ModeE:Value() == 2 then
						if GotBuff(target, "cassiopeiaqdebuff") > 0 or GotBuff(target, "cassiopeiawpoison") > 0 then
							useE(target)
						end
					end
				end
			end
		end
		if CassiopeiaMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, CassiopeiaR.range) then
					if 100*GetCurrentHP(target)/GetMaxHP(target) < CassiopeiaMenu.Misc.HP:Value() then
						if EnemiesAround(myHero, CassiopeiaR.range) >= CassiopeiaMenu.Misc.X:Value() then
							useR(target)
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if CassiopeiaMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > CassiopeiaMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, CassiopeiaQ.range) then
						useQ(target)
					end
				end
			end
		end
		if CassiopeiaMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > CassiopeiaMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, CassiopeiaW.range) then
						useW(target)
					end
				end
			end
		end
		if CassiopeiaMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > CassiopeiaMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, CassiopeiaE.range) then
						if CassiopeiaMenu.Harass.ModeE:Value() == 1 then
							useE(target)
						elseif CassiopeiaMenu.Harass.ModeE:Value() == 2 then
							if GotBuff(target, "cassiopeiaqdebuff") > 0 or GotBuff(target, "cassiopeiawpoison") > 0 then
								useE(target)
							end
						end
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if CassiopeiaMenu.KillSteal.UseE:Value() then
			if ValidTarget(enemy, CassiopeiaE.range) then
				if CanUseSpell(myHero,_E) == READY then
					if GotBuff(enemy, "cassiopeiaqdebuff") > 0 or GotBuff(enemy, "cassiopeiawpoison") > 0 then
						local CassiopeiaE2Dmg = ((4*GetLevel(myHero)+48)+(0.1*GetBonusAP(myHero)))+((20*GetCastLevel(myHero,_E)-10)+(0.6*GetBonusAP(myHero)))
						if GetCurrentHP(enemy)+GetArmor(enemy)+GetDmgShield(enemy)+GetMagicResist(enemy)+GetMagicShield(enemy)+GetHPRegen(enemy)*2 < CassiopeiaE2Dmg then
							CastTargetSpell(enemy, _E)
						end
					else
						local CassiopeiaEDmg = (4*GetLevel(myHero)+48)+(0.1*GetBonusAP(myHero))
						if GetCurrentHP(enemy)+GetArmor(enemy)+GetDmgShield(enemy)+GetMagicResist(enemy)+GetMagicShield(enemy)+GetHPRegen(enemy)*2 < CassiopeiaEDmg then
							CastTargetSpell(enemy, _E)
						end
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, CassiopeiaE.range) then
					if CassiopeiaMenu.LastHit.UseE:Value() then
						if CanUseSpell(myHero,_E) == READY then
							if GotBuff(minion, "cassiopeiaqdebuff") > 0 or GotBuff(minion, "cassiopeiawpoison") > 0 then
								local CassiopeiaE2Dmg = ((4*GetLevel(myHero)+48)+(0.1*GetBonusAP(myHero)))+((20*GetCastLevel(myHero,_E)-10)+(0.6*GetBonusAP(myHero)))
								if GetCurrentHP(minion) < CassiopeiaE2Dmg then
									BlockInput(true)
									if _G.IOW then
										IOW.attacksEnabled = false
									elseif _G.GoSWalkLoaded then
										_G.GoSWalk:EnableAttack(false)
									elseif _G.DAC_Loaded then
										DAC:AttacksEnabled(false)
									elseif _G.AutoCarry_Loaded then
										DACR.attacksEnabled = false
									end
									CastTargetSpell(minion, _E)
									BlockInput(false)
									if _G.IOW then
										IOW.attacksEnabled = true
									elseif _G.GoSWalkLoaded then
										_G.GoSWalk:EnableAttack(true)
									elseif _G.DAC_Loaded then
										DAC:AttacksEnabled(true)
									elseif _G.AutoCarry_Loaded then
										DACR.attacksEnabled = true
									end
								end
							else
								local CassiopeiaEDmg = (4*GetLevel(myHero)+48)+(0.1*GetBonusAP(myHero))
								if GetCurrentHP(minion) < CassiopeiaEDmg then
									BlockInput(true)
									if _G.IOW then
										IOW.attacksEnabled = false
									elseif _G.GoSWalkLoaded then
										_G.GoSWalk:EnableAttack(false)
									elseif _G.DAC_Loaded then
										DAC:AttacksEnabled(false)
									elseif _G.AutoCarry_Loaded then
										DACR.attacksEnabled = false
									end
									CastTargetSpell(minion, _E)
									BlockInput(false)
									if _G.IOW then
										IOW.attacksEnabled = true
									elseif _G.GoSWalkLoaded then
										_G.GoSWalk:EnableAttack(true)
									elseif _G.DAC_Loaded then
										DAC:AttacksEnabled(true)
									elseif _G.AutoCarry_Loaded then
										DACR.attacksEnabled = true
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if CassiopeiaMenu.LaneClear.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > CassiopeiaMenu.LaneClear.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					local BestPos, BestHit = GetLineFarmPosition(CassiopeiaQ.range, CassiopeiaQ.radius, MINION_ENEMY)
					if BestPos and BestHit > 3 then
						CastSkillShot(_Q, BestPos)
					end
				end
			end
		end
		if CassiopeiaMenu.LaneClear.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > CassiopeiaMenu.LaneClear.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					local BestPos, BestHit = GetLineFarmPosition(CassiopeiaW.range, CassiopeiaW.radius, MINION_ENEMY)
					if BestPos and BestHit > 3 then  
						CastSkillShot(_W, BestPos)
					end
				end
			end
		end
		if CassiopeiaMenu.LaneClear.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > CassiopeiaMenu.LaneClear.MP:Value() then
				for _, minion in pairs(minionManager.objects) do
					if GetTeam(minion) == MINION_ENEMY then
						if ValidTarget(minion, CassiopeiaE.range) then
							if CassiopeiaMenu.LaneClear.UseE:Value() then
								if CanUseSpell(myHero,_E) == READY then
									useE(minion)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, CassiopeiaQ.range) then
						if CassiopeiaMenu.JungleClear.UseQ:Value() then
							CastSkillShot(_Q,GetOrigin(mob))
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, CassiopeiaW.range) then
						if CassiopeiaMenu.JungleClear.UseW:Value() then	   
							CastSkillShot(_W,GetOrigin(mob))
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, CassiopeiaE.range) then
						if CassiopeiaMenu.JungleClear.UseE:Value() then	   
							useE(mob)
						end
					end
				end
			end
		end
	end
end

-- Anti-Gapcloser

function AntiGapcloser()
	for i,antigap in pairs(GetEnemyHeroes()) do
		if CanUseSpell(myHero,_W) == READY then
			if CassiopeiaMenu.AntiGapcloser.UseW:Value() then
				if ValidTarget(antigap, 500) then
					CastSkillShot(_W, antigap)
				end
			end
		elseif CanUseSpell(myHero,_R) == READY then
			if CassiopeiaMenu.AntiGapcloser.UseR:Value() then
				if ValidTarget(antigap, 250) then
					CastSkillShot(_R, antigap)
				end
			end
		end
	end
end

-- Interrupter

OnProcessSpell(function(unit, spell)
	if CassiopeiaMenu.Interrupter.UseR:Value() then
		for _, enemy in pairs(GetEnemyHeroes()) do
			if ValidTarget(enemy, CassiopeiaR.range) then
				if CanUseSpell(myHero,_R) == READY then
					local UnitName = GetObjectName(enemy)
					local UnitChanellingSpells = CHANELLING_SPELLS[UnitName]
					local UnitGapcloserSpells = GAPCLOSER_SPELLS[UnitName]
					if UnitChanellingSpells then
						for _, slot in pairs(UnitChanellingSpells) do
							if spell.name == GetCastName(enemy, slot) then useR(enemy) end
						end
					elseif UnitGapcloserSpells then
						for _, slot in pairs(UnitGapcloserSpells) do
							if spell.name == GetCastName(enemy, slot) then useR(enemy) end
						end
					end
				end
			end
		end
    end
end)

-- Misc

OnTick(function(myHero)
	if CassiopeiaMenu.Misc.ST:Value() then
		if GotBuff(myHero,"recall") == 0 then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > CassiopeiaMenu.Misc.MPT:Value() then
				if EnemiesAround(myHero, 2500) == 0 then
					if not UnderTurret(myHero, 775) then
						if GetItemSlot(myHero, 3070) > 0 then
							if CanUseSpell(myHero,_Q) == READY then
								DelayAction(function() CastSkillShot(_Q,GetOrigin(myHero)) end, 0.25)
							end
						end
					end
				end
			end
		end
	end
end)

function LevelUp()
	if CassiopeiaMenu.Misc.LvlUp:Value() then
		if CassiopeiaMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif CassiopeiaMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif CassiopeiaMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif CassiopeiaMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif CassiopeiaMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif CassiopeiaMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Fizz

elseif "Fizz" == GetObjectName(myHero) then

if not pcall( require, "AntiDangerousSpells" ) then PrintChat("<font color='#00BFFF'>AntiDangerousSpells.lua not detected! Probably incorrect file name or doesnt exist in Common folder!") return end

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Fizz loaded successfully!")
local FizzMenu = Menu("[T01] Fizz", "[T01] Fizz")
FizzMenu:Menu("Auto", "Auto")
FizzMenu.Auto:Boolean('UseE', 'Use E [Playful]', true)
FizzMenu:Menu("Combo", "Combo")
FizzMenu.Combo:Boolean('UseQ', 'Use Q [Urchin Strike]', true)
FizzMenu.Combo:Boolean('UseW', 'Use W [Seastone Trident]', true)
FizzMenu.Combo:Boolean('UseE', 'Use E [Playful]', true)
FizzMenu.Combo:Boolean('UseR', 'Use R [Chum the Waters]', true)
FizzMenu:Menu("Harass", "Harass")
FizzMenu.Harass:Boolean('UseQ', 'Use Q [Urchin Strike]', true)
FizzMenu.Harass:Boolean('UseW', 'Use W [Seastone Trident]', true)
FizzMenu.Harass:Boolean('UseE', 'Use E [Playful]', true)
FizzMenu.Harass:Slider("MP","Mana-Manager", 40, 0, 100, 5)
FizzMenu:Menu("KillSteal", "KillSteal")
FizzMenu.KillSteal:Boolean('UseQ', 'Use Q [Urchin Strike]', true)
FizzMenu:Menu("LastHit", "LastHit")
FizzMenu.LastHit:Boolean('UseW', 'Use W [Urchin Strike]', true)
FizzMenu.LastHit:Slider("MP","Mana-Manager", 40, 0, 100, 5)
FizzMenu:Menu("LaneClear", "LaneClear")
FizzMenu.LaneClear:Boolean('UseQ', 'Use Q [Urchin Strike]', true)
FizzMenu.LaneClear:Boolean('UseW', 'Use W [Seastone Trident]', false)
FizzMenu.LaneClear:Boolean('UseE', 'Use E [Playful]', true)
FizzMenu.LaneClear:Slider("MP","Mana-Manager", 40, 0, 100, 5)
FizzMenu:Menu("JungleClear", "JungleClear")
FizzMenu.JungleClear:Boolean('UseQ', 'Use Q [Urchin Strike]', true)
FizzMenu.JungleClear:Boolean('UseW', 'Use W [Seastone Trident]', true)
FizzMenu.JungleClear:Boolean('UseE', 'Use E [Playful]', true)
FizzMenu:Menu("Prediction", "Prediction")
FizzMenu.Prediction:DropDown("PredictionR", "Prediction: R", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
FizzMenu:Menu("Misc", "Misc")
FizzMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
FizzMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 6, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
FizzMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
FizzMenu.Misc:Slider('HP','HP-Manager: R', 40, 0, 100, 5)

local FizzQ = { range = 550 }
local FizzE = { range = 400 }
local FizzR = { range = 1300, radius = 80, width = 80, speed = 1300, delay = 0.25, type = "line", collision = false, source = myHero, col = {"yasuowall"}}

OnTick(function(myHero)
	target = GetCurrentTarget()
	Combo()
	Harass()
	KillSteal()
	LastHit()
	LaneClear()
	JungleClear()
	LevelUp()
end)

function useQ(target)
	CastTargetSpell(target, _Q)
end
function useW(target)
	if GotBuff(target, "fizzwdot") >= 1 then
		CastSpell(_W)
		if _G.IOW then
			IOW:ResetAA()
		elseif _G.GoSWalkLoaded then
			_G.GoSWalk:ResetAttack()
		elseif _G.DAC_Loaded then
			DAC:ResetAA()
		elseif _G.AutoCarry_Loaded then
			DACR:ResetAA()
		end
	end
end
function useE(target)
	if GotBuff(myHero, "fizzeicon") == 0 then
		CastSkillShot(_E,GetOrigin(target))
	end
end
function useR(target)
	if GetDistance(target) < FizzR.range then
		if FizzMenu.Prediction.PredictionR:Value() == 1 then
			CastSkillShot(_R,GetOrigin(target))
		elseif FizzMenu.Prediction.PredictionR:Value() == 2 then
			local RPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),FizzR.speed,FizzR.delay*1000,FizzR.range,FizzR.width,false,true)
			if RPred.HitChance == 1 then
				CastSkillShot(_R, RPred.PredPos)
			end
		elseif FizzMenu.Prediction.PredictionR:Value() == 3 then
			local RPred = _G.gPred:GetPrediction(target,myHero,FizzR,true,false)
			if RPred and RPred.HitChance >= 3 then
				CastSkillShot(_R, RPred.CastPosition)
			end
		elseif FizzMenu.Prediction.PredictionR:Value() == 4 then
			local RSpell = IPrediction.Prediction({name="FizzMarinerDoom", range=FizzR.range, speed=FizzR.speed, delay=FizzR.delay, width=FizzR.width, type="linear", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(FizzR.range)
			local x, y = RSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_R, y.x, y.y, y.z)
			end
		elseif FizzMenu.Prediction.PredictionR:Value() == 5 then
			local RPrediction = GetLinearAOEPrediction(target,FizzR)
			if RPrediction.hitChance > 0.9 then
				CastSkillShot(_R, RPrediction.castPos)
			end
		end
	end
end

-- Auto

addAntiDSCallback(function()
	if FizzMenu.Auto.UseE:Value() then
		if CanUseSpell(myHero,_E) == READY then
			CastSpell(_E)
		end
	end
end)

-- Combo

function Combo()
	if Mode() == "Combo" then
		if FizzMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, FizzQ.range) then
					useQ(target)
				end
			end
		end
		if FizzMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY and AA == true then
				if ValidTarget(target, GetRange(myHero)+150) then
					useW(target)
				end
			end
		end
		if FizzMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, FizzE.range) then
					useE(target)
				end
			end
		end
		if FizzMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, FizzR.range) then
					if 100*GetCurrentHP(target)/GetMaxHP(target) < FizzMenu.Misc.HP:Value() then
						if EnemiesAround(myHero, FizzR.range) >= FizzMenu.Misc.X:Value() then
							useR(target)
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if FizzMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > FizzMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, FizzQ.range) then
						useQ(target)
					end
				end
			end
		end
		if FizzMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > FizzMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_W) == READY and AA == true then
					if ValidTarget(target, GetRange(myHero)+150) then
						useW(target)
					end
				end
			end
		end
		if FizzMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > FizzMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, FizzE.range) then
						useE(target)
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if FizzMenu.KillSteal.UseQ:Value() then
			if ValidTarget(enemy, FizzQ.range) then
				if CanUseSpell(myHero,_Q) == READY then
					local FizzQDmg = (GetBonusDmg(myHero)+GetBaseDamage(myHero))+(15*GetCastLevel(myHero,_Q)-5)+(0.55*GetBonusAP(myHero))
					if GetCurrentHP(enemy)+GetArmor(enemy)+GetDmgShield(enemy)+GetMagicResist(enemy)+GetMagicShield(enemy)+GetHPRegen(enemy)*2 < FizzQDmg then
						useQ(enemy)
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, GetRange(myHero)+50) then
					if FizzMenu.LastHit.UseW:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > FizzMenu.LastHit.MP:Value() then
							if CanUseSpell(myHero,_W) == READY and AA == true then
								local FizzWDmg = (GetBonusDmg(myHero)+GetBaseDamage(myHero))+(10*GetCastLevel(myHero,_E)+10)+(0.4*GetBonusAP(myHero))
								local MinionToLastHit = minion
								if GetCurrentHP(MinionToLastHit) < FizzWDmg then
									useW(MinionToLastHit)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		for _,minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if FizzMenu.LaneClear.UseQ:Value() then
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > FizzMenu.LaneClear.MP:Value() then
						if ValidTarget(minion, FizzQ.range) then
							if CanUseSpell(myHero,_Q) == READY then
								useQ(minion)
							end
						end
					end
				end
				if FizzMenu.LaneClear.UseW:Value() then
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > FizzMenu.LaneClear.MP:Value() then
						if ValidTarget(minion, GetRange(myHero)+50) then
							if CanUseSpell(myHero,_W) == READY and AA == true then
								useW(minion)
							end
						end
					end
				end
				if FizzMenu.LaneClear.UseE:Value() then
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > FizzMenu.LaneClear.MP:Value() then
						if ValidTarget(minion, FizzE.range) then
							if CanUseSpell(myHero,_E) == READY then
								if MinionsAround(myHero, FizzE.range) >= 3 then
									if GotBuff(myHero, "fizzeicon") == 0 then
										CastSkillShot(_E,GetOrigin(minion))
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, FizzQ.range) then
						if FizzMenu.JungleClear.UseQ:Value() then
							useQ(mob)
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY and AA == true then
					if ValidTarget(mob, GetRange(myHero)+50) then
						if FizzMenu.JungleClear.UseW:Value() then
							useW(mob)
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, FizzE.range) then
						if FizzMenu.JungleClear.UseE:Value() then
							if GotBuff(myHero, "fizzeicon") == 0 then
								CastSkillShot(_E,GetOrigin(mob))
							end
						end
					end
				end
			end
		end
	end
end

-- Misc

function LevelUp()
	if FizzMenu.Misc.LvlUp:Value() then
		if FizzMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif FizzMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif FizzMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif FizzMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif FizzMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif FizzMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Gnar

elseif "Gnar" == GetObjectName(myHero) then

require('MapPositionGOS')

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Gnar loaded successfully!")
local GnarMenu = Menu("[T01] Gnar", "[T01] Gnar")
GnarMenu:Menu("Auto", "Auto")
GnarMenu.Auto:Boolean('UseQMini', 'Use Q [Boomerang Throw]', true)
GnarMenu.Auto:Boolean('UseQMega', 'Use Q [Boulder Toss]', true)
GnarMenu.Auto:Boolean('UseRMega', 'Use R [GNAR!]', true)
GnarMenu:Menu("Combo", "Combo")
GnarMenu.Combo:Boolean('UseQMini', 'Use Q [Boomerang Throw]', true)
GnarMenu.Combo:Boolean('UseEMini', 'Use E [Hop]', true)
GnarMenu.Combo:Boolean('UseQMega', 'Use Q [Boulder Toss]', true)
GnarMenu.Combo:Boolean('UseWMega', 'Use W [Wallop]', true)
GnarMenu.Combo:Boolean('UseEMega', 'Use E [Crunch]', true)
GnarMenu.Combo:Boolean('UseRMega', 'Use R [GNAR!]', true)
GnarMenu:Menu("Harass", "Harass")
GnarMenu.Harass:Boolean('UseQMini', 'Use Q [Boomerang Throw]', true)
GnarMenu.Harass:Boolean('UseEMini', 'Use E [Hop]', false)
GnarMenu.Harass:Boolean('UseQMega', 'Use Q [Boulder Toss]', true)
GnarMenu.Harass:Boolean('UseWMega', 'Use W [Wallop]', true)
GnarMenu.Harass:Boolean('UseEMega', 'Use E [Crunch]', false)
GnarMenu.Harass:Boolean('UseRMega', 'Use R [GNAR!]', true)
GnarMenu:Menu("KillSteal", "KillSteal")
GnarMenu.KillSteal:Boolean('UseQMini', 'Use Q [Boomerang Throw]', true)
GnarMenu.KillSteal:Boolean('UseQMega', 'Use Q [Boulder Toss]', true)
GnarMenu:Menu("LastHit", "LastHit")
GnarMenu.LastHit:Boolean('UseQMini', 'Use Q [Boomerang Throw]', true)
GnarMenu:Menu("LaneClear", "LaneClear")
GnarMenu.LaneClear:Boolean('UseQMini', 'Use Q [Boomerang Throw]', false)
GnarMenu.LaneClear:Boolean('UseQMega', 'Use Q [Boulder Toss]', true)
GnarMenu.LaneClear:Boolean('UseWMega', 'Use W [Wallop]', true)
GnarMenu.LaneClear:Boolean('UseEMega', 'Use E [Crunch]', false)
GnarMenu:Menu("JungleClear", "JungleClear")
GnarMenu.JungleClear:Boolean('UseQMini', 'Use Q [Boomerang Throw]', true)
GnarMenu.JungleClear:Boolean('UseEMini', 'Use E [Hop]', false)
GnarMenu.JungleClear:Boolean('UseQMega', 'Use Q [Boulder Toss]', true)
GnarMenu.JungleClear:Boolean('UseWMega', 'Use W [Wallop]', true)
GnarMenu.JungleClear:Boolean('UseEMega', 'Use E [Crunch]', true)
GnarMenu.JungleClear:Boolean('UseRMega', 'Use R [GNAR!]', true)
GnarMenu:Menu("AntiGapcloser", "Anti-Gapcloser")
GnarMenu.AntiGapcloser:Boolean('UseWMega', 'Use W [Wallop]', true)
GnarMenu:Menu("Prediction", "Prediction")
GnarMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
GnarMenu.Prediction:DropDown("PredictionW", "Prediction: W", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
GnarMenu.Prediction:DropDown("PredictionE", "Prediction: E", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
GnarMenu:Menu("Misc", "Misc")
GnarMenu.Misc:Boolean('UI', 'Use Offensive Items', true)
GnarMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
GnarMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 1, {"Q-W-E", "Q-E-W"})
GnarMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)

local GnarQMini = { range = 1100, radius = 55, width = 110, speed = 1700, delay = 0.25, type = "line", collision = false, source = myHero, col = {"minion","yasuowall"}}
local GnarEMini = { range = 475, radius = 160, width = 320, speed = 900, delay = 0.25, type = "circular", collision = false, source = myHero }
local GnarQMega = { range = 1100, radius = 90, width = 180, speed = 2100, delay = 0.5, type = "line", collision = true, source = myHero, col = {"minion","champion","yasuowall"}}
local GnarWMega = { range = 550, radius = 100, width = 200, speed = math.huge, delay = 0.6, type = "line", collision = false, source = myHero }
local GnarEMega = { range = 600, radius = 375, width = 750, speed = 800, delay = 0.25, type = "circular", collision = false, source = myHero }
local GnarRMega = { range = 475 }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	LastHit()
	LaneClear()
	JungleClear()
	AntiGapcloser()
	LevelUp()
end)

function useQMini(target)
	if GetDistance(target) < GnarQMini.range then
		if GnarMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif GnarMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),GnarQMini.speed,GnarQMini.delay*1000,GnarQMini.range,GnarQMini.radius,true,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif GnarMenu.Prediction.PredictionQ:Value() == 3 then
			local qPred = _G.gPred:GetPrediction(target,myHero,GnarQMini,false,true)
			if qPred and qPred.HitChance >= 3 then
				CastSkillShot(_Q, qPred.CastPosition)
			end
		elseif GnarMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="GnarQ", range=GnarQMini.range, speed=GnarQMini.speed, delay=GnarQMini.delay, width=GnarQMini.radius, type="linear", collision=true})
			ts = TargetSelector()
			target = ts:GetTarget(GnarQMini.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif GnarMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetLinearAOEPrediction(target,GnarQMini)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useQMega(target)
	if GetDistance(target) < GnarQMega.range then
		if GnarMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif GnarMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),GnarQMega.speed,GnarQMega.delay*1000,GnarQMega.range,GnarQMega.radius,true,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif GnarMenu.Prediction.PredictionQ:Value() == 3 then
			local qPred = _G.gPred:GetPrediction(target,myHero,GnarQMega,false,true)
			if qPred and qPred.HitChance >= 3 then
				CastSkillShot(_Q, qPred.CastPosition)
			end
		elseif GnarMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="GnarBigQ", range=GnarQMega.range, speed=GnarQMega.speed, delay=GnarQMega.delay, width=GnarQMega.radius, type="linear", collision=true})
			ts = TargetSelector()
			target = ts:GetTarget(GnarQMega.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif GnarMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetLinearAOEPrediction(target,GnarQMega)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useWMega(target)
	if GetDistance(target) < GnarWMega.range then
		if GnarMenu.Prediction.PredictionW:Value() == 1 then
			CastSkillShot(_W,GetOrigin(target))
		elseif GnarMenu.Prediction.PredictionW:Value() == 2 then
			local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),GnarWMega.speed,GnarWMega.delay*1000,GnarWMega.range,GnarWMega.radius,false,true)
			if WPred.HitChance == 1 then
				CastSkillShot(_W, WPred.PredPos)
			end
		elseif GnarMenu.Prediction.PredictionW:Value() == 3 then
			local wPred = _G.gPred:GetPrediction(target,myHero,GnarWMega,true,false)
			if wPred and wPred.HitChance >= 3 then
				CastSkillShot(_W, wPred.CastPosition)
			end
		elseif GnarMenu.Prediction.PredictionW:Value() == 4 then
			local WSpell = IPrediction.Prediction({name="GnarBigW", range=GnarWMega.range, speed=GnarWMega.speed, delay=GnarWMega.delay, width=GnarWMega.radius, type="linear", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(GnarWMega.range)
			local x, y = WSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_W, y.x, y.y, y.z)
			end
		elseif GnarMenu.Prediction.PredictionW:Value() == 5 then
			local WPrediction = GetLinearAOEPrediction(target,GnarWMega)
			if WPrediction.hitChance > 0.9 then
				CastSkillShot(_W, WPrediction.castPos)
			end
		end
	end
end
function useEMini(target)
	if GetDistance(target) < GnarEMini.range then
		if GnarMenu.Prediction.PredictionE:Value() == 1 then
			CastSkillShot(_E,GetOrigin(target))
		elseif GnarMenu.Prediction.PredictionE:Value() == 2 then
			local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),GnarEMini.speed,GnarEMini.delay*1000,GnarEMini.range,GnarEMini.width,false,true)
			if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
			end
		elseif GnarMenu.Prediction.PredictionE:Value() == 3 then
			local EPred = _G.gPred:GetPrediction(target,myHero,GnarEMini,true,false)
			if EPred and EPred.HitChance >= 3 then
				CastSkillShot(_E, EPred.CastPosition)
			end
		elseif GnarMenu.Prediction.PredictionE:Value() == 4 then
			local ESpell = IPrediction.Prediction({name="GnarE", range=GnarEMini.range, speed=GnarEMini.speed, delay=GnarEMini.delay, width=GnarEMini.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(GnarEMini.range)
			local x, y = ESpell:Predict(target)
			if x > 2 then
				CastSkillShot(_E, y.x, y.y, y.z)
			end
		elseif GnarMenu.Prediction.PredictionE:Value() == 5 then
			local EPrediction = GetCircularAOEPrediction(target,GnarEMini)
			if EPrediction.hitChance > 0.9 then
				CastSkillShot(_E, EPrediction.castPos)
			end
		end
	end
end
function useEMega(target)
	if GetDistance(target) < GnarEMega.range then
		if GnarMenu.Prediction.PredictionE:Value() == 1 then
			CastSkillShot(_E,GetOrigin(target))
		elseif GnarMenu.Prediction.PredictionE:Value() == 2 then
			local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),GnarEMega.speed,GnarEMega.delay*1000,GnarEMega.range,GnarEMega.width,false,true)
			if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
			end
		elseif GnarMenu.Prediction.PredictionE:Value() == 3 then
			local EPred = _G.gPred:GetPrediction(target,myHero,GnarEMega,true,false)
			if EPred and EPred.HitChance >= 3 then
				CastSkillShot(_E, EPred.CastPosition)
			end
		elseif GnarMenu.Prediction.PredictionE:Value() == 4 then
			local ESpell = IPrediction.Prediction({name="GnarBigE", range=GnarEMega.range, speed=GnarEMega.speed, delay=GnarEMega.delay, width=GnarEMega.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(GnarEMega.range)
			local x, y = ESpell:Predict(target)
			if x > 2 then
				CastSkillShot(_E, y.x, y.y, y.z)
			end
		elseif GnarMenu.Prediction.PredictionE:Value() == 5 then
			local EPrediction = GetCircularAOEPrediction(target,GnarEMega)
			if EPrediction.hitChance > 0.9 then
				CastSkillShot(_E, EPrediction.castPos)
			end
		end
	end
end
function useRMega(target)
	for _,unit in pairs(GetEnemyHeroes()) do
		local Distance = GnarRMega.range-GetDistance(myHero,unit)
		local RPred = GetPredictionForPlayer(GetOrigin(myHero),unit,GetMoveSpeed(unit),3000,0.25,GnarRMega.range,GnarRMega.range,false,true)
		local PredPos = Vector(RPred.PredPos)
		local HeroPos = Vector(myHero)
		local MaximumRRange = PredPos-(PredPos-HeroPos)*(-Distance/GetDistance(RPred.PredPos))
		local Shoot = LineSegment(Point(PredPos.x, PredPos.y, PredPos.z), Point(MaximumRRange.x, MaximumRRange.y, MaximumRRange.z))
		for i, Pos in pairs(Shoot:__getPoints()) do
			if MapPosition:inWall(Pos) then
				CastSkillShot(_R,RPred.PredPos)
			end
		end
	end
end

-- Auto

function Auto()
	if GetRange(myHero) > 300 then
		if GnarMenu.Auto.UseQMini:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, GnarQMini.range) then
					useQMini(target)
				end
			end
		end
	elseif GetRange(myHero) < 300 then
		if GnarMenu.Auto.UseQMega:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, GnarQMega.range) then
					useQMega(target)
				end
			end
		end
		if GnarMenu.Auto.UseRMega:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, GnarRMega.range) then
					if EnemiesAround(myHero, GnarRMega.range) >= GnarMenu.Misc.X:Value() then
						useRMega(target)
					end
				end
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if GetRange(myHero) > 300 then
			if GnarMenu.Combo.UseQMini:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, GnarQMini.range) then
						useQMini(target)
					end
				end
			end
			if GnarMenu.Combo.UseEMini:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, GnarEMini.range) then
						useEMini(target)
					end
				end
			end
		elseif GetRange(myHero) < 300 then
			if GnarMenu.Combo.UseQMega:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, GnarQMega.range) then
						useQMega(target)
					end
				end
			end
			if GnarMenu.Combo.UseWMega:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, GnarWMega.range) then
						useWMega(target)
					end
				end
			end
			if GnarMenu.Combo.UseEMega:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, GnarEMega.range) then
						useEMega(target)
					end
				end
			end
			if GnarMenu.Combo.UseRMega:Value() then
				if CanUseSpell(myHero,_R) == READY then
					if ValidTarget(target, GnarRMega.range) then
						if EnemiesAround(myHero, GnarRMega.range) >= GnarMenu.Misc.X:Value() then
							useRMega(target)
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if GetRange(myHero) > 300 then
			if GnarMenu.Harass.UseQMini:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, GnarQMini.range) then
						useQMini(target)
					end
				end
			end
			if GnarMenu.Harass.UseEMini:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, GnarEMini.range) then
						useEMini(target)
					end
				end
			end
		elseif GetRange(myHero) < 300 then
			if GnarMenu.Harass.UseQMega:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, GnarQMega.range) then
						useQMega(target)
					end
				end
			end
			if GnarMenu.Harass.UseWMega:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, GnarWMega.range) then
						useWMega(target)
					end
				end
			end
			if GnarMenu.Harass.UseEMega:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, GnarEMega.range) then
						useEMega(target)
					end
				end
			end
			if GnarMenu.Harass.UseRMega:Value() then
				if CanUseSpell(myHero,_R) == READY then
					if ValidTarget(target, GnarRMega.range) then
						if EnemiesAround(myHero, GnarRMega.range) >= GnarMenu.Misc.X:Value() then
							useRMega(target)
						end
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if GetRange(myHero) > 300 then
			if GnarMenu.KillSteal.UseQMini:Value() then
				if ValidTarget(enemy, GnarQMini.range) then
					if CanUseSpell(myHero,_Q) == READY then
						local GnarQMiniDmg = (40*GetCastLevel(myHero,_Q)-35)+(1.15*(GetBaseDamage(myHero)+GetBonusDmg(myHero)))
						if GetCurrentHP(enemy)+GetArmor(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2 < GnarQMiniDmg then
							useQMini(enemy)
						end
					end
				end
			end
		elseif GetRange(myHero) < 300 then
			if GnarMenu.KillSteal.UseQMega:Value() then
				if ValidTarget(enemy, GnarQMega.range) then
					if CanUseSpell(myHero,_Q) == READY then
						local GnarQMegaDmg = (40*GetCastLevel(myHero,_Q)-35)+(1.2*(GetBaseDamage(myHero)+GetBonusDmg(myHero)))
						if GetCurrentHP(enemy)+GetArmor(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2 < GnarQMegaDmg then
							useQMega(enemy)
						end
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, GnarQMini.range) then
					if GnarMenu.LastHit.UseQMini:Value() then
						if CanUseSpell(myHero,_Q) == READY then
							local GnarQMiniDmg = (20*GetCastLevel(myHero,_Q)-17.5)+(0.575*(GetBaseDamage(myHero)+GetBonusDmg(myHero)))
							if GetCurrentHP(minion) < GnarQMiniDmg then
								CastSkillShot(_Q,GetOrigin(minion))
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if GetRange(myHero) < 300 then
			if GnarMenu.LaneClear.UseWMega:Value() then
				if CanUseSpell(myHero,_W) == READY then
					local BestPos, BestHit = GetLineFarmPosition(GnarWMega.range, GnarWMega.radius, MINION_ENEMY)
					if BestPos and BestHit > 3 then  
						CastSkillShot(_W, BestPos)
					end
				end
			end
			if GnarMenu.LaneClear.UseEMega:Value() then
				if CanUseSpell(myHero,_E) == READY then
					local BestPos, BestHit = GetFarmPosition(GnarEMega.range, GnarEMega.radius, MINION_ENEMY)
					if BestPos and BestHit > 3 then  
						CastSkillShot(_E, BestPos)
					end
				end
			end
		end
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if GetRange(myHero) > 300 then
					if GnarMenu.LaneClear.UseQMini:Value() then
						if ValidTarget(minion, GnarQMini.range) then
							if CanUseSpell(myHero,_Q) == READY then
								CastSkillShot(_Q,GetOrigin(minion))
							end
						end
					end
				elseif GetRange(myHero) < 300 then
					if GnarMenu.LaneClear.UseQMega:Value() then
						if ValidTarget(minion, GnarQMega.range) then
							if CanUseSpell(myHero,_Q) == READY then
								CastSkillShot(_Q,GetOrigin(minion))
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if GetRange(myHero) > 300 then
					if GnarMenu.JungleClear.UseQMini:Value() then
						if CanUseSpell(myHero,_Q) == READY then
							if ValidTarget(mob, GnarQMini.range) then
								CastSkillShot(_Q, GetOrigin(mob))
							end
						end
					end
					if GnarMenu.JungleClear.UseEMini:Value() then
						if CanUseSpell(myHero,_E) == READY then
							if ValidTarget(mob, GnarEMini.range) then
								CastSkillShot(_E, GetOrigin(mob))
							end
						end
					end
				elseif GetRange(myHero) < 300 then
					if GnarMenu.JungleClear.UseQMega:Value() then
						if CanUseSpell(myHero,_Q) == READY then
							if ValidTarget(mob, GnarQMega.range) then
								CastSkillShot(_Q, GetOrigin(mob))
							end
						end
					end
					if GnarMenu.JungleClear.UseWMega:Value() then
						if CanUseSpell(myHero,_W) == READY then
							if ValidTarget(mob, GnarWMega.range) then
								CastSkillShot(_W, GetOrigin(mob))
							end
						end
					end
					if GnarMenu.JungleClear.UseEMega:Value() then
						if CanUseSpell(myHero,_E) == READY then
							if ValidTarget(mob, GnarEMega.range) then
								CastSkillShot(_E, GetOrigin(mob))
							end
						end
					end
					if GnarMenu.JungleClear.UseEMega:Value() then
						if CanUseSpell(myHero,_E) == READY then
							if ValidTarget(mob, GnarEMega.range) then
								useEMega(mob)
							end
						end
					end
				end
			end
		end
	end
end

-- Anti-Gapcloser

function AntiGapcloser()
	for i,antigap in pairs(GetEnemyHeroes()) do
		if GnarMenu.AntiGapcloser.UseWMega:Value() then
			if ValidTarget(antigap, GnarWMega.range) then
				if CanUseSpell(myHero,_W) == READY then
					useWMega(antigap)
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if Mode() == "Combo" then
		if GnarMenu.Misc.UI:Value() then
			if GetItemSlot(myHero, 3074) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3074)) == READY then
					CastSpell(GetItemSlot(myHero, 3074))
				end -- Ravenous Hydra
			end
			if GetItemSlot(myHero, 3077) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3077)) == READY then
					CastSpell(GetItemSlot(myHero, 3077))
				end -- Tiamat
			end
			if GetItemSlot(myHero, 3144) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3144)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3144))
					end -- Bilgewater Cutlass
				end
			end
			if GetItemSlot(myHero, 3146) >= 1 and ValidTarget(target, 700) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3146)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3146))
					end -- Hextech Gunblade
				end
			end
			if GetItemSlot(myHero, 3153) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3153)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3153))
					end -- BOTRK
				end
			end
			if GetItemSlot(myHero, 3748) >= 1 and ValidTarget(target, 300) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero,GetItemSlot(myHero, 3748)) == READY then
						CastSpell(GetItemSlot(myHero, 3748))
					end -- Titanic Hydra
				end
			end
		end
	end
end)

function LevelUp()
	if GnarMenu.Misc.LvlUp:Value() then
		if GnarMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif GnarMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif GnarMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif GnarMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif GnarMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif GnarMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Jayce

elseif "Jayce" == GetObjectName(myHero) then

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Jayce loaded successfully!")
local JayceMenu = Menu("[T01] Jayce", "[T01] Jayce")
JayceMenu:Menu("Auto", "Auto")
JayceMenu.Auto:Boolean('UseQCannon', 'Use Q [Shock Blast]', true)
JayceMenu.Auto:Boolean('UseECannon', 'Use E [Acceleration Gate]', false)
JayceMenu.Auto:Slider("MP","Mana-Manager", 40, 0, 100, 5)
JayceMenu:Menu("Combo", "Combo")
JayceMenu.Combo:Boolean('UseQCannon', 'Use Q [Shock Blast]', true)
JayceMenu.Combo:Boolean('UseWCannon', 'Use W [Hyper Charge]', true)
JayceMenu.Combo:Boolean('UseECannon', 'Use E [Acceleration Gate]', true)
JayceMenu.Combo:Boolean('UseQHammer', 'Use Q [To the Skies!]', true)
JayceMenu.Combo:Boolean('UseWHammer', 'Use W [Lightning Field]', true)
JayceMenu:Menu("Harass", "Harass")
JayceMenu.Harass:Boolean('UseQCannon', 'Use Q [Shock Blast]', true)
JayceMenu.Harass:Boolean('UseWCannon', 'Use W [Hyper Charge]', true)
JayceMenu.Harass:Boolean('UseECannon', 'Use E [Acceleration Gate]', true)
JayceMenu.Harass:Boolean('UseQHammer', 'Use Q [To the Skies!]', true)
JayceMenu.Harass:Boolean('UseWHammer', 'Use W [Lightning Field]', true)
JayceMenu.Harass:Slider("MP","Mana-Manager", 40, 0, 100, 5)
JayceMenu:Menu("KillSteal", "KillSteal")
JayceMenu.KillSteal:Boolean('UseQCannon', 'Use Q [Shock Blast]', true)
JayceMenu.KillSteal:Boolean('UseECannon', 'Use E [Acceleration Gate]', true)
JayceMenu.KillSteal:Boolean('UseEHammer', 'Use E [Thundering Blow]', true)
JayceMenu:Menu("LaneClear", "LaneClear")
JayceMenu.LaneClear:Boolean('UseQCannon', 'Use Q [Shock Blast]', true)
JayceMenu.LaneClear:Boolean('UseWCannon', 'Use W [Hyper Charge]', true)
JayceMenu.LaneClear:Boolean('UseECannon', 'Use E [Acceleration Gate]', false)
JayceMenu.LaneClear:Boolean('UseQHammer', 'Use Q [To the Skies!]', false)
JayceMenu.LaneClear:Boolean('UseWHammer', 'Use W [Lightning Field]', true)
JayceMenu.LaneClear:Boolean('UseEHammer', 'Use E [Thundering Blow]', true)
JayceMenu.LaneClear:Slider("MP","Mana-Manager", 40, 0, 100, 5)
JayceMenu:Menu("JungleClear", "JungleClear")
JayceMenu.JungleClear:Boolean('UseQCannon', 'Use Q [Shock Blast]', true)
JayceMenu.JungleClear:Boolean('UseWCannon', 'Use W [Hyper Charge]', true)
JayceMenu.JungleClear:Boolean('UseECannon', 'Use E [Acceleration Gate]', true)
JayceMenu.JungleClear:Boolean('UseQHammer', 'Use Q [To the Skies!]', true)
JayceMenu.JungleClear:Boolean('UseWHammer', 'Use W [Lightning Field]', true)
JayceMenu.JungleClear:Boolean('UseEHammer', 'Use E [Thundering Blow]', true)
JayceMenu:Menu("Interrupter", "Interrupter")
JayceMenu.Interrupter:Boolean('UseEHammer', 'Use E [Thundering Blow]', true)
JayceMenu:Menu("Prediction", "Prediction")
JayceMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
JayceMenu:Menu("Misc", "Misc")
JayceMenu.Misc:Boolean('UI', 'Use Offensive Items', true)
JayceMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
JayceMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 1, {"Q-W-E", "Q-E-W"})

local JayceQCannon = { range = 1000, radius = 80, width = 160, speed = 1450, delay = 0.25, type = "line", collision = true, source = myHero, col = {"minion","champion","yasuowall"}}
local JayceQExhanced = { range = 1470, radius = 110, width = 220, speed = 1890, delay = 0.25, type = "line", collision = true, source = myHero, col = {"minion","champion","yasuowall"}}
local JayceECannon = { range = 650 }
local JayceQHammer = { range = 600 }
local JayceWHammer = { range = 285 }
local JayceEHammer = { range = 240 }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	KillSteal()
	LaneClear()
	JungleClear()
	LevelUp()
end)

OnTick(function(myHero)
	if GetRange(myHero) > 300 then
		local QDmg = (70*GetCastLevel(myHero,_Q)+28)+(1.68*GetBonusDmg(myHero))
		local WDmg = ((0.08*GetCastLevel(myHero,_W)+0.62)*(GetBonusDmg(myHero)+GetBaseDamage(myHero)))*3
		local ComboDmg = QDmg + WDmg
		for _, enemy in pairs(GetEnemyHeroes()) do
			if ValidTarget(enemy) then

			end
		end
	elseif GetRange(myHero) < 300 then
		local QDmg = (35*GetCastLevel(myHero,_Q)+10)+(1.2*GetBonusDmg(myHero))
		local WDmg = (60*GetCastLevel(myHero,_W)+40)+GetBonusAP(myHero)
		local EDmg = ((0.024*GetCastLevel(myHero,_E)+0.056)*GetMaxHP(target))+GetBonusDmg(myHero)
		local ComboDmg = QDmg + WDmg + EDmg
		local WEDmg = WDmg + EDmg
		local QEDmg = QDmg + EDmg
		local QWDmg = QDmg + WDmg
		for _, enemy in pairs(GetEnemyHeroes()) do
			if ValidTarget(enemy) then

			end
		end
	end
end)

function useQCannon(target)
	if GetDistance(target) < JayceQCannon.range then
		if JayceMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif JayceMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),JayceQCannon.speed,JayceQCannon.delay*1000,JayceQCannon.range,JayceQCannon.radius,true,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif JayceMenu.Prediction.PredictionQ:Value() == 3 then
			local qPred = _G.gPred:GetPrediction(target,myHero,JayceQCannon,false,true)
			if qPred and qPred.HitChance >= 3 then
				CastSkillShot(_Q, qPred.CastPosition)
			end
		elseif JayceMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="JayceShockBlast", range=JayceQCannon.range, speed=JayceQCannon.speed, delay=JayceQCannon.delay, width=JayceQCannon.radius, type="linear", collision=true})
			ts = TargetSelector()
			target = ts:GetTarget(JayceQCannon.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif JayceMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetLinearAOEPrediction(target,JayceQCannon)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useEQCannon(target)
	if GetDistance(target) < JayceQExhanced.range then
		if JayceMenu.Prediction.PredictionQ:Value() == 1 then
			local EPos = Vector(myHero)-200*(Vector(myHero)-Vector(target)):normalized()
			CastSkillShot(_E, EPos)
			DelayAction(function() CastSkillShot(_Q,GetOrigin(target)) end, 0.25)
		elseif JayceMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),JayceQExhanced.speed,JayceQExhanced.delay*1000,JayceQExhanced.range,JayceQExhanced.radius,true,true)
			if QPred.HitChance == 1 then
				local EPos = Vector(myHero)-200*(Vector(myHero)-Vector(target)):normalized()
				CastSkillShot(_E, EPos)
				DelayAction(function() CastSkillShot(_Q, QPred.PredPos) end, 0.25)
			end
		elseif JayceMenu.Prediction.PredictionQ:Value() == 3 then
			local qPred = _G.gPred:GetPrediction(target,myHero,JayceQExhanced,false,true)
			if qPred and qPred.HitChance >= 3 then
				local EPos = Vector(myHero)-200*(Vector(myHero)-Vector(target)):normalized()
				CastSkillShot(_E, EPos)
				DelayAction(function() CastSkillShot(_Q, qPred.CastPosition) end, 0.25)
			end
		elseif JayceMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="JayceShockBlastWallMis", range=JayceQExhanced.range, speed=JayceQExhanced.speed, delay=JayceQExhanced.delay, width=JayceQExhanced.radius, type="linear", collision=true})
			ts = TargetSelector()
			target = ts:GetTarget(JayceQExhanced.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				local EPos = Vector(myHero)-200*(Vector(myHero)-Vector(target)):normalized()
				CastSkillShot(_E, EPos)
				DelayAction(function() CastSkillShot(_Q, y.x, y.y, y.z) end, 0.25)
			end
		elseif JayceMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetLinearAOEPrediction(target,JayceQExhanced)
			if QPrediction.hitChance > 0.9 then
				local EPos = Vector(myHero)-200*(Vector(myHero)-Vector(target)):normalized()
				CastSkillShot(_E, EPos)
				DelayAction(function() CastSkillShot(_Q, QPrediction.castPos) end, 0.25)
			end
		end
	end
end
function useWCannon(target)
	CastSpell(_W)
	if _G.IOW then
		IOW:ResetAA()
	elseif _G.GoSWalkLoaded then
		GoSWalk:ResetAttack()
	elseif _G.DAC_Loaded then
		DAC:ResetAA()
	elseif _G.AutoCarry_Loaded then
		DACR:ResetAA()
	end
end
function useQHammer(target)
	CastTargetSpell(target, _Q)
end
function useWHammer(target)
	CastSpell(_W)
end
function useEHammer(target)
	CastTargetSpell(target, _E)
end

-- Auto

function Auto()
	if GetRange(myHero) > 300 then
		if JayceMenu.Auto.UseECannon:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > JayceMenu.Auto.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, JayceQExhanced.range) then
						useEQCannon(target)
					end
				end
			end
		end
		if JayceMenu.Auto.UseQCannon:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > JayceMenu.Auto.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, JayceQCannon.range) then
						useQCannon(target)
					end
				end
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if GetRange(myHero) > 300 then
			if JayceMenu.Combo.UseECannon:Value() then
				if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, JayceQExhanced.range) then
						useEQCannon(target)
					end
				end
			end
			if JayceMenu.Combo.UseQCannon:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, JayceQCannon.range) then
						useQCannon(target)
					end
				end
			end
			if JayceMenu.Combo.UseWCannon:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, GetRange(myHero)+50) then
						useWCannon(target)
					end
				end
			end
		elseif GetRange(myHero) < 300 then
			if JayceMenu.Combo.UseQHammer:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, JayceQHammer.range) then
						useQHammer(target)
					end
				end
			end
			if JayceMenu.Combo.UseWHammer:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, JayceWHammer.range) then
						useWHammer(target)
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if GetRange(myHero) > 300 then
			if JayceMenu.Harass.UseECannon:Value() then
				if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > JayceMenu.Harass.MP:Value() then
					if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) == READY then
						if ValidTarget(target, JayceQExhanced.range) then
							useEQCannon(target)
						end
					end
				end
			end
			if JayceMenu.Harass.UseQCannon:Value() then
				if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > JayceMenu.Harass.MP:Value() then
					if CanUseSpell(myHero,_Q) == READY then
						if ValidTarget(target, JayceQCannon.range) then
							useQCannon(target)
						end
					end
				end
			end
			if JayceMenu.Harass.UseWCannon:Value() then
				if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > JayceMenu.Harass.MP:Value() then
					if CanUseSpell(myHero,_W) == READY then
						if ValidTarget(target, GetRange(myHero)+50) then
							useWCannon(target)
						end
					end
				end
			end
		elseif GetRange(myHero) < 300 then
			if JayceMenu.Harass.UseQHammer:Value() then
				if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > JayceMenu.Harass.MP:Value() then
					if CanUseSpell(myHero,_Q) == READY then
						if ValidTarget(target, JayceQHammer.range) then
							useQHammer(target)
						end
					end
				end
			end
			if JayceMenu.Harass.UseWHammer:Value() then
				if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > JayceMenu.Harass.MP:Value() then
					if CanUseSpell(myHero,_W) == READY then
						if ValidTarget(target, JayceWHammer.range) then
							useWHammer(target)
						end
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if GetRange(myHero) > 300 then
			if JayceMenu.KillSteal.UseECannon:Value() then
				if ValidTarget(enemy, JayceQExhanced.range) then
					if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) == READY then
						local JayceEQDmg = (70*GetCastLevel(myHero,_Q)+28)+(1.68*GetBonusDmg(myHero))
						if GetCurrentHP(enemy)+GetArmor(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2 < JayceEQDmg then
							useEQCannon(enemy)
						end
					end
				end
			end
			if JayceMenu.KillSteal.UseQCannon:Value() then
				if ValidTarget(enemy, JayceQCannon.range) then
					if CanUseSpell(myHero,_Q) == READY then
						local JayceQDmg = (50*GetCastLevel(myHero,_Q)+20)+(1.2*GetBonusDmg(myHero))
						if GetCurrentHP(enemy)+GetArmor(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2 < JayceQDmg then
							useQCannon(enemy)
						end
					end
				end
			end
		else
			if JayceMenu.KillSteal.UseEHammer:Value() then
				if ValidTarget(enemy, JayceEHammer.range) then
					if CanUseSpell(myHero,_E) == READY then
						local JayceEDmg = ((0.024*GetCastLevel(myHero,_E)+0.056)*GetMaxHP(target))+GetBonusDmg(myHero)
						if GetCurrentHP(enemy)+GetArmor(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2 < JayceEDmg then
							useEHammer(enemy)
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if GetRange(myHero) > 300 then
					if JayceMenu.LaneClear.UseECannon:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > JayceMenu.LaneClear.MP:Value() then
							if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) == READY then
								if ValidTarget(minion, JayceQExhanced.range) then
									local EPos = Vector(myHero)-100*(Vector(myHero)-Vector(minion)):normalized()
									CastSkillShot(_E, EPos)
									CastSkillShot(_Q, GetOrigin(minion))
								end
							end
						end
					end
					if JayceMenu.LaneClear.UseQCannon:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > JayceMenu.LaneClear.MP:Value() then
							if CanUseSpell(myHero,_Q) == READY then
								if ValidTarget(minion, JayceQCannon.range) then
									CastSkillShot(_Q, GetOrigin(minion))
								end
							end
						end
					end
					if JayceMenu.LaneClear.UseWCannon:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > JayceMenu.LaneClear.MP:Value() then
							if CanUseSpell(myHero,_W) == READY then
								if ValidTarget(minion, GetRange(myHero)+50) then
									useWCannon(minion)
								end
							end
						end
					end
				elseif GetRange(myHero) < 300 then
					if JayceMenu.LaneClear.UseQHammer:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > JayceMenu.LaneClear.MP:Value() then
							if CanUseSpell(myHero,_Q) == READY then
								if ValidTarget(minion, JayceQHammer.range) then
									useQHammer(minion)
								end
							end
						end
					end
					if JayceMenu.LaneClear.UseWHammer:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > JayceMenu.LaneClear.MP:Value() then
							if CanUseSpell(myHero,_W) == READY then
								if ValidTarget(minion, JayceWHammer.range) then
									useWHammer(minion)
								end
							end
						end
					end
					if JayceMenu.LaneClear.UseEHammer:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > JayceMenu.LaneClear.MP:Value() then
							if CanUseSpell(myHero,_E) == READY then
								if ValidTarget(minion, JayceEHammer.range) then
									useEHammer(minion)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if GetRange(myHero) > 300 then
					if JayceMenu.JungleClear.UseECannon:Value() then
						if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) == READY then
							if ValidTarget(mob, JayceQExhanced.range) then
								local EPos = Vector(myHero)-100*(Vector(myHero)-Vector(mob)):normalized()
								CastSkillShot(_E, EPos)
								CastSkillShot(_Q, GetOrigin(mob))
							end
						end
					end
					if JayceMenu.JungleClear.UseQCannon:Value() then
						if CanUseSpell(myHero,_Q) == READY then
							if ValidTarget(mob, JayceQCannon.range) then
								CastSkillShot(_Q, GetOrigin(mob))
							end
						end
					end
					if JayceMenu.JungleClear.UseWCannon:Value() then
						if CanUseSpell(myHero,_W) == READY then
							if ValidTarget(mob, GetRange(myHero)+50) then
								useWCannon(mob)
							end
						end
					end
				elseif GetRange(myHero) < 300 then
					if JayceMenu.JungleClear.UseQHammer:Value() then
						if CanUseSpell(myHero,_Q) == READY then
							if ValidTarget(mob, JayceQHammer.range) then
								useQHammer(mob)
							end
						end
					end
					if JayceMenu.JungleClear.UseWHammer:Value() then
						if CanUseSpell(myHero,_W) == READY then
							if ValidTarget(mob, JayceWHammer.range) then
								useWHammer(mob)
							end
						end
					end
					if JayceMenu.JungleClear.UseEHammer:Value() then
						if CanUseSpell(myHero,_E) == READY then
							if ValidTarget(mob, JayceEHammer.range) then
								useEHammer(mob)
							end
						end
					end
				end
			end
		end
	end
end

-- Interrupter

OnProcessSpell(function(unit, spell)
	if JayceMenu.Interrupter.UseEHammer:Value() then
		for _, enemy in pairs(GetEnemyHeroes()) do
			if ValidTarget(enemy, JayceEHammer.range) then
				if CanUseSpell(myHero,_E) == READY then
					local UnitName = GetObjectName(enemy)
					local UnitChanellingSpells = CHANELLING_SPELLS[UnitName]
					local UnitGapcloserSpells = GAPCLOSER_SPELLS[UnitName]
					if UnitChanellingSpells then
						for _, slot in pairs(UnitChanellingSpells) do
							if spell.name == GetCastName(enemy, slot) then useEHammer(enemy) end
						end
					elseif UnitGapcloserSpells then
						for _, slot in pairs(UnitGapcloserSpells) do
							if spell.name == GetCastName(enemy, slot) then useEHammer(enemy) end
						end
					end
				end
			end
		end
    end
end)

-- Misc

function LevelUp()
	if JayceMenu.Misc.LvlUp:Value() then
		if JayceMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _W, _Q, _W, _Q, _W, _Q, _W, _W, _E, _E, _E, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif JayceMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _E, _Q, _E, _Q, _E, _Q, _E, _E, _W, _W, _W, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

OnTick(function(myHero)
	if Mode() == "Combo" then
		if JayceMenu.Misc.UI:Value() then
			if GetItemSlot(myHero, 3074) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3074)) == READY then
					CastSpell(GetItemSlot(myHero, 3074))
				end -- Ravenous Hydra
			end
			if GetItemSlot(myHero, 3077) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3077)) == READY then
					CastSpell(GetItemSlot(myHero, 3077))
				end -- Tiamat
			end
			if GetItemSlot(myHero, 3144) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3144)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3144))
					end -- Bilgewater Cutlass
				end
			end
			if GetItemSlot(myHero, 3146) >= 1 and ValidTarget(target, 700) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3146)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3146))
					end -- Hextech Gunblade
				end
			end
			if GetItemSlot(myHero, 3153) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3153)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3153))
					end -- BOTRK
				end
			end
			if GetItemSlot(myHero, 3748) >= 1 and ValidTarget(target, 300) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero,GetItemSlot(myHero, 3748)) == READY then
						CastSpell(GetItemSlot(myHero, 3748))
					end -- Titanic Hydra
				end
			end
		end
	end
end)

-- Katarina

elseif "Katarina" == GetObjectName(myHero) then

local Dagger = {}

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Katarina loaded successfully!")
local KatarinaMenu = Menu("[T01] Katarina", "[T01] Katarina")
KatarinaMenu:Menu("Auto", "Auto")
KatarinaMenu.Auto:Boolean('UseQ', 'Use Q [Bouncing Blade]', true)
KatarinaMenu.Auto:Boolean('UseW', 'Use W [Preparation]', true)
KatarinaMenu:Menu("Combo", "Combo")
KatarinaMenu.Combo:Boolean('UseQ', 'Use Q [Bouncing Blade]', true)
KatarinaMenu.Combo:Boolean('UseW', 'Use W [Preparation]', true)
KatarinaMenu.Combo:Boolean('UseE', 'Use E [Shunpo]', true)
KatarinaMenu.Combo:Boolean('UseR', 'Use R [Death Lotus]', true)
KatarinaMenu.Combo:Boolean('CD', 'Teleport To Diggers', true)
KatarinaMenu:Menu("Harass", "Harass")
KatarinaMenu.Harass:Boolean('UseQ', 'Use Q [Bouncing Blade]', true)
KatarinaMenu.Harass:Boolean('UseW', 'Use W [Preparation]', true)
KatarinaMenu.Harass:Boolean('UseE', 'Use E [Shunpo]', true)
KatarinaMenu.Harass:Boolean('CD', 'Teleport To Diggers', true)
KatarinaMenu:Menu("KillSteal", "KillSteal")
KatarinaMenu.KillSteal:Boolean('UseE', 'Use E [Shunpo]', true)
KatarinaMenu:Menu("LastHit", "LastHit")
KatarinaMenu.LastHit:Boolean('UseQ', 'Use Q [Bouncing Blade]', true)
KatarinaMenu:Menu("LaneClear", "LaneClear")
KatarinaMenu.LaneClear:Boolean('UseQ', 'Use Q [Bouncing Blade]', true)
KatarinaMenu.LaneClear:Boolean('UseW', 'Use W [Preparation]', true)
KatarinaMenu.LaneClear:Boolean('UseE', 'Use E [Shunpo]', true)
KatarinaMenu:Menu("JungleClear", "JungleClear")
KatarinaMenu.JungleClear:Boolean('UseQ', 'Use Q [Bouncing Blade]', true)
KatarinaMenu.JungleClear:Boolean('UseW', 'Use W [Preparation]', true)
KatarinaMenu.JungleClear:Boolean('UseE', 'Use E [Shunpo]', true)
KatarinaMenu:Menu("Prediction", "Prediction")
KatarinaMenu.Prediction:DropDown("PredictionE", "Prediction: E", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
KatarinaMenu:Menu("Misc", "Misc")
KatarinaMenu.Misc:Boolean('UI', 'Use Offensive Items', true)
KatarinaMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
KatarinaMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 2, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
KatarinaMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
KatarinaMenu.Misc:Slider('HP','HP-Manager: R', 40, 0, 100, 5)

local KatarinaQ = { range = 625 }
local KatarinaW = { range = 340 }
local KatarinaE = { range = 725, radius = 150, width = 150, speed = math.huge, delay = 0.15, type = "circular", collision = false, source = myHero }
local KatarinaR = { range = 550 }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	KillSteal()
	LastHit()
	LaneClear()
	JungleClear()
	LevelUp()
end)

function useQ(target)
	CastTargetSpell(target, _Q)
end
function useW(target)
	CastSpell(_W)
end
function useE(target)
	if GetDistance(target) < KatarinaE.range then
		if KatarinaMenu.Prediction.PredictionE:Value() == 1 then
			CastSkillShot(_E,GetOrigin(target))
		elseif KatarinaMenu.Prediction.PredictionE:Value() == 2 then
			local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),KatarinaE.speed,KatarinaE.delay*1000,KatarinaE.range,KatarinaE.width,false,true)
			if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
			end
		elseif KatarinaMenu.Prediction.PredictionE:Value() == 3 then
			local EPred = _G.gPred:GetPrediction(target,myHero,KatarinaE,true,false)
			if EPred and EPred.HitChance >= 3 then
				CastSkillShot(_W, WPred.CastPosition)
			end
		elseif KatarinaMenu.Prediction.PredictionE:Value() == 4 then
			local WSpell = IPrediction.Prediction({name="KatarinaE", range=KatarinaE.range, speed=KatarinaE.speed, delay=KatarinaE.delay, width=KatarinaE.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(KatarinaE.range)
			local x, y = ESpell:Predict(target)
			if x > 2 then
				CastSkillShot(_E, y.x, y.y, y.z)
			end
		elseif KatarinaMenu.Prediction.PredictionE:Value() == 5 then
			local EPrediction = GetCircularAOEPrediction(target,KatarinaE)
			if EPrediction.hitChance > 0.9 then
				CastSkillShot(_E, EPrediction.castPos)
			end
		end
	end
end
function useECD(target)
	for _,Sztylet in pairs(Dagger) do
		if GetDistance(Sztylet, target) < KatarinaW.range then
			CastSkillShot(_E,GetOrigin(target) + (VectorWay(GetOrigin(target),GetOrigin(Sztylet))):normalized()*150)
		end
	end
end
function useR(target)
	if 100*GetCurrentHP(target)/GetMaxHP(target) < KatarinaMenu.Misc.HP:Value() then
		if EnemiesAround(myHero, KatarinaR.range) >= KatarinaMenu.Misc.X:Value() then
			CastSpell(_R)
		end
	end
end

OnTick(function(myHero)
	if GotBuff(myHero,"katarinarsound") > 0 then
		if EnemiesAround(myHero, KatarinaR.range) >= 1 then
			BlockF7OrbWalk(true)
			BlockF7Dodge(true)
			BlockInput(true)
			if _G.IOW then
				IOW.movementEnabled = false
				IOW.attacksEnabled = false
			elseif _G.GoSWalkLoaded then
				_G.GoSWalk:EnableMovement(false)
				_G.GoSWalk:EnableAttack(false)
			elseif _G.DAC_Loaded then
				DAC:MovementEnabled(false)
				DAC:AttacksEnabled(false)
			elseif _G.AutoCarry_Loaded then
				DACR.movementEnabled = false
				DACR.attacksEnabled = false
			end
		else
			BlockF7OrbWalk(false)
			BlockF7Dodge(false)
			BlockInput(false)
			if _G.IOW then
				IOW.movementEnabled = true
				IOW.attacksEnabled = true
			elseif _G.GoSWalkLoaded then
				_G.GoSWalk:EnableMovement(true)
				_G.GoSWalk:EnableAttack(true)
			elseif _G.DAC_Loaded then
				DAC:MovementEnabled(true)
				DAC:AttacksEnabled(true)
			elseif _G.AutoCarry_Loaded then
				DACR.movementEnabled = true
				DACR.attacksEnabled = true
			end
		end
	else
		BlockF7OrbWalk(false)
		BlockF7Dodge(false)
		BlockInput(false)
		if _G.IOW then
			IOW.movementEnabled = true
			IOW.attacksEnabled = true
		elseif _G.GoSWalkLoaded then
			_G.GoSWalk:EnableMovement(true)
			_G.GoSWalk:EnableAttack(true)
		elseif _G.DAC_Loaded then
			DAC:MovementEnabled(true)
			DAC:AttacksEnabled(true)
		elseif _G.AutoCarry_Loaded then
			DACR.movementEnabled = true
			DACR.attacksEnabled = true
		end
	end
end)
OnSpellCast(function(_Q)
	if GotBuff(myHero,"katarinarsound") > 0 then
		BlockCast()
	end
end)
OnSpellCast(function(_W)
	if GotBuff(myHero,"katarinarsound") > 0 then
		BlockCast()
	end
end)
OnSpellCast(function(_E)
	if GotBuff(myHero,"katarinarsound") > 0 then
		BlockCast()
	end
end)

OnCreateObj(function(Object)
	if GetObjectBaseName(Object) == "HiddenMinion" then
		table.insert(Dagger, Object)
		DelayAction(function() table.remove(Dagger, 1) end, 4)
	end
end)
OnDeleteObj(function(Object)
	if GetObjectBaseName(Object) == "HiddenMinion" then
		for i in pairs(Dagger) do
			if GetNetworkID(Object) == GetNetworkID(myHero) then
				table.remove(Dagger,i) 
			end
		end
	end
end)
OnObjectLoad(function(Object)
	if GetObjectBaseName(Object) == "Katarina_Base_W_Indicator_Ally" then
		Dagger = Object
	end
end)
OnCreateObj(function(Object)
	if GetObjectBaseName(Object) == "Katarina_Base_W_Indicator_Ally" then
		Dagger = Object
	end
end)

-- Auto

function Auto()
	if KatarinaMenu.Auto.UseQ:Value() then
		if CanUseSpell(myHero,_Q) == READY then
			if ValidTarget(target, KatarinaQ.range) then
				useQ(target)
			end
		end
	end
	if KatarinaMenu.Auto.UseW:Value() then
		if CanUseSpell(myHero,_W) == READY then
			if ValidTarget(target, KatarinaW.range) then
				useW(target)
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if KatarinaMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, KatarinaQ.range) then
					useQ(target)
				end
			end
		end
		if KatarinaMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, KatarinaW.range) then
					useW(target)
				end
			end
		end
		if KatarinaMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, KatarinaE.range) then
					if KatarinaMenu.Combo.CD:Value() then
						useECD(target)
					else
						useE(target)
					end
				end
			end
		end
		if KatarinaMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, KatarinaR.range-350) then
					if 100*GetCurrentHP(target)/GetMaxHP(target) < KatarinaMenu.Misc.HP:Value() then
						if EnemiesAround(myHero, KatarinaR.range) >= KatarinaMenu.Misc.X:Value() then
							useR(target)
							BlockF7OrbWalk(true)
							BlockF7Dodge(true)
							BlockInput(true)
							if _G.IOW then
								IOW.movementEnabled = false
								IOW.attacksEnabled = false
							elseif _G.GoSWalkLoaded then
								_G.GoSWalk:EnableMovement(false)
								_G.GoSWalk:EnableAttack(false)
							elseif _G.DAC_Loaded then
								DAC:MovementEnabled(false)
								DAC:AttacksEnabled(false)
							elseif _G.AutoCarry_Loaded then
								DACR.movementEnabled = false
								DACR.attacksEnabled = false
							end
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if KatarinaMenu.Harass.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, KatarinaQ.range) then
					useQ(target)
				end
			end
		end
		if KatarinaMenu.Harass.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, KatarinaW.range) then
					useW(target)
				end
			end
		end
		if KatarinaMenu.Harass.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, KatarinaE.range) then
					if KatarinaMenu.Harass.CD:Value() then
						useECD(target)
					else
						useE(target)
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if KatarinaMenu.KillSteal.UseE:Value() then
			if ValidTarget(enemy, KatarinaE.range) then
				if CanUseSpell(myHero,_E) == READY then
					local KatarinaEDmg = (15*GetCastLevel(myHero,_E))+(0.5*(GetBonusDmg(myHero)+GetBaseDamage(myHero)))+(0.25*GetBonusAP(myHero))
					if GetCurrentHP(enemy)+GetArmor(enemy)+GetDmgShield(enemy)+GetMagicResist(enemy)+GetMagicShield(enemy)+GetHPRegen(enemy)*2 < KatarinaEDmg then
						useE(enemy)
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, KatarinaQ.range) then
					if KatarinaMenu.LastHit.UseQ:Value() then
						if CanUseSpell(myHero,_Q) == READY then
							local KatarinaQDmg = (30*GetCastLevel(myHero,_Q)+45)+(0.3*GetBonusAP(myHero))
							if GetCurrentHP(minion) < KatarinaQDmg then
								useQ(minion)
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if KatarinaMenu.LaneClear.UseQ:Value() then
					if ValidTarget(minion, KatarinaQ.range) then
						if KatarinaMenu.LaneClear.UseQ:Value() then
							if CanUseSpell(myHero,_Q) == READY then
								useQ(minion)
							end
						end
					end
				end
				if KatarinaMenu.LaneClear.UseW:Value() then
					if ValidTarget(minion, KatarinaW.range) then
						if KatarinaMenu.LaneClear.UseW:Value() then
							if CanUseSpell(myHero,_W) == READY then
								useW(minion)
							end
						end
					end
				end
				if KatarinaMenu.LaneClear.UseE:Value() then
					if ValidTarget(minion, KatarinaE.range) then
						if KatarinaMenu.LaneClear.UseE:Value() then
							if CanUseSpell(myHero,_E) == READY then
								CastSkillShot(_E,GetOrigin(minion))
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, KatarinaQ.range) then
						if KatarinaMenu.JungleClear.UseQ:Value() then
							useQ(mob)
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, KatarinaW.range) then
						if KatarinaMenu.JungleClear.UseW:Value() then
							useW(mob)
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, KatarinaE.range) then
						if KatarinaMenu.JungleClear.UseE:Value() then
							CastSkillShot(_E,GetOrigin(minion))
						end
					end
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if Mode() == "Combo" then
		if KatarinaMenu.Misc.UI:Value() then
			if GetItemSlot(myHero, 3074) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3074)) == READY then
					CastSpell(GetItemSlot(myHero, 3074))
				end -- Ravenous Hydra
			end
			if GetItemSlot(myHero, 3077) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3077)) == READY then
					CastSpell(GetItemSlot(myHero, 3077))
				end -- Tiamat
			end
			if GetItemSlot(myHero, 3144) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3144)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3144))
					end -- Bilgewater Cutlass
				end
			end
			if GetItemSlot(myHero, 3146) >= 1 and ValidTarget(target, 700) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3146)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3146))
					end -- Hextech Gunblade
				end
			end
			if GetItemSlot(myHero, 3153) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3153)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3153))
					end -- BOTRK
				end
			end
			if GetItemSlot(myHero, 3748) >= 1 and ValidTarget(target, 300) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero,GetItemSlot(myHero, 3748)) == READY then
						CastSpell(GetItemSlot(myHero, 3748))
					end -- Titanic Hydra
				end
			end
		end
	end
end)

function LevelUp()
	if KatarinaMenu.Misc.LvlUp:Value() then
		if KatarinaMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif KatarinaMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif KatarinaMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif KatarinaMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif KatarinaMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif KatarinaMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

function VectorWay(A,B)
	WayX = B.x - A.x
	WayY = B.y - A.y
	WayZ = B.z - A.z
	return Vector(WayX, WayY, WayZ)
end

-- Leblanc

elseif "Leblanc" == GetObjectName(myHero) then

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Leblanc loaded successfully!")
local LeblancMenu = Menu("[T01] Leblanc", "[T01] Leblanc")
LeblancMenu:Menu("Auto", "Auto")
LeblancMenu.Auto:Boolean('UseQ', 'Use Q [Sigil of Malice]', true)
LeblancMenu.Auto:Boolean('UseE', 'Use E [Ethereal Chains]', false)
LeblancMenu.Auto:Slider("MP","Mana-Manager", 40, 0, 100, 5)
LeblancMenu:Menu("Combo", "Combo")
LeblancMenu.Combo:Boolean('UseQ', 'Use Q [Sigil of Malice]', true)
LeblancMenu.Combo:Boolean('UseW', 'Use W [Distortion]', true)
LeblancMenu.Combo:Boolean('UseE', 'Use E [Ethereal Chains]', true)
LeblancMenu.Combo:Boolean('UseR', 'Use R [Mimic]', true)
LeblancMenu.Combo:DropDown("ModeW", "Cast Mode: W", 2, {"Mouse Position", "Predicted Position"})
LeblancMenu:Menu("Harass", "Harass")
LeblancMenu.Harass:Boolean('UseQ', 'Use Q [Sigil of Malice]', true)
LeblancMenu.Harass:Boolean('UseW', 'Use W [Distortion]', true)
LeblancMenu.Harass:Boolean('UseE', 'Use E [Ethereal Chains]', true)
LeblancMenu.Harass:DropDown("ModeW", "Cast Mode: W", 2, {"Mouse Position", "Predicted Position"})
LeblancMenu.Harass:Slider("MP","Mana-Manager", 40, 0, 100, 5)
LeblancMenu:Menu("LastHit", "LastHit")
LeblancMenu.LastHit:Boolean('UseQ', 'Use Q [Sigil of Malice]', true)
LeblancMenu.LastHit:Slider("MP","Mana-Manager", 40, 0, 100, 5)
LeblancMenu:Menu("LaneClear", "LaneClear")
LeblancMenu.LaneClear:Boolean('UseQ', 'Use Q [Sigil of Malice]', false)
LeblancMenu.LaneClear:Boolean('UseW', 'Use W [Distortion]', true)
LeblancMenu.LaneClear:Boolean('UseE', 'Use E [Ethereal Chains]', true)
LeblancMenu.LaneClear:Slider("MP","Mana-Manager", 40, 0, 100, 5)
LeblancMenu:Menu("JungleClear", "JungleClear")
LeblancMenu.JungleClear:Boolean('UseQ', 'Use Q [Sigil of Malice]', true)
LeblancMenu.JungleClear:Boolean('UseW', 'Use W [Distortion]', true)
LeblancMenu.JungleClear:Boolean('UseE', 'Use E [Ethereal Chains]', true)
LeblancMenu:Menu("AntiGapcloser", "Anti-Gapcloser")
LeblancMenu.AntiGapcloser:Boolean('UseE', 'Use E [Ethereal Chains]', true)
LeblancMenu:Menu("Interrupter", "Interrupter")
LeblancMenu.Interrupter:Boolean('UseE', 'Use E [Ethereal Chains]', true)
LeblancMenu:Menu("Prediction", "Prediction")
LeblancMenu.Prediction:DropDown("PredictionW", "Prediction: W", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
LeblancMenu.Prediction:DropDown("PredictionE", "Prediction: E", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
LeblancMenu:Menu("Misc", "Misc")
LeblancMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
LeblancMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 1, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
LeblancMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
LeblancMenu.Misc:Slider('HP','HP-Manager: R', 40, 0, 100, 5)

local LeblancQ = { range = 700 }
local LeblancW = { range = 600, radius = 260, width = 260, speed = 1450, delay = 0, type = "circular", collision = false, source = myHero }
local LeblancE = { range = 925, radius = 55, width = 55, speed = 1750, delay = 0.25, type = "line", collision = true, source = myHero, col = {"minion","champion","yasuowall"}}

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	LastHit()
	LaneClear()
	JungleClear()
	AntiGapcloser()
	LevelUp()
end)

function useQ(target)
	CastTargetSpell(target, _Q)
end
function useW(target)
	if GetDistance(target) < LeblancW.range then
		if LeblancMenu.Prediction.PredictionW:Value() == 1 then
			CastSkillShot(_W,GetOrigin(target))
		elseif LeblancMenu.Prediction.PredictionW:Value() == 2 then
			local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),LeblancW.speed,LeblancW.delay*1000,LeblancW.range,LeblancW.width,false,true)
			if WPred.HitChance == 1 then
				CastSkillShot(_W, WPred.PredPos)
			end
		elseif LeblancMenu.Prediction.PredictionW:Value() == 3 then
			local WPred = _G.gPred:GetPrediction(target,myHero,LeblancW,true,false)
			if WPred and WPred.HitChance >= 3 then
				CastSkillShot(_W, WPred.CastPosition)
			end
		elseif LeblancMenu.Prediction.PredictionW:Value() == 4 then
			local WSpell = IPrediction.Prediction({name="LeblancW", range=LeblancW.range, speed=LeblancW.speed, delay=LeblancW.delay, width=LeblancW.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(LeblancW.range)
			local x, y = WSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_W, y.x, y.y, y.z)
			end
		elseif LeblancMenu.Prediction.PredictionW:Value() == 5 then
			local WPrediction = GetCircularAOEPrediction(target,LeblancW)
			if WPrediction.hitChance > 0.9 then
				CastSkillShot(_W, WPrediction.castPos)
			end
		end
	end
end
function useRW(target)
	if GetDistance(target) < LeblancW.range then
		if LeblancMenu.Prediction.PredictionW:Value() == 1 then
			CastSkillShot(_R,GetOrigin(target))
		elseif LeblancMenu.Prediction.PredictionW:Value() == 2 then
			local RPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),LeblancW.speed,LeblancW.delay*1000,LeblancW.range,LeblancW.width,false,true)
			if RPred.HitChance == 1 then
				CastSkillShot(_R, WPred.PredPos)
			end
		elseif LeblancMenu.Prediction.PredictionW:Value() == 3 then
			local RPred = _G.gPred:GetPrediction(target,myHero,LeblancW,true,false)
			if RPred and RPred.HitChance >= 3 then
				CastSkillShot(_R, RPred.CastPosition)
			end
		elseif LeblancMenu.Prediction.PredictionW:Value() == 4 then
			local RSpell = IPrediction.Prediction({name="LeblancRW", range=LeblancW.range, speed=LeblancW.speed, delay=LeblancW.delay, width=LeblancW.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(LeblancW.range)
			local x, y = RSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_R, y.x, y.y, y.z)
			end
		elseif LeblancMenu.Prediction.PredictionW:Value() == 5 then
			local RPrediction = GetCircularAOEPrediction(target,LeblancW)
			if RPrediction.hitChance > 0.9 then
				CastSkillShot(_R, RPrediction.castPos)
			end
		end
	end
end
function useE(target)
	if GetDistance(target) < LeblancE.range then
		if LeblancMenu.Prediction.PredictionE:Value() == 1 then
			CastSkillShot(_E,GetOrigin(target))
		elseif LeblancMenu.Prediction.PredictionE:Value() == 2 then
			local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),LeblancE.speed,LeblancE.delay*1000,LeblancE.range,LeblancE.width,true,true)
			if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
			end
		elseif LeblancMenu.Prediction.PredictionE:Value() == 3 then
			local EPred = _G.gPred:GetPrediction(target,myHero,LeblancE,false,true)
			if EPred and EPred.HitChance >= 3 then
				CastSkillShot(_E, EPred.CastPosition)
			end
		elseif LeblancMenu.Prediction.PredictionE:Value() == 4 then
			local ESpell = IPrediction.Prediction({name="LeblancE", range=LeblancE.range, speed=LeblancE.speed, delay=LeblancE.delay, width=LeblancE.width, type="linear", collision=true})
			ts = TargetSelector()
			target = ts:GetTarget(LeblancE.range)
			local x, y = ESpell:Predict(target)
			if x > 2 then
				CastSkillShot(_E, y.x, y.y, y.z)
			end
		elseif LeblancMenu.Prediction.PredictionE:Value() == 5 then
			local EPrediction = GetLinearAOEPrediction(target,LeblancE)
			if EPrediction.hitChance > 0.9 then
				CastSkillShot(_E, EPrediction.castPos)
			end
		end
	end
end
function useRE(target)
	if GetDistance(target) < LeblancE.range then
		if LeblancMenu.Prediction.PredictionE:Value() == 1 then
			CastSkillShot(_R,GetOrigin(target))
		elseif LeblancMenu.Prediction.PredictionE:Value() == 2 then
			local RPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),LeblancE.speed,LeblancE.delay*1000,LeblancE.range,LeblancE.width,true,true)
			if RPred.HitChance == 1 then
				CastSkillShot(_R, RPred.PredPos)
			end
		elseif LeblancMenu.Prediction.PredictionE:Value() == 3 then
			local RPred = _G.gPred:GetPrediction(target,myHero,LeblancE,false,true)
			if RPred and RPred.HitChance >= 3 then
				CastSkillShot(_R, RPred.CastPosition)
			end
		elseif LeblancMenu.Prediction.PredictionE:Value() == 4 then
			local RSpell = IPrediction.Prediction({name="LeblancRE", range=LeblancE.range, speed=LeblancE.speed, delay=LeblancE.delay, width=LeblancE.width, type="linear", collision=true})
			ts = TargetSelector()
			target = ts:GetTarget(LeblancE.range)
			local x, y = RSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_R, y.x, y.y, y.z)
			end
		elseif LeblancMenu.Prediction.PredictionE:Value() == 5 then
			local RPrediction = GetLinearAOEPrediction(target,LeblancE)
			if RPrediction.hitChance > 0.9 then
				CastSkillShot(_R, EPrediction.castPos)
			end
		end
	end
end

-- Auto

function Auto()
	if LeblancMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > LeblancMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, LeblancQ.range) then
					useQ(target)
				end
			end
		end
	end
	if LeblancMenu.Auto.UseE:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > LeblancMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, LeblancE.range) then
					useE(target)
				end
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if LeblancMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, LeblancQ.range) then
					useQ(target)
				end
			end
		end
		if LeblancMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, LeblancW.range) then
					if GotBuff(myHero, "LeblancW") == 0 then
						if LeblancMenu.Combo.ModeW:Value() == 1 then
							CastSkillShot(_W, GetMousePos())
						elseif LeblancMenu.Combo.ModeW:Value() == 2 then
							useW(target)
						end
					end
				end
			end
		end
		if LeblancMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, LeblancE.range) then
					useE(target)
				end
			end
		end
		if LeblancMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, LeblancE.range) then
					if 100*GetCurrentHP(target)/GetMaxHP(target) < LeblancMenu.Misc.HP:Value() then
						if EnemiesAround(myHero, LeblancE.range) >= LeblancMenu.Misc.X:Value() then
							if GetCastRange(myHero, _R) > 651 and GetCastRange(myHero, _R) < 799 then
								CastTargetSpell(target, _R)
							elseif GetCastRange(myHero, _R) < 650 then
								if GotBuff(myHero, "LeblancRW") == 0 then
									if LeblancMenu.Harass.ModeW:Value() == 1 then
										CastSkillShot(_R, GetMousePos())
									elseif LeblancMenu.Harass.ModeW:Value() == 2 then
										useRW(target)
									end
								end
							elseif GetCastRange(myHero, _R) > 800 then
								useRE(target)
							end
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if LeblancMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > LeblancMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, LeblancQ.range) then
						useQ(target)
					end
				end
			end
		end
		if LeblancMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > LeblancMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, LeblancW.range) then
						if GotBuff(myHero, "LeblancW") == 0 then
							if LeblancMenu.Harass.ModeW:Value() == 1 then
								CastSkillShot(_W, GetMousePos())
							elseif LeblancMenu.Harass.ModeW:Value() == 2 then
								useW(target)
							end
						end
					end
				end
			end
		end
		if LeblancMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > LeblancMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, LeblancE.range) then
						useE(target)
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, LeblancQ.range) then
					if LeblancMenu.LastHit.UseQ:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > LeblancMenu.LastHit.MP:Value() then
							if CanUseSpell(myHero,_Q) == READY then
								local LeblancQDmg = (25*GetCastLevel(myHero,_Q)+30)+(0.4*GetBonusAP(myHero))
								if GetCurrentHP(minion) < LeblancQDmg then
									useQ(minion)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if LeblancMenu.LaneClear.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > LeblancMenu.LaneClear.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					local BestPos, BestHit = GetLineFarmPosition(LeblancW.range, LeblancW.radius, MINION_ENEMY)
					if BestPos and BestHit > 3 then  
						CastSkillShot(_W, BestPos)
					end
				end
			end
		end
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > LeblancMenu.LaneClear.MP:Value() then
			for _, minion in pairs(minionManager.objects) do
				if GetTeam(minion) == MINION_ENEMY then
					if CanUseSpell(myHero,_Q) == READY then
						if ValidTarget(minion, LeblancQ.range) then
							if LeblancMenu.LaneClear.UseQ:Value() then
								useQ(minion)
							end
						end
					elseif CanUseSpell(myHero,_E) == READY then
						if ValidTarget(minion, LeblancE.range) then
							if LeblancMenu.LaneClear.UseE:Value() then
								CastSkillShot(_E, minion)
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, LeblancQ.range) then
						if LeblancMenu.JungleClear.UseQ:Value() then
							useQ(mob)
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, LeblancW.range) then
						if LeblancMenu.JungleClear.UseW:Value() then	   
							CastSkillShot(_W,GetOrigin(mob))
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, LeblancE.range) then
						if LeblancMenu.JungleClear.UseE:Value() then	   
							CastSkillShot(_E,GetOrigin(mob))
						end
					end
				end
			end
		end
	end
end

-- Anti-Gapcloser

function AntiGapcloser()
	for i,antigap in pairs(GetEnemyHeroes()) do
		if LeblancMenu.AntiGapcloser.UseE:Value() then
			if ValidTarget(antigap, 400) then
				if CanUseSpell(myHero,_E) == READY then
					CastSkillShot(_E, myHero)
				end
			end
		end
	end
end

-- Interrupter

OnProcessSpell(function(unit, spell)
	if LeblancMenu.Interrupter.UseE:Value() then
		for _, enemy in pairs(GetEnemyHeroes()) do
			if ValidTarget(enemy, LeblancE.range) then
				if CanUseSpell(myHero,_E) == READY then
					local UnitName = GetObjectName(enemy)
					local UnitChanellingSpells = CHANELLING_SPELLS[UnitName]
					local UnitGapcloserSpells = GAPCLOSER_SPELLS[UnitName]
					if UnitGapcloserSpells then
						for _, slot in pairs(UnitGapcloserSpells) do
							if spell.name == GetCastName(enemy, slot) then useE(enemy) end
						end
					end
				end
			end
		end
    end
end)

-- Misc

function LevelUp()
	if LeblancMenu.Misc.LvlUp:Value() then
		if LeblancMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif LeblancMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif LeblancMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif LeblancMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif LeblancMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif LeblancMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- MasterYi

elseif "MasterYi" == GetObjectName(myHero) then

if not pcall( require, "AntiDangerousSpells" ) then PrintChat("<font color='#00BFFF'>AntiDangerousSpells.lua not detected! Probably incorrect file name or doesnt exist in Common folder!") return end

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>MasterYi loaded successfully!")
local MasterYiMenu = Menu("[T01] MasterYi", "[T01] MasterYi")
MasterYiMenu:Menu("Auto", "Auto")
MasterYiMenu.Auto:Boolean('UseQ', 'Use Q [Alpha Strike]', true)
MasterYiMenu:Menu("Combo", "Combo")
MasterYiMenu.Combo:Boolean('UseQ', 'Use Q [Alpha Strike]', true)
MasterYiMenu.Combo:Boolean('UseE', 'Use E [Wuju Style]', true)
MasterYiMenu.Combo:Boolean('UseR', 'Use R [Highlander]', true)
MasterYiMenu:Menu("Harass", "Harass")
MasterYiMenu.Harass:Boolean('UseQ', 'Use Q [Alpha Strike]', true)
MasterYiMenu.Harass:Boolean('UseE', 'Use E [Wuju Style]', true)
MasterYiMenu.Harass:Slider("MP","Mana-Manager", 40, 0, 100, 5)
MasterYiMenu:Menu("KillSteal", "KillSteal")
MasterYiMenu.KillSteal:Boolean('UseQ', 'Use Q [Alpha Strike]', true)
MasterYiMenu:Menu("LaneClear", "LaneClear")
MasterYiMenu.LaneClear:Boolean('UseQ', 'Use Q [Alpha Strike]', true)
MasterYiMenu.LaneClear:Boolean('UseE', 'Use E [Wuju Style]', true)
MasterYiMenu.LaneClear:Slider("MP","Mana-Manager", 40, 0, 100, 5)
MasterYiMenu:Menu("JungleClear", "JungleClear")
MasterYiMenu.JungleClear:Boolean('UseQ', 'Use Q [Alpha Strike]', true)
MasterYiMenu.JungleClear:Boolean('UseE', 'Use E [Wuju Style]', true)
MasterYiMenu:Menu("Misc", "Misc")
MasterYiMenu.Misc:Boolean('UI', 'Use Items', true)
MasterYiMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
MasterYiMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 2, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
MasterYiMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
MasterYiMenu.Misc:Slider('HP','HP-Manager: R', 40, 0, 100, 5)

local MasterYiQ = { range = 600 }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Combo()
	Harass()
	KillSteal()
	LaneClear()
	JungleClear()
	LevelUp()
end)

function useQ(target)
	CastTargetSpell(target, _Q)
end
function useE(target)
	CastSpell(_E)
end
function useR(target)
	CastSpell(_R)
end

-- Auto

addAntiDSCallback(function()
	if MasterYiMenu.Auto.UseQ:Value() then
		for _, dodge in pairs(minionManager.objects) do
			if GetTeam(dodge) == MINION_ENEMY then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(dodge, MasterYiQ.range-50) then
						CastTargetSpell(dodge, _Q)
					end
				end
			end
		end
	end
end)

-- Combo

function Combo()
	if Mode() == "Combo" then
		if MasterYiMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, MasterYiQ.range) then
					useQ(target)
				end
			end
		end
		if MasterYiMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, GetRange(myHero)+100) then
					useE(target)
				end
			end
		end
		if MasterYiMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, 1000) then
					if 100*GetCurrentHP(target)/GetMaxHP(target) < MasterYiMenu.Misc.HP:Value() then
						if EnemiesAround(myHero, 1000) >= MasterYiMenu.Misc.X:Value() then
							useR(target)
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if MasterYiMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > MasterYiMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, MasterYiQ.range) then
						useQ(target)
					end
				end
			end
		end
		if MasterYiMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > MasterYiMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, GetRange(myHero)+100) then
						useE(target)
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if MasterYiMenu.KillSteal.UseQ:Value() then
			if ValidTarget(enemy, MasterYiQ.range) then
				if CanUseSpell(myHero,_Q) == READY then
					local MasterYiQDmg = (35*GetCastLevel(myHero,_Q)-10)+(GetBonusDmg(myHero)+GetBaseDamage(myHero))+0.6*(GetBonusDmg(myHero)+GetBaseDamage(myHero))
					if GetCurrentHP(enemy)+GetArmor(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2 < MasterYiQDmg then
						useQ(enemy)
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		for _,minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if MasterYiMenu.LaneClear.UseQ:Value() then
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > MasterYiMenu.LaneClear.MP:Value() then
						if ValidTarget(minion, MasterYiQ.range) then
							if CanUseSpell(myHero,_Q) == READY then
								useQ(minion)
							end
						end
					end
				end
				if MasterYiMenu.LaneClear.UseE:Value() then
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > MasterYiMenu.LaneClear.MP:Value() then
						if ValidTarget(minion, GetRange(myHero)+100) then
							if CanUseSpell(myHero,_E) == READY then
								useE(minion)
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, MasterYiQ.range) then
						if MasterYiMenu.JungleClear.UseQ:Value() then
							useQ(mob)
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, GetRange(myHero)+100) then
						if MasterYiMenu.JungleClear.UseE:Value() then
							useE(mob)
						end
					end
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if Mode() == "Combo" then
		if MasterYiMenu.Misc.UI:Value() then
			if GetItemSlot(myHero, 3074) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3074)) == READY then
					CastSpell(GetItemSlot(myHero, 3074))
				end -- Ravenous Hydra
			end
			if GetItemSlot(myHero, 3077) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3077)) == READY then
					CastSpell(GetItemSlot(myHero, 3077))
				end -- Tiamat
			end
			if GetItemSlot(myHero, 3144) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3144)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3144))
					end -- Bilgewater Cutlass
				end
			end
			if GetItemSlot(myHero, 3146) >= 1 and ValidTarget(target, 700) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3146)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3146))
					end -- Hextech Gunblade
				end
			end
			if GetItemSlot(myHero, 3153) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3153)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3153))
					end -- BOTRK
				end
			end
			if GetItemSlot(myHero, 3748) >= 1 and ValidTarget(target, 300) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero,GetItemSlot(myHero, 3748)) == READY then
						CastSpell(GetItemSlot(myHero, 3748))
					end -- Titanic Hydra
				end
			end
		end
	end
end)

function LevelUp()
	if MasterYiMenu.Misc.LvlUp:Value() then
		if MasterYiMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif MasterYiMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif MasterYiMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif MasterYiMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif MasterYiMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif MasterYiMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Orianna

elseif "Orianna" == GetObjectName(myHero) then

local Ball = myHero

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Orianna loaded successfully!")
local OriannaMenu = Menu("[T01] Orianna", "[T01] Orianna")
OriannaMenu:Menu("Auto", "Auto")
OriannaMenu.Auto:Boolean('UseQ', 'Use Q [Command Attack]', true)
OriannaMenu.Auto:Boolean('UseW', 'Use W [Command Dissonance]', true)
OriannaMenu.Auto:Boolean('UseR', 'Use R [Command Shockwave]', false)
OriannaMenu.Auto:Slider("MP","Mana-Manager", 40, 0, 100, 5)
OriannaMenu:Menu("Combo", "Combo")
OriannaMenu.Combo:Boolean('UseQ', 'Use Q [Command Attack]', true)
OriannaMenu.Combo:Boolean('UseW', 'Use W [Command Dissonance]', true)
OriannaMenu.Combo:Boolean('UseE', 'Use E [Command Protect]', true)
OriannaMenu.Combo:Boolean('UseR', 'Use R [Command Shockwave]', true)
OriannaMenu:Menu("Harass", "Harass")
OriannaMenu.Harass:Boolean('UseQ', 'Use Q [Command Attack]', true)
OriannaMenu.Harass:Boolean('UseW', 'Use W [Command Dissonance]', true)
OriannaMenu.Harass:Boolean('UseE', 'Use E [Command Protect]', true)
OriannaMenu.Harass:Slider("MP","Mana-Manager", 40, 0, 100, 5)
OriannaMenu:Menu("KillSteal", "KillSteal")
OriannaMenu.KillSteal:Boolean('UseW', 'Use W [Command Dissonance]', true)
OriannaMenu.KillSteal:Boolean('UseR', 'Use R [Command Shockwave]', true)
OriannaMenu:Menu("LaneClear", "LaneClear")
OriannaMenu.LaneClear:Boolean('UseQ', 'Use Q [Command Attack]', true)
OriannaMenu.LaneClear:Boolean('UseW', 'Use W [Command Dissonance]', true)
OriannaMenu.LaneClear:Slider("MP","Mana-Manager", 40, 0, 100, 5)
OriannaMenu:Menu("JungleClear", "JungleClear")
OriannaMenu.JungleClear:Boolean('UseQ', 'Use Q [Command Attack]', true)
OriannaMenu.JungleClear:Boolean('UseW', 'Use W [Command Dissonance]', true)
OriannaMenu.JungleClear:Boolean('UseE', 'Use E [Command Protect]', true)
OriannaMenu:Menu("Interrupter", "Interrupter")
OriannaMenu.Interrupter:Boolean('UseR', 'Use R [Command Shockwave]', true)
OriannaMenu:Menu("Prediction", "Prediction")
OriannaMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 2, {"CurrentPos", "GoSPred", "IPrediction", "OpenPredict"})
OriannaMenu:Menu("Misc", "Misc")
OriannaMenu.Misc:Key("UseE", "Force E Key", string.byte("A"))
OriannaMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
OriannaMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 1, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
OriannaMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
OriannaMenu.Misc:Slider('HP','HP-Manager: R', 40, 0, 100, 5)

local OriannaQ = { range = 825, radius = 80, width = 80, speed = 1400, delay = 0.25, type = "linear", collision = false, source = myHero }
local OriannaW = { range = 250 }
local OriannaE = { range = 1125, radius = 80 }
local OriannaR = { range = 325 }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	KillSteal()
	LaneClear()
	JungleClear()
	LevelUp()
end)

function useQ(target)
	if GetDistance(target) < OriannaQ.range then
		if OriannaMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif OriannaMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),OriannaQ.speed,OriannaQ.delay*1000,OriannaQ.range,OriannaQ.width,false,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif OriannaMenu.Prediction.PredictionQ:Value() == 3 then
			local QSpell = IPrediction.Prediction({name="OrianaIzunaCommand", range=OriannaQ.range, speed=OriannaQ.speed, delay=OriannaQ.delay, width=OriannaQ.width, type="linear", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(OriannaQ.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif OriannaMenu.Prediction.PredictionQ:Value() == 4 then
			local QPrediction = GetLinearAOEPrediction(target,OriannaQ)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useW(target)
	CastSpell(_W)
end
function useR(target)
	CastSpell(_R)
end

local Missiles = {}
OnCreateObj(function(Object) 
	if GetObjectBaseName(Object) == "missile" then
		table.insert(Missiles,Object) 
	end
end)
OnDeleteObj(function(Object)
	if GetObjectBaseName(Object) == "missile" then
		for i,rip in pairs(Missiles) do
			if GetNetworkID(Object) == GetNetworkID(rip) then
				table.remove(Missiles,i) 
			end
		end
	end
end)
OnProcessSpell(function(unit, spell)
	if unit == myHero and spell.name == "OrianaRedactCommand" then 
		Ball = spell.target
	end
end)
OnObjectLoad(function(Object)  
	if GetObjectBaseName(Object) == "Orianna_Base_Q_yomu_ring_green" then
		Ball = Object
	end
end)
OnCreateObj(function(Object) 
	if GetObjectBaseName(Object) == "Orianna_Base_Q_yomu_ring_green" then
		Ball = Object
	end
end)
OnUpdateBuff(function(unit,buff)
	if unit == myHero and buff.Name == "orianaghostself" then
		Ball = myHero
	end
end)
OnTick(function(myHero)
	for _,missile in pairs(Missiles) do
		if GetObjectSpellOwner(missile) == myHero and GetObjectSpellName(missile) == "orianaizuna" then
			Ball = missile
		end
	end
end)

-- Auto

function Auto()
	if OriannaMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > OriannaMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, OriannaQ.range) then
					useQ(target)
				end
			end
		end
	end
	if OriannaMenu.Auto.UseW:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > OriannaMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, OriannaE.range) and GetDistance(Ball, target) <= OriannaW.range then
					useW(target)
				end
			end
		end
	end
	if OriannaMenu.Auto.UseR:Value() then
		if CanUseSpell(myHero,_R) == READY then
			if 100*GetCurrentHP(target)/GetMaxHP(target) < OriannaMenu.Misc.HP:Value() then
				if EnemiesAround(GetOrigin(Ball), OriannaR.range) >= OriannaMenu.Misc.X:Value() then
					useR(target)
				end
			end
		end
	end
	if OriannaMenu.Misc.UseE:Value() then
		if CanUseSpell(myHero,_E) == READY then
			CastTargetSpell(myHero, _E)
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if OriannaMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, OriannaQ.range) then
					useQ(target)
				end
			end
		end
		if OriannaMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, OriannaE.range) and GetDistance(Ball, target) <= OriannaW.range then
					useW(target)
				end
			end
		end
		if OriannaMenu.Combo.UseE:Value() then
			if Ball ~= myHero and CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, OriannaE.range) then
					local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GetOrigin(myHero), GetOrigin(target), Vector(Ball))
					if pointLine and GetDistance(pointSegment, target) < OriannaE.radius then
						CastTargetSpell(myHero, _E)
					end
				end
			end
		end
		if OriannaMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, OriannaE.range) then
					if 100*GetCurrentHP(target)/GetMaxHP(target) < OriannaMenu.Misc.HP:Value() then
						if EnemiesAround(GetOrigin(Ball), OriannaR.range) >= OriannaMenu.Misc.X:Value() then
							useR(target)
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if OriannaMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > OriannaMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, OriannaQ.range) then
						useQ(target)
					end
				end
			end
		end
		if OriannaMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > OriannaMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, OriannaE.range) and GetDistance(Ball, target) <= OriannaW.range then
						useW(target)
					end
				end
			end
		end
		if OriannaMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > OriannaMenu.Harass.MP:Value() then
				if Ball ~= myHero and CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, OriannaE.range) then
						local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GetOrigin(myHero), GetOrigin(target), Vector(Ball))
						if pointLine and GetDistance(pointSegment, target) < OriannaE.radius then
							CastTargetSpell(myHero, _E)
						end
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if CanUseSpell(myHero,_W) == READY then
			if OriannaMenu.KillSteal.UseW:Value() then
				if ValidTarget(enemy, OriannaE.range) and GetDistance(Ball, enemy) <= OriannaW.range then
					local OriannaWDmg = (45*GetCastLevel(myHero,_W)+15)+(0.7*GetBonusAP(myHero))
					if GetCurrentHP(enemy)+GetDmgShield(enemy)+GetMagicResist(enemy)+GetMagicShield(enemy)+GetHPRegen(enemy)*2 < OriannaWDmg then
						useR(enemy)
					end
				end
			end
		elseif CanUseSpell(myHero,_R) == READY then
			if OriannaMenu.KillSteal.UseR:Value() then
				if ValidTarget(enemy, OriannaE.range) and GetDistance(Ball, enemy) <= OriannaR.range then
					local OriannaRDmg = (75*GetCastLevel(myHero,_R)+75)+(0.7*GetBonusAP(myHero))
					if GetCurrentHP(enemy)+GetDmgShield(enemy)+GetMagicResist(enemy)+GetMagicShield(enemy)+GetHPRegen(enemy)*2 < OriannaRDmg then
						useR(enemy)
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if OriannaMenu.LaneClear.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > OriannaMenu.LaneClear.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					local BestPos, BestHit = GetLineFarmPosition(OriannaQ.range, OriannaQ.radius, MINION_ENEMY)
					if BestPos and BestHit > 3 then
						CastSkillShot(_Q, BestPos)
					end
				end
			end
		end
		if OriannaMenu.LaneClear.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > OriannaMenu.LaneClear.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if MinionsAround(GetOrigin(Ball), OriannaW.range) > 2 then
						CastSpell(_W)
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, OriannaQ.range) then
						if OriannaMenu.JungleClear.UseQ:Value() then
							CastSkillShot(_Q, mob)
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if GetDistance(Ball, mob) <= OriannaW.range then
						if OriannaMenu.JungleClear.UseW:Value() then
							CastSpell(_W)
						end
					end
				end
				if Ball ~= myHero and CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, OriannaE.range) then
						if OriannaMenu.JungleClear.UseE:Value() then
							local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GetOrigin(myHero), GetOrigin(mob), GetOrigin(Ball))
							if pointLine and GetDistance(pointSegment, mob) <= OriannaE.radius then
								CastTargetSpell(myHero, _E)
							end
						end
					end
				end
			end
		end
	end
end

-- Interrupter

OnProcessSpell(function(unit, spell)
	if OriannaMenu.Interrupter.UseR:Value() then
		for _, enemy in pairs(GetEnemyHeroes()) do
			if ValidTarget(enemy, OriannaE.range) and GetDistance(Ball, enemy) <= OriannaR.range then
				if CanUseSpell(myHero,_R) == READY then
					local UnitName = GetObjectName(enemy)
					local UnitChanellingSpells = CHANELLING_SPELLS[UnitName]
					local UnitGapcloserSpells = GAPCLOSER_SPELLS[UnitName]
					if UnitChanellingSpells then
						for _, slot in pairs(UnitChanellingSpells) do
							if spell.name == GetCastName(enemy, slot) then useR(enemy) end
						end
					elseif UnitGapcloserSpells then
						for _, slot in pairs(UnitGapcloserSpells) do
							if spell.name == GetCastName(enemy, slot) then useR(enemy) end
						end
					end
				end
			end
		end
    end
end)

-- Misc

function LevelUp()
	if OriannaMenu.Misc.LvlUp:Value() then
		if OriannaMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif OriannaMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif OriannaMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif OriannaMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif OriannaMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif OriannaMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Riven

elseif "Riven" == GetObjectName(myHero) then

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Riven loaded successfully!")
local RivenMenu = Menu("[T01] Riven", "[T01] Riven")
RivenMenu:Menu("Auto", "Auto")
RivenMenu.Auto:Boolean('UseW', 'Use W [Ki Burst]', true)
RivenMenu:Menu("Combo", "Combo")
RivenMenu.Combo:Boolean('UseQ', 'Use Q [Broken Wings]', true)
RivenMenu.Combo:Boolean('UseW', 'Use W [Ki Burst]', true)
RivenMenu.Combo:Boolean('UseE', 'Use E [Valor]', true)
RivenMenu:Menu("Harass", "Harass")
RivenMenu.Harass:Boolean('UseQ', 'Use Q [Broken Wings]', true)
RivenMenu.Harass:Boolean('UseW', 'Use W [Ki Burst]', true)
RivenMenu.Harass:Boolean('UseE', 'Use E [Valor]', true)
RivenMenu:Menu("KillSteal", "KillSteal")
RivenMenu.KillSteal:Boolean('UseR', 'Use R [Blade of the Exile]', true)
RivenMenu:Menu("LaneClear", "LaneClear")
RivenMenu.LaneClear:Boolean('UseQ', 'Use Q [Broken Wings]', true)
RivenMenu.LaneClear:Boolean('UseW', 'Use W [Ki Burst]', true)
RivenMenu:Menu("JungleClear", "JungleClear")
RivenMenu.JungleClear:Boolean('UseQ', 'Use Q [Broken Wings]', true)
RivenMenu.JungleClear:Boolean('UseW', 'Use W [Ki Burst]', true)
RivenMenu.JungleClear:Boolean('UseE', 'Use E [Valor]', true)
RivenMenu:Menu("Prediction", "Prediction")
RivenMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
RivenMenu.Prediction:DropDown("PredictionR", "Prediction: R", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
RivenMenu:Menu("Misc", "Misc")
RivenMenu.Misc:Boolean('UI', 'Use Offensive Items', true)
RivenMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
RivenMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 2, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
RivenMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
RivenMenu.Misc:Slider('HP','HP-Manager: R', 40, 0, 100, 5)

local RivenQ = { range = 460, radius = 150, width = 150, speed = math.huge, delay = 0, type = "line", collision = false, source = myHero }
local RivenW = { range = 270 }
local RivenE = { range = 325, radius = 100, width = 100, speed = 1100, delay = 0, type = "line", collision = false, source = myHero }
local RivenR = { range = 900, angle = 50, radius = 50, width = 100, speed = 1600, delay = 0.25, type = "cone", collision = false, source = myHero }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	KillSteal()
	LaneClear()
	JungleClear()
	LevelUp()
end)

function useQ(target)
	if GetDistance(target) < RivenQ.range then
		if RivenMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif RivenMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),RivenQ.speed,RivenQ.delay*1000,RivenQ.range,RivenQ.radius,false,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif RivenMenu.Prediction.PredictionQ:Value() == 3 then
			local qPred = _G.gPred:GetPrediction(target,myHero,RivenQ,true,false)
			if qPred and qPred.HitChance >= 3 then
				CastSkillShot(_Q, qPred.CastPosition)
			end
		elseif RivenMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="RivenTriCleave", range=RivenQ.range, speed=RivenQ.speed, delay=RivenQ.delay, width=RivenQ.radius, type="linear", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(RivenQ.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif RivenMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetLinearAOEPrediction(target,RivenQ)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useW(target)
	CastSkillShot(_W,GetOrigin(target))
end
function useE(target)
	CastSkillShot(_E,GetOrigin(target))
end
function useR(target)
	if GetDistance(target) < RivenR.range then
		if RivenMenu.Prediction.PredictionR:Value() == 1 then
			CastSkillShot(_R,GetOrigin(target))
		elseif RivenMenu.Prediction.PredictionR:Value() == 2 then
			local RPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),RivenR.speed,RivenR.delay*1000,RivenR.range,RivenR.width,false,true)
			if RPred.HitChance == 1 then
				CastSkillShot(_R, RPred.PredPos)
			end
		elseif RivenMenu.Prediction.PredictionR:Value() == 3 then
			local RPred = _G.gPred:GetPrediction(target,myHero,RivenR,true,false)
			if RPred and RPred.HitChance >= 3 then
				CastSkillShot(_R, RPred.CastPosition)
			end
		elseif RivenMenu.Prediction.PredictionR:Value() == 4 then
			local RSpell = IPrediction.Prediction({name="RivenIzunaBlade", range=RivenR.range, speed=RivenR.speed, delay=RivenR.delay, width=RivenR.width, type="conic", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(RivenR.range)
			local x, y = RSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_R, y.x, y.y, y.z)
			end
		elseif RivenMenu.Prediction.PredictionR:Value() == 5 then
			local RPrediction = GetConicAOEPrediction(target,RivenR)
			if RPrediction.hitChance > 0.9 then
				CastSkillShot(_R, RPrediction.castPos)
			end
		end
	end
end

-- Auto

function Auto()
	if RivenMenu.Auto.UseW:Value() then
		if CanUseSpell(myHero,_W) == READY then
			if ValidTarget(target, RivenW.range) then
				useW(target)
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if RivenMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, RivenE.range+GetRange(myHero)+GetHitBox(myHero)+100) then
					useE(target)
				end
			end
		end
		if RivenMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY and AA == true then
				if ValidTarget(target, RivenQ.range+GetRange(myHero)+GetHitBox(myHero)+100) then
					useQ(target)
				end
			end
		end
		if RivenMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, RivenW.range) then
					useW(target)
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if RivenMenu.Harass.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, RivenE.range+GetRange(myHero)+GetHitBox(myHero)+100) then
					useE(target)
				end
			end
		end
		if RivenMenu.Harass.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY and AA == true then
				if ValidTarget(target, RivenQ.range+GetRange(myHero)+GetHitBox(myHero)+100) then
					useQ(target)
				end
			end
		end
		if RivenMenu.Harass.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, RivenW.range) then
					useW(target)
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if RivenMenu.KillSteal.UseR:Value() then
			if ValidTarget(enemy, RivenR.range) then
				if GetRange(myHero) > 150 then
					if CanUseSpell(myHero,_R) == READY then
						local RivenRDmg = ((50*GetCastLevel(myHero,_R)+50)+(0.6*GetBonusDmg(myHero)))*math.max(0.04*math.min(100-GetPercentHP(enemy),75),1)
						if GetCurrentHP(enemy)+GetArmor(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2 < RivenRDmg then
							useR(enemy)
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if RivenMenu.LaneClear.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY and AA == true then
				local BestPos, BestHit = GetLineFarmPosition(RivenQ.range, RivenQ.radius, MINION_ENEMY)
				if BestPos and BestHit > 2 then
					CastSkillShot(_Q, BestPos)
				end
			end
		end
		if RivenMenu.LaneClear.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				local BestPos, BestHit = GetLineFarmPosition(RivenW.range, RivenW.range, MINION_ENEMY)
				if BestPos and BestHit > 2 then
					CastSkillShot(_W, BestPos)
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, RivenE.range) then
						if RivenMenu.JungleClear.UseE:Value() then	   
							CastSkillShot(_E,GetOrigin(mob))
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, RivenW.range) then
						if RivenMenu.JungleClear.UseW:Value() then	   
							CastSkillShot(_W,GetOrigin(mob))
						end
					end
				end
				if CanUseSpell(myHero,_Q) == READY and AA == true then
					if ValidTarget(mob, RivenQ.range) then
						if RivenMenu.JungleClear.UseQ:Value() then
							CastSkillShot(_Q,GetOrigin(mob))
						end
					end
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if Mode() == "Combo" then
		if RivenMenu.Misc.UI:Value() then
			if GetItemSlot(myHero, 3074) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3074)) == READY then
					CastSpell(GetItemSlot(myHero, 3074))
				end -- Ravenous Hydra
			end
			if GetItemSlot(myHero, 3077) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3077)) == READY then
					CastSpell(GetItemSlot(myHero, 3077))
				end -- Tiamat
			end
			if GetItemSlot(myHero, 3144) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3144)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3144))
					end -- Bilgewater Cutlass
				end
			end
			if GetItemSlot(myHero, 3146) >= 1 and ValidTarget(target, 700) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3146)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3146))
					end -- Hextech Gunblade
				end
			end
			if GetItemSlot(myHero, 3153) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3153)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3153))
					end -- BOTRK
				end
			end
			if GetItemSlot(myHero, 3748) >= 1 and ValidTarget(target, 300) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero,GetItemSlot(myHero, 3748)) == READY then
						CastSpell(GetItemSlot(myHero, 3748))
					end -- Titanic Hydra
				end
			end
		end
	end
end)

function LevelUp()
	if RivenMenu.Misc.LvlUp:Value() then
		if RivenMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif RivenMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif RivenMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif RivenMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif RivenMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif RivenMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Ryze

elseif "Ryze" == GetObjectName(myHero) then

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Ryze loaded successfully!")
local RyzeMenu = Menu("[T01] Ryze", "[T01] Ryze")
RyzeMenu:Menu("Auto", "Auto")
RyzeMenu.Auto:Boolean('UseQ', 'Use Q [Overload]', true)
RyzeMenu.Auto:Slider("MP","Mana-Manager", 40, 0, 100, 5)
RyzeMenu:Menu("Combo", "Combo")
RyzeMenu.Combo:Boolean('UseQ', 'Use Q [Overload]', true)
RyzeMenu.Combo:Boolean('UseW', 'Use W [Rune Prison]', true)
RyzeMenu.Combo:Boolean('UseE', 'Use E [Spell Flux]', true)
RyzeMenu:Menu("Harass", "Harass")
RyzeMenu.Harass:Boolean('UseQ', 'Use Q [Overload]', true)
RyzeMenu.Harass:Boolean('UseW', 'Use W [Rune Prison]', true)
RyzeMenu.Harass:Boolean('UseE', 'Use E [Spell Flux]', true)
RyzeMenu.Harass:Slider("MP","Mana-Manager", 40, 0, 100, 5)
RyzeMenu:Menu("LastHit", "LastHit")
RyzeMenu.LastHit:Boolean('UseQ', 'Use Q [Overload]', false)
RyzeMenu.LastHit:Boolean('UseE', 'Use E [Spell Flux]', true)
RyzeMenu.LastHit:Slider("MP","Mana-Manager", 40, 0, 100, 5)
RyzeMenu:Menu("LaneClear", "LaneClear")
RyzeMenu.LaneClear:Boolean('UseQ', 'Use Q [Overload]', true)
RyzeMenu.LaneClear:Boolean('UseW', 'Use W [Rune Prison]', false)
RyzeMenu.LaneClear:Boolean('UseE', 'Use E [Spell Flux]', false)
RyzeMenu.LaneClear:Slider("MP","Mana-Manager", 40, 0, 100, 5)
RyzeMenu:Menu("JungleClear", "JungleClear")
RyzeMenu.JungleClear:Boolean('UseQ', 'Use Q [Overload]', true)
RyzeMenu.JungleClear:Boolean('UseW', 'Use W [Rune Prison]', true)
RyzeMenu.JungleClear:Boolean('UseE', 'Use E [Spell Flux]', true)
RyzeMenu:Menu("AntiGapcloser", "Anti-Gapcloser")
RyzeMenu.AntiGapcloser:Boolean('UseW', 'Use W [Rune Prison]', true)
RyzeMenu:Menu("Interrupter", "Interrupter")
RyzeMenu.Interrupter:Boolean('UseW', 'Use W [Rune Prison]', true)
RyzeMenu:Menu("Prediction", "Prediction")
RyzeMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
RyzeMenu:Menu("Misc", "Misc")
RyzeMenu.Misc:Boolean('ST', 'Stack Tear', true)
RyzeMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
RyzeMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 5, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
RyzeMenu.Misc:Slider("MPT","Mana-Manager: Tear", 80, 0, 100, 5)

local RyzeQ = { range = 1000, radius = 55, width = 55, speed = 1700, delay = 0.25, type = "line", collision = true, source = myHero, col = {"minion","champion","yasuowall"}}
local RyzeW = { range = 615 }
local RyzeE = { range = 615 }
local RyzeR = { range = GetCastRange(myHero,_R) }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	LastHit()
	LaneClear()
	JungleClear()
	AntiGapcloser()
	LevelUp()
end)

function useQ(target)
	if GetDistance(target) < RyzeQ.range then
		if RyzeMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif RyzeMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),RyzeQ.speed,RyzeQ.delay*1000,RyzeQ.range,RyzeQ.width,true,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif RyzeMenu.Prediction.PredictionQ:Value() == 3 then
			local qPred = _G.gPred:GetPrediction(target,myHero,RyzeQ,false,true)
			if qPred and qPred.HitChance >= 3 then
				CastSkillShot(_Q, qPred.CastPosition)
			end
		elseif RyzeMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="RyzeQ", range=RyzeQ.range, speed=RyzeQ.speed, delay=RyzeQ.delay, width=RyzeQ.width, type="linear", collision=true})
			ts = TargetSelector()
			target = ts:GetTarget(RyzeQ.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif RyzeMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetPrediction(target,RyzeQ)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useW(target)
	if CanUseSpell(myHero,_Q) == ONCOOLDOWN then
		CastTargetSpell(target, _W)
	end
end
function useE(target)
	if CanUseSpell(myHero,_Q) == ONCOOLDOWN then
		CastTargetSpell(target, _E)
	end
end

-- Auto

function Auto()
	if RyzeMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > RyzeMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, RyzeQ.range) then
					useQ(target)
				end
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if RyzeMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY and AA == true then
				if ValidTarget(target, RyzeQ.range) then
					useQ(target)
				end
			end
		end
		if RyzeMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, RyzeW.range) then
					useW(target)
				end
			end
		end
		if RyzeMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, RyzeE.range) then
					useE(target)
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if RyzeMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > RyzeMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY and AA == true then
					if ValidTarget(target, RyzeQ.range) then
						useQ(target)
					end
				end
			end
		end
		if RyzeMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > RyzeMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, RyzeW.range) then
						useW(target)
					end
				end
			end
		end
		if RyzeMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > RyzeMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, RyzeE.range) then
						useE(target)
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, RyzeQ.range) then
					if RyzeMenu.LastHit.UseQ:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > RyzeMenu.LastHit.MP:Value() then
							if CanUseSpell(myHero,_Q) == READY and AA == true then
								if GotBuff(minion, "RyzeE") > 0 then
									local RyzeQBDmg = ((25*GetCastLevel(myHero,_Q)+35)+(0.45*GetBonusAP(myHero))+(0.03*GetMaxMana(myHero)))*(0.1*GetCastLevel(myHero,_Q)+1.3)
									if GetCurrentHP(minion) < RyzeQBDmg then
										local qPredMin = _G.gPred:GetPrediction(minion,myHero,RyzeQ,false,true)
										if qPredMin and qPredMin.HitChance >= 3 then
											CastSkillShot(_Q, qPredMin.CastPosition)
										end
									end
								else
									local RyzeQDmg = (25*GetCastLevel(myHero,_Q)+35)+(0.45*GetBonusAP(myHero))+(0.03*GetMaxMana(myHero))
									if GetCurrentHP(minion) < RyzeQDmg then
										local qPredMin = _G.gPred:GetPrediction(minion,myHero,RyzeQ,false,true)
										if qPredMin and qPredMin.HitChance >= 3 then
											CastSkillShot(_Q, qPredMin.CastPosition)
										end
									end
								end
							end
						end
					end
				end
				if ValidTarget(minion, RyzeE.range) then
					if RyzeMenu.LastHit.UseE:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > RyzeMenu.LastHit.MP:Value() then
							if CanUseSpell(myHero,_E) == READY then
								local RyzeEDmg = (25*GetCastLevel(myHero,_E)+25)+(0.3*GetBonusAP(myHero))+(0.02*GetMaxMana(myHero))
								if GetCurrentHP(minion) < RyzeEDmg then
									CastTargetSpell(minion, _E)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if RyzeMenu.LaneClear.UseQ:Value() then
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > RyzeMenu.LaneClear.MP:Value() then
						if ValidTarget(minion, RyzeQ.range) then
							if RyzeMenu.LaneClear.UseQ:Value() then
								if CanUseSpell(myHero,_Q) == READY and AA == true then
									if GotBuff(minion, "RyzeE") > 0 then
										local qPredMin = _G.gPred:GetPrediction(minion,myHero,RyzeQ,false,true)
										if qPredMin and qPredMin.HitChance >= 3 then
											CastSkillShot(_Q, qPredMin.CastPosition)
										end
									end
								end
							end
						end
					end
				end
				if RyzeMenu.LaneClear.UseW:Value() then
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > RyzeMenu.LaneClear.MP:Value() then
						if ValidTarget(minion, RyzeW.range) then
							if RyzeMenu.LaneClear.UseW:Value() then
								if CanUseSpell(myHero,_W) == READY then
									CastTargetSpell(minion, _W)
								end
							end
						end
					end
				end
				if RyzeMenu.LaneClear.UseE:Value() then
					if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > RyzeMenu.LaneClear.MP:Value() then
						if ValidTarget(minion, RyzeE.range) then
							if RyzeMenu.LaneClear.UseE:Value() then
								if CanUseSpell(myHero,_E) == READY then
									if GotBuff(minion, "RyzeE") > 0 then
										CastTargetSpell(minion, _E)
									else
										CastTargetSpell(minion, _E)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY and AA == true then
					if ValidTarget(mob, RyzeQ.range) then
						if RyzeMenu.JungleClear.UseQ:Value() then
							CastSkillShot(_Q,GetOrigin(mob))
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, RyzeW.range) then
						if RyzeMenu.JungleClear.UseW:Value() then	   
							CastTargetSpell(mob, _W)
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, RyzeE.range) then
						if RyzeMenu.JungleClear.UseE:Value() then
							CastTargetSpell(mob, _E)
						end
					end
				end
			end
		end
	end
end

-- Interrupter

OnProcessSpell(function(unit, spell)
	if RyzeMenu.Interrupter.UseW:Value() then
		for _, enemy in pairs(GetEnemyHeroes()) do
			if ValidTarget(enemy, RyzeW.range) then
				if CanUseSpell(myHero,_W) == READY then
					local UnitName = GetObjectName(enemy)
					local UnitChanellingSpells = CHANELLING_SPELLS[UnitName]
					local UnitGapcloserSpells = GAPCLOSER_SPELLS[UnitName]
					if UnitGapcloserSpells then
						for _, slot in pairs(UnitGapcloserSpells) do
							if spell.name == GetCastName(enemy, slot) then CastTargetSpell(enemy, _W) end
						end
					end
				end
			end
		end
    end
end)

-- Anti-Gapcloser

function AntiGapcloser()
	for i,antigap in pairs(GetEnemyHeroes()) do
		if RyzeMenu.AntiGapcloser.UseW:Value() then
			if ValidTarget(antigap, 250) then
				if CanUseSpell(myHero,_W) == READY then
					CastTargetSpell(antigap, _W)
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if RyzeMenu.Misc.ST:Value() then
		if GotBuff(myHero,"recall") == 0 then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > RyzeMenu.Misc.MPT:Value() then
				if EnemiesAround(myHero, 2500) == 0 then
					if not UnderTurret(myHero, 775) then
						if GetItemSlot(myHero, 3070) > 0 then
							if CanUseSpell(myHero,_Q) == READY then
								DelayAction(function() CastSkillShot(_Q,GetOrigin(myHero)) end, 0.25)
							end
						end
					end
				end
			end
		end
	end
end)

function LevelUp()
	if RyzeMenu.Misc.LvlUp:Value() then
		if RyzeMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif RyzeMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif RyzeMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif RyzeMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif RyzeMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif RyzeMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Syndra

elseif "Syndra" == GetObjectName(myHero) then

local Seed = {}

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Syndra loaded successfully!")
local SyndraMenu = Menu("[T01] Syndra", "[T01] Syndra")
SyndraMenu:Menu("Auto", "Auto")
SyndraMenu.Auto:Boolean('UseQ', 'Use Q [Dark Sphere]', true)
SyndraMenu.Auto:Boolean('UseW', 'Use W [Force of Will]', false)
SyndraMenu.Auto:Boolean('UseE', 'Use E [Scatter the Weak]', false)
SyndraMenu.Auto:Slider("MP","Mana-Manager", 40, 0, 100, 5)
SyndraMenu:Menu("Combo", "Combo")
SyndraMenu.Combo:Boolean('UseQ', 'Use Q [Dark Sphere]', true)
SyndraMenu.Combo:Boolean('UseW', 'Use W [Force of Will]', true)
SyndraMenu.Combo:Boolean('UseE', 'Use E [Scatter the Weak]', true)
SyndraMenu.Combo:Boolean('UseQE', 'Use Stunning Q+E', true)
SyndraMenu:Menu("Harass", "Harass")
SyndraMenu.Harass:Boolean('UseQ', 'Use Q [Dark Sphere]', true)
SyndraMenu.Harass:Boolean('UseW', 'Use W [Force of Will]', true)
SyndraMenu.Harass:Boolean('UseE', 'Use E [Scatter the Weak]', false)
SyndraMenu.Harass:Slider("MP","Mana-Manager", 40, 0, 100, 5)
SyndraMenu:Menu("KillSteal", "KillSteal")
SyndraMenu.KillSteal:Boolean('UseR', 'Use R [Unleashed Power]', true)
SyndraMenu:Menu("LaneClear", "LaneClear")
SyndraMenu.LaneClear:Boolean('UseQ', 'Use Q [Dark Sphere]', true)
SyndraMenu.LaneClear:Boolean('UseW', 'Use W [Force of Will]', true)
SyndraMenu.LaneClear:Slider("MP","Mana-Manager", 40, 0, 100, 5)
SyndraMenu:Menu("JungleClear", "JungleClear")
SyndraMenu.JungleClear:Boolean('UseQ', 'Use Q [Dark Sphere]', true)
SyndraMenu.JungleClear:Boolean('UseW', 'Use W [Force of Will]', true)
SyndraMenu.JungleClear:Boolean('UseE', 'Use E [Scatter the Weak]', true)
SyndraMenu:Menu("AntiGapcloser", "Anti-Gapcloser")
SyndraMenu.AntiGapcloser:Boolean('UseE', 'Use E [Scatter the Weak]', true)
SyndraMenu:Menu("Prediction", "Prediction")
SyndraMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
SyndraMenu.Prediction:DropDown("PredictionW", "Prediction: W", 2, {"CurrentPos", "GoSPred"})
SyndraMenu.Prediction:DropDown("PredictionE", "Prediction: E", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
SyndraMenu:Menu("Misc", "Misc")
SyndraMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
SyndraMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 2, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})

local SyndraQ = { range = 800, radius = 200, width = 200, speed = math.huge, delay = 0.625, type = "circular", collision = false, source = myHero }
local SyndraW = { range = 950, radius = 225, width = 225, speed = 1450, delay = 0.25, type = "circular", collision = false, source = myHero }
local SyndraE = { range = 700, angle = 40, radius = 40, width = 80, speed = 2500, delay = 0.25, type = "cone", collision = false, source = myHero }
local SyndraR = { range = GetCastRange(myHero,_R) }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	KillSteal()
	LaneClear()
	JungleClear()
	AntiGapcloser()
	LevelUp()
end)


function useQ(target)
	if GetDistance(target) < SyndraQ.range then
		if SyndraMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif SyndraMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),SyndraQ.speed,SyndraQ.delay*1000,SyndraQ.range,SyndraQ.width,false,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif SyndraMenu.Prediction.PredictionQ:Value() == 3 then
			local QPred = _G.gPred:GetPrediction(target,myHero,SyndraQ,true,false)
			if QPred and QPred.HitChance >= 3 then
				CastSkillShot(_Q, QPred.CastPosition)
			end
		elseif SyndraMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="SyndraQ", range=SyndraQ.range, speed=SyndraQ.speed, delay=SyndraQ.delay, width=SyndraQ.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(SyndraQ.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif SyndraMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetCircularAOEPrediction(target,SyndraQ)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useW(target)
	if GetDistance(target) < SyndraW.range then
		if SyndraMenu.Prediction.PredictionW:Value() == 1 then
			CastSkillShot3(_W,target,GetOrigin(Seed))
		elseif SyndraMenu.Prediction.PredictionW:Value() == 2 then
			local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),SyndraW.speed,SyndraW.delay*1000,SyndraW.range,SyndraW.width,false,true)
			if WPred.HitChance == 1 then
				CastSkillShot3(_W, WPred.PredPos, GetOrigin(Seed))
			end
		end
	end
end
function useE(target)
	if GetDistance(target) < SyndraE.range then
		if SyndraMenu.Prediction.PredictionE:Value() == 1 then
			CastSkillShot(_E,GetOrigin(target))
		elseif SyndraMenu.Prediction.PredictionE:Value() == 2 then
			local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),SyndraE.speed,SyndraE.delay*1000,SyndraE.range,SyndraE.width,false,true)
			if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
			end
		elseif SyndraMenu.Prediction.PredictionE:Value() == 3 then
			local EPred = _G.gPred:GetPrediction(target,myHero,SyndraE,true,false)
			if EPred and EPred.HitChance >= 3 then
				CastSkillShot(_E, EPred.CastPosition)
			end
		elseif SyndraMenu.Prediction.PredictionE:Value() == 4 then
			local ESpell = IPrediction.Prediction({name="SyndraE", range=SyndraE.range, speed=SyndraE.speed, delay=SyndraE.delay, width=SyndraE.width, type="conic", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(SyndraE.range)
			local x, y = ESpell:Predict(target)
			if x > 2 then
				CastSkillShot(_E, y.x, y.y, y.z)
			end
		elseif SyndraMenu.Prediction.PredictionE:Value() == 5 then
			local EPrediction = GetConicAOEPrediction(target,SyndraE)
			if EPrediction.hitChance > 0.9 then
				CastSkillShot(_E, EPrediction.castPos)
			end
		end
	end
end

local function CountBalls(table)
	local count = 0
	for _ in pairs(table) do 
		count = count + 1
	end
	return count
end
OnCreateObj(function(Object) 
	if GetObjectBaseName(Object) == "Seed" then
		table.insert(Seed, Object)
		DelayAction(function() table.remove(Seed, 1) end, 6)
	end
end)

-- Auto

function Auto()
	if SyndraMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, SyndraQ.range) then
					useQ(target)
				end
			end
		end
	end
	if SyndraMenu.Auto.UseW:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, SyndraW.range) then
					useW(target)
				end
			end
		end
	end
	if SyndraMenu.Auto.UseE:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, SyndraE.range) then
					useE(target)
				end
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if SyndraMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, SyndraQ.range) then
					useQ(target)
				end
			end
		end
		if SyndraMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, SyndraW.range) then
					useW(target)
				end
			end
		end
		if SyndraMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, SyndraE.range) then
					useE(target)
				end
			end
		end
		if SyndraMenu.Combo.UseQE:Value() then
			if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, 1250) then
					local QEPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),1600,250,1250,60,false,true)
					if QEPred.HitChance == 1 then
						local QPos = Vector(myHero)-500*(Vector(myHero)-Vector(QEPred.PredPos)):normalized()
						CastSkillShot(_Q, QPos)
						DelayAction(function() CastSkillShot(_E, QPos) end, 0.25)
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if SyndraMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, SyndraQ.range) then
						useQ(target)
					end
				end
			end
		end
		if SyndraMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, SyndraW.range) then
						useW(target)
					end
				end
			end
		end
		if SyndraMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, SyndraE.range) then
						useE(target)
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if SyndraMenu.KillSteal.UseR:Value() then
			if ValidTarget(enemy, SyndraR.range) then
				if CanUseSpell(myHero,_R) == READY then
					local RMulti = CountBalls(Seed)+3
					local SyndraRDmg = (((45*GetCastLevel(myHero,_R)+45)+(0.2*GetBonusAP(myHero)))*RMulti)
					if GetCurrentHP(enemy)+GetDmgShield(enemy)+GetMagicResist(enemy)+GetMagicShield(enemy)+GetHPRegen(enemy)*2 < SyndraRDmg then
						CastTargetSpell(enemy, _R)
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if SyndraMenu.LaneClear.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.LaneClear.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					local BestPos, BestHit = GetFarmPosition(SyndraQ.range, SyndraQ.radius, MINION_ENEMY)
					if BestPos and BestHit > 3 then
						CastSkillShot(_Q, BestPos)
					end
				end
			end
		end
		if SyndraMenu.LaneClear.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > SyndraMenu.LaneClear.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					local BestPos, BestHit = GetFarmPosition(SyndraW.range, SyndraW.radius, MINION_ENEMY)
					if BestPos and BestHit > 3 then 
						CastSkillShot3(_W, BestPos, GetOrigin(Seed))
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, SyndraQ.range) then
						if SyndraMenu.JungleClear.UseQ:Value() then
							CastSkillShot(_Q, mob)
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, SyndraW.range) then
						if SyndraMenu.JungleClear.UseW:Value() then
							CastSkillShot3(_W, mob, GetOrigin(Seed))
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, SyndraE.range) then
						if SyndraMenu.JungleClear.UseE:Value() then
							CastSkillShot(_E, mob)
						end
					end
				end
			end
		end
	end
end

-- Anti-Gapcloser

function AntiGapcloser()
	for i,antigap in pairs(GetEnemyHeroes()) do
		if SyndraMenu.AntiGapcloser.UseE:Value() then
			if ValidTarget(antigap, 200) then
				if CanUseSpell(myHero,_E) == READY then
					CastSkillShot(_E, antigap)
				end
			end
		end
	end
end

-- Misc

function LevelUp()
	if SyndraMenu.Misc.LvlUp:Value() then
		if SyndraMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif SyndraMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif SyndraMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif SyndraMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif SyndraMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif SyndraMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

function VectorWay(A,B)
	WayX = B.x - A.x
	WayY = B.y - A.y
	WayZ = B.z - A.z
	return Vector(WayX, WayY, WayZ)
end

-- TwistedFate

elseif "TwistedFate" == GetObjectName(myHero) then

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>TwistedFate loaded successfully!")
PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>TIP: Use IOW orbwalker for perfect AA.")
local TwistedFateMenu = Menu("[T01] TwistedFate", "[T01] TwistedFate")
TwistedFateMenu:Menu("Auto", "Auto")
TwistedFateMenu.Auto:Boolean('UseQ', 'Use Q [Wild Cards]', true)
TwistedFateMenu.Auto:DropDown("ModeQ", "Cast Mode: Q", 2, {"Standard", "On Immobile"})
TwistedFateMenu:Menu("Combo", "Combo")
TwistedFateMenu.Combo:Boolean('UseQ', 'Use Q [Wild Cards]', true)
TwistedFateMenu.Combo:Boolean('UseW', 'Use W [Pick a Card]', true)
TwistedFateMenu.Combo:DropDown("ModeQ", "Cast Mode: Q", 2, {"Standard", "On Immobile"})
TwistedFateMenu.Combo:DropDown("ModeW", "Cast Mode: W", 1, {"Priority", "Smart"})
TwistedFateMenu.Combo:DropDown("PickW", "Priority: W", 3, {"Blue", "Red", "Gold"})
TwistedFateMenu:Menu("Harass", "Harass")
TwistedFateMenu.Harass:Boolean('UseQ', 'Use Q [Wild Cards]', true)
TwistedFateMenu.Harass:Boolean('UseW', 'Use W [Pick a Card]', true)
TwistedFateMenu.Harass:DropDown("ModeQ", "Cast Mode: Q", 2, {"Standard", "On Immobile"})
TwistedFateMenu.Harass:DropDown("ModeW", "Cast Mode: W", 2, {"Priority", "Smart"})
TwistedFateMenu.Harass:DropDown("PickW", "Priority: W", 3, {"Blue", "Red", "Gold"})
TwistedFateMenu:Menu("KillSteal", "KillSteal")
TwistedFateMenu.KillSteal:Boolean('UseQ', 'Use Q [Wild Cards]', true)
TwistedFateMenu:Menu("LaneClear", "LaneClear")
TwistedFateMenu.LaneClear:Boolean('UseQ', 'Use Q [Wild Cards]', true)
TwistedFateMenu.LaneClear:Boolean('UseW', 'Use W [Pick a Card]', false)
TwistedFateMenu.LaneClear:DropDown("ModeW", "Cast Mode: W", 2, {"Priority", "Smart"})
TwistedFateMenu.LaneClear:DropDown("PickW", "Priority: W", 1, {"Blue", "Red"})
TwistedFateMenu:Menu("JungleClear", "JungleClear")
TwistedFateMenu.JungleClear:Boolean('UseQ', 'Use Q [Wild Cards]', true)
TwistedFateMenu.JungleClear:Boolean('UseW', 'Use W [Pick a Card]', true)
TwistedFateMenu:Menu("Prediction", "Prediction")
TwistedFateMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
TwistedFateMenu:Menu("Misc", "Misc")
TwistedFateMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
TwistedFateMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 1, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
TwistedFateMenu.Misc:Slider("MP","Mana-Manager", 40, 0, 100, 5)

local TwistedFateQ = { range = 1450, radius = 40, width = 40, speed = 1000, delay = 0.25, type = "line", collision = false, source = myHero, col = {"yasuowall"}}
local TwistedFateR = { range = GetCastRange(myHero,_R) }
local GlobalTimer = 0

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	KillSteal()
	LaneClear()
	JungleClear()
	LevelUp()
end)

function useQ(target)
	if GetDistance(target) < TwistedFateQ.range then
		if TwistedFateMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif TwistedFateMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),TwistedFateQ.speed,TwistedFateQ.delay*1000,TwistedFateQ.range,TwistedFateQ.width,false,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif TwistedFateMenu.Prediction.PredictionQ:Value() == 3 then
			local QPred = _G.gPred:GetPrediction(target,myHero,TwistedFateQ,true,false)
			if QPred and QPred.HitChance >= 3 then
				CastSkillShot(_Q, QPred.CastPosition)
			end
		elseif TwistedFateMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="WildCards", range=TwistedFateQ.range, speed=TwistedFateQ.speed, delay=TwistedFateQ.delay, width=TwistedFateQ.width, type="linear", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(TwistedFateQ.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif TwistedFateMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetLinearAOEPrediction(target,TwistedFateQ)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
OnCreateObj(function(Object)
	if GetObjectBaseName(Object) == "TwistedFate_Base_W_BlueCard" then
		CurrentCard = "Blue"
	elseif GetObjectBaseName(Object) == "TwistedFate_Base_W_RedCard" then
		CurrentCard = "Red"
	elseif GetObjectBaseName(Object) == "TwistedFate_Base_W_GoldCard" then
		CurrentCard = "Gold"
	end
end)

-- Auto

function Auto()
	if TwistedFateMenu.Auto.UseQ:Value() then
		if CanUseSpell(myHero,_Q) == READY and AA == true then
			if ValidTarget(target, TwistedFateQ.range) then
				if TwistedFateMenu.Auto.ModeQ:Value() == 1 then
					useQ(target)
				elseif TwistedFateMenu.Auto.ModeQ:Value() == 2 then
					if GotBuff(target, "Stun") > 0 or GotBuff(target, "Taunt") > 0 or GotBuff(target, "Slow") > 0 or GotBuff(target, "Snare") > 0 or GotBuff(target, "Charm") > 0 or GotBuff(target, "Suppression") > 0 or GotBuff(target, "Flee") > 0 or GotBuff(target, "Knockup") > 0 then
						CastSkillShot(_Q,GetOrigin(target))
					end
				end
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if TwistedFateMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY and AA == true then
				if ValidTarget(target, TwistedFateQ.range) then
					if TwistedFateMenu.Combo.ModeQ:Value() == 1 then
						useQ(target)
					elseif TwistedFateMenu.Auto.ModeQ:Value() == 2 then
						if GotBuff(target, "Stun") > 0 or GotBuff(target, "Taunt") > 0 or GotBuff(target, "Slow") > 0 or GotBuff(target, "Snare") > 0 or GotBuff(target, "Charm") > 0 or GotBuff(target, "Suppression") > 0 or GotBuff(target, "Flee") > 0 or GotBuff(target, "Knockup") > 0 then
							CastSkillShot(_Q,GetOrigin(target))
						end
					end
				end
			end
		end
		if TwistedFateMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, GetRange(myHero)+500) then
					if GotBuff(myHero, "pickacard_tracker") == 0 then
						local TimerW = GetTickCount()
						if (GlobalTimer + 1000) < TimerW then
							CastSpell(_W)
							GlobalTimer = TimerW
						end
					else
						if TwistedFateMenu.Combo.ModeW:Value() == 1 then
							if TwistedFateMenu.Combo.PickW:Value() == 1 then
								if CurrentCard == "Blue" then
									CastSpell(_W)
									CurrentCard = "nil"
								end
							elseif TwistedFateMenu.Combo.PickW:Value() == 2 then
								if CurrentCard == "Red" then
									CastSpell(_W)
									CurrentCard = "nil"
								end
							elseif TwistedFateMenu.Combo.PickW:Value() == 3 then
								if CurrentCard == "Gold" then
									CastSpell(_W)
									CurrentCard = "nil"
								end
							end
						elseif TwistedFateMenu.Combo.ModeW:Value() == 2 then
							if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > TwistedFateMenu.Misc.MP:Value() then
								if EnemiesAround(target, 200) > 1 then
									if CurrentCard == "Red" then
										CastSpell(_W)
										CurrentCard = "nil"
									end
								else
									if CurrentCard == "Gold" then
										CastSpell(_W)
										CurrentCard = "nil"
									end
								end
							else
								if CurrentCard == "Blue" then
									CastSpell(_W)
									CurrentCard = "nil"
								end
							end
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if TwistedFateMenu.Harass.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY and AA == true then
				if ValidTarget(target, TwistedFateQ.range) then
					if TwistedFateMenu.Harass.ModeQ:Value() == 1 then
						useQ(target)
					elseif TwistedFateMenu.Auto.ModeQ:Value() == 2 then
						if GotBuff(target, "Stun") > 0 or GotBuff(target, "Taunt") > 0 or GotBuff(target, "Slow") > 0 or GotBuff(target, "Snare") > 0 or GotBuff(target, "Charm") > 0 or GotBuff(target, "Suppression") > 0 or GotBuff(target, "Flee") > 0 or GotBuff(target, "Knockup") > 0 then
							CastSkillShot(_Q,GetOrigin(target))
						end
					end
				end
			end
		end
		if TwistedFateMenu.Harass.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, GetRange(myHero)+500) then
					if GotBuff(myHero, "pickacard_tracker") == 0 then
						local TimerW = GetTickCount()
						if (GlobalTimer + 1000) < TimerW then
							CastSpell(_W)
							GlobalTimer = TimerW
						end
					else
						if TwistedFateMenu.Harass.ModeW:Value() == 1 then
							if TwistedFateMenu.Harass.PickW:Value() == 1 then
								if CurrentCard == "Blue" then
									CastSpell(_W)
									CurrentCard = "nil"
								end
							elseif TwistedFateMenu.Harass.PickW:Value() == 2 then
								if CurrentCard == "Red" then
									CastSpell(_W)
									CurrentCard = "nil"
								end
							elseif TwistedFateMenu.Harass.PickW:Value() == 3 then
								if CurrentCard == "Gold" then
									CastSpell(_W)
									CurrentCard = "nil"
								end
							end
						elseif TwistedFateMenu.Harass.ModeW:Value() == 2 then
							if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > TwistedFateMenu.Misc.MP:Value() then
								if EnemiesAround(target, 200) > 1 then
									if CurrentCard == "Red" then
										CastSpell(_W)
										CurrentCard = "nil"
									end
								else
									if CurrentCard == "Gold" then
										CastSpell(_W)
										CurrentCard = "nil"
									end
								end
							else
								if CurrentCard == "Blue" then
									CastSpell(_W)
									CurrentCard = "nil"
								end
							end
						end
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if TwistedFateMenu.KillSteal.UseQ:Value() then
			if ValidTarget(enemy, TwistedFateQ.range) then
				if CanUseSpell(myHero,_Q) == READY then
					local TwistedFateQDmg = (45*GetCastLevel(myHero,_Q)+15)+(0.65*GetBonusAP(myHero))
					if GetCurrentHP(enemy)+GetDmgShield(enemy)+GetMagicResist(enemy)+GetMagicShield(enemy)+GetHPRegen(enemy)*2 < TwistedFateQDmg then
						useQ(enemy)
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if TwistedFateMenu.LaneClear.UseQ:Value() and AA == true then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > TwistedFateMenu.Misc.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					local BestPos, BestHit = GetLineFarmPosition(TwistedFateQ.range, TwistedFateQ.radius, MINION_ENEMY)
					if BestPos and BestHit > 3 then
						CastSkillShot(_Q, BestPos)
					end
				end
			end
		end
		for _,minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if TwistedFateMenu.LaneClear.UseW:Value() then
					if ValidTarget(minion, GetRange(myHero)+100) then
						if CanUseSpell(myHero,_W) == READY then
							if GotBuff(myHero, "pickacard_tracker") == 0 then
								local TimerW = GetTickCount()
								if (GlobalTimer + 1000) < TimerW then
									CastSpell(_W)
									GlobalTimer = TimerW
								end
							else
								if TwistedFateMenu.LaneClear.ModeW:Value() == 1 then
									if TwistedFateMenu.LaneClear.PickW:Value() == 1 then
										if CurrentCard == "Blue" then
											CastSpell(_W)
											CurrentCard = "nil"
										end
									elseif TwistedFateMenu.LaneClear.PickW:Value() == 2 then
										if CurrentCard == "Red" then
											CastSpell(_W)
											CurrentCard = "nil"
										end
									end
								elseif TwistedFateMenu.LaneClear.ModeW:Value() == 2 then
									if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > TwistedFateMenu.Misc.MP:Value() then
										if CurrentCard == "Red" then
											CastSpell(_W)
											CurrentCard = "nil"
										end
									else
										if CurrentCard == "Blue" then
											CastSpell(_W)
											CurrentCard = "nil"
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY and AA == true then
					if ValidTarget(mob, TwistedFateQ.range) then
						if TwistedFateMenu.JungleClear.UseQ:Value() then
							CastSkillShot(_Q,GetOrigin(mob))
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, GetRange(myHero)) then
						if TwistedFateMenu.JungleClear.UseW:Value() then
							if GotBuff(myHero, "pickacard_tracker") == 0 then
								local TimerW = GetTickCount()
								if (GlobalTimer + 1000) < TimerW then
									CastSpell(_W)
									GlobalTimer = TimerW
								end
							else
								if CurrentCard == "Blue" then
									CastSpell(_W)
									CurrentCard = "nil"
								end
							end
						end
					end
				end
			end
		end
	end
end

-- Misc

function LevelUp()
	if TwistedFateMenu.Misc.LvlUp:Value() then
		if TwistedFateMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif TwistedFateMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif TwistedFateMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif TwistedFateMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif TwistedFateMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif TwistedFateMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Veigar

elseif "Veigar" == GetObjectName(myHero) then

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Veigar loaded successfully!")
local VeigarMenu = Menu("[T01] Veigar", "[T01] Veigar")
VeigarMenu:Menu("Auto", "Auto")
VeigarMenu.Auto:Boolean('UseQ', 'Use Q [Baleful Strike]', true)
VeigarMenu.Auto:Boolean('UseW', 'Use W [Dark Matter]', true)
VeigarMenu.Auto:Boolean('UseE', 'Use E [Event Horizon]', false)
VeigarMenu.Auto:DropDown("ModeW", "Cast Mode: W", 2, {"Standard", "On Stunned"})
VeigarMenu.Auto:Slider("MP","Mana-Manager", 40, 0, 100, 5)
VeigarMenu:Menu("Combo", "Combo")
VeigarMenu.Combo:Boolean('UseQ', 'Use Q [Baleful Strike]', true)
VeigarMenu.Combo:Boolean('UseW', 'Use W [Dark Matter]', true)
VeigarMenu.Combo:Boolean('UseE', 'Use E [Event Horizon]', true)
VeigarMenu.Combo:DropDown("ModeW", "Cast Mode: W", 1, {"Standard", "On Stunned"})
VeigarMenu:Menu("Harass", "Harass")
VeigarMenu.Harass:Boolean('UseQ', 'Use Q [Baleful Strike]', true)
VeigarMenu.Harass:Boolean('UseW', 'Use W [Dark Matter]', true)
VeigarMenu.Harass:Boolean('UseE', 'Use E [Event Horizon]', true)
VeigarMenu.Harass:DropDown("ModeW", "Cast Mode: W", 2, {"Standard", "On Stunned"})
VeigarMenu.Harass:Slider("MP","Mana-Manager", 40, 0, 100, 5)
VeigarMenu:Menu("KillSteal", "KillSteal")
VeigarMenu.KillSteal:Boolean('UseR', 'Use R [Primordial Burst]', true)
VeigarMenu:Menu("LastHit", "LastHit")
VeigarMenu.LastHit:Boolean('UseQ', 'Use Q [Baleful Strike]', true)
VeigarMenu.LastHit:Slider("MP","Mana-Manager", 40, 0, 100, 5)
VeigarMenu:Menu("LaneClear", "LaneClear")
VeigarMenu.LaneClear:Boolean('UseQ', 'Use Q [Baleful Strike]', false)
VeigarMenu.LaneClear:Boolean('UseW', 'Use W [Dark Matter]', true)
VeigarMenu.LaneClear:Slider("MP","Mana-Manager", 40, 0, 100, 5)
VeigarMenu:Menu("JungleClear", "JungleClear")
VeigarMenu.JungleClear:Boolean('UseQ', 'Use Q [Baleful Strike]', true)
VeigarMenu.JungleClear:Boolean('UseW', 'Use W [Dark Matter]', true)
VeigarMenu:Menu("AntiGapcloser", "Anti-Gapcloser")
VeigarMenu.AntiGapcloser:Boolean('UseE', 'Use E [Event Horizon]', true)
VeigarMenu:Menu("Prediction", "Prediction")
VeigarMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
VeigarMenu.Prediction:DropDown("PredictionW", "Prediction: W", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
VeigarMenu.Prediction:DropDown("PredictionE", "Prediction: E", 1, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
VeigarMenu:Menu("Misc", "Misc")
VeigarMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
VeigarMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 1, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})

local VeigarQ = { range = 950, radius = 70, width = 70, speed = 2200, delay = 0.25, type = "line", collision = true, source = myHero }
local VeigarW = { range = 900, radius = 225, width = 225, speed = math.huge, delay = 1.25, type = "circular", collision = false, source = myHero }
local VeigarE = { range = 700, radius = 375, width = 375, speed = math.huge, delay = 0.75, type = "circular", collision = false, source = myHero }
local VeigarR = { range = 650 }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	KillSteal()
	LastHit()
	LaneClear()
	JungleClear()
	AntiGapcloser()
	LevelUp()
end)

function useQ(target)
	if GetDistance(target) < VeigarQ.range then
		if VeigarMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif VeigarMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),VeigarQ.speed,VeigarQ.delay*1000,VeigarQ.range,VeigarQ.radius,true,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif VeigarMenu.Prediction.PredictionQ:Value() == 3 then
			local qPred = _G.gPred:GetPrediction(target,myHero,VeigarQ,false,true)
			if qPred and qPred.HitChance >= 3 then
				CastSkillShot(_Q, qPred.CastPosition)
			end
		elseif VeigarMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="VeigarBalefulStrike", range=VeigarQ.range, speed=VeigarQ.speed, delay=VeigarQ.delay, width=VeigarQ.radius, type="linear", collision=true})
			ts = TargetSelector()
			target = ts:GetTarget(VeigarQ.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif VeigarMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetLinearAOEPrediction(target,VeigarQ)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useW(target)
	if GetDistance(target) < VeigarW.range then
		if VeigarMenu.Prediction.PredictionW:Value() == 1 then
			CastSkillShot(_W,GetOrigin(target))
		elseif VeigarMenu.Prediction.PredictionW:Value() == 2 then
			local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),VeigarW.speed,VeigarW.delay*1000,VeigarW.range,VeigarW.width,false,true)
			if WPred.HitChance == 1 then
				CastSkillShot(_W, WPred.PredPos)
			end
		elseif VeigarMenu.Prediction.PredictionW:Value() == 3 then
			local WPred = _G.gPred:GetPrediction(target,myHero,VeigarW,true,false)
			if WPred and WPred.HitChance >= 3 then
				CastSkillShot(_W, WPred.CastPosition)
			end
		elseif VeigarMenu.Prediction.PredictionW:Value() == 4 then
			local WSpell = IPrediction.Prediction({name="VeigarDarkMatter", range=VeigarW.range, speed=VeigarW.speed, delay=VeigarW.delay, width=VeigarW.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(VeigarW.range)
			local x, y = WSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_W, y.x, y.y, y.z)
			end
		elseif VeigarMenu.Prediction.PredictionW:Value() == 5 then
			local WPrediction = GetCircularAOEPrediction(target,VeigarW)
			if WPrediction.hitChance > 0.9 then
				CastSkillShot(_W, WPrediction.castPos)
			end
		end
	end
end
function useWIM(target)
	CastSkillShot(_W,GetOrigin(target))
end
function useE(target)
	if GetDistance(target) < VeigarE.range then
		if VeigarMenu.Prediction.PredictionE:Value() == 1 then
			CastSkillShot(_E,GetOrigin(target))
		elseif VeigarMenu.Prediction.PredictionE:Value() == 2 then
			local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),VeigarE.speed,VeigarE.delay*1000,VeigarE.range,VeigarE.width,false,true)
			if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
			end
		elseif VeigarMenu.Prediction.PredictionE:Value() == 3 then
			local EPred = _G.gPred:GetPrediction(target,myHero,VeigarE,true,false)
			if EPred and EPred.HitChance >= 3 then
				CastSkillShot(_E, EPred.CastPosition)
			end
		elseif VeigarMenu.Prediction.PredictionE:Value() == 4 then
			local ESpell = IPrediction.Prediction({name="VeigarEventHorizon", range=VeigarE.range, speed=VeigarE.speed, delay=VeigarE.delay, width=VeigarE.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(VeigarE.range)
			local x, y = ESpell:Predict(target)
			if x > 2 then
				CastSkillShot(_E, y.x, y.y, y.z)
			end
		elseif VeigarMenu.Prediction.PredictionE:Value() == 5 then
			local EPrediction = GetCircularAOEPrediction(target,VeigarE)
			if EPrediction.hitChance > 0.9 then
				CastSkillShot(_E, EPrediction.castPos)
			end
		end
	end
end

-- Auto

function Auto()
	if VeigarMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, VeigarQ.range) then
					useQ(target)
				end
			end
		end
	end
	if VeigarMenu.Auto.UseW:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, VeigarW.range) then
					if VeigarMenu.Auto.ModeW:Value() == 1 then
						useW(target)
					elseif VeigarMenu.Auto.ModeW:Value() == 2 then
						if GotBuff(target, "veigareventhorizonstun") > 0 then
							useWIM(target)
						end
					end
				end
			end
		end
	end
	if VeigarMenu.Auto.UseE:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, VeigarE.range) then
					useE(target)
				end
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if VeigarMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, VeigarQ.range) then
					useQ(target)
				end
			end
		end
		if VeigarMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, VeigarW.range) then
					if VeigarMenu.Combo.ModeW:Value() == 1 then
						useW(target)
					elseif VeigarMenu.Combo.ModeW:Value() == 2 then
						if GotBuff(target, "veigareventhorizonstun") > 0 then
							useWIM(target)
						end
					end
				end
			end
		end
		if VeigarMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, VeigarE.range) then
					useE(target)
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if VeigarMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, VeigarQ.range) then
						useQ(target)
					end
				end
			end
		end
		if VeigarMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, VeigarW.range) then
						if VeigarMenu.Harass.ModeW:Value() == 1 then
							useW(target)
						elseif VeigarMenu.Harass.ModeW:Value() == 2 then
							if GotBuff(target, "veigareventhorizonstun") > 0 then
								useWIM(target)
							end
						end
					end
				end
			end
		end
		if VeigarMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, VeigarE.range) then
						useE(target)
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if VeigarMenu.KillSteal.UseR:Value() then
			if ValidTarget(enemy, VeigarR.range) then
				if CanUseSpell(myHero,_R) == READY then
					local InitRDmg = GetPercentHP(enemy) > 33.3 and (75*GetCastLevel(myHero,_R)+100)+(0.75*GetBonusAP(myHero)) or (150*GetCastLevel(myHero,_R)+200)+(1.5*GetBonusAP(myHero))
					local VeigarRDmg = InitRDmg+((0.015*InitRDmg)*(100-((GetCurrentHP(enemy)/GetMaxHP(enemy))*100)))
					if GetCurrentHP(enemy)+GetDmgShield(enemy)+GetMagicResist(enemy)+GetMagicShield(enemy)+GetHPRegen(enemy)*2 < VeigarRDmg then
						CastTargetSpell(enemy, _R)
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, VeigarQ.range) then
					if VeigarMenu.LastHit.UseQ:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.LastHit.MP:Value() then
							if CanUseSpell(myHero,_Q) == READY then
								local VeigarQDmg = (40*GetCastLevel(myHero,_Q)+30)+(0.6*GetBonusAP(myHero))
								if GetCurrentHP(minion) < VeigarQDmg then
									useQ(minion)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if VeigarMenu.LaneClear.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.LaneClear.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					local BestPos, BestHit = GetLineFarmPosition(VeigarW.range, VeigarW.radius, MINION_ENEMY)
					if BestPos and BestHit > 3 then  
						CastSkillShot(_W, BestPos)
					end
				end
			end
		end
		if VeigarMenu.LaneClear.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > VeigarMenu.LaneClear.MP:Value() then
				for _, minion in pairs(minionManager.objects) do
					if GetTeam(minion) == MINION_ENEMY then
						if ValidTarget(minion, VeigarQ.range) then
							if VeigarMenu.LaneClear.UseQ:Value() then
								if CanUseSpell(myHero,_Q) == READY then
									useQ(minion)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, VeigarQ.range) then
						if VeigarMenu.JungleClear.UseQ:Value() then
							useQ(mob)
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, VeigarW.range) then
						if VeigarMenu.JungleClear.UseW:Value() then	   
							CastSkillShot(_W,GetOrigin(mob))
						end
					end
				end
			end
		end
	end
end

-- Anti-Gapcloser

function AntiGapcloser()
	for i,antigap in pairs(GetEnemyHeroes()) do
		if VeigarMenu.AntiGapcloser.UseE:Value() then
			if ValidTarget(antigap, VeigarE.radius) then
				if CanUseSpell(myHero,_E) == READY then
					CastSkillShot(_E, myHero)
				end
			end
		end
	end
end

-- Misc

function LevelUp()
	if VeigarMenu.Misc.LvlUp:Value() then
		if VeigarMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VeigarMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VeigarMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VeigarMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VeigarMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VeigarMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Viktor

elseif "Viktor" == GetObjectName(myHero) then

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Viktor loaded successfully!")
local ViktorMenu = Menu("[T01] Viktor", "[T01] Viktor")
ViktorMenu:Menu("Auto", "Auto")
ViktorMenu.Auto:Boolean('UseQ', 'Use Q [Siphon Power]', true)
ViktorMenu.Auto:Boolean('UseW', 'Use W [Gravity Field]', false)
ViktorMenu.Auto:Boolean('UseE', 'Use E [Death Ray]', true)
ViktorMenu.Auto:Slider("MP","Mana-Manager", 40, 0, 100, 5)
ViktorMenu:Menu("Combo", "Combo")
ViktorMenu.Combo:Boolean('UseQ', 'Use Q [Siphon Power]', true)
ViktorMenu.Combo:Boolean('UseW', 'Use W [Gravity Field]', true)
ViktorMenu.Combo:Boolean('UseE', 'Use E [Death Ray]', true)
ViktorMenu.Combo:Boolean('UseR', 'Use R [Chaos Storm]', true)
ViktorMenu:Menu("Harass", "Harass")
ViktorMenu.Harass:Boolean('UseQ', 'Use Q [Siphon Power]', true)
ViktorMenu.Harass:Boolean('UseW', 'Use W [Gravity Field]', true)
ViktorMenu.Harass:Boolean('UseE', 'Use E [Death Ray]', true)
ViktorMenu.Harass:Slider("MP","Mana-Manager", 40, 0, 100, 5)
ViktorMenu:Menu("LastHit", "LastHit")
ViktorMenu.LastHit:Boolean('UseQ', 'Use Q [Siphon Power]', true)
ViktorMenu.LastHit:Slider("MP","Mana-Manager", 40, 0, 100, 5)
ViktorMenu:Menu("LaneClear", "LaneClear")
ViktorMenu.LaneClear:Boolean('UseQ', 'Use Q [Siphon Power]', false)
ViktorMenu.LaneClear:Boolean('UseE', 'Use E [Death Ray]', true)
ViktorMenu.LaneClear:Slider("MP","Mana-Manager", 40, 0, 100, 5)
ViktorMenu:Menu("JungleClear", "JungleClear")
ViktorMenu.JungleClear:Boolean('UseQ', 'Use Q [Siphon Power]', true)
ViktorMenu.JungleClear:Boolean('UseE', 'Use E [Death Ray]', true)
ViktorMenu:Menu("Interrupter", "Interrupter")
ViktorMenu.Interrupter:Boolean('UseW', 'Use W [Gravity Field]', true)
ViktorMenu.Interrupter:Boolean('UseR', 'Use R [Chaos Storm]', true)
ViktorMenu:Menu("Prediction", "Prediction")
ViktorMenu.Prediction:DropDown("PredictionW", "Prediction: W", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
ViktorMenu.Prediction:DropDown("PredictionE", "Prediction: E", 2, {"CurrentPos", "GoSPred", "OpenPredict"})
ViktorMenu.Prediction:DropDown("PredictionR", "Prediction: R", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
ViktorMenu:Menu("Misc", "Misc")
ViktorMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
ViktorMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 5, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
ViktorMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
ViktorMenu.Misc:Slider('HP','HP-Manager: R', 40, 0, 100, 5)

local ViktorQ = { range = 600 }
local ViktorW = { range = 700, radius = 290, width = 290, speed = math.huge, delay = 1.3, type = "circular", collision = false, source = myHero }
local ViktorE = { range = 1025, radius = 80, width = 80, speed = 1050, delay = 0, type = "line", collision = false, source = myHero, col = {"yasuowall"}}
local ViktorR = { range = 700, radius = 290, width = 290, speed = math.huge, delay = 0.25, type = "circular", collision = false, source = myHero }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	LastHit()
	LaneClear()
	JungleClear()
	LevelUp()
end)

function useQ(target)
	BlockInput(true)
	if _G.IOW then
		IOW.attacksEnabled = false
	elseif _G.GoSWalkLoaded then
		_G.GoSWalk:EnableAttack(false)
	elseif _G.DAC_Loaded then
		DAC:AttacksEnabled(false)
	elseif _G.AutoCarry_Loaded then
		DACR.attacksEnabled = false
	end
	CastTargetSpell(target, _Q)
	AttackUnit(target)
	BlockInput(false)
	if _G.IOW then
		IOW.attacksEnabled = true
	elseif _G.GoSWalkLoaded then
		_G.GoSWalk:EnableAttack(true)
	elseif _G.DAC_Loaded then
		DAC:AttacksEnabled(true)
	elseif _G.AutoCarry_Loaded then
		DACR.attacksEnabled = true
	end
end
function useW(target)
	if GetDistance(target) < ViktorW.range then
		if ViktorMenu.Prediction.PredictionW:Value() == 1 then
			CastSkillShot(_W,GetOrigin(target))
		elseif ViktorMenu.Prediction.PredictionW:Value() == 2 then
			local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ViktorW.speed,ViktorW.delay*1000,ViktorW.range,ViktorW.width,false,true)
			if WPred.HitChance == 1 then
				CastSkillShot(_W, WPred.PredPos)
			end
		elseif ViktorMenu.Prediction.PredictionW:Value() == 3 then
			local WPred = _G.gPred:GetPrediction(target,myHero,ViktorW,true,false)
			if WPred and WPred.HitChance >= 3 then
				CastSkillShot(_W, WPred.CastPosition)
			end
		elseif ViktorMenu.Prediction.PredictionW:Value() == 4 then
			local WSpell = IPrediction.Prediction({name="ViktorGravitonField", range=ViktorW.range, speed=ViktorW.speed, delay=ViktorW.delay, width=ViktorW.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(ViktorW.range)
			local x, y = WSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_W, y.x, y.y, y.z)
			end
		elseif ViktorMenu.Prediction.PredictionW:Value() == 5 then
			local WPrediction = GetCircularAOEPrediction(target,ViktorW)
			if WPrediction.hitChance > 0.9 then
				CastSkillShot(_W, WPrediction.castPos)
			end
		end
	end
end
function useE(target)
	if GetDistance(target) < ViktorE.range then
		if ViktorMenu.Prediction.PredictionE:Value() == 1 then
			local StartPos = Vector(myHero)-(ViktorE.range-500)*(Vector(myHero)-Vector(target)):normalized()
			CastSkillShot3(_E,StartPos,target)
		elseif ViktorMenu.Prediction.PredictionE:Value() == 2 then
			local StartPos = Vector(myHero)-(ViktorE.range-500)*(Vector(myHero)-Vector(target)):normalized()
			local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ViktorE.speed,ViktorE.delay*1000,ViktorE.range,ViktorE.width,false,true)
			if EPred.HitChance == 1 then
				CastSkillShot3(_E,StartPos,EPred.PredPos)
			end
		elseif ViktorMenu.Prediction.PredictionE:Value() == 3 then
			local StartPos = Vector(myHero)-(ViktorE.range-500)*(Vector(myHero)-Vector(target)):normalized()
			local EPrediction = GetLinearAOEPrediction(target,ViktorE)
			if EPrediction.hitChance > 0.9 then
				CastSkillShot3(_E,StartPos,EPrediction.castPos)
			end
		end
	end
end
function useR(target)
	if GetDistance(target) < ViktorR.range then
		if ViktorMenu.Prediction.PredictionR:Value() == 1 then
			CastSkillShot(_R,GetOrigin(target))
		elseif ViktorMenu.Prediction.PredictionR:Value() == 2 then
			local RPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ViktorR.speed,ViktorR.delay*1000,ViktorR.range,ViktorR.width,false,true)
			if RPred.HitChance == 1 then
				CastSkillShot(_R, RPred.PredPos)
			end
		elseif ViktorMenu.Prediction.PredictionR:Value() == 3 then
			local RPred = _G.gPred:GetPrediction(target,myHero,ViktorR,true,false)
			if RPred and RPred.HitChance >= 3 then
				CastSkillShot(_R, RPred.CastPosition)
			end
		elseif ViktorMenu.Prediction.PredictionR:Value() == 4 then
			local RSpell = IPrediction.Prediction({name="ViktorChaosStorm", range=ViktorR.range, speed=ViktorR.speed, delay=ViktorR.delay, width=ViktorR.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(ViktorR.range)
			local x, y = RSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_R, y.x, y.y, y.z)
			end
		elseif ViktorMenu.Prediction.PredictionR:Value() == 5 then
			local RPrediction = GetCircularAOEPrediction(target,ViktorR)
			if RPrediction.hitChance > 0.9 then
				CastSkillShot(_R, RPrediction.castPos)
			end
		end
	end
end

-- Interrupter

OnProcessSpell(function(unit, spell)
	if CanUseSpell(myHero,_W) == READY then
		if ViktorMenu.Interrupter.UseW:Value() then
			for _, enemy in pairs(GetEnemyHeroes()) do
				if ValidTarget(enemy, ViktorW.range) then
					local UnitName = GetObjectName(enemy)
					local UnitChanellingSpells = CHANELLING_SPELLS[UnitName]
					local UnitGapcloserSpells = GAPCLOSER_SPELLS[UnitName]
					if UnitChanellingSpells then
						for _, slot in pairs(UnitChanellingSpells) do
							if spell.name == GetCastName(enemy, slot) then useW(enemy) end
						end
					elseif UnitGapcloserSpells then
						for _, slot in pairs(UnitGapcloserSpells) do
							if spell.name == GetCastName(enemy, slot) then useW(enemy) end
						end
					end
				end
			end
		end
    elseif CanUseSpell(myHero,_R) == READY then
		if ViktorMenu.Interrupter.UseR:Value() then
			for _, enemy in pairs(GetEnemyHeroes()) do
				if ValidTarget(enemy, ViktorR.range) then
					local UnitName = GetObjectName(enemy)
					local UnitChanellingSpells = CHANELLING_SPELLS[UnitName]
					local UnitGapcloserSpells = GAPCLOSER_SPELLS[UnitName]
					if UnitChanellingSpells then
						for _, slot in pairs(UnitChanellingSpells) do
							if spell.name == GetCastName(enemy, slot) then useR(enemy) end
						end
					end
				end
			end
		end
	end
end)

-- Auto

function Auto()
	if ViktorMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, ViktorQ.range) then
					useQ(target)
				end
			end
		end
	end
	if ViktorMenu.Auto.UseW:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, ViktorW.range) then
					useW(target)
				end
			end
		end
	end
	if ViktorMenu.Auto.UseE:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, ViktorE.range) then
					useE(target)
				end
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if ViktorMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, ViktorQ.range) then
					useQ(target)
				end
			end
		end
		if ViktorMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, ViktorW.range) then
					useW(target)
				end
			end
		end
		if ViktorMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, ViktorE.range) then
					useE(target)
				end
			end
		end
		if ViktorMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, ViktorR.range) then
					if 100*GetCurrentHP(target)/GetMaxHP(target) < ViktorMenu.Misc.HP:Value() then
						if EnemiesAround(myHero, ViktorR.range) >= ViktorMenu.Misc.X:Value() then
							useR(target)
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if ViktorMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(target, ViktorQ.range) then
						useQ(target)
					end
				end
			end
		end
		if ViktorMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(target, ViktorW.range) then
						useW(target)
					end
				end
			end
		end
		if ViktorMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(target, ViktorE.range) then
						useE(target)
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, ViktorQ.range) then
					if ViktorMenu.LastHit.UseQ:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.LastHit.MP:Value() then
							if CanUseSpell(myHero,_Q) == READY then
								local ViktorQDmg = ((20*GetCastLevel(myHero,_Q)+40)+(0.4*GetBonusAP(myHero)))+((20*GetCastLevel(myHero,_Q))+(GetBonusDmg(myHero)+GetBaseDamage(myHero))+(0.5*GetBonusAP(myHero)))
								local MinionToLastHit = minion
								if GetCurrentHP(MinionToLastHit) < ViktorQDmg then
									useQ(MinionToLastHit)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if ViktorMenu.LaneClear.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.LaneClear.MP:Value() then
				if CanUseSpell(myHero,_E) == READY then
					local BestPos, BestHit = GetLineFarmPosition(ViktorE.range, ViktorE.radius, MINION_ENEMY)
					if BestPos and BestHit > 3 then
						local StartPos = Vector(myHero)-(ViktorE.range-500)*(Vector(myHero)-Vector(BestPos)):normalized()
						CastSkillShot3(_E,StartPos,BestPos)
					end
				end
			end
		end
		if ViktorMenu.LaneClear.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > ViktorMenu.LaneClear.MP:Value() then
				for _, minion in pairs(minionManager.objects) do
					if GetTeam(minion) == MINION_ENEMY then
						if ValidTarget(minion, ViktorQ.range) then
							if ViktorMenu.LaneClear.UseQ:Value() then
								if CanUseSpell(myHero,_Q) == READY then
									useQ(minion)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, ViktorQ.range) then
						if ViktorMenu.JungleClear.UseQ:Value() then
							useQ(mob)
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, ViktorE.range) then
						if ViktorMenu.JungleClear.UseE:Value() then
							StartPos = Vector(myHero)-ViktorE.range*(Vector(myHero)-Vector(mob)):normalized()		   
							CastSkillShot3(_E, StartPos, mob)
						end
					end
				end
			end
		end
	end
end

-- Misc

function LevelUp()
	if ViktorMenu.Misc.LvlUp:Value() then
		if ViktorMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ViktorMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ViktorMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ViktorMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ViktorMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ViktorMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Vladimir

elseif "Vladimir" == GetObjectName(myHero) then

if not pcall( require, "AntiDangerousSpells" ) then PrintChat("<font color='#00BFFF'>AntiDangerousSpells.lua not detected! Probably incorrect file name or doesnt exist in Common folder!") return end

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Vladimir loaded successfully!")
local VladimirMenu = Menu("[T01] Vladimir", "[T01] Vladimir")
VladimirMenu:Menu("Auto", "Auto")
VladimirMenu.Auto:Boolean('UseQ', 'Use Q [Transfusion]', true)
VladimirMenu.Auto:Boolean('UseW', 'Use W [Sanguine Pool]', true)
VladimirMenu.Auto:Boolean('UseE', 'Use E [Tides of Blood]', false)
VladimirMenu:Menu("Combo", "Combo")
VladimirMenu.Combo:Boolean('UseQ', 'Use Q [Transfusion]', true)
VladimirMenu.Combo:Boolean('UseE', 'Use E [Tides of Blood]', true)
VladimirMenu.Combo:Boolean('UseR', 'Use R [Hemoplague]', true)
VladimirMenu:Menu("Harass", "Harass")
VladimirMenu.Harass:Boolean('UseQ', 'Use Q [Transfusion]', true)
VladimirMenu.Harass:Boolean('UseE', 'Use E [Tides of Blood]', true)
VladimirMenu:Menu("KillSteal", "KillSteal")
VladimirMenu.KillSteal:Boolean('UseR', 'Use R [Hemoplague]', true)
VladimirMenu:Menu("LastHit", "LastHit")
VladimirMenu.LastHit:Boolean('UseQ', 'Use Q [Transfusion]', true)
VladimirMenu:Menu("LaneClear", "LaneClear")
VladimirMenu.LaneClear:Boolean('UseQ', 'Use Q [Transfusion]', false)
VladimirMenu.LaneClear:Boolean('UseW', 'Use W [Sanguine Pool]', false)
VladimirMenu.LaneClear:Boolean('UseE', 'Use E [Tides of Blood]', true)
VladimirMenu:Menu("JungleClear", "JungleClear")
VladimirMenu.JungleClear:Boolean('UseQ', 'Use Q [Transfusion]', true)
VladimirMenu.JungleClear:Boolean('UseW', 'Use W [Sanguine Pool]', true)
VladimirMenu.JungleClear:Boolean('UseE', 'Use E [Tides of Blood]', true)
VladimirMenu:Menu("AntiGapcloser", "Anti-Gapcloser")
VladimirMenu.AntiGapcloser:Boolean('UseW', 'Use W [Sanguine Pool]', true)
VladimirMenu:Menu("Prediction", "Prediction")
VladimirMenu.Prediction:DropDown("PredictionR", "Prediction: R", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
VladimirMenu:Menu("Misc", "Misc")
VladimirMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
VladimirMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 2, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
VladimirMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
VladimirMenu.Misc:Slider('HP','HP-Manager: R', 40, 0, 100, 5)

local VladimirQ = { range = 600 }
local VladimirW = { range = 300 }
local VladimirE = { range = 600 }
local VladimirR = { range = 700, radius = 350, width = 350, speed = math.huge, delay = 0.389, type = "circular", collision = false, source = myHero }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	KillSteal()
	LastHit()
	LaneClear()
	JungleClear()
	AntiGapcloser()
	LevelUp()
end)

function useQ(target)
	CastTargetSpell(target, _Q)
end
function useW(target)
	BlockInput(true)
	if _G.IOW then
		IOW.attacksEnabled = false
	elseif _G.GoSWalkLoaded then
		_G.GoSWalk:EnableAttack(false)
	elseif _G.DAC_Loaded then
		DAC:AttacksEnabled(false)
	elseif _G.AutoCarry_Loaded then
		DACR.attacksEnabled = false
	end
	CastSpell(_W)
end
function useE(target)
	BlockInput(true)
	if _G.IOW then
		IOW.attacksEnabled = false
	elseif _G.GoSWalkLoaded then
		_G.GoSWalk:EnableAttack(false)
	elseif _G.DAC_Loaded then
		DAC:AttacksEnabled(false)
	elseif _G.AutoCarry_Loaded then
		DACR.attacksEnabled = false
	end
	CastSkillShot(_E,GetMousePos())
end
OnTick(function(myHero)
	if GotBuff(myHero,"VladimirSanguinePool") > 0 or GotBuff(myHero,"VladimirE") > 0 then
		BlockInput(true)
		if _G.IOW then
			IOW.attacksEnabled = false
		elseif _G.GoSWalkLoaded then
			_G.GoSWalk:EnableAttack(false)
		elseif _G.DAC_Loaded then
			DAC:AttacksEnabled(false)
		elseif _G.AutoCarry_Loaded then
			DACR.attacksEnabled = false
		end
	else
		BlockInput(false)
		if _G.IOW then
			IOW.attacksEnabled = true
		elseif _G.GoSWalkLoaded then
			_G.GoSWalk:EnableAttack(true)
		elseif _G.DAC_Loaded then
			DAC:AttacksEnabled(true)
		elseif _G.AutoCarry_Loaded then
			DACR.attacksEnabled = true
		end
	end
end)
function useR(target)
	if GetDistance(target) < VladimirR.range then
		if VladimirMenu.Prediction.PredictionR:Value() == 1 then
			CastSkillShot(_R,GetOrigin(target))
		elseif VladimirMenu.Prediction.PredictionR:Value() == 2 then
			local RPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),VladimirR.speed,VladimirR.delay*1000,VladimirR.range,VladimirR.width,false,true)
			if RPred.HitChance == 1 then
				CastSkillShot(_R, RPred.PredPos)
			end
		elseif VladimirMenu.Prediction.PredictionR:Value() == 3 then
			local RPred = _G.gPred:GetPrediction(target,myHero,VladimirR,true,false)
			if RPred and RPred.HitChance >= 3 then
				CastSkillShot(_R, RPred.CastPosition)
			end
		elseif VladimirMenu.Prediction.PredictionR:Value() == 4 then
			local RSpell = IPrediction.Prediction({name="VladimirR", range=VladimirR.range, speed=VladimirR.speed, delay=VladimirR.delay, width=VladimirR.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(VladimirR.range)
			local x, y = RSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_R, y.x, y.y, y.z)
			end
		elseif VladimirMenu.Prediction.PredictionR:Value() == 5 then
			local RPrediction = GetCircularAOEPrediction(target,VladimirR)
			if RPrediction.hitChance > 0.9 then
				CastSkillShot(_R, RPrediction.castPos)
			end
		end
	end
end

-- Auto

function Auto()
	if VladimirMenu.Auto.UseQ:Value() then
		if CanUseSpell(myHero,_Q) == READY then
			if ValidTarget(target, VladimirQ.range) then
				useQ(target)
			end
		end
	end
	if VladimirMenu.Auto.UseE:Value() then
		if CanUseSpell(myHero,_E) == READY then
			if ValidTarget(target, VladimirE.range) then
				useE(target)
			end
		end
	end
end
addAntiDSCallback(function()
	if VladimirMenu.Auto.UseW:Value() then
		if CanUseSpell(myHero,_W) == READY then
			CastSpell(_W)
		end
	end
end)

-- Combo

function Combo()
	if Mode() == "Combo" then
		if VladimirMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, VladimirQ.range) then
					useQ(target)
				end
			end
		end
		if VladimirMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, VladimirE.range) then
					useE(target)
				end
			end
		end
		if VladimirMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, VladimirR.range) then
					if 100*GetCurrentHP(target)/GetMaxHP(target) < VladimirMenu.Misc.HP:Value() then
						if EnemiesAround(myHero, VladimirR.range) >= VladimirMenu.Misc.X:Value() then
							useR(target)
						end
					end
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if VladimirMenu.Harass.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, VladimirQ.range) then
					useQ(target)
				end
			end
		end
		if VladimirMenu.Harass.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, VladimirE.range) then
					useE(target)
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if VladimirMenu.KillSteal.UseR:Value() then
			if ValidTarget(enemy, VladimirR.range) then
				if CanUseSpell(myHero,_R) == READY then
					if AlliesAround(myHero, 1000) == 0 then
						local VladimirRDmg = (100*GetCastLevel(myHero,_R)+50)+(0.7*GetBonusAP(myHero))
						if GetCurrentHP(enemy)+GetDmgShield(enemy)+GetMagicResist(enemy)+GetMagicShield(enemy)+GetHPRegen(enemy)*2 < VladimirRDmg then
							CastTargetSpell(enemy, _R)
						end
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, VladimirQ.range) then
					if VladimirMenu.LastHit.UseQ:Value() then
						if CanUseSpell(myHero,_Q) == READY then
							local VladimirQDmg = (20*GetCastLevel(myHero,_Q)+60)+(0.6*GetBonusAP(myHero))
							if GotBuff(myHero, "vladimirqfrenzy") > 0 then
								if GetCurrentHP(minion) < VladimirQDmg*1.85 then
									useQ(minion)
								end
							else
								if GetCurrentHP(minion) < VladimirQDmg then
									useQ(minion)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		for _,minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if VladimirMenu.LaneClear.UseQ:Value() then
					if ValidTarget(minion, VladimirQ.range) then
						if CanUseSpell(myHero,_Q) == READY then
							useQ(minion)
						end
					end
				end
				if VladimirMenu.LaneClear.UseW:Value() then
					if ValidTarget(minion, VladimirW.range) then
						if CanUseSpell(myHero,_W) == READY then
							if MinionsAround(myHero, VladimirW.range) >= 3 then
								useW(minion)
							end
						end
					end
				end
				if VladimirMenu.LaneClear.UseE:Value() then
					if ValidTarget(minion, VladimirE.range) then
						if CanUseSpell(myHero,_E) == READY then
							if MinionsAround(myHero, VladimirE.range) >= 3 then
								useE(minion)
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, VladimirQ.range) then
						if VladimirMenu.JungleClear.UseQ:Value() then
							useQ(mob)
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, VladimirW.range) then
						if VladimirMenu.JungleClear.UseW:Value() then
							useW(mob)
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, VladimirE.range) then
						if VladimirMenu.JungleClear.UseE:Value() then
							CastSkillShot(_E,GetOrigin(mob))
						end
					end
				end
			end
		end
	end
end

-- Anti-Gapcloser

function AntiGapcloser()
	for i,antigap in pairs(GetEnemyHeroes()) do
		if VladimirMenu.AntiGapcloser.UseW:Value() then
			if ValidTarget(antigap, 150) then
				if CanUseSpell(myHero,_W) == READY then
					CastSpell(_W)
				end
			end
		end
	end
end

-- Misc

function LevelUp()
	if VladimirMenu.Misc.LvlUp:Value() then
		if VladimirMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VladimirMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VladimirMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VladimirMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VladimirMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif VladimirMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Xerath

elseif "Xerath" == GetObjectName(myHero) then

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Xerath loaded successfully!")
local XerathMenu = Menu("[T01] Xerath", "[T01] Xerath")
XerathMenu:Menu("Auto", "Auto")
XerathMenu.Auto:Boolean('UseQ', 'Use Q [Arcanopulse]', true)
XerathMenu.Auto:Boolean('UseW', 'Use W [Eye of Destruction]', true)
XerathMenu.Auto:Boolean('UseE', 'Use E [Shocking Orb]', false)
XerathMenu.Auto:Slider("MP","Mana-Manager", 40, 0, 100, 5)
XerathMenu:Menu("Combo", "Combo")
XerathMenu.Combo:Boolean('UseQ', 'Use Q [Arcanopulse]', true)
XerathMenu.Combo:Boolean('UseW', 'Use W [Eye of Destruction]', true)
XerathMenu.Combo:Boolean('UseE', 'Use E [Shocking Orb]', true)
XerathMenu:Menu("Harass", "Harass")
XerathMenu.Harass:Boolean('UseQ', 'Use Q [Arcanopulse]', true)
XerathMenu.Harass:Boolean('UseW', 'Use W [Eye of Destruction]', false)
XerathMenu.Harass:Boolean('UseE', 'Use E [Shocking Orb]', false)
XerathMenu.Harass:Slider("MP","Mana-Manager", 40, 0, 100, 5)
XerathMenu:Menu("KillSteal", "KillSteal")
XerathMenu.KillSteal:Boolean('UseR', 'Use R [Rite of the Arcane]', true)
XerathMenu.KillSteal:DropDown("ModeR", "Cast Mode: R", 1, {"Auto", "Near Mouse"})
XerathMenu:Menu("LastHit", "LastHit")
XerathMenu.LastHit:Boolean('UseE', 'Use E [Sweeping Blade]', true)
XerathMenu.LastHit:Slider("MP","Mana-Manager", 40, 0, 100, 5)
XerathMenu:Menu("LaneClear", "LaneClear")
XerathMenu.LaneClear:Boolean('UseQ', 'Use Q [Arcanopulse]', true)
XerathMenu.LaneClear:Boolean('UseW', 'Use W [Eye of Destruction]', true)
XerathMenu.LaneClear:Slider("MP","Mana-Manager", 40, 0, 100, 5)
XerathMenu:Menu("JungleClear", "JungleClear")
XerathMenu.JungleClear:Boolean('UseQ', 'Use Q [Arcanopulse]', true)
XerathMenu.JungleClear:Boolean('UseW', 'Use W [Eye of Destruction]', true)
XerathMenu.JungleClear:Boolean('UseE', 'Use E [Shocking Orb]', true)
XerathMenu:Menu("AntiGapcloser", "Anti-Gapcloser")
XerathMenu.AntiGapcloser:Boolean('UseE', 'Use E [Shocking Orb]', true)
XerathMenu:Menu("Interrupter", "Interrupter")
XerathMenu.Interrupter:Boolean('UseE', 'Use E [Shocking Orb]', true)
XerathMenu:Menu("Prediction", "Prediction")
XerathMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
XerathMenu.Prediction:DropDown("PredictionW", "Prediction: W", 5, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
XerathMenu.Prediction:DropDown("PredictionE", "Prediction: E", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
XerathMenu.Prediction:DropDown("PredictionR", "Prediction: R", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
XerathMenu:Menu("Misc", "Misc")
XerathMenu.Misc:Key("UseQ", "Release Q Key", string.byte("A"))
XerathMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
XerathMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 1, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
XerathMenu.Misc:Boolean('ExtraDelay', 'Delay Before Casting Q', false)
XerathMenu.Misc:Slider("ED","Extended Delay: Q", 0.1, 0, 1, 0.05)

local XerathQ = { range = 1400, radius = 75, width = 75, speed = math.huge, delay = 0.5, type = "line", collision = false, source = myHero }
local XerathW = { range = 1100, radius = 235, width = 235, speed = math.huge, delay = 0.5, type = "circular", collision = false, source = myHero }
local XerathE = { range = 1050, radius = 60, width = 60, speed = 1400, delay = 0.2, type = "line", collision = true, source = myHero, col = {"minion","champion","yasuowall"}}
local XerathR = { range = GetCastRange(myHero,_R), radius = 200, width = 200, speed = math.huge, delay = 0.6, type = "circular", collision = false, source = myHero }

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	KillSteal()
	LastHit()
	LaneClear()
	JungleClear()
	AntiGapcloser()
	LevelUp()
end)

function useQ(target)
	if ValidTarget(target, XerathQ.range) then
		if GotBuff(myHero, "XerathArcanopulseChargeUp") > 0 then
			if XerathMenu.Misc.UseQ:Value() then
				if XerathMenu.Prediction.PredictionQ:Value() == 1 then
					if XerathMenu.Misc.ExtraDelay:Value() then
						DelayAction(function() CastSkillShot2(_Q,GetOrigin(target)) end, XerathMenu.Misc.ED:Value())
					else
						CastSkillShot2(_Q,GetOrigin(target))
					end
				elseif XerathMenu.Prediction.PredictionQ:Value() == 2 then
					if XerathMenu.Misc.ExtraDelay:Value() then
						DelayAction(function() 
							local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),XerathQ.speed,XerathQ.delay*1000,XerathQ.range,XerathQ.width,false,true)
							if QPred.HitChance == 1 then
								CastSkillShot2(_Q, QPred.PredPos)
							end
						end, XerathMenu.Misc.ED:Value())
					else
						local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),XerathQ.speed,XerathQ.delay*1000,XerathQ.range,XerathQ.width,false,true)
						if QPred.HitChance == 1 then
							CastSkillShot2(_Q, QPred.PredPos)
						end
					end
				elseif XerathMenu.Prediction.PredictionQ:Value() == 3 then
					if XerathMenu.Misc.ExtraDelay:Value() then
						DelayAction(function() 
							local qPred = _G.gPred:GetPrediction(target,myHero,XerathQ,true,false)
							if qPred and qPred.HitChance >= 3 then
								CastSkillShot2(_Q, qPred.CastPosition)
							end
						end, XerathMenu.Misc.ED:Value())
					else
						local qPred = _G.gPred:GetPrediction(target,myHero,XerathQ,true,false)
						if qPred and qPred.HitChance >= 3 then
							CastSkillShot2(_Q, qPred.CastPosition)
						end
					end
				elseif XerathMenu.Prediction.PredictionQ:Value() == 4 then
					if XerathMenu.Misc.ExtraDelay:Value() then
						DelayAction(function() 
							local QSpell = IPrediction.Prediction({name="XerathArcanopulse2", range=XerathQ.range, speed=XerathQ.speed, delay=XerathQ.delay, width=XerathQ.width, type="linear", collision=false})
							ts = TargetSelector()
							target = ts:GetTarget(XerathQ.range)
							local x, y = QSpell:Predict(target)
							if x > 2 then
								CastSkillShot2(_Q, y.x, y.y, y.z)
							end
						end, XerathMenu.Misc.ED:Value())
					else
						local QSpell = IPrediction.Prediction({name="XerathArcanopulse2", range=XerathQ.range, speed=XerathQ.speed, delay=XerathQ.delay, width=XerathQ.width, type="linear", collision=false})
						ts = TargetSelector()
						target = ts:GetTarget(XerathQ.range)
						local x, y = QSpell:Predict(target)
						if x > 2 then
							CastSkillShot2(_Q, y.x, y.y, y.z)
						end
					end
				elseif XerathMenu.Prediction.PredictionQ:Value() == 5 then
					if XerathMenu.Misc.ExtraDelay:Value() then
						DelayAction(function() 
							local QPrediction = GetLinearAOEPrediction(target,XerathQ)
							if QPrediction.hitChance > 0.9 then
								CastSkillShot2(_Q, QPrediction.castPos)
							end
						end, XerathMenu.Misc.ED:Value())
					else
						local QPrediction = GetLinearAOEPrediction(target,XerathQ)
						if QPrediction.hitChance > 0.9 then
							CastSkillShot2(_Q, QPrediction.castPos)
						end
					end
				end
			end
		else
			CastSkillShot(_Q,GetMousePos())
		end
	end
end
function useW(target)
	if GetDistance(target) < XerathW.range then
		if XerathMenu.Prediction.PredictionW:Value() == 1 then
			CastSkillShot(_W,GetOrigin(target))
		elseif XerathMenu.Prediction.PredictionW:Value() == 2 then
			local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),XerathW.speed,XerathW.delay*1000,XerathW.range,XerathW.width,false,true)
			if WPred.HitChance == 1 then
				CastSkillShot(_W, WPred.PredPos)
			end
		elseif XerathMenu.Prediction.PredictionW:Value() == 3 then
			local WPred = _G.gPred:GetPrediction(target,myHero,XerathW,true,false)
			if WPred and WPred.HitChance >= 3 then
				CastSkillShot(_W, WPred.CastPosition)
			end
		elseif XerathMenu.Prediction.PredictionW:Value() == 4 then
			local WSpell = IPrediction.Prediction({name="XerathArcaneBarrage2", range=XerathW.range, speed=XerathW.speed, delay=XerathW.delay, width=XerathW.width, type="circular", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(XerathW.range)
			local x, y = WSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_W, y.x, y.y, y.z)
			end
		elseif XerathMenu.Prediction.PredictionW:Value() == 5 then
			local WPrediction = GetCircularAOEPrediction(target,XerathW)
			if WPrediction.hitChance > 0.9 then
				CastSkillShot(_W, WPrediction.castPos)
			end
		end
	end
end
function useE(target)
	if GetDistance(target) < XerathE.range then
		if XerathMenu.Prediction.PredictionE:Value() == 1 then
			CastSkillShot(_E,GetOrigin(target))
		elseif XerathMenu.Prediction.PredictionE:Value() == 2 then
			local EPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),XerathE.speed,XerathE.delay*1000,XerathE.range,XerathE.width,true,false)
			if EPred.HitChance == 1 then
				CastSkillShot(_E, EPred.PredPos)
			end
		elseif XerathMenu.Prediction.PredictionE:Value() == 3 then
			local EPred = _G.gPred:GetPrediction(target,myHero,XerathE,false,true)
			if EPred and EPred.HitChance >= 3 then
				CastSkillShot(_E, EPred.CastPosition)
			end
		elseif XerathMenu.Prediction.PredictionE:Value() == 4 then
			local ESpell = IPrediction.Prediction({name="XerathMageSpear", range=XerathE.range, speed=XerathE.speed, delay=XerathE.delay, width=XerathE.width, type="linear", collision=true})
			ts = TargetSelector()
			target = ts:GetTarget(XerathE.range)
			local x, y = ESpell:Predict(target)
			if x > 2 then
				CastSkillShot(_E, y.x, y.y, y.z)
			end
		elseif XerathMenu.Prediction.PredictionE:Value() == 5 then
			local EPrediction = GetLinearAOEPrediction(target,XerathE)
			if EPrediction.hitChance > 0.9 then
				CastSkillShot(_E, EPrediction.castPos)
			end
		end
	end
end

-- Interrupter

OnProcessSpell(function(unit, spell)
	if XerathMenu.Interrupter.UseE:Value() then
		for _, enemy in pairs(GetEnemyHeroes()) do
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(enemy, XerathE.range) then
					local UnitName = GetObjectName(enemy)
					local UnitChanellingSpells = CHANELLING_SPELLS[UnitName]
					local UnitGapcloserSpells = GAPCLOSER_SPELLS[UnitName]
					if UnitChanellingSpells then
						for _, slot in pairs(UnitChanellingSpells) do
							if spell.name == GetCastName(enemy, slot) then useE(enemy) end
						end
					elseif UnitGapcloserSpells then
						for _, slot in pairs(UnitGapcloserSpells) do
							if spell.name == GetCastName(enemy, slot) then useE(enemy) end
						end
					end
				end
			end
		end
	end
end)

-- Auto

function Auto()
	if XerathMenu.Auto.UseE:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_E) == READY then
				useE(target)
			end
		end
	end
	if XerathMenu.Auto.UseQ:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				useQ(target)
			end
		end
	end
	if XerathMenu.Auto.UseW:Value() then
		if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.Auto.MP:Value() then
			if CanUseSpell(myHero,_W) == READY then
				useW(target)
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if XerathMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				useE(target)
			end
		end
		if XerathMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				useQ(target)
			end
		end
		if XerathMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				useW(target)
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if XerathMenu.Harass.UseE:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_E) == READY then
					useE(target)
				end
			end
		end
		if XerathMenu.Harass.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					useQ(target)
				end
			end
		end
		if XerathMenu.Harass.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.Harass.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					useW(target)
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if XerathMenu.KillSteal.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(enemy, XerathR.range) then
					local XerathRDmg = ((40*GetCastLevel(myHero,_R)+160)+(0.43*GetBonusAP(myHero)))*(2+(GetCastLevel(myHero,_R)))
					if XerathMenu.KillSteal.ModeR:Value() == 1 then
						if GetCurrentHP(enemy)+GetDmgShield(enemy)+GetMagicResist(enemy)+GetMagicShield(enemy)+GetHPRegen(enemy)*2 < XerathRDmg then
							local EnemyToKS = enemy
							if GotBuff(myHero, "xerathrshots") > 0 then
								if XerathMenu.Prediction.PredictionR:Value() == 1 then
									CastSkillShot(_R,GetOrigin(EnemyToKS))
								elseif XerathMenu.Prediction.PredictionR:Value() == 2 then
									local RPred = GetPredictionForPlayer(GetOrigin(myHero),EnemyToKS,GetMoveSpeed(EnemyToKS),XerathR.speed,XerathR.delay*1000,XerathR.range,XerathR.width,false,true)
									if RPred.HitChance == 1 then
										CastSkillShot(_R, RPred.PredPos)
									end
								elseif XerathMenu.Prediction.PredictionR:Value() == 3 then
									local RPred = _G.gPred:GetPrediction(EnemyToKS,myHero,XerathR,true,false)
									if RPred and RPred.HitChance >= 3 then
										CastSkillShot(_R, RPred.CastPosition)
									end
								elseif XerathMenu.Prediction.PredictionR:Value() == 4 then
									local RSpell = IPrediction.Prediction({name="XerathLocusPulse", range=XerathR.range, speed=XerathR.speed, delay=XerathR.delay, width=XerathR.width, type="circular", collision=false})
									local x, y = RSpell:Predict(EnemyToKS)
									if x > 2 then
										CastSkillShot(_R, y.x, y.y, y.z)
									end
								elseif XerathMenu.Prediction.PredictionR:Value() == 5 then
									local RPrediction = GetCircularAOEPrediction(EnemyToKS,XerathR)
									if RPrediction.hitChance > 0.9 then
										CastSkillShot(_R, RPrediction.castPos)
									end
								end
							else
								DrawCircle(EnemyToKS,XerathR.radius,5,25,0xffffd700)
							end
						else
							if GotBuff(myHero, "xerathrshots") > 0 then
								if XerathMenu.Prediction.PredictionR:Value() == 1 then
									CastSkillShot(_R,GetOrigin(enemy))
								elseif XerathMenu.Prediction.PredictionR:Value() == 2 then
									local RPred = GetPredictionForPlayer(GetOrigin(myHero),enemy,GetMoveSpeed(enemy),XerathR.speed,XerathR.delay*1000,XerathR.range,XerathR.width,false,true)
									if RPred.HitChance == 1 then
										CastSkillShot(_R, RPred.PredPos)
									end
								elseif XerathMenu.Prediction.PredictionR:Value() == 3 then
									local RPred = _G.gPred:GetPrediction(enemy,myHero,XerathR,true,false)
									if RPred and RPred.HitChance >= 3 then
										CastSkillShot(_R, RPred.CastPosition)
									end
								elseif XerathMenu.Prediction.PredictionR:Value() == 4 then
									local RSpell = IPrediction.Prediction({name="XerathLocusPulse", range=XerathR.range, speed=XerathR.speed, delay=XerathR.delay, width=XerathR.width, type="circular", collision=false})
									local x, y = RSpell:Predict(enemy)
									if x > 2 then
										CastSkillShot(_R, y.x, y.y, y.z)
									end
								elseif XerathMenu.Prediction.PredictionR:Value() == 5 then
									local RPrediction = GetCircularAOEPrediction(enemy,XerathR)
									if RPrediction.hitChance > 0.9 then
										CastSkillShot(_R, RPrediction.castPos)
									end
								end
							end
						end
					elseif XerathMenu.KillSteal.ModeR:Value() == 2 then
						local EnemyToKS2 = ClosestEnemy(GetMousePos())
						if GotBuff(myHero, "xerathrshots") > 0 then
							if XerathMenu.Prediction.PredictionR:Value() == 1 then
								CastSkillShot(_R,GetOrigin(EnemyToKS2))
							elseif XerathMenu.Prediction.PredictionR:Value() == 2 then
								local RPred = GetPredictionForPlayer(GetOrigin(myHero),EnemyToKS2,GetMoveSpeed(EnemyToKS2),XerathR.speed,XerathR.delay*1000,XerathR.range,XerathR.width,false,true)
								if RPred.HitChance == 1 then
									CastSkillShot(_R, RPred.PredPos)
								end
							elseif XerathMenu.Prediction.PredictionR:Value() == 3 then
								local RPred = _G.gPred:GetPrediction(EnemyToKS2,myHero,XerathR,true,false)
								if RPred and RPred.HitChance >= 3 then
									CastSkillShot(_R, RPred.CastPosition)
								end
							elseif XerathMenu.Prediction.PredictionR:Value() == 4 then
								local RSpell = IPrediction.Prediction({name="XerathLocusPulse", range=XerathR.range, speed=XerathR.speed, delay=XerathR.delay, width=XerathR.width, type="circular", collision=false})
								local x, y = RSpell:Predict(EnemyToKS2)
								if x > 2 then
									CastSkillShot(_R, y.x, y.y, y.z)
								end
							elseif XerathMenu.Prediction.PredictionR:Value() == 5 then
								local RPrediction = GetCircularAOEPrediction(EnemyToKS2,XerathR)
								if RPrediction.hitChance > 0.9 then
									CastSkillShot(_R, RPrediction.castPos)
								end
							end
						else
							if GetCurrentHP(enemy)+GetDmgShield(enemy)+GetMagicResist(enemy)+GetMagicShield(enemy)+GetHPRegen(enemy)*2 < XerathRDmg then
								DrawCircle(enemy,XerathR.radius,5,25,0xffffd700)
							end
						end
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, XerathE.range) then
					if XerathMenu.LastHit.UseE:Value() then
						if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.LastHit.MP:Value() then
							if CanUseSpell(myHero,_E) == READY then
								local XerathEDmg = (30*GetCastLevel(myHero,_E)+50)+(0.45*GetBonusAP(myHero))
								if GetCurrentHP(minion) < XerathEDmg then
									useE(minion)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if XerathMenu.LaneClear.UseQ:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.LaneClear.MP:Value() then
				if CanUseSpell(myHero,_Q) == READY then
					local BestPos, BestHit = GetLineFarmPosition(XerathQ.range, XerathQ.radius, MINION_ENEMY)
					if BestPos and BestHit > 2 then
						if GotBuff(myHero, "XerathArcanopulseChargeUp") > 0 then
							DelayAction(function() CastSkillShot2(_Q, BestPos) end, 0.5)
						else
							CastSkillShot(_Q,GetMousePos())
						end
					end
				end
			end
		end
		if XerathMenu.LaneClear.UseW:Value() then
			if 100*GetCurrentMana(myHero)/GetMaxMana(myHero) > XerathMenu.LaneClear.MP:Value() then
				if CanUseSpell(myHero,_W) == READY then
					local BestPos, BestHit = GetFarmPosition(XerathW.range, XerathW.radius, MINION_ENEMY)
					if BestPos and BestHit > 3 then 
						CastSkillShot(_W, BestPos)
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, XerathQ.range) then
						if XerathMenu.JungleClear.UseQ:Value() then
							if GotBuff(myHero, "XerathArcanopulseChargeUp") > 0 then
								DelayAction(function() CastSkillShot2(_Q,GetOrigin(mob)) end, 0.25)
							else
								CastSkillShot(_Q,GetMousePos())
							end
						end
					end
				end
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, XerathW.range) then
						if XerathMenu.JungleClear.UseW:Value() then
							CastSkillShot(_W,GetOrigin(mob))
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, XerathE.range) then
						if XerathMenu.JungleClear.UseE:Value() then
							CastSkillShot(_E,GetOrigin(mob))
						end
					end
				end
			end
		end
	end
end

-- Anti-Gapcloser

function AntiGapcloser()
	for i,antigap in pairs(GetEnemyHeroes()) do
		if XerathMenu.AntiGapcloser.UseE:Value() then
			if ValidTarget(antigap, 400) then
				if CanUseSpell(myHero,_E) == READY then
					useE(antigap)
				end
			end
		end
	end
end

-- Misc

function LevelUp()
	if XerathMenu.Misc.LvlUp:Value() then
		if XerathMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif XerathMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif XerathMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif XerathMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif XerathMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif XerathMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Yasuo

elseif "Yasuo" == GetObjectName(myHero) then

WALL_SPELLS = { 
    ["Aatrox"]                      = {_E},
    ["Ahri"]                      = {_Q,_E},
    ["Akali"]                      = {_Q},
    ["Amumu"]                      = {_Q},
    ["Anivia"]                      = {_Q,_E},
    ["Annie"]                      = {_Q},
    ["Ashe"]                      = {_W,_R},
    ["AurelionSol"]                      = {_Q},
    ["Bard"]                      = {_Q},
    ["Blitzcrank"]                      = {_Q},
    ["Brand"]                      = {_Q,_R},
    ["Braum"]                      = {_Q,_R},
    ["Caitlyn"]                      = {_Q,_E,_R},
    ["Cassiopeia"]                      = {_W,_E},
    ["Corki"]                      = {_Q,_R},
    ["Diana"]                      = {_Q},
    ["DrMundo"]                      = {_Q},
    ["Draven"]                      = {_E,_R},
    ["Ekko"]                      = {_Q},
    ["Elise"]                      = {_Q,_E},
    ["Evelynn"]                      = {_Q},
    ["Ezreal"]                      = {_Q,_W,_R},
    ["FiddleSticks"]                      = {_E},
    ["Fizz"]                      = {_R},
    ["Galio"]                      = {_Q},
    ["Gangplank"]                      = {_Q},
    ["Gnar"]                      = {_Q},
    ["Gragas"]                      = {_Q,_R},
    ["Graves"]                      = {_Q,_R},
    ["Heimerdinger"]                      = {_W},
    ["Illaoi"]                      = {_Q},
    ["Irelia"]                      = {_R},
    ["Ivern"]                      = {_Q},
    ["Janna"]                      = {_Q,_W},
    ["Jayce"]                      = {_Q},
    ["Jhin"]                      = {_Q,_R},
    ["Jinx"]                      = {_W,_R},
    ["Kaisa"]                      = {_Q,_W},
    ["Kalista"]                      = {_Q},
    ["Karma"]                      = {_Q},
    ["Kassadin"]                      = {_Q},
    ["Katarina"]                      = {_Q,_R},
    ["Kayle"]                      = {_Q},
    ["Kennen"]                      = {_Q},
    ["KhaZix"]                      = {_W},
    ["Kindred"]                      = {_Q},
    ["Kled"]                      = {_Q},
    ["KogMaw"]                      = {_Q,_E},
    ["Leblanc"]                      = {_Q,_E},
    ["Leesin"]                      = {_Q},
    ["Ivern"]                      = {_Q},
    ["Leona"]                      = {_E},
    ["Lissandra"]                      = {_E},
    ["Lucian"]                      = {_W,_R},
    ["Lulu"]                      = {_Q},
    ["Lux"]                      = {_Q,_E},
    ["Malphite"]                      = {_Q},
    ["Missfortune"]                      = {_R},
    ["Morgana"]                      = {_Q},
    ["Nami"]                      = {_W,_R},
    ["Nautilus"]                      = {_Q},
    ["Nocturne"]                      = {_Q},
    ["Ornn"]                      = {_R},
    ["Pantheon"]                      = {_Q},
    ["Quinn"]                      = {_Q},
    ["Rakan"]                      = {_Q},
    ["RekSai"]                      = {_Q},
    ["Rengar"]                      = {_E},
    ["Riven"]                      = {_R},
    ["Ryze"]                      = {_Q,_E},
    ["Sejuani"]                      = {_R},
    ["Sivir"]                      = {_Q},
    ["Skarner"]                      = {_E},
    ["Sona"]                      = {_Q,_R},
    ["Shyvana"]                      = {_E},
    ["Swain"]                      = {_Q,_E,_R},
    ["Syndra"]                      = {_E,_R},
    ["Taliyah"]                      = {_Q},
    ["Talon"]                      = {_W,_R},
    ["Teemo"]                      = {_Q},
    ["Thresh"]                      = {_Q},
    ["Tristana"]                      = {_R},
    ["TwistedFate"]                      = {_Q},
    ["Twitch"]                      = {_W,_R},
    ["Urgot"]                      = {_Q,_R},
    ["Varus"]                      = {_Q,_R},
    ["Vayne"]                      = {_E},
    ["Veigar"]                      = {_Q,_R},
    ["Velkoz"]                      = {_Q,_W},
    ["Viktor"]                      = {_E},
    ["Vladimir"]                      = {_E},
    ["Xayah"]                      = {_Q,_W,_R},
    ["Xerath"]                      = {_E},
    ["Yasuo"]                      = {_Q},
    ["Zac"]                      = {_Q},
    ["Zed"]                      = {_Q},
    ["Ziggs"]                      = {_Q,_W,_E},
    ["Zoe"]                      = {_Q,_E},
    ["Zyra"]                      = {_E}
} 

WALL_SPELLS = { 
    ["AatroxE"]                      = {Spellname ="AatroxE",Name= "Aatrox", Spellslot =_E},
    ["AhriOrbofDeception"]                      = {Spellname ="AhriOrbofDeception",Name = "Ahri", Spellslot =_Q},
    ["AhriSeduce"]                      = {Spellname ="AhriSeduce",Name = "Ahri", Spellslot =_E},
    ["AkaliMota"]                      = {Spellname ="AkaliMota",Name = "Akali", Spellslot =_Q},
    ["BandageToss"]                      = {Spellname ="BandageToss",Name ="Amumu",Spellslot =_Q},
    ["FlashFrost"]                      = {Spellname ="FlashFrost",Name = "Anivia", Spellslot =_Q},
    ["Frostbite"]                      = {Spellname ="Frostbite",Name = "Anivia", Spellslot =_E},
    ["Disintegrate"]                      = {Spellname ="Disintegrate",Name = "Annie", Spellslot =_Q},
    ["Volley"]                      = {Spellname ="Volley",Name ="Ashe", Spellslot =_W},
    ["EnchantedCrystalArrow"]                      = {Spellname ="EnchantedCrystalArrow",Name ="Ashe", Spellslot =_R},
    ["AurelionSolQ"]                      = {Spellname ="AurelionSolQ",Name ="AurelionSol", Spellslot =_Q},
    ["BardQ"]                      = {Spellname ="BardQ",Name ="Bard", Spellslot =_Q},
    ["RocketGrabMissile"]                      = {Spellname ="RocketGrabMissile",Name ="Blitzcrank",Spellslot =_Q},
    ["BrandQ"]                      = {Spellname ="BrandBlaze",Name ="Brand", Spellslot =_Q},
    ["BrandR"]                      = {Spellname ="BrandWildfire",Name ="Brand", Spellslot =_R},
    ["BraumQ"]                      = {Spellname ="BraumQ",Name ="Braum",Spellslot =_Q},
    ["BraumRWapper"]                      = {Spellname ="BraumRWapper",Name ="Braum",Spellslot =_R},
    ["CaitlynPiltoverPeacemaker"]                      = {Spellname ="CaitlynPiltoverPeacemaker",Name ="Caitlyn",Spellslot =_Q},
    ["CaitlynEntrapment"]                      = {Spellname ="CaitlynEntrapment",Name ="Caitlyn",Spellslot =_E},
    ["CaitlynAceintheHole"]                      = {Spellname ="CaitlynAceintheHole",Name ="Caitlyn",Spellslot =_R},
    ["CassiopeiaW"]                      = {Spellname ="CassiopeiaMiasma",Name ="Cassiopeia",Spellslot =_W},
    ["CassiopeiaTwinFang"]                      = {Spellname ="CassiopeiaTwinFang",Name ="Cassiopeia",Spellslot =_E},
    ["PhosphorusBomb"]                      = {Spellname ="PhosphorusBomb",Name ="Corki",Spellslot =_Q},
    ["MissileBarrage"]                      = {Spellname ="MissileBarrage",Name ="Corki",Spellslot =_R},
    ["DianaArc"]                      = {Spellname ="DianaArc",Name ="Diana",Spellslot =_Q},
    ["InfectedCleaverMissileCast"]                      = {Spellname ="InfectedCleaverMissileCast",Name ="DrMundo",Spellslot =_Q},
    ["DravenDoubleShot"]                      = {Spellname ="DravenDoubleShot",Name ="Draven",Spellslot =_E},
    ["DravenRCast"]                      = {Spellname ="DravenRCast",Name ="Draven",Spellslot =_R},
    ["EkkoQ"]                      = {Spellname ="EkkoQ",Name ="Ekko",Spellslot =_Q},
    ["EliseHumanQ"]                      = {Spellname ="EliseHumanQ",Name ="Elise",Spellslot =_Q},
    ["EliseHumanE"]                      = {Spellname ="EliseHumanE",Name ="Elise",Spellslot =_E},
    ["EvelynnQ"]                      = {Spellname ="EvelynnQ",Name ="Evelynn",Spellslot =_Q},
    ["EzrealMysticShot"]                      = {Spellname ="EzrealMysticShot",Name ="Ezreal",Spellslot =_Q,},
    ["EzrealEssenceFlux"]                      = {Spellname ="EzrealEssenceFlux",Name ="Ezreal",Spellslot =_W},
    ["EzrealArcaneShift"]                      = {Spellname ="EzrealArcaneShift",Name ="Ezreal",Spellslot =_R},
    ["FiddlesticksDarkWind"]                      = {Spellname ="FiddlesticksDarkWind",Name ="FiddleSticks",Spellslot =_E},
    ["FizzMarinerDoom"]                      = {Spellname ="FizzMarinerDoom",Name = "Fizz", Spellslot =_R},
    ["GalioResoluteSmite"]                      = {Spellname ="GalioResoluteSmite",Name ="Galio",Spellslot =_Q},
    ["Parley"]                      = {Spellname ="Parley",Name ="Gangplank",Spellslot =_Q},
    ["GnarQ"]                      = {Spellname ="GnarQ",Name ="Gnar",Spellslot =_Q},
    ["GragasQ"]                      = {Spellname ="GragasQ",Name ="Gragas",Spellslot =_Q},
    ["GragasR"]                      = {Spellname ="GragasR",Name ="Gragas",Spellslot =_R},
    ["GravesClusterShot"]                      = {Spellname ="GravesClusterShot",Name ="Graves",Spellslot =_Q},
    ["GravesChargeShot"]                      = {Spellname ="GravesChargeShot",Name ="Graves",Spellslot =_R},
    ["HeimerdingerW"]                      = {Spellname ="HeimerdingerW",Name ="Heimerdinger",Spellslot =_W},
    ["IllaoiQ"]                      = {Spellname ="IllaoiQ",Name ="Illaoi",Spellslot =_Q},
    ["IreliaTranscendentBlades"]                      = {Spellname ="IreliaTranscendentBlades",Name ="Irelia",Spellslot =_R},
    ["IvernQ"]                      = {Spellname ="IvernQ",Name ="Ivern",Spellslot =_Q},
    ["HowlingGale"]                      = {Spellname ="HowlingGale",Name ="Janna",Spellslot =_Q},
    ["Zephyr"]                      = {Spellname ="Zephyr",Name ="Janna",Spellslot =_W},
    ["JayceToTheSkies"]                      = {Spellname ="JayceToTheSkies" or "jayceshockblast",Name ="Jayce",Spellslot =_Q},
    ["jayceshockblast"]                      = {Spellname ="JayceToTheSkies" or "jayceshockblast",Name ="Jayce",Spellslot =_Q},
    ["JhinQ"]                      = {Spellname ="JhinQ",Name ="Jhin",Spellslot =_Q},
    ["JhinRShot"]                      = {Spellname ="JhinRShot",Name ="Jhin",Spellslot =_R},
    ["JinxW"]                      = {Spellname ="JinxW",Name ="Jinx",Spellslot =_W},
    ["JinxR"]                      = {Spellname ="JinxR",Name ="Jinx",Spellslot =_R},
    ["KaisaQ"]                      = {Spellname ="KaisaQ",Name ="Kaisa",Spellslot =_Q},
    ["KaisaW"]                      = {Spellname ="KaisaW",Name ="Kaisa",Spellslot =_W},
    ["KalistaMysticShot"]                      = {Spellname ="KalistaMysticShot",Name ="Kalista",Spellslot =_Q},
    ["KarmaQ"]                      = {Spellname ="KarmaQ",Name ="Karma",Spellslot =_Q},
    ["NullLance"]                      = {Spellname ="NullLance",Name ="Kassadin",Spellslot =_Q},
    ["KatarinaQ"]                      = {Spellname ="KatarinaQ",Name ="Katarina",Spellslot =_Q},
    ["KatarinaR"]                      = {Spellname ="KatarinaR",Name ="Katarina",Spellslot =_R},
    ["KayleQ"]                      = {Spellname ="KayleQ",Name ="Kayle",Spellslot =_Q},
    ["KennenShurikenHurlMissile1"]                      = {Spellname ="KennenShurikenHurlMissile1",Name ="Kennen",Spellslot =_Q},
    ["KhazixW"]                      = {Spellname ="KhazixW",Name ="Khazix",Spellslot =_W},
    ["KhazixWLong"]                      = {Spellname ="KhazixWLong",Name ="Khazix",Spellslot =_W},
    ["KindredQ"]                      = {Spellname ="KindredQ",Name ="Kindred",Spellslot =_Q},
    ["KledQ"]                      = {Spellname ="KledQ",Name ="Kled",Spellslot =_Q},
    ["KledRiderQ"]                      = {Spellname ="KledRiderQ",Name ="Kled",Spellslot =_Q},
    ["KogMawQ"]                      = {Spellname ="KogMawQ",Name ="KogMaw",Spellslot =_Q},
    ["KogMawVoidOoze"]                      = {Spellname ="KogMawE",Name ="KogMaw",Spellslot =_E},
    ["LeblancChaosOrb"]                      = {Spellname ="LeblancChaosOrb",Name ="Leblanc",Spellslot =_Q},
    ["LeblancSoulShackle"]                      = {Spellname ="LeblancSoulShackle" or "LeblancSoulShackleM",Name ="Leblanc",Spellslot =_E},
    ["LeblancSoulShackleM"]                      = {Spellname ="LeblancSoulShackle" or "LeblancSoulShackleM",Name ="Leblanc",Spellslot =_E},
    ["BlindMonkQOne"]                      = {Spellname ="BlindMonkQOne",Name ="Leesin",Spellslot =_Q},
    ["LeonaZenithBladeMissle"]                      = {Spellname ="LeonaZenithBladeMissle",Name ="Leona",Spellslot =_E},
    ["LissandraE"]                      = {Spellname ="LissandraE",Name ="Lissandra",Spellslot =_E},
    ["LucianW"]                      = {Spellname ="LucianW",Name ="Lucian",Spellslot =_W},
    ["LucianRMis"]                      = {Spellname ="LucianR",Name ="Lucian",Spellslot =_R},
    ["LuluQ"]                      = {Spellname ="LuluQ",Name ="Lulu",Spellslot =_Q},
    ["LuxLightBinding"]                      = {Spellname ="LuxLightBinding",Name ="Lux",Spellslot =_Q},
    ["LuxLightStrikeKugel"]                      = {Spellname ="LuxLightStrikeKugel",Name ="Lux",Spellslot =_E},
    ["MalphiteQ"]                      = {Spellname ="MalphiteQ",Name ="Malphite",Spellslot =_Q},
    ["MissFortuneBulletTime"]                      = {Spellname ="MissFortuneBulletTime",Name ="Missfortune",Spellslot =_R},
    ["DarkBindingMissile"]                      = {Spellname ="DarkBindingMissile",Name ="Morgana",Spellslot =_Q},
    ["NamiW"]                      = {Spellname ="NamiW",Name ="Nami",Spellslot =_W},
    ["NamiR"]                      = {Spellname ="NamiR",Name ="Nami",Spellslot =_R},
    ["NautilusAnchorDrag"]                      = {Spellname ="NautilusAnchorDrag",Name ="Nautilus",Spellslot =_Q},
    ["JavelinToss"]                      = {Spellname ="JavelinToss",Name ="Nidalee",Spellslot =_Q},
    ["NocturneDuskbringer"]                      = {Spellname ="NocturneDuskbringer",Name ="Nocturne",Spellslot =_Q},
    ["OrnnR"]                      = {Spellname ="OrnnR",Name ="Ornn",Spellslot =_R},
    ["PantheonQ"]                      = {Spellname ="PantheonQ",Name ="Pantheon",Spellslot =_Q},
    ["QuinnQ"]                      = {Spellname ="QuinnQ",Name ="Quinn",Spellslot =_Q},
    ["RakanQ"]                      = {Spellname ="RakanQ",Name ="Rakan",Spellslot =_Q},
    ["reksaiqburrowed"]                      = {Spellname ="reksaiqburrowed",Name ="RekSai",Spellslot =_Q},
    ["RengarE"]                      = {Spellname ="RengarE",Name ="Rengar",Spellslot =_E},
    ["rivenizunablade"]                      = {Spellname ="rivenizunablade",Name ="Riven",Spellslot =_R},
    ["Overload"]                      = {Spellname ="Overload",Name ="Ryze",Spellslot =_Q},
    ["SpellFlux"]                      = {Spellname ="SpellFlux",Name ="Ryze",Spellslot =_E},
    ["SejuaniGlacialPrisonStart"]                      = {Spellname ="SejuaniGlacialPrisonStart",Name ="Sejuani",Spellslot =_R},
    ["SivirQ"]                      = {Spellname ="SivirQ",Name ="Sivir",Spellslot =_Q},
    ["SkarnerFractureMissileSpell"]                      = {Spellname ="SkarnerFractureMissileSpell",Name ="Skarner",Spellslot =_E},
    ["SonaQ"]                      = {Spellname ="SonaQ",Name ="Sona",Spellslot =_Q},
    ["SonaCrescendo"]                      = {Spellname ="SonaCrescendo",Name ="Sona",Spellslot =_R},
    ["ShyvanaFireball"]                      = {Spellname ="ShyvanaFireball",Name ="Shyvana",Spellslot =_E},
    ["SwainDecrepify"]                      = {Spellname ="SwainDecrepify",Name ="Swain",Spellslot =_Q},
    ["SwainTorment"]                      = {Spellname ="SwainTorment",Name ="Swain",Spellslot =_E},
    ["SwainMetamorphism"]                      = {Spellname ="SwainMetamorphism",Name ="Swain",Spellslot =_R},
    ["SyndraE"]                      = {Spellname ="SyndraE",Name ="Syndra",Spellslot =_E},
    ["SyndraR"]                      = {Spellname ="SyndraR",Name ="Syndra",Spellslot =_R},
    ["TaliyahQMis"]                      = {Spellname ="TaliyahQMis",Name ="Taliyah",Spellslot =_Q},
    ["TalonRake"]                      = {Spellname ="TalonRake",Name ="Talon",Spellslot =_W},
    ["TalonShadowAssault"]                      = {Spellname ="TalonShadowAssault",Name ="Talon",Spellslot =_R},
    ["BlindingDart"]                      = {Spellname ="BlindingDart",Name ="Teemo",Spellslot =_Q},
    ["Thresh"]                      = {Spellname ="ThreshQ",Name ="Thresh",Spellslot =_Q},
    ["BusterShot"]                      = {Spellname ="BusterShot",Name ="Tristana",Spellslot =_R},
    ["WildCards"]                      = {Spellname ="WildCards",Name ="TwistedFate",Spellslot =_Q},
    ["TwitchVenomCask"]                      = {Spellname ="TwitchVenomCask",Name ="Twitch",Spellslot =_W},
    ["TwitchSprayAndPrayAttack"]                      = {Spellname ="TwitchSprayAndPrayAttack",Name ="Twitch",Spellslot =_R},
    ["UrgotHeatseekingLineMissile"]                      = {Spellname ="UrgotHeatseekingLineMissile",Name ="Urgot",Spellslot =_Q},
    ["UrgotR"]                      = {Spellname ="UrgotR",Name ="Urgot",Spellslot =_R},
    ["VarusQ"]                      = {Spellname ="VarusQ",Name ="Varus",Spellslot =_Q},
    ["VarusR"]                      = {Spellname ="VarusR",Name ="Varus",Spellslot =_R},
    ["VayneCondemm"]                      = {Spellname ="VayneCondemm",Name ="Vayne",Spellslot =_E},
    ["VeigarBalefulStrike"]                      = {Spellname ="VeigarBalefulStrike",Name ="Veigar",Spellslot =_Q},
    ["VeigarPrimordialBurst"]                      = {Spellname ="VeigarPrimordialBurst",Name ="Veigar",Spellslot =_R},
    ["VelkozQ"]                      = {Spellname ="VelkozQ",Name ="Velkoz",Spellslot =_Q},
    ["VelkozW"]                      = {Spellname ="VelkozW",Name ="Velkoz",Spellslot =_W},
    ["ViktorDeathRay"]                      = {Spellname ="ViktorDeathRay",Name ="Viktor",Spellslot =_E},
    ["VladimirE"]                      = {Spellname ="VladimirE",Name ="Vladimir",Spellslot =_E},
    ["XayahQ"]                      = {Spellname ="XayahQ",Name ="Xayah",Spellslot =_Q},
    ["XayahW"]                      = {Spellname ="XayahW",Name ="Xayah",Spellslot =_W},
    ["XayahR"]                      = {Spellname ="XayahR",Name ="Xayah",Spellslot =_R},
    ["XerathMageSpear"]                      = {Spellname ="XerathMageSpear",Name ="Xerath",Spellslot =_E},
    ["YasuoQ3W"]                      = {Spellname ="YasuoQ3W",Name ="Yasuo",Spellslot =_Q},
    ["ZacQ"]                      = {Spellname ="ZacQ",Name ="Zac",Spellslot =_Q},
    ["ZedShuriken"]                      = {Spellname ="ZedShuriken",Name ="Zed",Spellslot =_Q},
    ["ZiggsQ"]                      = {Spellname ="ZiggsQ",Name ="Ziggs",Spellslot =_Q},
    ["ZiggsW"]                      = {Spellname ="ZiggsW",Name ="Ziggs",Spellslot =_W},
    ["ZiggsE"]                      = {Spellname ="ZiggsE",Name ="Ziggs",Spellslot =_E},
    ["ZoeQ"]                      = {Spellname ="ZoeQ",Name ="Zoe",Spellslot =_Q},
    ["ZoeE"]                      = {Spellname ="ZoeE",Name ="Zoe",Spellslot =_E},
    ["ZyraGraspingRoots"]                      = {Spellname ="ZyraGraspingRoots",Name ="Zyra",Spellslot =_E}
} 

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Yasuo loaded successfully!")
local YasuoMenu = Menu("[T01] Yasuo", "[T01] Yasuo")
YasuoMenu:Menu("Auto", "Auto")
YasuoMenu.Auto:Boolean('UseQ', 'Use Q [Steel Tempest]', true)
YasuoMenu.Auto:Boolean('UseQ3', 'Use Q3 [Gathering Storm]', true)
YasuoMenu.Auto:Boolean('UseW', 'Use W [Wind Wall]', true)
YasuoMenu:Menu("Combo", "Combo")
YasuoMenu.Combo:Boolean('UseQ', 'Use Q [Steel Tempest]', true)
YasuoMenu.Combo:Boolean('UseQ3', 'Use Q3 [Gathering Storm]', true)
YasuoMenu.Combo:Boolean('UseE', 'Use E [Sweeping Blade]', true)
YasuoMenu.Combo:Boolean('UseR', 'Use R [Last Breath]', true)
YasuoMenu:Menu("Harass", "Harass")
YasuoMenu.Harass:Boolean('UseQ', 'Use Q [Steel Tempest]', true)
YasuoMenu.Harass:Boolean('UseQ3', 'Use Q3 [Gathering Storm]', true)
YasuoMenu.Harass:Boolean('UseE', 'Use E [Sweeping Blade]', true)
YasuoMenu:Menu("KillSteal", "KillSteal")
YasuoMenu.KillSteal:Boolean('UseR', 'Use R [Last Breath]', true)
YasuoMenu:Menu("LastHit", "LastHit")
YasuoMenu.LastHit:Boolean('UseE', 'Use E [Sweeping Blade]', true)
YasuoMenu:Menu("LaneClear", "LaneClear")
YasuoMenu.LaneClear:Boolean('UseQ', 'Use Q [Steel Tempest]', true)
YasuoMenu.LaneClear:Boolean('UseQ3', 'Use Q3 [Gathering Storm]', true)
YasuoMenu.LaneClear:Boolean('UseE', 'Use E [Sweeping Blade]', false)
YasuoMenu:Menu("JungleClear", "JungleClear")
YasuoMenu.JungleClear:Boolean('UseQ', 'Use Q [Steel Tempest]', true)
YasuoMenu.JungleClear:Boolean('UseQ3', 'Use Q3 [Gathering Storm]', true)
YasuoMenu.JungleClear:Boolean('UseE', 'Use E [Sweeping Blade]', true)
YasuoMenu:Menu("Interrupter", "Interrupter")
YasuoMenu.Interrupter:Boolean('UseQ3', 'Use Q3 [Gathering Storm]', true)
YasuoMenu:Menu("Prediction", "Prediction")
YasuoMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
YasuoMenu.Prediction:DropDown("PredictionQ3", "Prediction: Q3", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
YasuoMenu:Menu("Misc", "Misc")
YasuoMenu.Misc:Boolean('UI', 'Use Offensive Items', true)
YasuoMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
YasuoMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 2, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
YasuoMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
YasuoMenu.Misc:Slider('HP','HP-Manager: R', 40, 0, 100, 5)

-- > #Deftsu
function GenerateWallPos(unitPos)
	local mydpos = GetOrigin(myHero)
	local tV = {x = (unitPos.x-mydpos.x), z = (unitPos.z-mydpos.z)}
	local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
	return {x = mydpos.x + 400 * tV.x / len, y = 0, z = mydpos.z + 400 * tV.z / len}
end
function GenerateSpellPos(unitPos, spellPos, range)
	local tV = {x = (spellPos.x-unitPos.x), z = (spellPos.z-unitPos.z)}
	local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
	return {x = unitPos.x + range * tV.x / len, y = 0, z = unitPos.z + range * tV.z / len}
end
OnProcessSpell(function(unit, spell)
	if YasuoMenu.Auto.UseW:Value() and WALL_SPELLS[spell.name] then
		myHero = GetMyHero()
		if unit and GetTeam(unit) ~= GetTeam(myHero) and GetObjectType(unit) == GetObjectType(myHero) and GetDistance(unit) < 1500 then
			unispells = WALL_SPELLS[GetObjectName(unit)]
			if myHero == spell.target and GetRange(unit) >= 450 and CalcDamage(unit, myHero, GetBonusDmg(unit)+GetBaseDamage(unit))/GetCurrentHP(myHero) > 0.1337 and not spell.name:lower():find("attack") then
				local wPos = GetOrigin(unit)
				CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
			elseif spell.endPos and not spell.name:lower():find("attack") then
				local makeUpPos = GenerateSpellPos(GetOrigin(unit), spell.endPos, GetDistance(unit, myHero))
				if GetDistanceSqr(makeUpPos) < (GetHitBox(myHero)*3)^2 or GetDistanceSqr(spell.endPos) < (GetHitBox(myHero)*3)^2 then
					local wPos = GetOrigin(unit)
					CastSkillShot(_W, wPos.x, wPos.y, wPos.z)
				end
			end
		end
	end
end)
-- < #Deftsu

local YasuoQ = { range = 475, radius = 40, width = 40, speed = math.huge, delay = GetWindUp(myHero), type = "line", collision = false, source = myHero }
local YasuoQ3 = { range = 1000, radius = 90, width = 90, speed = 1200, delay = GetWindUp(myHero), type = "line", col = {"yasuowall"}, collision = false, source = myHero }
local YasuoW = { range = 400 }
local YasuoE = { range = 475 }
local YasuoR = { range = 1400 }
local ETravelTime = true

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	KillSteal()
	LastHit()
	LaneClear()
	JungleClear()
	LevelUp()
end)

function useQ(target)
	if GetCastRange(myHero,_Q) < 500 then
		if YasuoMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif YasuoMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),YasuoQ.speed,YasuoQ.delay*1000,YasuoQ.range,YasuoQ.width,false,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif YasuoMenu.Prediction.PredictionQ:Value() == 3 then
			local qPred = _G.gPred:GetPrediction(target,myHero,YasuoQ,true,false)
			if qPred and qPred.HitChance >= 3 then
				CastSkillShot(_Q, qPred.CastPosition)
			end
		elseif YasuoMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="YasuoQ", range=YasuoQ.range, speed=YasuoQ.speed, delay=YasuoQ.delay, width=YasuoQ.width, type="linear", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(YasuoQ.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif YasuoMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetPrediction(target,YasuoQ)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useQ3(target)
	if GetCastRange(myHero,_Q) > 600 then
		if GetDistance(target) < YasuoQ3.range then
			if YasuoMenu.Prediction.PredictionQ3:Value() == 1 then
				CastSkillShot(_Q,GetOrigin(target))
			elseif YasuoMenu.Prediction.PredictionQ3:Value() == 2 then
				local Q3Pred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),YasuoQ3.speed,YasuoQ3.delay*1000,YasuoQ3.range,YasuoQ3.width,false,true)
				if Q3Pred.HitChance == 1 then
					CastSkillShot(_Q, Q3Pred.PredPos)
				end
			elseif YasuoMenu.Prediction.PredictionQ3:Value() == 3 then
				local q3Pred = _G.gPred:GetPrediction(target,myHero,YasuoQ3,true,false)
				if q3Pred and q3Pred.HitChance >= 3 then
					CastSkillShot(_Q, q3Pred.CastPosition)
				end
			elseif YasuoMenu.Prediction.PredictionQ3:Value() == 4 then
				local Q3Spell = IPrediction.Prediction({name="YasuoQ3W", range=YasuoQ3.range, speed=YasuoQ3.speed, delay=YasuoQ3.delay, width=YasuoQ3.width, type="linear", collision=false})
				ts = TargetSelector()
				target = ts:GetTarget(YasuoQ3.range)
				local x, y = Q3Spell:Predict(target)
				if x > 2 then
					CastSkillShot(_Q, y.x, y.y, y.z)
				end
			elseif YasuoMenu.Prediction.PredictionQ3:Value() == 5 then
				local Q3Prediction = GetPrediction(target,YasuoQ3)
				if Q3Prediction.hitChance > 0.9 then
					CastSkillShot(_Q, Q3Prediction.castPos)
				end
			end
		end
	end
end
function useE(target)
	CastTargetSpell(target, _E)
end
function useR(target)
	if 100*GetCurrentHP(target)/GetMaxHP(target) < YasuoMenu.Misc.HP:Value() then
		if EnemiesAround(myHero, YasuoR.range) >= YasuoMenu.Misc.X:Value() then
			CastTargetSpell(target, _R)
		end
	end
end
OnSpellCast(function(spell)
	if spell.spellID == _E then
		ETravelTime = false
		DelayAction(function() ETravelTime = true end, 0.61)
	end
end)

-- Interrupter

OnProcessSpell(function(unit, spell)
	if YasuoMenu.Interrupter.UseQ3:Value() then
		for _, enemy in pairs(GetEnemyHeroes()) do
			if CanUseSpell(myHero,_Q) == READY and GetCastRange(myHero,_Q) > 500 then
				if ValidTarget(enemy, YasuoQ3.range) then
					local UnitName = GetObjectName(enemy)
					local UnitChanellingSpells = CHANELLING_SPELLS[UnitName]
					local UnitGapcloserSpells = GAPCLOSER_SPELLS[UnitName]
					if UnitChanellingSpells then
						for _, slot in pairs(UnitChanellingSpells) do
							if spell.name == GetCastName(enemy, slot) then useQ3(enemy) end
						end
					elseif UnitGapcloserSpells then
						for _, slot in pairs(UnitGapcloserSpells) do
							if spell.name == GetCastName(enemy, slot) then useQ3(enemy) end
						end
					end
				end
			end
		end
	end
end)

-- Auto

function Auto()
	if YasuoMenu.Auto.UseQ:Value() then
		if CanUseSpell(myHero,_Q) == READY then
			useQ(target)
		end
	end
	if YasuoMenu.Auto.UseQ3:Value() then
		if CanUseSpell(myHero,_Q) == READY and ETravelTime then
			useQ3(target)
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if YasuoMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				useQ(target)
			end
		end
		if YasuoMenu.Combo.UseQ3:Value() then
			if CanUseSpell(myHero,_Q) == READY and ETravelTime then
				useQ3(target)
			end
		end
		if YasuoMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if GetDistance(target) < YasuoE.range and GetDistance(target) > GetRange(myHero) then
					if GotBuff(target, "YasuoDashWrapper") == 0 then
						useE(target)
					end
				elseif GetDistance(target) < YasuoE.range+1300 and GetDistance(target) > GetRange(myHero) then
					for _, minion in pairs(minionManager.objects) do
						if GetDistance(minion) <= YasuoE.range and GotBuff(minion, "YasuoDashWrapper") == 0 then
							local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GetOrigin(myHero), GetOrigin(target), GetOrigin(minion))
							if isOnSegment and GetDistance(pointSegment, minion) < 300 then
								useE(minion)
							end
						end
					end
				end
			end
		end
		if YasuoMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, YasuoR.range) then
					useR(target)
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if YasuoMenu.Harass.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				useQ(target)
			end
		end
		if YasuoMenu.Harass.UseQ3:Value() then
			if CanUseSpell(myHero,_Q) == READY and ETravelTime then
				useQ3(target)
			end
		end
		if YasuoMenu.Harass.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if GetDistance(target) < YasuoE.range and GetDistance(target) > GetRange(myHero) then
					if GotBuff(target, "YasuoDashWrapper") == 0 then
						useE(target)
					end
				elseif GetDistance(target) < YasuoE.range+1300 and GetDistance(target) > GetRange(myHero) then
					for _, minion in pairs(minionManager.objects) do
						if GetDistance(minion) <= YasuoE.range and GotBuff(minion, "YasuoDashWrapper") == 0 then
							local pointSegment,pointLine,isOnSegment = VectorPointProjectionOnLineSegment(GetOrigin(myHero), GetOrigin(target), GetOrigin(minion))
							if isOnSegment and GetDistance(pointSegment, minion) < 300 then
								useE(minion)
							end
						end
					end
				end
			end
		end
	end
end

-- KillSteal

function KillSteal()
	for i,enemy in pairs(GetEnemyHeroes()) do
		if YasuoMenu.KillSteal.UseR:Value() then
			if ValidTarget(enemy, YasuoR.range) then
				if CanUseSpell(myHero,_R) == READY then
					local YasuoRDmg = (100*GetCastLevel(myHero,_R)+100)+(1.5*GetBonusDmg(myHero))
					if GetCurrentHP(enemy)+GetArmor(enemy)+GetDmgShield(enemy)+GetHPRegen(enemy)*2 < YasuoRDmg then
						CastTargetSpell(enemy, _R)
					end
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if GotBuff(minion, "YasuoDashWrapper") == 0 then
					if ValidTarget(minion, YasuoE.range) then
						if YasuoMenu.LastHit.UseE:Value() then
							if CanUseSpell(myHero,_E) == READY then
								local YasuoEDmg = (10*GetCastLevel(myHero,_E)+50)+(0.2*GetBonusDmg(myHero))+(0.6*GetBonusAP(myHero))
								if GetCurrentHP(minion) < YasuoEDmg then
									CastTargetSpell(minion, _E)
								end
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if CanUseSpell(myHero,_Q) == READY then
					if GetCastRange(myHero,_Q) > 600 then
						if ValidTarget(minion, YasuoQ3.range) then
							if YasuoMenu.LaneClear.UseQ3:Value() then
								CastSkillShot(_Q,GetOrigin(minion))
							end
						end
					else
						if ValidTarget(minion, YasuoQ.range) then
							if YasuoMenu.LaneClear.UseQ:Value() then
								CastSkillShot(_Q,GetOrigin(minion))
							end
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if GotBuff(minion, "YasuoDashWrapper") == 0 then
						if ValidTarget(minion, YasuoE.range) then
							if YasuoMenu.LaneClear.UseE:Value() then
								CastTargetSpell(minion, _E)
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_Q) == READY then
					if GetCastRange(myHero,_Q) > 600 then
						if ValidTarget(mob, YasuoQ3.range) then
							if YasuoMenu.JungleClear.UseQ3:Value() then
								CastSkillShot(_Q,GetOrigin(mob))
							end
						end
					else
						if ValidTarget(mob, YasuoQ.range) then
							if YasuoMenu.JungleClear.UseQ:Value() then
								CastSkillShot(_Q,GetOrigin(mob))
							end
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if GotBuff(mob, "YasuoDashWrapper") == 0 then
						if ValidTarget(mob, YasuoE.range) then
							if YasuoMenu.JungleClear.UseE:Value() then
								CastTargetSpell(mob,_E)
							end
						end
					end
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if Mode() == "Combo" then
		if YasuoMenu.Misc.UI:Value() then
			if GetItemSlot(myHero, 3074) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3074)) == READY then
					CastSpell(GetItemSlot(myHero, 3074))
				end -- Ravenous Hydra
			end
			if GetItemSlot(myHero, 3077) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3077)) == READY then
					CastSpell(GetItemSlot(myHero, 3077))
				end -- Tiamat
			end
			if GetItemSlot(myHero, 3144) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3144)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3144))
					end -- Bilgewater Cutlass
				end
			end
			if GetItemSlot(myHero, 3146) >= 1 and ValidTarget(target, 700) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3146)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3146))
					end -- Hextech Gunblade
				end
			end
			if GetItemSlot(myHero, 3153) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3153)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3153))
					end -- BOTRK
				end
			end
			if GetItemSlot(myHero, 3748) >= 1 and ValidTarget(target, 300) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero,GetItemSlot(myHero, 3748)) == READY then
						CastSpell(GetItemSlot(myHero, 3748))
					end -- Titanic Hydra
				end
			end
		end
	end
end)

function LevelUp()
	if YasuoMenu.Misc.LvlUp:Value() then
		if YasuoMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif YasuoMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif YasuoMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif YasuoMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif YasuoMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif YasuoMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end

-- Zed

elseif "Zed" == GetObjectName(myHero) then

PrintChat("<font color='#1E90FF'>[<font color='#00BFFF'>T01<font color='#1E90FF'>] <font color='#00BFFF'>Zed loaded successfully!")
local ZedMenu = Menu("[T01] Zed", "[T01] Zed")
ZedMenu:Menu("Auto", "Auto")
ZedMenu.Auto:Boolean('UseQ', 'Use Q [Razor Shuriken]', true)
ZedMenu.Auto:Boolean('UseE', 'Use E [Shadow Slash]', true)
ZedMenu:Menu("Combo", "Combo")
ZedMenu.Combo:Boolean('UseQ', 'Use Q [Razor Shuriken]', true)
ZedMenu.Combo:Boolean('UseW', 'Use W [Living Shadow]', true)
ZedMenu.Combo:Boolean('UseE', 'Use E [Shadow Slash]', true)
ZedMenu.Combo:Boolean('UseR', 'Use R [Death Mark]', true)
ZedMenu.Combo:Boolean('GapW', 'Gapclose Using W', true)
ZedMenu:Menu("Harass", "Harass")
ZedMenu.Harass:Boolean('UseQ', 'Use Q [Razor Shuriken]', true)
ZedMenu.Harass:Boolean('UseW', 'Use W [Living Shadow]', true)
ZedMenu.Harass:Boolean('UseE', 'Use E [Shadow Slash]', true)
ZedMenu.Harass:Boolean('GapW', 'Gapclose Using W', false)
ZedMenu:Menu("LastHit", "LastHit")
ZedMenu.LastHit:Boolean('UseQ', 'Use Q [Razor Shuriken]', true)
ZedMenu.LastHit:Boolean('UseE', 'Use E [Shadow Slash]', true)
ZedMenu:Menu("LaneClear", "LaneClear")
ZedMenu.LaneClear:Boolean('UseQ', 'Use Q [Razor Shuriken]', false)
ZedMenu.LaneClear:Boolean('UseE', 'Use E [Shadow Slash]', false)
ZedMenu:Menu("JungleClear", "JungleClear")
ZedMenu.JungleClear:Boolean('UseQ', 'Use Q [Razor Shuriken]', true)
ZedMenu.JungleClear:Boolean('UseW', 'Use W [Living Shadow]', true)
ZedMenu.JungleClear:Boolean('UseE', 'Use E [Shadow Slash]', true)
ZedMenu:Menu("Prediction", "Prediction")
ZedMenu.Prediction:DropDown("PredictionQ", "Prediction: Q", 2, {"CurrentPos", "GoSPred", "GPrediction", "IPrediction", "OpenPredict"})
ZedMenu:Menu("Misc", "Misc")
ZedMenu.Misc:Boolean('UI', 'Use Offensive Items', true)
ZedMenu.Misc:Boolean('LvlUp', 'Level-Up', true)
ZedMenu.Misc:DropDown('AutoLvlUp', 'Level Table', 2, {"Q-W-E", "Q-E-W", "W-Q-E", "W-E-Q", "E-Q-W", "E-W-Q"})
ZedMenu.Misc:Slider('X','Minimum Enemies: R', 1, 0, 5, 1)
ZedMenu.Misc:Slider('HP','HP-Manager: R', 40, 0, 100, 5)

local ZedQ = { range = 900, radius = 50, width = 50, speed = 1700, delay = 0.25, type = "line", collision = false, source = myHero, col = {"yasuowall"}}
local ZedW = { range = 650, radius = 60, width = 60, speed = 1750, delay = 0.25, type = "line", collision = false, source = myHero, col = {"yasuowall"}}
local ZedE = { range = 290 }
local ZedR = { range = 625 }
local GlobalTimer = 0

OnTick(function(myHero)
	target = GetCurrentTarget()
	Auto()
	Combo()
	Harass()
	LastHit()
	LaneClear()
	JungleClear()
	LevelUp()
end)

function useQ(target)
	if GetDistance(target) < ZedQ.range then
		if ZedMenu.Prediction.PredictionQ:Value() == 1 then
			CastSkillShot(_Q,GetOrigin(target))
		elseif ZedMenu.Prediction.PredictionQ:Value() == 2 then
			local QPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ZedQ.speed,ZedQ.delay*1000,ZedQ.range,ZedQ.width,false,true)
			if QPred.HitChance == 1 then
				CastSkillShot(_Q, QPred.PredPos)
			end
		elseif ZedMenu.Prediction.PredictionQ:Value() == 3 then
			local qPred = _G.gPred:GetPrediction(target,myHero,ZedQ,true,false)
			if qPred and qPred.HitChance >= 3 then
				CastSkillShot(_Q, qPred.CastPosition)
			end
		elseif ZedMenu.Prediction.PredictionQ:Value() == 4 then
			local QSpell = IPrediction.Prediction({name="ZedQMissile", range=ZedQ.range, speed=ZedQ.speed, delay=ZedQ.delay, width=ZedQ.width, type="linear", collision=false})
			ts = TargetSelector()
			target = ts:GetTarget(ZedQ.range)
			local x, y = QSpell:Predict(target)
			if x > 2 then
				CastSkillShot(_Q, y.x, y.y, y.z)
			end
		elseif ZedMenu.Prediction.PredictionQ:Value() == 5 then
			local QPrediction = GetLinearAOEPrediction(target,ZedQ)
			if QPrediction.hitChance > 0.9 then
				CastSkillShot(_Q, QPrediction.castPos)
			end
		end
	end
end
function useE(target)
	CastSpell(_E)
end
function useR(target)
	if 100*GetCurrentHP(target)/GetMaxHP(target) < ZedMenu.Misc.HP:Value() then
		if EnemiesAround(myHero, ZedR.range) >= ZedMenu.Misc.X:Value() then
			CastTargetSpell(target, _R)
		end
	end
end

-- Auto

function Auto()
	if ZedMenu.Auto.UseQ:Value() then
		if CanUseSpell(myHero,_Q) == READY and CanUseSpell(myHero,_W) == ONCOOLDOWN then
			if ValidTarget(target, ZedQ.range) then
				useQ(target)
			end
		end
	end
	if ZedMenu.Auto.UseE:Value() then
		if CanUseSpell(myHero,_E) == READY then
			if ValidTarget(target, ZedE.range) then
				useE(target)
			end
		end
	end
end

-- Combo

function Combo()
	if Mode() == "Combo" then
		if ZedMenu.Combo.UseR:Value() then
			if CanUseSpell(myHero,_R) == READY then
				if ValidTarget(target, ZedR.range) then
					if GotBuff(target,"zedrtargetmark") == 0 then
						useR(target)
					end
				end
			end
		end
		if ZedMenu.Combo.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, ZedW.range) then
					if ZedMenu.Combo.GapW:Value() then
						local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ZedW.speed,ZedW.delay*1000,ZedW.range,ZedW.width,false,true)
						if WPred.HitChance == 1 then
							CastSkillShot(_W, WPred.PredPos)
							DelayAction(function() CastSpell(_E) end, 0.1)
						end
					else
						local TimerW = GetTickCount()
						if (GlobalTimer + 5500) < TimerW then
							local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ZedW.speed,ZedW.delay*1000,ZedW.range,ZedW.width,false,true)
							if WPred.HitChance == 1 then
								CastSkillShot(_W, WPred.PredPos)
								DelayAction(function() CastSpell(_E) end, 0.1)
								GlobalTimer = TimerW
							end
						end
					end
				end
			end
		end
		if ZedMenu.Combo.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, ZedW.range-10) then
					DelayAction(function() useQ(target) end, 0.1)
				end
			end
		end
		if ZedMenu.Combo.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, ZedE.range) then
					useE(target)
				end
			end
		end
	end
end

-- Harass

function Harass()
	if Mode() == "Harass" then
		if ZedMenu.Harass.UseW:Value() then
			if CanUseSpell(myHero,_W) == READY then
				if ValidTarget(target, ZedW.range) then
					if ZedMenu.Harass.GapW:Value() then
						local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ZedW.speed,ZedW.delay*1000,ZedW.range,ZedW.width,false,true)
						if WPred.HitChance == 1 then
							CastSkillShot(_W, WPred.PredPos)
							DelayAction(function() CastSpell(_E) end, 0.1)
						end
					else
						local TimerW = GetTickCount()
						if (GlobalTimer + 5500) < TimerW then
							local WPred = GetPredictionForPlayer(GetOrigin(myHero),target,GetMoveSpeed(target),ZedW.speed,ZedW.delay*1000,ZedW.range,ZedW.width,false,true)
							if WPred.HitChance == 1 then
								CastSkillShot(_W, WPred.PredPos)
								DelayAction(function() CastSpell(_E) end, 0.1)
								GlobalTimer = TimerW
							end
						end
					end
				end
			end
		end
		if ZedMenu.Harass.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				if ValidTarget(target, ZedW.range-10) then
					DelayAction(function() useQ(target) end, 0.1)
				end
			end
		end
		if ZedMenu.Harass.UseE:Value() then
			if CanUseSpell(myHero,_E) == READY then
				if ValidTarget(target, ZedE.range) then
					useE(target)
				end
			end
		end
	end
end

-- LastHit

function LastHit()
	if Mode() == "LaneClear" then
		for _, minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if ValidTarget(minion, ZedQ.range) then
					if ZedMenu.LastHit.UseQ:Value() then
						if CanUseSpell(myHero,_Q) == READY then
							local ZedQDmg = (21*GetCastLevel(myHero,_Q)+27)+(0.54*GetBonusDmg(myHero))
							if GetCurrentHP(minion) < ZedQDmg then
								CastSkillShot(_Q,GetOrigin(minion))
							end
						end
					end
				end
				if ValidTarget(minion, ZedE.range) then
					if ZedMenu.LastHit.UseE:Value() then
						if CanUseSpell(myHero,_E) == READY then
							local ZedEDmg = (25*GetCastLevel(myHero,_E)+45)+(0.8*GetBonusDmg(myHero))
							if GetCurrentHP(minion) < ZedEDmg then
								useE(minion)
							end
						end
					end
				end
			end
		end
	end
end

-- LaneClear

function LaneClear()
	if Mode() == "LaneClear" then
		if ZedMenu.LaneClear.UseQ:Value() then
			if CanUseSpell(myHero,_Q) == READY then
				local BestPos, BestHit = GetLineFarmPosition(ZedQ.range, ZedQ.radius, MINION_ENEMY)
				if BestPos and BestHit > 3 then  
					CastSkillShot(_Q, BestPos)
				end
			end
		end
		if ZedMenu.LaneClear.UseE:Value() then
			for _, minion in pairs(minionManager.objects) do
				if GetTeam(minion) == MINION_ENEMY then
					if ValidTarget(minion, ZedE.range) then
						if ZedMenu.LaneClear.UseE:Value() then
							if CanUseSpell(myHero,_E) == READY then
								useE(minion)
							end
						end
					end
				end
			end
		end
	end
end

-- JungleClear

function JungleClear()
	if Mode() == "LaneClear" then
		for _,mob in pairs(minionManager.objects) do
			if GetTeam(mob) == 300 then
				if CanUseSpell(myHero,_W) == READY then
					if ValidTarget(mob, ZedW.range) then
						if ZedMenu.JungleClear.UseW:Value() then	   
							CastSkillShot(_W,GetOrigin(mob))
						end
					end
				end
				if CanUseSpell(myHero,_Q) == READY then
					if ValidTarget(mob, ZedQ.range) then
						if ZedMenu.JungleClear.UseQ:Value() then
							CastSkillShot(_Q,GetOrigin(mob))
						end
					end
				end
				if CanUseSpell(myHero,_E) == READY then
					if ValidTarget(mob, ZedE.range) then
						if ZedMenu.JungleClear.UseE:Value() then
							useE(mob)
						end
					end
				end
			end
		end
	end
end

-- Misc

OnTick(function(myHero)
	if Mode() == "Combo" then
		if ZedMenu.Misc.UI:Value() then
			if GetItemSlot(myHero, 3074) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3074)) == READY then
					CastSpell(GetItemSlot(myHero, 3074))
				end -- Ravenous Hydra
			end
			if GetItemSlot(myHero, 3077) >= 1 and ValidTarget(target, 400) then
				if CanUseSpell(myHero, GetItemSlot(myHero, 3077)) == READY then
					CastSpell(GetItemSlot(myHero, 3077))
				end -- Tiamat
			end
			if GetItemSlot(myHero, 3144) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3144)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3144))
					end -- Bilgewater Cutlass
				end
			end
			if GetItemSlot(myHero, 3146) >= 1 and ValidTarget(target, 700) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3146)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3146))
					end -- Hextech Gunblade
				end
			end
			if GetItemSlot(myHero, 3153) >= 1 and ValidTarget(target, 550) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero, GetItemSlot(myHero, 3153)) == READY then
						CastTargetSpell(target, GetItemSlot(myHero, 3153))
					end -- BOTRK
				end
			end
			if GetItemSlot(myHero, 3748) >= 1 and ValidTarget(target, 300) then
				if (GetCurrentHP(target) / GetMaxHP(target)) <= 0.5 then
					if CanUseSpell(myHero,GetItemSlot(myHero, 3748)) == READY then
						CastSpell(GetItemSlot(myHero, 3748))
					end -- Titanic Hydra
				end
			end
		end
	end
end)

function LevelUp()
	if ZedMenu.Misc.LvlUp:Value() then
		if ZedMenu.Misc.AutoLvlUp:Value() == 1 then
			leveltable = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ZedMenu.Misc.AutoLvlUp:Value() == 2 then
			leveltable = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ZedMenu.Misc.AutoLvlUp:Value() == 3 then
			leveltable = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ZedMenu.Misc.AutoLvlUp:Value() == 4 then
			leveltable = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ZedMenu.Misc.AutoLvlUp:Value() == 5 then
			leveltable = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		elseif ZedMenu.Misc.AutoLvlUp:Value() == 6 then
			leveltable = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}
			if GetLevelPoints(myHero) > 0 then
				DelayAction(function() LevelSpell(leveltable[GetLevel(myHero) + 1 - GetLevelPoints(myHero)]) end, 0.5)
			end
		end
	end
end
end