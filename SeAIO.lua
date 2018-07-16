local ver = "1.0"

function AutoUpdate(data)
    if tonumber(data) > tonumber(ver) then
        PrintChat("New version found! " .. data)
        PrintChat("Downloading update, please wait...")
        DownloadFileAsync("https://raw.githubusercontent.com/SofieSiar/GoS/master/Internal/SeAIO.lua", SCRIPT_PATH .. "SeAIO.lua", function() PrintChat("Update Complete, please 2x F6!") return end)
    else
        PrintChat("No updates found!")
    end
end

GetWebResultAsync("https://raw.githubusercontent.com/SofieSiar/GoS/master/Internal/SeAIO.version", AutoUpdate)

local SAIOChamps = {"Aatrox", "Ezreal", "Garen", "Nasus", "Renekton", "Skarner"}
if not table.contains(SAIOChamps, myHero.charName) then print("" ..GetObjectName(myHero).. " Is Not Supported!") return end

require("DamageLib")
require("OpenPredict")

function Mode()
	if _G.IOW_Loaded and IOW:Mode() then
		return IOW:Mode()
	elseif _G.PW_Loaded and PW:Mode() then
		return PW:Mode()
	elseif _G.DAC_Loaded and DAC:Mode() then
		return DAC:Mode()
	elseif _G.AutoCarry_Loaded and DACR:Mode() then
		return DACR:Mode()
	end
end

class "Aatrox"

function Aatrox:__init()
	PrintChat("SAIO | Aatrox Loaded")
	self.Spells = {
		Q = {range = 650, delay = 0.25, speed = 1500,  width = 56},
		E = {range = 1000, delay = 0.25, speed = 1000,  width = 150}
	}
	self:Menu()
	OnTick(function() self:Tick() end)
	OnDraw(function() self:Draw() end)
end

function Aatrox:Menu()
	self.Aatrox = Menu("Aatrox - Sofie", "Aatrox - Sofie")

	self.Aatrox:SubMenu("Combo", "Combo Settings")
	self.Aatrox.Combo:Boolean("Q", "Use Q", true)
	self.Aatrox.Combo:Boolean("W", "Use W", true)
	self.Aatrox.Combo:Slider("minW", "Min. HP to Blood Thirst (%)", 50, 0, 100)
	self.Aatrox.Combo:Slider("maxW", "Max. HP to Blood Price (%)", 80, 0, 100)
	self.Aatrox.Combo:Boolean("E", "Use E", true)
	self.Aatrox.Combo:Boolean("R", "Use R", true)
	self.Aatrox.Combo:DropDown("RMode", "R Mode", 1, {"Combo (Min. Enemies)", "Low HP"})
	if self.Aatrox.Combo.RMode:Value() == 1 then
		self.Aatrox.Combo:Slider("RE", "Use R if x enemies", 2, 1, 5)
	end
	if self.Aatrox.Combo.RMode:Value() == 2 then
		self.Aatrox.Combo:Slider("RH", "Use Auto R at Health (%)", 30, 0, 100)
	end
	self.Aatrox.Combo:Boolean("I", "Use Items", true)

	self.Aatrox:SubMenu("Harass", "Harass Settings")
	self.Aatrox.Harass:Boolean("Q", "Use Q", true)
	self.Aatrox.Harass:Boolean("E", "Use E", true)

	self.Aatrox:SubMenu("Farm", "Farm Settings")
	self.Aatrox.Farm:Boolean("Q", "Use Q", true)
	self.Aatrox.Farm:Boolean("W", "Use W", true)
	self.Aatrox.Farm:Slider("minW", "Min. HP to Blood Thirst (%)", 50, 0, 100)
	self.Aatrox.Farm:Slider("maxW", "Max. HP to Blood Price (%)", 80, 0, 100)
	self.Aatrox.Farm:Boolean("E", "Use E", true)
	self.Aatrox.Farm:Boolean("I", "Use Items", true)

	self.Aatrox:SubMenu("LastHit", "LastHit Settings")
	self.Aatrox.LastHit:Boolean("E", "Use E", true)

	self.Aatrox:SubMenu("Ks", "KillSteal Settings")
	self.Aatrox.Ks:Boolean("Q", "Use Q", true)
	self.Aatrox.Ks:Boolean("E", "Use E", true)
	self.Aatrox.Ks:Boolean("Recall", "Don't Ks during Recall", true)
	self.Aatrox.Ks:Boolean("Disabled", "Don't Ks", false)

	self.Aatrox:SubMenu("Draw", "Drawing Settings")
	self.Aatrox.Draw:Boolean("Q", "Draws Q", true)
	self.Aatrox.Draw:Boolean("E", "Draws E", true)
end

function Aatrox:Tick()
	target = GetCurrentTarget()
	if Mode() == "Combo" then
		if self.Aatrox.Combo.W:Value() and Ready(_W) and ValidTarget(target, GetRange(myHero)) then
			if GetPercentHP(myHero) < self.Aatrox.Combo.minW:Value() and GetSpellData(myHero, _W).toggleState == 2 then
				CastSpell(_W)
			end
			if GetPercentHP(myHero) > self.Aatrox.Combo.maxW:Value() and GetSpellData(myHero, _W).toggleState == 1 then
				CastSpell(_W)
			end
		end
		if self.Aatrox.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, self.Spells.Q.range) then
			local QPred = GetCircularAOEPrediction(target, self.Spells.Q)
			if QPred.hitChance > 0.2 then
				CastSkillShot(_Q, QPred.castPos)
			end
		end
		if self.Aatrox.Combo.I:Value() and ValidTarget(target, GetRange(myHero)) then
			if GetItemSlot(myHero, 3077) > 0 and Ready(GetItemSlot(myHero, 3077)) then
				CastSpell(GetItemSlot(myHero, 3077))
			end
			if GetItemSlot(myHero, 3074) > 0 and Ready(GetItemSlot(myHero, 3074)) then
				CastSpell(GetItemSlot(myHero, 3074))
			end
			if GetItemSlot(myHero, 3748) > 0 and Ready(GetItemSlot(myHero, 3748)) then
				CastSpell(GetItemSlot(myHero, 3748))
			end
			if GetItemSlot(myHero, 3153) > 0 and Ready(GetItemSlot(myHero, 3153)) then
				CastTargetSpell(target, GetItemSlot(myHero, 3153))
			end
			if GetItemSlot(myHero, 3144) > 0 and Ready(GetItemSlot(myHero, 3144)) then
				CastTargetSpell(target, GetItemSlot(myHero, 3144))
			end
		end
		if self.Aatrox.Combo.RMode:Value() == 1 then
			if self.Aatrox.Combo.R:Value() and Ready(_R) and ValidTarget(target, GetRange(myHero)) and EnemiesAround(myHero, GetRange(myHero) + 400) >= self.Aatrox.Combo.RE:Value() then
				CastSpell(_R)
			end
		end
		if self.Aatrox.Combo.E:Value() and Ready(_E) and ValidTarget(target, self.Spells.E.range) then
			local EPred = GetPrediction(target, self.Spells.E)
			if EPred.hitChance > 0.2 then
				CastSkillShot(_E, EPred.castPos)
			end
		end
	end
	if Mode() == "Harass" then
		if self.Aatrox.Harass.E:Value() and Ready(_E) and ValidTarget(target, self.Spells.E.range) then
			local EPred = GetPrediction(target, self.Spells.E)
			if EPred.hitChance > 0.2 then
				CastSkillShot(_E, EPred.castPos)
			end
		end
		if self.Aatrox.Harass.Q:Value() and Ready(_Q) and ValidTarget(target, self.Spells.Q.range) then
			local QPred = GetCircularAOEPrediction(target, self.Spells.Q)
			if QPred.hitChance > 0.2 then
				CastSkillShot(_Q, QPred.castPos)
			end
		end
	end
	for _, mobs in pairs(minionManager.objects) do
		if Mode() == "LaneClear" then
			if self.Aatrox.Farm.W:Value() and Ready(_W) and ValidTarget(mobs, GetRange(myHero)) then
				if GetPercentHP(myHero) < self.Aatrox.Farm.minW:Value() and GetSpellData(myHero, _W).toggleState == 2 then
					CastSpell(_W)
				end
				if GetPercentHP(myHero) > self.Aatrox.Farm.maxW:Value() and GetSpellData(myHero, _W).toggleState == 1 then
					CastSpell(_W)
				end
			end
			if self.Aatrox.Farm.I:Value() and ValidTarget(mobs, GetRange(myHero)) then
				if GetItemSlot(myHero, 3077) > 0 and Ready(GetItemSlot(myHero, 3077)) then
					CastSpell(GetItemSlot(myHero, 3077))
				end
				if GetItemSlot(myHero, 3074) > 0 and Ready(GetItemSlot(myHero, 3074)) then
					CastSpell(GetItemSlot(myHero, 3074))
				end
				if GetItemSlot(myHero, 3748) > 0 and Ready(GetItemSlot(myHero, 3748)) then
					CastSpell(GetItemSlot(myHero, 3748))
				end
			end
			if self.Aatrox.Farm.Q:Value() and Ready(_Q) and ValidTarget(mobs, self.Spells.Q.range) then
				local QPred = GetCircularAOEPrediction(mobs, self.Spells.Q)
				if QPred.hitChance > 0.2 then
					CastSkillShot(_Q, QPred.castPos)
				end
			end
			if self.Aatrox.Farm.E:Value() and Ready(_E) and ValidTarget(mobs, self.Spells.E.range) then
				local EPred = GetPrediction(mobs, self.Spells.E)
				if EPred.hitChance > 0.2 then
					CastSkillShot(_E, EPred.castPos)
				end
			end
		end
		if Mode() == "LastHit" then
			if self.Aatrox.LastHit.E:Value() and Ready(_E) and ValidTarget(mobs, self.Spells.E.range) then
				local EPred = GetPrediction(mobs, self.Spells.E)
				if EPred.hitChance > 0.2 and getdmg("E", mobs, myHero) > GetCurrentHP(mobs) then
					CastSkillShot(_E, EPred.castPos)
				end
			end
		end
	end
	for _, enemy in pairs(GetEnemyHeroes()) do
		if self.Aatrox.Ks.Disabled:Value() or (IsRecalling(myHero) and self.Aatrox.Ks.Recall:Value()) then return end
		if getdmg("Q", enemy, myHero) > GetCurrentHP(enemy) and ValidTarget(enemy, self.Spells.Q.range) and Ready(_Q) and self.Aatrox.Ks.Q:Value() then
			local QPred = GetCircularAOEPrediction(enemy, self.Spells.Q)
			if QPred.hitChance > 0.2 then
				CastSkillShot(_Q, QPred.castPos)
			end
		end
		if getdmg("E", enemy, myHero) > GetCurrentHP(enemy) and ValidTarget(enemy, self.Spells.E.range) and Ready(_E) and self.Aatrox.Ks.E:Value() then
			local EPred = GetPrediction(enemy, self.Spells.E)
			if EPred.hitChance > 0.2 then
				CastSkillShot(_E, EPred.castPos)
			end
		end
		if self.Aatrox.Combo.RMode:Value() == 2 then
			if self.Aatrox.Combo.R:Value() and Ready(_R) and self.Aatrox.Combo.RH:Value() >= GetPercentHP(myHero) then
				CastSpell(_R)
			end
		end
	end
end

function Aatrox:Draw()
	if self.Aatrox.Draw.Q:Value() then
		DrawCircle(GetOrigin(myHero), self.Spells.Q.range, 0, 150, GoS.White)
	end
	if self.Aatrox.Draw.E:Value() then
		DrawCircle(GetOrigin(myHero), self.Spells.E.range, 0, 150, GoS.White)
	end
end

class "Ezreal"

function Ezreal:__init()
	print("SAIO | Ezreal Loaded")
	self.Spells = {
		Q = {range = 1150, delay = 0.25, speed = 2000,  width = 30},
		W = {range = 1000, delay = 0.25, speed = 1550,  width = 80},
		R = {range = 2000, delay = 1, speed = 2000,  width = 40}
	}
	self:Menu()
	OnTick(function() self:Tick() end)
	OnDraw(function() self:Draw() end)
end

function Ezreal:Menu()
	self.Ezreal = Menu("Ezreal - Siar", "Ezreal - Siar")

	self.Ezreal:SubMenu("Combo", "Combo Settings")
	self.Ezreal.Combo:Boolean("Q", "Use Q", true)
	self.Ezreal.Combo:Boolean("W", "Use W", true)
	self.Ezreal.Combo:Boolean("R", "Use R when the enemy is stunned", true)
	self.Ezreal.Combo:Boolean("BOTRK", "Use BOTRK")

	self.Ezreal:SubMenu("Harass", "Harass Settings")
	self.Ezreal.Harass:Boolean("Q", "Use Q", true)
	self.Ezreal.Harass:Boolean("W", "Use W", true)
	self.Ezreal.Harass:Slider("Mana", "Min. Mana", 40, 0, 100, 1)

	self.Ezreal:SubMenu("Farm", "Farm Settings")
	self.Ezreal.Farm:Boolean("Q", "Use Q", true)
	self.Ezreal.Farm:Slider("Mana", "Min. Mana", 40, 0, 100, 1)

	self.Ezreal:SubMenu("LastHit", "LastHit Settings")
	self.Ezreal.LastHit:Boolean("Q", "Use Q", true)
	self.Ezreal.LastHit:Slider("Mana", "Min. Mana", 40, 0, 100, 1)

	self.Ezreal:SubMenu("Ks", "KillSteal Settings")
	self.Ezreal.Ks:Boolean("Q", "Use Q", true)
	self.Ezreal.Ks:Boolean("W", "Use W", true)
	self.Ezreal.Ks:Boolean("R", "Use R", true)
	self.Ezreal.Ks:Boolean("Recall", "Don't Ks during Recall", true)
	self.Ezreal.Ks:Boolean("Disabled", "Don't Ks", false)

	self.Ezreal:SubMenu("Draw", "Drawing Settings")
	self.Ezreal.Draw:Boolean("Q", "Draw Q", true)
	self.Ezreal.Draw:Boolean("W", "Draw W", true)
end

function Ezreal:Tick()
	target = GetCurrentTarget()
	if Mode() == "Combo" then
		if self.Ezreal.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 1150) then
			local QPred = GetPrediction(target, self.Spells.Q)
			if QPred.hitChance > 0.2 and not QPred:mCollision(1) then
				CastSkillShot(_Q, QPred.castPos)
			end
		end
		if self.Ezreal.Combo.BOTRK:Value() and ValidTarget(target, GetRange(myHero)) then
			if GetItemSlot(myHero, 3153) > 0 and Ready(GetItemSlot(myHero, 3153)) then
				CastTargetSpell(target, GetItemSlot(myHero, 3153))
			end
			if GetItemSlot(myHero, 3144) > 0 and Ready(GetItemSlot(myHero, 3144)) then
				CastTargetSpell(target, GetItemSlot(myHero, 3144))
			end
		end
		if self.Ezreal.Combo.W:Value() and Ready(_W) and ValidTarget(target, 1000) then
			local WPred = GetLinearAOEPrediction(target, self.Spells.W)
			if WPred.hitChance > 0.2 then
				CastSkillShot(_W, WPred.castPos)
			end
		end
		if self.Ezreal.Combo.R:Value() and Ready(_W) and GotBuff(target, "stun") > 0 then
			local RPred = GetLinearAOEPrediction(target, self.Spells.R)
			if RPred.hitChance > 0.2 then
				CastSkillShot(_R, RPred.castPos)
			end
		end 
	end
	if Mode() == "Harass" then
		if (myHero.mana/myHero.maxMana >= self.Ezreal.Harass.Mana:Value() /100) then
			if self.Ezreal.Harass.Q:Value() and Ready(_Q) and ValidTarget(target, 1150) then
				local QPred = GetPrediction(target, self.Spells.Q)
				if QPred.hitChance > 0.2 and not QPred:mCollision(1) then
					CastSkillShot(_Q, QPred.castPos)
				end
			end
			if self.Ezreal.Harass.W:Value() and Ready(_W) and ValidTarget(target, 1000) then
				local WPred = GetLinearAOEPrediction(target, self.Spells.W)
				if WPred.hitChance > 0.2 then
					CastSkillShot(_W, WPred.castPos)
				end
			end
		end
	end
	if Mode() == "LaneClear" then
		if (myHero.mana/myHero.maxMana >= self.Ezreal.Farm.Mana:Value() /100) then
			for _, minion in pairs(minionManager.objects) do
				if self.Ezreal.Farm.Q:Value() and Ready(_Q) and ValidTarget(minion, 1150) then
					local QPred = GetPrediction(minion, self.Spells.Q)
					if QPred.hitChance > 0.2 and not QPred:hCollision(1) then
						CastSkillShot(_Q, QPred.castPos)
					end
				end
			end
		end
	end
	if Mode() == "LastHit" then
		if (myHero.mana/myHero.maxMana >= self.Ezreal.LastHit.Mana:Value() /100) then
			for _, minion in pairs(minionManager.objects) do
				if self.Ezreal.LastHit.Q:Value() and Ready(_Q) and ValidTarget(minion, 1150) then
					if GetCurrentHP(minion) < getdmg("Q", minion, myHero) then
						local QPred = GetPrediction(minion, self.Spells.Q)
						if QPred.hitChance > 0.2 and not QPred:hCollision(1) and not QPred:mCollision(1) then
							CastSkillShot(_Q, QPred.castPos)
						end
					end
				end
			end
		end
	end
	-- Ks
	for _, enemy in pairs(GetEnemyHeroes()) do
		if self.Ezreal.Ks.Disabled:Value() or (IsRecalling(myHero) and self.Ezreal.Ks.Recall:Value()) then return end
		if self.Ezreal.Ks.Q:Value() and Ready(_Q) and ValidTarget(enemy, 1150) then
			if GetCurrentHP(enemy) < getdmg("Q", enemy, myHero) then
				local QPred = GetPrediction(enemy, self.Spells.Q)
				if QPred.hitChance > 0.2 and not QPred:mCollision(1) then
					CastSkillShot(_Q, QPred.castPos)
				end
			end
		end
		if self.Ezreal.Ks.W:Value() and Ready(_W) and ValidTarget(enemy, 1000) then
			if GetCurrentHP(enemy) < getdmg("W", enemy, myHero) then
				local WPred = GetLinearAOEPrediction(enemy, self.Spells.W)
				if WPred.hitChance > 0.2 then
					CastSkillShot(_W, WPred.castPos)
				end
			end
		end
		if self.Ezreal.Ks.R:Value() and Ready(_R) and ValidTarget(enemy, 3000) then
			if GetCurrentHP(enemy) < getdmg("R", enemy, myHero) then
			    local RPred = GetLinearAOEPrediction(enemy, self.Spells.R)
				if RPred.HitChance == 1 then
					CastSkillShot(_R, RPred.PredPos)
				end
			end
		end
	end
end

function Ezreal:Draw()
	if self.Ezreal.Draw.Q:Value() then
		DrawCircle(GetOrigin(myHero), 1150, 0, 150, GoS.White)
	end
	if self.Ezreal.Draw.W:Value() then
		DrawCircle(GetOrigin(myHero), 1000, 0, 150, GoS.White)
	end
end

class "Garen"

function Garen:__init()
	print("SAIO | Garen Laoded")
	self.Spells = {
	    E = {range = 300, delay = 0.25},
	    R = {range = 400, delay = 0.25}
	}
	self:Menu()
	OnTick(function() self:Tick() end)
	OnDraw(function() self:Draw() end)
end

function Garen:Menu()
	self.Garen = Menu("Garen - Sofie", "Garen - Sofie")

	self.Garen:SubMenu("Combo", "Combo Settings")
	self.Garen.Combo:Boolean("Q", "Use Q", true)
	self.Garen.Combo:Boolean("E", "Use E", true)

	self.Garen:SubMenu("Harass", "Harass Settings")
	self.Garen.Harass:Boolean("Q", "Use Q", true)
	self.Garen.Harass:Boolean("E", "Use E", true)

	self.Garen:SubMenu("Farm", "Farm Settings")
	self.Garen.Farm:Boolean("Q", "Use Q", true)
	self.Garen.Farm:Boolean("E", "Use E", true)

	self.Garen:SubMenu("LastHit", "LastHit Settings")
	self.Garen.LastHit:Boolean("Q", "Use Q", true)

	self.Garen:SubMenu("Ks", "KillSteal Settings")
	self.Garen.Ks:Boolean("Q", "Use Q", true)
	self.Garen.Ks:Boolean("R", "Use R", true)
	self.Garen.Ks:Boolean("Recall", "Don't Ks during Recall", true)
	self.Garen.Ks:Boolean("Disabled", "Don't Ks", false)

	self.Garen:SubMenu("Misc", "Misc Settings")
	self.Garen.Misc:Boolean("W", "Auto cast W", true)
	self.Garen.Misc:Slider("rangeQ", "Min. Range to cast Q", 300, 0, 1000)
	self.Garen.Misc:Slider("autoW", "Use Auto W at Health (%)", 50, 0, 100)

	self.Garen:SubMenu("Draw", "Drawing Settings")
	self.Garen.Draw:Boolean("Q", "Draw Q", true)
	self.Garen.Draw:Boolean("E", "Draw E", true)
	self.Garen.Draw:Boolean("R", "Draw R", true)
end

function Garen:Tick()
	target = GetCurrentTarget()
	if Mode() == "Combo" then
		if self.Garen.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, self.Garen.Misc.rangeQ:Value()) then
			CastSpell(_Q)
		end
		if self.Garen.Combo.E:Value() and Ready(_E) and ValidTarget(target, self.Spells.E.range) and GetCastName(myHero, _E) == "GarenE" then
			CastSpell(_E)
		end
	end
	if Mode() == "Harass" then
		if self.Garen.Harass.Q:Value() and Ready(_Q) and ValidTarget(target, self.Garen.Misc.rangeQ:Value()) then
			CastSpell(_Q)
		end
		if self.Garen.Harass.E:Value() and Ready(_E) and ValidTarget(target, self.Spells.E.range) and GetCastName(myHero, _E) == "GarenE" then
			CastSpell(_E)
		end
	end
	for _, mobs in pairs(minionManager.objects) do
		if Mode() == "LaneClear" then
			if self.Garen.Farm.Q:Value() and Ready(_Q) and ValidTarget(mobs, self.Garen.Misc.rangeQ:Value()) then
				CastSpell(_Q)
			end
			if self.Garen.Farm.E:Value() and Ready(_E) and ValidTarget(mobs, self.Spells.E.range) and GetCastName(myHero, _E) == "GarenE" then
				CastSpell(_E)
			end
		end
		if Mode() == "LastHit" then
			if self.Garen.LastHit.Q:Value() and Ready(_Q) and ValidTarget(mobs, self.Garen.Misc.rangeQ:Value()) then
				if GetCurrentHP(mobs) < getdmg("Q", mobs, myHero) then
					CastSpell(_Q)
				end
			end
		end
	end
	for _, enemy in pairs(GetEnemyHeroes()) do
		if self.Garen.Ks.Disabled:Value() or (IsRecalling(myHero) and self.Garen.Ks.Recall:Value()) then return end
		if getdmg("Q", enemy, myHero) > GetCurrentHP(enemy) and ValidTarget(enemy, self.Garen.Misc.rangeQ:Value()) and Ready(_Q) and self.Garen.Ks.Q:Value() then
			CastSpell(_Q)
		elseif getdmg("Q", enemy, myHero) > GetCurrentHP(enemy) and ValidTarget(enemy, self.Garen.Misc.rangeQ:Value()) and Ready(_Q) and GetCastName(myHero, _E) == "GarenECancel" and self.Garen.Ks.Q:Value() and not IsDead(enemy) then
			CastSpell(_E)
			DelayAction(function() CastSpell(_Q)end,0.25)
		end
		if getdmg("R", enemy, myHero) > GetCurrentHP(enemy) and ValidTarget(enemy, self.Spells.R.range) and Ready(_R) and self.Garen.Ks.R:Value() then
			CastTargetSpell(enemy, _R)
		elseif getdmg("R", enemy, myHero) > GetCurrentHP(enemy) and ValidTarget(enemy, self.Spells.R.range) and Ready(_R) and GetCastName(myHero, _E) == "GarenECancel" and self.Garen.Ks.R:Value() and not IsDead(enemy) then
			CastSpell(_E)
			DelayAction(function() CastTargetSpell(enemy, _R)end,0.25)
		end
		if self.Garen.Misc.W:Value() and Ready(_W) and self.Garen.Misc.autoW:Value() >= GetPercentHP(myHero) then
			CastSpell(_W)
		end
	end
end

function Garen:Draw()
	if self.Garen.Draw.Q:Value() then
		DrawCircle(GetOrigin(myHero), self.Garen.Misc.rangeQ:Value(), 0, 150, GoS.White)
	end
	if self.Garen.Draw.E:Value() then
		DrawCircle(GetOrigin(myHero), self.Spells.E.range, 0, 150, GoS.White)
	end
	if self.Garen.Draw.R:Value() then
		DrawCircle(GetOrigin(myHero), self.Spells.R.range, 0, 150, GoS.White)
	end
end

class "Nasus"

function Nasus:__init()
	print("SeAIO | Nasus Loaded")
	self.Spells = {
	    Q = {range = 350, delay = 0.25},
	    W = {range = 600, delay = 0.25},
	    E = {range = 650, delay = 0.25, speed = math.huge, width = 200},
	    R = {range = 175}
	}
	self:Menu()
	OnTick(function() self:Tick() end)
	OnDraw(function() self:Draw() end)
end

function Nasus:Menu()
	self.Nasus = Menu("Nasus - Sofie", "Nasus - Sofie")

	self.Nasus:SubMenu("Combo", "Combo Settings")
	self.Nasus.Combo:Boolean("Q", "Use Q", true)
	self.Nasus.Combo:Boolean("W", "Use W", true)
	self.Nasus.Combo:Boolean("E", "Use E", true)
	self.Nasus.Combo:Boolean("R", "Use R", true)
	self.Nasus.Combo:DropDown("RMode", "R Mode", 1, {"Combo (Min.Enemies)", "Low HP"})
	if self.Nasus.Combo.RMode:Value() == 1 then
		self.Nasus.Combo:Slider("RE", "Use R if x enemies", 2, 1, 5)
	elseif self.Nasus.Combo.RMode:Value() == 2 then
		self.Nasus.Combo:Slider("RH", "Use Auto R at Health (%)", 30, 0, 100)
	end

	self.Nasus:SubMenu("Harass", "Harass Settings")
	self.Nasus.Harass:Boolean("Q", "Use Q", true)
	self.Nasus.Harass:Boolean("W", "Use W", true)
	self.Nasus.Harass:Boolean("E", "Use E", true)
	self.Nasus.Harass:Slider("Mana", "Min. Mana", 40, 0, 100, 1)

	self.Nasus:SubMenu("Farm", "Farm Settings")
	self.Nasus.Farm:Boolean("Q", "Use Q", true)
	self.Nasus.Farm:Boolean("E", "Use E", true)
	self.Nasus.Farm:Slider("Mana", "Min. Mana", 40, 0, 100, 1)

	self.Nasus:SubMenu("LastHit", "LastHit Settings")
	self.Nasus.LastHit:Boolean("Q", "Use Q", true)

	self.Nasus:SubMenu("Ks", "KillSteal Settings")
	self.Nasus.Ks:Boolean("Q", "Use Q", true)
	self.Nasus.Ks:Boolean("Recall", "Don't Ks during Recall", true)
	self.Nasus.Ks:Boolean("Disabled", "Don't Ks", false)

	self.Nasus:SubMenu("Draw", "Drawing Settings")
	self.Nasus.Draw:Boolean("Q", "Draw Q", true)
	self.Nasus.Draw:Boolean("W", "Draw W", true)
	self.Nasus.Draw:Boolean("E", "Draw E", true)
end

function Nasus:Tick()
	target = GetCurrentTarget()
	if Mode() == "Combo" then
		if self.Nasus.Combo.RMode:Value() == 1 then
			if self.Nasus.Combo.R:Value() and Ready(_R) and ValidTarget(target, self.Spells.R.range) and EnemiesAround(myHero, self.Spells.R.range) >= self.Nasus.Combo.RE:Value() then
				CastSpell(_R)
			end
		end
		if self.Nasus.Combo.W:Value() and Ready(_W) and ValidTarget(target, self.Spells.W.range) then
			CastTargetSpell(target, _W)
		end
		if self.Nasus.Combo.E:Value() and Ready(_E) and ValidTarget(target, self.Spells.E.range) then
			local EPred = GetCircularAOEPrediction(target, self.Spells.E)
			if EPred.hitChance > 0.2 then
				CastSkillShot(_E, EPred.castPos)
			end
		end
		if self.Nasus.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, self.Spells.Q.range) then
			CastSpell(_Q)
		end
	end
	if Mode() == "Harass" then
		if (myHero.mana/myHero.maxMana >= self.Nasus.Harass.Mana:Value() /100) then
			if self.Nasus.Harass.E:Value() and Ready(_E) and ValidTarget(target, self.Spells.E.range) then
				local EPred = GetCircularAOEPrediction(target, self.Spells.E)
				if EPred.hitChance > 0.2 then
					CastSkillShot(_E, EPred.castPos)
				end
			end
			if self.Nasus.Harass.W:Value() and Ready(_W) and ValidTarget(target, self.Spells.W.range) then
				CastTargetSpell(target, _W)
			end
		end
		if self.Nasus.Harass.Q:Value() and Ready(_Q) and ValidTarget(target, self.Spells.Q.range) then
			CastSpell(_Q)
		end
	end
	for _, mobs in pairs(minionManager.objects) do
		if Mode() == "Harass" then
			if self.Nasus.Harass.Q:Value() and Ready(_Q) and ValidTarget(mobs, self.Spells.Q.range) then
				if GetCurrentHP(mobs) < getdmg("Q", mobs, myHero) then
					CastSpell(_Q)
				end
			end
		end
		if Mode() == "LaneClear" then
			if self.Nasus.Farm.Q:Value() and Ready(_Q) and ValidTarget(mobs, self.Spells.Q.range) then
				if GetCurrentHP(mobs) < getdmg("Q", mobs, myHero) then
					CastSpell(_Q)
				end
			end
			if (myHero.mana/myHero.maxMana >= self.Skarner.Harass.Mana:Value() /100) then
				if self.Nasus.Farm.E:Value() and Ready(_E) and ValidTarget(mobs, self.Spells.E.range) then
					local EPred = GetCircularAOEPrediction(mobs, self.Spells.E)
					if EPred.hitChance > 0.2 then
						CastSkillShot(_E, EPred.castPos)
					end
				end
			end
		end
		if Mode() == "LastHit" then
			if self.Nasus.LastHit.Q:Value() and Ready(_Q) and ValidTarget(mobs, self.Spells.Q.range) then
				if GetCurrentHP(mobs) < getdmg("Q", mobs, myHero) then
					CastSpell(_Q)
				end
			end
		end
	end
	for _, enemy in pairs(GetEnemyHeroes()) do
		if self.Nasus.Ks.Disabled:Value() or (IsRecalling(myHero) and self.Nasus.Ks.Recall:Value()) then return end
		if GetCurrentHP(enemy) < getdmg("Q", enemy, myHero) and ValidTarget(enemy, self.Spells.Q.range) and self.Nasus.Ks.Q:Value() then
			CastSpell(_Q)
		end
		if self.Nasus.Combo.RMode:Value() == 2 then
			if self.Nasus.Combo.R:Value() and Ready(_R) and self.Nasus.Combo.RH:Value() >= GetPercentHP(myHero) then
				CastSpell(_R)
			end
		end
	end
end

function Nasus:Draw()
	if self.Nasus.Draw.Q:Value() then
		DrawCircle(GetOrigin(myHero), self.Spells.Q.range, 0, 150, GoS.White)
	end
	if self.Nasus.Draw.W:Value() then
		DrawCircle(GetOrigin(myHero), self.Spells.E.range, 0, 150, GoS.White)
	end
	if self.Nasus.Draw.E:Value() then
		DrawCircle(GetOrigin(myHero), self.Spells.E.range, 0, 150, GoS.White)
	end
end

class "Renekton"

function Renekton:__init()
	print("SAIO | Renekton Loaded")
	self.Spells = {
		E = {range = 450, delay = 0.25, speed = math.huge,  width = 80}
	}
	self:Menu()
	OnTick(function() self:Tick() end)
	OnDraw(function() self:Draw() end)
end

function Renekton:Menu()
	self.Renekton = Menu("Renekton - Sofie", "Renekton - Sofie")

	self.Renekton:SubMenu("Combo", "Combo Settings")
	self.Renekton.Combo:Boolean("Q", "Use Q", true)
	self.Renekton.Combo:Boolean("W", "Use W", true)
	self.Renekton.Combo:Boolean("E", "Use E", true)
	self.Renekton.Combo:Boolean("R", "Use R", true)
	self.Renekton.Combo:Slider("RH", "Auto cast R at Health (%)", 30, 0, 100)
	self.Renekton.Combo:Boolean("I", "Use Items", true)

	self.Renekton:SubMenu("Harass", "Harass Settings")
	self.Renekton.Harass:Boolean("Q", "Use Q", true)
	self.Renekton.Harass:Boolean("E", "Use E", false)

	self.Renekton:SubMenu("Farm", "Farm Settings")
	self.Renekton.Farm:Boolean("Q", "Use Q", true)
	self.Renekton.Farm:Boolean("W", "Use W", true)
	self.Renekton.Farm:Boolean("E", "Use E", true)
	self.Renekton.Farm:Boolean("I", "Use Items", true)

	self.Renekton:SubMenu("LastHit", "LastHit Settings")
	self.Renekton.LastHit:Boolean("Q", "Use Q", true)

	self.Renekton:SubMenu("Ks", "KillSteal Settings")
	self.Renekton.Ks:Boolean("Q", "Use Q", true)
	self.Renekton.Ks:Boolean("E", "Use E", true)
	self.Renekton.Ks:Boolean("Recall", "Don't Ks during Recall", true)
	self.Renekton.Ks:Boolean("Disabled", "Don't Ks", false)

	self.Renekton:SubMenu("Draw", "Drawing Settings")
	self.Renekton.Draw:Boolean("Q", "Draw Q", true)
	self.Renekton.Draw:Boolean("E", "Draw E", true)
end

function Renekton:Tick()
	mySafeSpot = nil
	target = GetCurrentTarget()
	if Mode() == "Combo" then
		if self.Renekton.Combo.E:Value() and Ready(_E) and ValidTarget(target, self.Spells.E.range) then
			local EPred = GetPrediction(target, self.Spells.E)
			if EPred.hitChance > 0.2 then
				CastSkillShot(_E, EPred.castPos)
			end
		end
		if self.Renekton.Combo.W:Value() and Ready(_W) and ValidTarget(target, GetRange(myHero) + GetHitBox(target)) then
			CastSpell(_W)
		end
		if self.Renekton.Combo.I:Value() and ValidTarget(target, GetRange(myHero)) then
			if GetItemSlot(myHero, 3077) > 0 and Ready(GetItemSlot(myHero, 3077)) then
				CastSpell(GetItemSlot(myHero, 3077))
			end
			if GetItemSlot(myHero, 3074) > 0 and Ready(GetItemSlot(myHero, 3074)) then
				CastSpell(GetItemSlot(myHero, 3074))
			end
			if GetItemSlot(myHero, 3748) > 0 and Ready(GetItemSlot(myHero, 3748)) then
				CastSpell(GetItemSlot(myHero, 3748))
			end
		end
		if self.Renekton.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 325) then
			CastSpell(_Q)
		end
	end
	if Mode() == "Harass" then
		if self.Renekton.Harass.Q:Value() and Ready(_Q) and ValidTarget(target, 325) then
			CastSpell(_Q)
		end
		if self.Renekton.Harass.E:Value() and Ready(_E) and ValidTarget(target, self.Spells.E.range) then
			local EPred = GetPrediction(target, self.Spells.E)
			if EPred.hitChance > 0.2 then
				CastSkillShot(_E, EPred.castPos)
			end
		end
	end
	for _, mobs in pairs(minionManager.objects) do
		if Mode() == "LaneClear" then
			if self.Renekton.Farm.E:Value() and Ready(_E) and ValidTarget(mobs, self.Spells.E.range) then
				local EPred = GetPrediction(mobs, self.Spells.E)
				if EPred.hitChance > 0.2 then
					CastSkillShot(_E, EPred.castPos)
				end
			end
			if self.Renekton.Farm.W:Value() and Ready(_W) and ValidTarget(mobs, GetRange(myHero) + GetHitBox(mobs)) then
				CastSpell(_W)
			end
			if self.Renekton.Farm.I:Value() and ValidTarget(mobs, GetRange(myHero)) then
				if GetItemSlot(myHero, 3077) > 0 and Ready(GetItemSlot(myHero, 3077)) then
					CastSpell(GetItemSlot(myHero, 3077))
				end
				if GetItemSlot(myHero, 3074) > 0 and Ready(GetItemSlot(myHero, 3074)) then
					CastSpell(GetItemSlot(myHero, 3074))
				end
				if GetItemSlot(myHero, 3748) > 0 and Ready(GetItemSlot(myHero, 3748)) then
					CastSpell(GetItemSlot(myHero, 3748))
				end
			end
			if self.Renekton.Farm.Q:Value() and Ready(_Q) and ValidTarget(mobs, 325) then
				CastSpell(_Q)
			end
		end
		if Mode() == "LastHit" then
			if self.Renekton.LastHit.Q:Value() and Ready(_Q) and ValidTarget(mobs, 325) then
				if getdmg("Q", mobs, myHero) > GetCurrentHP(mobs) then
					CastSpell(_Q)
				end
			end
		end
	end
	-- KillSteal
	for _, enemy in pairs(GetEnemyHeroes()) do
		if self.Renekton.Ks.Disabled:Value() or (IsRecalling(myHero) and self.Renekton.Ks.Recall:Value()) then return end
		if getdmg("Q", enemy, myHero) > GetCurrentHP(enemy) and ValidTarget(enemy, 325) and Ready(_Q) and self.Renekton.Ks.Q:Value() then
			CastSpell(_Q)
		end
		if getdmg("E", enemy, myHero) > GetCurrentHP(enemy) and ValidTarget(enemy, self.Spells.E.range) and Ready(_E) and self.Renekton.Ks.E:Value() then
			local mySafeSpot = myHero.pos
			local EPred = GetPrediction(enemy, self.Spells.E)
			if EPred.hitChance > 0.2 then
				CastSkillShot(_E, EPred.castPos)
				DelayAction(function() CastSkillShot(_E, mySafeSpot)end,0.25)
			end
		end
		if self.Renekton.Combo.R:Value() and Ready(_Q) and self.Renekton.Combo.RH:Value() >= GetPercentHP(myHero) then
			CastSpell(_R)
		end
	end
end

function Renekton:Draw()
	if self.Renekton.Draw.Q:Value() then
		DrawCircle(GetOrigin(myHero), 325, 0, 150, GoS.White)
	end
	if self.Renekton.Draw.E:Value() then
		DrawCircle(GetOrigin(myHero), self.Spells.E.range, 0, 150, GoS.White)
	end
end

class "Skarner"

function Skarner:__init()
	print("SAIO | Skarner Loaded")
	self.Spells = {
		E = {range = 1000, delay = 0.25, speed = 1500,  width = 70},
		R = {range = 350, delay = 1.75, speed = math.huge}
	}
	self:Menu()
	OnTick(function() self:Tick() end)
	OnDraw(function() self:Draw() end)
end

function Skarner:Menu()
	self.Skarner = Menu("Skarner - Siar", "Skarner - Siar")

	self.Skarner:SubMenu("Combo", "Combo Settings")
	self.Skarner.Combo:Boolean("Q", "Use Q", true)
	self.Skarner.Combo:Boolean("W", "Use W", true)
	self.Skarner.Combo:Boolean("E", "Use E", true)
	self.Skarner.Combo:Boolean("R", "Use R", true)

	self.Skarner:SubMenu("Harass", "Harass Settings")
	self.Skarner.Harass:Boolean("E", "Use E", true)
	self.Skarner.Harass:Slider("Mana", "Min. Mana", 40, 0, 100, 1)

	self.Skarner:SubMenu("Farm", "Farm Settings")
	self.Skarner.Farm:Boolean("Q", "Use Q", true)
	self.Skarner.Farm:Boolean("W", "Use W", true)
	self.Skarner.Farm:Boolean("E", "Use E", true)
	self.Skarner.Farm:Slider("Mana", "Min. Mana", 40, 0, 100, 1)

	self.Skarner:SubMenu("LastHit", "LastHit Settings")
	self.Skarner.LastHit:Boolean("E", "Use E", true)
	self.Skarner.LastHit:Slider("Mana", "Min. Mana", 40, 0, 100, 1)

	self.Skarner:SubMenu("Ks", "KillSteal Settings")
	self.Skarner.Ks:Boolean("E", "Use E", true)
	self.Skarner.Ks:Boolean("Recall", "Don't Ks during Recall", true)
	self.Skarner.Ks:Boolean("Disabled", "Don't Ks", false)

	self.Skarner:SubMenu("Draw", "Drawing Settings")
	self.Skarner.Draw:Boolean("Q", "Draw Q", true)
	self.Skarner.Draw:Boolean("E", "Draw E", true)
	self.Skarner.Draw:Boolean("R", "Draw R", true)
end

function Skarner:Tick()
	target = GetCurrentTarget()
	if Mode() == "Combo" then
		if self.Skarner.Combo.E:Value() and Ready(_E) and ValidTarget(target, self.Spells.E.range) then
			local EPred = GetPrediction(target, self.Spells.E)
			if EPred.hitChance > 0.2 then
				CastSkillShot(_E, EPred.castPos)
			end
		end
		if self.Skarner.Combo.W:Value() and Ready(_W) and ValidTarget(target, GetRange(myHero) + GetHitBox(target)) then
			CastSpell(_W)
		end
		if self.Skarner.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, GetRange(myHero) + GetHitBox(target)) then
			CastSpell(_Q)
		end
		if self.Skarner.Combo.R:Value() and Ready(_R) and ValidTarget(target, 350 + GetHitBox(target)) then
			CastTargetSpell(target, _R)
		end
	end
	if Mode() == "Harass" then
		if (myHero.mana/myHero.maxMana >= self.Skarner.Harass.Mana:Value() /100) then
			if self.Skarner.Harass.E:Value() and Ready(_E) and ValidTarget(target, self.Spells.E.range) then
				CastE()
			end
		end
	end
	for _, minion in pairs(minionManager.objects) do
		if Mode() == "LaneClear" then
			if (myHero.mana/myHero.maxMana >= self.Skarner.Farm.Mana:Value() /100) then
				if self.Skarner.Farm.E:Value() and Ready(_E) and ValidTarget(minion, self.Spells.E.range) then
					local EPred = GetPrediction(minion, self.Spells.E)
					if EPred.hitChance > 0.2 then
						CastSkillShot(_E, EPred.castPos)
					end
				end
				if self.Skarner.Farm.Q:Value() and Ready(_Q) and ValidTarget(minion, GetRange(myHero) + GetHitBox(target)) then
					CastSpell(_Q)
				end
				if self.Skarner.Farm.W:Value() and Ready(_W) and ValidTarget(minion, GetRange(myHero) + GetHitBox(target)) then
					CastSpell(_W)
				end
			end
		end
		if Mode() == "LastHit" then
			if (myHero.mana/myHero.maxMana >= self.Skarner.LastHit.Mana:Value() /100) then
				for _, minion in pairs(minionManager.objects) do
					if self.Skarner.LastHit.E:Value() and Ready(_E) and ValidTarget(minion, self.Spells.E.range) then
						if GetCurrentHP(minion) < getdmg("E", minion, myHero) then
							CastSkillShot(_E, minion)
						end
					end
				end
			end
		end
	end
	--Ks
	for _, enemy in pairs(GetEnemyHeroes()) do
		if self.Skarner.Ks.Disabled:Value() or (IsRecalling(myHero) and self.Skarner.Ks.Recall:Value()) then return end
		if self.Skarner.Ks.E:Value() and Ready(_E) and ValidTarget(enemy, 1000) then
			if GetCurrentHP(enemy) < getdmg("E", enemy, myHero) then
				local EPred = GetPrediction(target, self.Spells.E)
				if EPred.hitChance > 0.2 then
					CastSkillShot(_E, EPred.castPos)
				end
			end
		end
	end
end

function Skarner:Draw()
	if self.Skarner.Draw.Q:Value() then
		DrawCircle(GetOrigin(myHero), 350, 0, 150, GoS.White)
	end
	if self.Skarner.Draw.E:Value() then
		DrawCircle(GetOrigin(myHero), 1000, 0, 150, GoS.White)
	end
	if self.Skarner.Draw.R:Value() then
		DrawCircle(GetOrigin(myHero), 350, 0, 150, GoS.White)
	end
end

if _G[GetObjectName(myHero)]() then print("Thanks " ..GetUser().. " for using my AIO, remember post your suggestions and feedback.") end
