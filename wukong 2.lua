if GetObjectName(myHero) ~= "MonkeyKing" then return end

local ver = "0.02"

local mainMenu = Menu("W", "Wukong")
mainMenu:SubMenu("C", "Combo")
mainMenu.C:Boolean("CQ", "Use Q", true)
mainMenu.C:DropDown("CQC", "Q Settings", 1, {"Normal", "AA Reset"})
mainMenu.C:Boolean("CW", "Use W", true)
mainMenu.C:Slider("CWC", "HP To W", 75, 0, 100, 1)
mainMenu.C:Boolean("CE", "Use E", true)
mainMenu.C:Boolean("CR", "Use R", true)
mainMenu.C:Slider("CMM", "Min Mana To Combo", 20, 0, 100, 1)
mainMenu.C:Boolean("CRC", "Stick To Target With R", true)
mainMenu.C:Boolean("CTH", "Use T Hydra", true)
mainMenu.C:Boolean("CRH", "Use R Hydra", true)
mainMenu.C:Boolean("CYGB", "Use GhostBlade", true)

mainMenu:SubMenu("H", "Harass")
mainMenu.H:Boolean("HQ", "Use Q", true)
mainMenu.H:DropDown("HQC", "Q Settings", 1, {"Normal", "AA Reset"})
mainMenu.H:Boolean("HW", "Use W", true)
mainMenu.H:Slider("HWC", "HP To Use W", 75, 0, 100, 1)
mainMenu.H:Boolean("HE", "Use E", true)
mainMenu.H:Slider("HMM", "Min Mana To Harass", 40, 0, 100, 1)

mainMenu:SubMenu("LH", "LastHit")
mainMenu.LH:Boolean("LHQ", "Use Q", true)
mainMenu.LH:Boolean("LHE", "Use E", true)

mainMenu:SubMenu("LC", "LaneClear")
mainMenu.LC:Boolean("LCQ", "Use Q", true)
mainMenu.LC:Boolean("LCW", "Use W", true)
mainMenu.LC:Boolean("LCE", "Use E", true)
mainMenu.LC:Slider("LCMM", "Min Mana To LaneClear", 40, 0, 100, 1)
mainMenu.LC:Boolean("LCTH", "Use T Hydra", true)
mainMenu.LC:Boolean("LCRH", "Use R Hydra", true)

mainMenu:SubMenu("JC", "JungleClear")
mainMenu.JC:Boolean("JCQ", "Use Q", true)
mainMenu.JC:Boolean("JCW", "Use W", true)
mainMenu.JC:Boolean("JCE", "Use E", true)
mainMenu.JC:Slider("JCMM", "Min Mana To Jungle", 50, 0, 100, 1)	
mainMenu.JC:Boolean("JCTH", "Use T Hydra", true)
mainMenu.JC:Boolean("JCRH", "Use R Hydra", true)

mainMenu:SubMenu("KS", "KillSteal")
mainMenu.KS:Boolean("KSQ", "Use Q", true)
mainMenu.KS:Boolean("KSE", "Use E", true)

mainMenu:SubMenu("M", "Misc")
mainMenu.M:DropDown("AutoLevel", "AutoLevel", 1, {"Off", "QEW", "QWE", "WQE", "WEQ", "EQW", "EWQ"})
mainMenu.M:Boolean("AR", "Auto R", true)
mainMenu.M:Slider("ARC", "Min Enemies To Auto R", 3, 1, 6, 1)
mainMenu.M:Boolean("AW", "Auto W", true)
mainMenu.M:Slider("AWC", "Min HP To W", 20, 0, 100, 1)
mainMenu.M:Boolean("AI", "Auto Ignite", true)
mainMenu.M:Boolean("QSS", "Use QSS", true)
mainMenu.M:Slider("QSSC", "HP To QSS", 90, 0, 100, 1)
mainMenu.M:Boolean("DAAS", "Dont Attack While Invis", true)
mainMenu.M:Boolean("QT", "Use Q On Towers", true)

mainMenu:SubMenu("AutoSmite", "Auto Smite")
mainMenu.AutoSmite:Boolean("ASG", "Smite Gromp", false)
mainMenu.AutoSmite:Boolean("ASB", "Smite Blue", true)
mainMenu.AutoSmite:Boolean("ASR", "Smite Red", false)
mainMenu.AutoSmite:Boolean("ASK", "Smite Big Krug", false)
mainMenu.AutoSmite:Boolean("ASD", "Smite Dragon", true)
mainMenu.AutoSmite:Boolean("ASBA", "Smite Baron", true)

mainMenu:SubMenu("E", "Escape")
mainMenu.E:Boolean("EE", "Use E", true)
mainMenu.E:Boolean("EYGB", "Use GhostBlade")
mainMenu.E:KeyBinding("EK", "Escape Key", string.byte("G"))

local spellorder1 = {_Q, _E, _W, _Q, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
local spellorder2 = {_Q, _W, _E, _Q, _Q, _R, _Q, _W, _Q, _W, _R, _W, _W, _E, _E, _R, _E, _E}
local spellorder3 = {_W, _Q, _E, _W, _W, _R, _W, _Q, _W, _Q, _R, _Q, _Q, _E, _E, _R, _E, _E}
local spellorder4 = {_W, _E, _Q, _W, _W, _R, _W, _E, _W, _E, _R, _E, _E, _Q, _Q, _R, _Q, _Q}
local spellorder5 = {_E, _Q, _W, _E, _E, _R, _E, _Q, _E, _Q, _R, _Q, _Q, _W, _W, _R, _W, _W}
local spellorder6 = {_E, _W, _Q, _E, _E, _R, _E, _W, _E, _W, _R, _W, _W, _Q, _Q, _R, _Q, _Q}

local target = GetCurrentTarget()
function QDmg(unit) return CalcDamage(myHero, unit, myHero.totalDamage + ((30 * GetCastLevel(myHero, _Q)) + (myHero. totalDamage * 0.1)), 0) end
function EDmg(unit) return CalcDamage(myHero, unit, 15 + 45 * GetCastLevel(myHero, _E) + GetBonusDmg(myHero) * 0.8) end
local AARange = 175 + GetHitBox(myHero)
local ERange = GetCastRange(myHero, _E) + GetHitBox(myHero)
local QRange = GetCastRange(myHero, _Q) + GetHitBox(myHero)
local RRange = GetCastRange(myHero, _R) + GetHitBox(myHero)
function RDmg(unit) return CalcDamage(myHero, unit, ((-70 + 90 * GetCastLevel(myHero, _R)) + (myHero.totalDamage * 1.1)) * 4, 0) end
local TH = nil
local T = nil
local RH = nil
local YGB = nil
local CCType = {[5] = "Stun", [8] = "Taunt", [9] = "Polymorph", [11] = "Snare", [21] = "Fear", [22] = "Charm", [24] = "Suppression"}

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

function ResetAA()
    if _G.IOW_Loaded then
        return IOW:ResetAA()
        elseif _G.PW_Loaded then
        return PW:ResetAA()
        elseif _G.DAC_Loaded then
        return DAC:ResetAA()
        elseif _G.AutoCarry_Loaded then
        return DACR:ResetAA()
        elseif _G.SLW_Loaded then
        return SLW:ResetAA()
    end
end

function BlockAttack(boolean)
	if _G.IOW_Loaded then
		return IOW.attacksEnabled == (boolean)
		elseif _G.PW_Loaded then
        return PW.attacksEnabled == (boolean)
        elseif _G.DAC_Loaded then
        return DAC.attacksEnabled == (boolean)
        elseif _G.AutoCarry_Loaded then
        return DACR.attacksEnabled == (boolean)
        elseif _G.SLW_Loaded then
        return SLW.attacksEnabled == (boolean)
    end
end

OnTick(function()
	
	target = GetCurrentTarget()
	TH = GetItemSlot(myHero, 3748)
	T = GetItemSlot(myHero, 3077)
	RH = GetItemSlot(myHero, 3074)
	YGB = GetItemSlot(myHero, 3142)
	local Invis = GotBuff(myHero, "monkeykingdecoystealth")
	local UltOn = GotBuff(myHero, "MonkeyKingSpinToWin")
	local THBuff = GotBuff(myHero, "itemtitanichydracleavebuff")
	local IDamage = (50 + (20 * GetLevel(myHero)))
	local smd = (({[1]=390,[2]=410,[3]=430,[4]=450,[5]=480,[6]=510,[7]=540,[8]=570,[9]=600,[10]=640,[11]=680,[12]=720,[13]=760,[14]=800,[15]=850,[16]=900,[17]=950,[18]=1000})[GetLevel(myHero)])
	
	if Invis > 0 and mainMenu.M.DAAS:Value() then BlockAttack(true) end
	if Invis < 1 then BlockAttack(false) end
	
	if UltOn > 0 then BlockAttack(true) end
	if UltOn < 1 then BlockAttack(false) end
	
	--AutoLevel
	if GetLevelPoints(myHero) > 0 then
		if mainMenu.M.AutoLevel:Value() == 2 then
			LevelSpell(spellorder1[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			elseif mainMenu.M.AutoLevel:Value() == 3 then
			LevelSpell(spellorder2[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			elseif mainMenu.M.AutoLevel:Value() == 4 then
			LevelSpell(spellorder3[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			elseif mainMenu.M.AutoLevel:Value() == 5 then
			LevelSpell(spellorder4[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			elseif mainMenu.M.AutoLevel:Value() == 6 then
			LevelSpell(spellorder5[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
			elseif mainMenu.M.AutoLevel:Value() == 7 then
			LevelSpell(spellorder6[GetLevel(myHero) + 1 - GetLevelPoints(myHero)])
		end
	end
	
	-- Combo
	if Mode() == "Combo" then
		if mainMenu.C.CQ:Value() and mainMenu.C.CQC:Value() == 1 and Ready(_Q) and ValidTarget(target, QRange) then
			if GetPercentMP(myHero) >= mainMenu.C.CMM:Value() then
				CastSpell(_Q)
			end
		end
		
		if mainMenu.C.CE:Value() and Ready(_E) and ValidTarget(target, ERange) and GetDistance(target) > AARange then
			if GetPercentMP(myHero) >= mainMenu.C.CMM:Value() then
				CastTargetSpell(target, _E)
			end
		end
		
		if mainMenu.C.CW:Value() and Ready(_W) and not Ready(_Q) and not Ready(_E) and ValidTarget(target, 175) then
			if GetPercentMP(myHero) >= mainMenu.C.CMM:Value() and GetPercentHP(myHero) <= mainMenu.C.CWC:Value() then
				CastSpell(_W)
			end	
		end
		
		if mainMenu.C.CR:Value() and UltOn < 1 and Ready(_R) and not Ready(_E) and not Ready(_Q) and not Ready(TH) and not Ready(T) and not Ready(RH) and THBuff < 1 and ValidTarget(target, RRange) and GetPercentHP(target) >= 25 then
			CastSpell(_R)
		end
		
		if mainMenu.C.CRC:Value() and UltOn > 0 and ValidTarget(target, 650) then
			MoveToXYZ(target)
		end

		if mainMenu.C.CYGB:Value() and YGB > 0 and Ready(YGB) and ValidTarget(target, 700) then
			CastSpell(YGB)
		end
	end
	
	-- Harass
	if Mode() == "Harass" then
		if mainMenu.C.CQ:Value() and mainMenu.H.HQC:Value() == 1 and Ready(_Q) and ValidTarget(target, QRange) then
			if GetPercentMP(myHero) >= mainMenu.H.HMM:Value() then
				CastSpell(_Q)
			end	
		end	
	
		if mainMenu.H.HE:Value() and Ready(_E) and ValidTarget(target, ERange) then
			if GetPercentMP(myHero) >= mainMenu.H.HMM:Value() then
				CastTargetSpell(target, _E)
			end
		end
		
		if mainMenu.H.HW:Value() and Ready(_W) and not Ready(_Q) and not Ready(_E) and ValidTarget(target, 175) then
			if GetPercentMP(myHero) >= mainMenu.H.HMM:Value() and GetPercentHP(myHero) <= mainMenu.H.HEC:Value() then
				CastSpell(_W)
			end
		end
	end		

	--LaneClear
	if Mode() == "LaneClear" then
		for _,minion in pairs(minionManager.objects) do
			if GetTeam(minion) == MINION_ENEMY then
				if mainMenu.LC.LCW:Value() and Ready(_W) and ValidTarget(minion, AARange) and MinionsAround(minion, 175, MINION_ENEMY) > 2 then
					if GetPercentMP(myHero) >= mainMenu.LC.LCMM:Value() then
						CastSpell(_W)
					end	
				end
				
				if mainMenu.LC.LCE:Value() and Ready(_E) and ValidTarget(minion, ERange) and MinionsAround(minion, 187.5, MINION_ENEMY) > 1 then
					if GetPercentMP(myHero) >= mainMenu.LC.LCMM:Value() then
						CastTargetSpell(minion, _E)
					end	
				end
			end
			
			if GetTeam(minion) == 300 then
				if mainMenu.JC.JCE:Value() and Ready(_E) and ValidTarget(minion, ERange) and not GetObjectName(minion):lower():find("mini") then
					if GetPercentMP(myHero) >= mainMenu.JC.JCMM:Value() then
						CastTargetSpell(minion, _E)
					end	
				end
			end
		end
	end
	
	--LastHit
	if Mode() == "LastHit" then
		for _,minion in pairs(minionManager.objects) do
			if mainMenu.LH.LHQ:Value() and Ready(_Q) and ValidTarget(minion, QRange) and GetDistance(myHero, minion) > AARange then
				if GetCurrentHP(minion) < QDmg(minion) then
					CastSpell(_Q)
				end	
			end
			
			if mainMenu.LH.LHE:Value() and Ready(_E) and ValidTarget(minion, ERange) and GetDistance(myHero, minion) > AARange then
				if GetCurrentHP(minion) < EDmg(minion) then
					CastTargetSpell(minion, _E)
				end
			end
		end
	end				

	-- KillSteal
	for _, enemy in pairs(GetEnemyHeroes()) do
		if mainMenu.KS.KSQ:Value() and Ready(_Q) and ValidTarget(enemy, QRange) then
			if GetCurrentHP(enemy) + GetHPRegen(enemy) + GetDmgShield(enemy) <= QDmg(enemy) then
				CastSpell(_Q)
				AttackUnit(enemy)
			end
		end

		if mainMenu.KS.KSE:Value() and Ready(_E) and ValidTarget(enemy, ERange) then
			if GetCurrentHP(enemy) + GetHPRegen(enemy) + GetDmgShield(enemy) <= EDmg(enemy) then
				CastTargetSpell(enemy, _E)
			end
		end

		-- Auto Ignite
		if GetCastName(myHero, SUMMONER_1):lower():find("summonerdot") then
			if mainMenu.M.AI:Value() and Ready(SUMMONER_1) and ValidTarget(enemy, 600) then
				if GetCurrentHP(enemy) + GetShieldDmg(enemy) + GetHPRegen(enemy) <= IDamage then
					CastTargetSpell(enemy, SUMMONER_1)
				end
			end
		end
	
		if GetCastName(myHero, SUMMONER_2):lower():find("summonerdot") then
			if mainMenu.M.AI:Value() and Ready(SUMMONER_2) and ValidTarget(enemy, 600) then
				if GetCurrentHP(enemy) + GetDmgShield(enemy) + GetHPRegen(enemy) <= IDamage then
					CastTargetSpell(enemy, SUMMONER_2)
				end
			end
		end
	end

	-- Auto R
	if mainMenu.M.AR:Value() and Ready(_R) then
		if EnemiesAround(myHero, RRange) >= mainMenu.M.ARC:Value() then
			CastSpell(_R)
		end	
	end
	
	-- Auto W
	if mainMenu.M.AW:Value() and Ready(_W) then
		if EnemiesAround(myHero, 700) >= 1 and GetPercentHP(myHero) <= mainMenu.M.AWC:Value() then
			CastSpell(_W)
		end	
	end
	
	-- Escape
	if mainMenu.E.EK:Value() then	
		MoveToXYZ(GetMousePos())
		for _, EMinion in pairs(minionManager.objects) do
			if mainMenu.E.EE:Value() and Ready(_E) and ValidTarget(EMinion, ERange) and EnemiesAround(myHero, 1000) > 0 and EnemiesAround(EMinion, 800) < 1 then
				CastTargetSpell(EMinion, _E)
				elseif mainMenu.E.EYGB:Value() and YGB > 0 and Ready(YGB) and EnemiesAround(myHero, 1000) > 0 then
				CastSpell(YGB)
			end
		end		
	end
	
	for _, jung in pairs(minionManager.objects) do
		if GetCastName(myHero, SUMMONER_1):lower():find("summonersmite") then
			if mainMenu.AutoSmite.ASG:Value() and GetObjectName(jung):lower():find("sru_gromp") and Ready(SUMMONER_1) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
			CastTargetSpell(jung, SUMMONER_1)
			elseif mainMenu.AutoSmite.ASK:Value() and GetObjectName(jung):lower():find("sru_krug") and Ready(SUMMONER_1) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
			CastTargetSpell(jung, SUMMONER_1)
			elseif mainMenu.AutoSmite.ASD:Value() and GetObjectName(jung):lower():find("sru_dragon") and Ready(SUMMONER_1) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
			CastTargetSpell(jung, SUMMONER_1)
			elseif mainMenu.AutoSmite.ASB:Value() and GetObjectName(jung):lower():find("sru_blue") and Ready(SUMMONER_1) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
			CastTargetSpell(jung, SUMMONER_1)
			elseif mainMenu.AutoSmite.ASR:Value() and GetObjectName(jung):lower():find("sru_red") and Ready(SUMMONER_1) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
			CastTargetSpell(jung, SUMMONER_1)
			elseif mainMenu.AutoSmite.ASBA:Value() and GetObjectName(jung):lower():find("sru_baron") and Ready(SUMMONER_1) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
			CastTargetSpell(jung, SUMMONER_1)
			end
		end
		
		if GetCastName(myHero, SUMMONER_2):lower():find("summonersmite") then
			if mainMenu.AutoSmite.ASG:Value() and GetObjectName(jung):lower():find("sru_gromp") and Ready(SUMMONER_2) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_2)
				elseif mainMenu.AutoSmite.ASK:Value() and GetObjectName(jung):lower():find("sru_krug") and Ready(SUMMONER_2) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_2)
				elseif mainMenu.AutoSmite.ASD:Value() and GetObjectName(jung):lower():find("sru_dragon") and Ready(SUMMONER_2) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_2)
				elseif mainMenu.AutoSmite.ASB:Value() and GetObjectName(jung):lower():find("sru_blue") and Ready(SUMMONER_2) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_2)
				elseif mainMenu.AutoSmite.ASR:Value() and GetObjectName(jung):lower():find("sru_red") and Ready(SUMMONER_2) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_2)
				elseif mainMenu.AutoSmite.ASBA:Value() and GetObjectName(jung):lower():find("sru_baron") and Ready(SUMMONER_2) and ValidTarget(jung, 500) and GetCurrentHP(jung) <= smd then
				CastTargetSpell(jung, SUMMONER_2)
			end
		end
	end
end)	

-- Auto QSS
OnUpdateBuff(function(unit, buff)
	local QSS = GetItemSlot(myHero, 3140)
	local MercSkimm = GetItemSlot(myHero, 3139)
	if unit.isMe and CCType[buff.Type] and mainMenu.M.QSS:Value() and QSS > 0 and Ready(QSS) then
		if GetPercentHP(myHero) <= mainMenu.M.QSSC:Value() and EnemiesAround(myHero, 900) >= 1 then
			CastSpell(QSS)
		end	
	end
	
	if unit.isMe and CCType[buff.Type] and mainMenu.M.QSS:Value() and MercSkimm > 0 and Ready(MercSkimm) then
		if GetPercentHP(myHero) <= mainMenu.M.QSSC:Value() and EnemiesAround(myHero, 900) >= 1 then
			CastSpell(MercSkimm)
		end
	end
end)

--Some Stuff	
OnProcessSpell(function(unit, spell)
	if unit.isMe and spell.name:lower():find("tiamatcleave") then
		ResetAA()
	end
	
	if unit.isMe and spell.name:lower():find("monkeykingq") then
		ResetAA()
	end
	
	if Mode() == "LaneClear" then
		if unit.isMinion and GetTeam(unit) == 300 and not GetObjectName(unit):lower():find("mini") and spell.target.isMe then
			if mainMenu.JC.JCW:Value() and Ready(_W) and GetPercentMP(myHero) >= mainMenu.JC.JCMM:Value() then
				DelayAction(function()
					CastSpell(_W)
				end, spell.windUpTime / 1.5)
			end
		end		
	end
	
	if unit.isMe and spell.name:lower():find("monkeykingspintowin") then
		if YGB > 0 and Ready(YGB) then
			CastSpell(YGB)
		end	
	end
end)	

-- AA Resets
OnProcessSpellComplete(function(unit, spell)
	if Mode() == "Combo" then
		if unit.isMe and spell.target.isHero and IsObjectAlive(spell.target) then
			if spell.name:lower():find("basicattack") and mainMenu.C.CQ:Value() and mainMenu.C.CQC:Value() == 2 then
				if Ready(_Q) and GetPercentMP(myHero) >= mainMenu.C.CMM:Value() then
					CastSpell(_Q)
				end
			end

			if spell.name:lower():find("basicattack") then
				if mainMenu.C.CTH:Value() and not Ready(_Q) and TH > 0 and Ready(TH) then
					CastSpell(TH)
					elseif mainMenu.C.CRH:Value() and not Ready(_Q) and RH > 0 and Ready(RH) then
					CastSpell(RH)
					elseif mainMenu.C.CRH:Value() and not Ready(_Q) and T > 0 and Ready(T) then
					CastSpell(T)
				end
			end		
		
			if spell.name:lower():find("monkeykingq") then
				if mainMenu.C.CTH:Value() and TH > 0 and Ready(TH) then
					CastSpell(TH)
					elseif mainMenu.C.CRH:Value() and RH > 0 and Ready(RH) then
					CastSpell(RH)
					elseif mainMenu.C.CRH:Value() and T > 0 and Ready(T) then
					CastSpell(T)
				end
			end	
		end
	end

	if Mode() == "Harass" then
		if unit.isMe and spell.target.isHero and IsObjectAlive(spell.target) then
			if spell.name:lower():find("basicattack") and mainMenu.H.HQ:Value() and mainMenu.H.HQC:Value() == 2 then
				if Ready(_Q) and GetPercentMP(myHero) >= mainMenu.H.HMM:Value() then
					CastSpell(_Q)
				end
			end

			if spell.name:lower():find("basicattack") then
				if mainMenu.H.HTH:Value() and not Ready(_Q) and TH > 0 and Ready(TH) then
					CastSpell(TH)
					elseif mainMenu.H.HRH:Value() and not Ready(_Q) and RH > 0 and Ready(RH) then
					CastSpell(RH)
					elseif mainMenu.H.HRH:Value() and not Ready(_Q) and T > 0 and Ready(T) then
					CastSpell(T)
				end
			end

			if spell.name:lower():find("monkeykingq") then
				if mainMenu.H.HTH:Value() and TH > 0 and Ready(TH) then
					CastSpell(TH)
					elseif mainMenu.H.HRH:Value() and RH > 0 and Ready(TH) then
					CastSpell(RH)
					elseif mainMenu.H.HRH:Value() and T > 0 and Ready(T) then
					CastSpell(T)
				end
			end
		end
	end

	if Mode() == "LaneClear" then
		if unit.isMe and spell.target.isMinion and GetTeam(spell.target) == MINION_ENEMY and IsObjectAlive(spell.target) then
			if spell.name:lower():find("basicattack") and mainMenu.LC.LCQ:Value() then
				if Ready(_Q) and GetPercentMP(myHero) >= mainMenu.LC.LCMM:Value() then
					CastSpell(_Q)
				end
			end
			
			if spell.name:lower():find("basicattack") then
				if mainMenu.LC.LCTH:Value() and not Ready(_Q) and TH > 0 and Ready(TH) and MinionsAround(spell.target, 700, MINION_ENEMY) > 1 then
					CastSpell(TH)
					elseif mainMenu.LC.LCRH:Value() and not Ready(_Q) and RH > 0 and Ready(RH) and MinionsAround(myHero, 400, MINION_ENEMY) > 1 then
					CastSpell(RH)
					elseif mainMenu.LC.LCRH:Value() and not Ready(_Q) and T > 0 and Ready(T) and MinionsAround(myHero, 400, MINION_ENEMY) > 1 then
					CastSpell(T)
				end
			end

			if spell.name:lower():find("monkeykingq") then
				if mainMenu.LC.LCTH:Value() and TH > 0 and Ready(TH) and MinionsAround(spell.target, 700, MINION_ENEMY) > 1 then
					CastSpell(TH)
					elseif mainMenu.LC.LCRH:Value() and RH > 0 and Ready(RH) and MinionsAround(myHero, 400, MINION_ENEMY) > 1 then
					CastSpell(RH)
					elseif mainMenu.LC.LCRH:Value() and T > 0 and Ready(T) and MinionsAround(myHero, 400, MINION_ENEMY) > 1 then
					CastSpell(T)
				end
			end
		end

		if unit.isMe and spell.target.isMinion and GetTeam(spell.target) == 300 and IsObjectAlive(spell.target) and not GetObjectName(spell.target):lower():find("mini") then
			if spell.name:lower():find("basicattack") and mainMenu.JC.JCQ:Value() then
				if Ready(_Q) and GetPercentMP(myHero) >= mainMenu.JC.JCMM:Value() then
					CastSpell(_Q)
				end
			end

			if spell.name:lower():find("basicattack") then
				if mainMenu.JC.JCTH:Value()and not Ready(_Q) and TH > 0 and Ready(TH) then
					CastSpell(TH)
					elseif mainMenu.JC.JCRH:Value() and not Ready(_Q) and RH > 0 and Ready(RH) then
					CastSpell(RH)
					elseif mainMenu.JC.JCRH:Value() and not Ready(_Q) and T > 0 and Ready(T) then
					CastSpell(T)
				end
			end
		
			if spell.name:lower():find("monkeykingq") then
				if mainMenu.JC.JCTH:Value() and TH > 0 and Ready(TH) then
					CastSpell(TH)
					elseif mainMenu.JC.JCRH:Value() and RH > 0 and Ready(RH) then
					CastSpell(RH)
					elseif mainMenu.JC.JCRH:Value() and T > 0 and Ready(T) then
					CastSpell(T)
				end
			end		
		end
	end

	if unit.isMe and spell.name:lower():find("basicattack") and spell.target.name:lower():find("turret") and Ready(_Q) then
		CastSpell(_Q)
	end
end)

print("Thanks For Using Eternal Wukong, Have Fun " ..myHero.name.. " :)")	
