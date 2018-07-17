if myHero.charName ~= "Lucian" then return end 

local Menu, Q, Q2, W, E, R 

local Alert = function(text, name) 
        if not name then name = "Shulepin's Lucian " end 
        print("<b><font color=\"#ffb10a\">"..name.."- <font color=\"#ffffff\"><b>"..text) 
end

local LoLVer, ScrVer = "7.8", 3 
local AutoUpdate = function(data)     
        if tonumber(data) > ScrVer then         
	        Alert("New version found! -" .. data)         
	        Alert("Downloading update, please wait...")         
	        DownloadFileAsync("https://raw.githubusercontent.com/BluePrinceEB/GoS/master/Lucian.lua", SCRIPT_PATH .. "Lucian.lua", function() Alert("Update Complete, please 2x F6!") return end)       
	else         
		Alert("No updates found!")     
	end 
end 

GetWebResultAsync("https://raw.githubusercontent.com/BluePrinceEB/GoS/master/Lucian.version", AutoUpdate) 

local OrbMode = function() 
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
        elseif EOW_Loaded 
        	then return EOW:Mode() 
        end 
        return "" 
end 

local ResetAA = function() 
        if IOW_Loaded then 
        	return IOW:ResetAA() 
        elseif DAC_Loaded then 
        	return DAC:ResetAA() 
        elseif PW_Loaded then 
        	return PW:ResetAA() 
        elseif GoSWalkLoaded then 
        	return GoSWalk:ResetAttack() 
        elseif AutoCarry_Loaded then 
        	return DACR:ResetAA() 
        elseif _G.SLW_Loaded then
        	return SLW:ResetAA() 
        elseif EOW_Loaded then 
                return EOW:ResetAA() 
        end
end

local CircleCircleIntersection = function(c1, c2, r1, r2) 
        local D = GetDistance(c1, c2)
        if D > r1 + r2 or D <= math.abs(r1 - r2) then return nil end 
        local A = (r1 * r2 - r2 * r1 + D * D) / (2 * D) 
        local H = math.sqrt(r1 * r1 - A * A)
        local Direction = (c2 - c1):normalized() 
        local PA = c1 + A * Direction 
        local S1 = PA + H * Direction:perpendicular() 
        local S2 = PA - H * Direction:perpendicular() 
        return S1, S2 
end 
 
local VectorExtend = function(v1, v2, distance) 
        return v1 + distance * (v2 - v1):normalized() 
end 

local ClosestToMouse = function(p1, p2) 
        if GetDistance(mousePos, p1) > GetDistance(mousePos, p2) then return p2 else return p1 end
end 

local CastQ = function(target) 
        CastTargetSpell(target, _Q) 
end 

local CastQ2 = function(target) 
        local pred = GetPrediction(target, Q2) 
        if pred.castPos == nil then return end 
        local targetPos = VectorExtend(Vector(myHero), Vector(pred.castPos), Q2.range) 
        if Q.IsReady() and ValidTarget(target) and GetDistance(pred.castPos) <= Q2.range then 
        	for i, minion in pairs(minionManager.objects) do 
        		if minion and not minion.dead and minion.team ~= myHero.team and ValidTarget(minion, Q.range) then 
        			local minionPos = VectorExtend(Vector(myHero), Vector(minion), Q2.range) 
        			if GetDistance(targetPos, minionPos) <= Q2.width then 
        				CastTargetSpell(minion, _Q) 
        			end 
        		end 
        	end 
        end 
end 

local CastW = function(target, fast) 
        if not fast then 
        	local pred = GetPrediction(target, W) 
        	if pred and pred.castPos and not pred:mCollision(1) then 
        		CastSkillShot(_W, pred.castPos) 
                end 
        else 
        	CastSkillShot(_W, target) 
        end 
end 

local CastE = function(target, mode, range) 
        if mode == 1 then 
        	local c1, c2, r1, r2 = Vector(myHero), Vector(target), myHero.range, 525 
        	local O1, O2 = CircleCircleIntersection(c1, c2, r1, r2) 
        	if O1 or O2 then 
        		local pos = VectorExtend(c1, Vector(ClosestToMouse(O1, O2)), range) 
        		CastSkillShot(_E, pos) 
        	end 
        elseif mode == 2 then 
        	local pos = VectorExtend(Vector(myHero), Vector(GetMousePos()), range) 
        	CastSkillShot(_E, pos) 
        elseif mode == 3 then 
        	local pos = VectorExtend(Vector(myHero), Vector(target), range) CastSkillShot(_E, pos) 
        end 
end 

local a2v = function(a, m) 
        m = m or 1 
        local x = math.cos(a) * m 
        local y = math.sin(a) * m
        return x, y
end 

local DrawTriangle = function(object, color, thickness, size, inc, speed, yshift, ylevel) 
        local pi = 3.14159 	
        if not object then  object = myHero end 	
        if not color then color = ARGB(255,255,255,255) end 	
        if not thickness then thickness = 3 end 	
        if not size then size = 50 end 	if not speed then speed = 1 else speed = 1-speed end 	
        local X, Y, Z = object.x, object.y, object.z 	Y = Y + yshift + (inc * ylevel) 	
        local RX1, RZ1 = a2v((inc*speed), size) 	
        local RX2, RZ2 = a2v((inc*speed)+math.pi*0.33333, size) 	
        local RX3, RZ3 = a2v((inc*speed)+math.pi*0.66666, size) 	
        local PX1 = X+RX1 	
        local PZ1 = Z+RZ1 	
        local PX2 = X+RX2 	
        local PZ2 = Z+RZ2 	
        local PX3 = X+RX3 	
        local PZ3 = Z+RZ3 	
        local PXT1 = X-(PX1-X) 	
        local PZT1 = Z-(PZ1-Z) 	
        local PXT3 = X-(PX3-X) 	
        local PZT3 = Z-(PZ3-Z)  	
        DrawLine3D(PXT1, Y, PZT1, PXT3, Y, PZT3, thickness, color) 	
        DrawLine3D(PXT3, Y, PZT3, PX2, Y, PZ2, thickness, color) 	
        DrawLine3D(PX2, Y, PZ2, PXT1, Y, PZT1, thickness, color) 
end 

local DrawRectangleOutline = function(startPos, endPos, width, color, ex)     
        local c1 = startPos+Vector(Vector(endPos)-startPos):perpendicular():normalized()*width     
        local c2 = startPos+Vector(Vector(endPos)-startPos):perpendicular2():normalized()*width     
        local c3 = endPos+Vector(Vector(startPos)-endPos):perpendicular():normalized()*width     
        local c4 = endPos+Vector(Vector(startPos)-endPos):perpendicular2():normalized()*width     
        DrawLine3D(c1.x,c1.y,c1.z,c2.x,c2.y,c2.z,math.ceil(width/ex),color)     
        DrawLine3D(c2.x,c2.y,c2.z,c3.x,c3.y,c3.z,math.ceil(width/ex),color)     
        DrawLine3D(c3.x,c3.y,c3.z,c4.x,c4.y,c4.z,math.ceil(width/ex),color)     
        DrawLine3D(c1.x,c1.y,c1.z,c4.x,c4.y,c4.z,math.ceil(width/ex),color) 
end 

local Tick = function()         
        if myHero.dead then return end         
        local target = GetCurrentTarget()         
        if Menu.AutoHarass.Use:Value() and GetPercentMP(myHero) >= Menu.AutoHarass.Mana:Value() and target.visible and Menu.AutoHarass.WhiteList["S"..target.charName]:Value() then 
                	if Menu.AutoHarass.Q.Use2:Value() then CastQ2(target) end         
        end         
        if Menu.KS.Use:Value() then 		
        	for i, enemy in pairs(GetEnemyHeroes()) do 			
        		if target.visible and Menu.KS.WhiteList["S"..enemy.charName]:Value() then 				
        			if Menu.KS.Q.Use:Value() and ValidTarget(enemy, Q.range) and enemy.health < Q.GetDamage(enemy) then 					
        				CastQ(enemy) 				
        		        end 				
        		        if Menu.KS.W.Use:Value() and ValidTarget(enemy, W.range) and enemy.health < W.GetDamage(enemy) then 					
        		        	CastW(enemy, false) 				
        		        end 			
        		end 		
                end 	
        end         
        if OrbMode() == "Combo" then         	
        	if Menu.Combo.Q.Use2:Value() then 
        		CastQ2(target) 
        	end         
        elseif OrbMode() == "Harass" and GetPercentMP(myHero) >= Menu.Harass.Mana:Value() and target.visible and Menu.Harass.WhiteList["S"..target.charName]:Value() then         	
        	if Menu.Harass.Q.Use:Value() and Q.IsReady() and ValidTarget(target, Q.range) then 
        		CastQ(target) 
        	end         	
        	if Menu.Harass.Q.Use2:Value() then 
        		CastQ2(target) 
        	end         	
        	if Menu.Harass.W.Use:Value() and W.IsReady() and ValidTarget(target, W.range) then 
        		CastW(target, false) 
        	end         
        end         
        if Menu.WJ.Key:Value() then                 
        	local p1 = VectorExtend(Vector(myHero), Vector(GetMousePos()), 200)                 
        	local p2 = VectorExtend(Vector(myHero), Vector(GetMousePos()), E.range)                 
        	local p3 = VectorExtend(Vector(myHero), Vector(GetMousePos()), myHero.boundingRadius)                 
        	if MapPosition:inWall(p1) then                         
        		if not MapPosition:inWall(p2) and GetMousePos().y-myHero.y < 225 then                                 
        			CastSkillShot(_E, p2)                                 
        			MoveToXYZ(p2)                         
        		else                                 
        			MoveToXYZ(p3)                        
        		end                 
        	else                         
        		MoveToXYZ(p1)                
        	end         
        end 
end 

local Draw = function()         
        if myHero.dead or Menu.Draw.Disable:Value() then return end         
        local target = GetCurrentTarget() 	
        if not inc then inc = 0 end 	
        inc = inc + 0.002 	
        if inc > 6.28318 then inc = 0 end 	
        DrawTriangle(target, ARGB(255,255,180,60), 2, 75, inc, 6, 0, 0) 	
        if Menu.Draw.Q.Range:Value() and Q.IsReady() then 		
        	DrawCircle(myHero.pos, Q.range, 1, 100, Menu.Draw.Q.Color:Value()) 	
        end 	
        if Menu.Draw.Q.Rec:Value() and Q.IsReady() and GetDistance(target) <= 1500 then  		
        	DrawRectangleOutline(myHero.pos, VectorExtend(myHero.pos, target.pos, Q.range), Q2.width, Menu.Draw.Q.Color3:Value(), 50) 		
        	DrawRectangleOutline(myHero.pos, VectorExtend(myHero.pos, target.pos, Q2.range), Q2.width, Menu.Draw.Q.Color3:Value(), 50) 	
        end 	
        if Menu.Draw.W.Range:Value() and W.IsReady() then 		
        	DrawCircle(myHero.pos, W.range, 1, 100, Menu.Draw.W.Color:Value()) 	
        end 	
        if Menu.Draw.E.Range:Value() and E.IsReady() then 		
        	DrawCircle(myHero.pos, E.range, 1, 100, Menu.Draw.E.Color:Value()) 	
        end 	
        if Menu.Draw.R.Range:Value() and R.IsReady() then 		
        	DrawCircle(myHero.pos, R.range, 1, 100, Menu.Draw.R.Color:Value()) 	
        end 	
        if Menu.WJ.Key:Value() then 		
        	local pos1 = VectorExtend(Vector(myHero), Vector(GetMousePos()), E.range) 	        
        	local pos2 = VectorExtend(Vector(myHero), Vector(GetMousePos()), myHero.boundingRadius)  	        
        	if MapPosition:inWall(pos1) then 		       
        	        DrawCircle(pos1, 150, 2, 50, ARGB(255, 255, 0, 0)) 		        
        	        DrawText("E Pos", 25, WorldToScreen(0, pos1).x-25, WorldToScreen(0, pos1).y, ARGB(255, 255, 0, 0)) 	        
        	else 		        
        	        DrawCircle(pos1, 150, 2, 50, ARGB(255, 255, 255, 255)) 		        
        	        DrawText("E Pos", 25, WorldToScreen(0, pos1).x-25, WorldToScreen(0, pos1).y, ARGB(255, 255, 255, 255)) 	        
        	end         
        end 
end 

local SpellCast = function(spell) 
        if spell.spellID == _E then 
        	ResetAA() 
        end  
end 

local AfterAttack = function(unit, spell)         
        if unit.isMe then    
                local ComboRotation = Menu.Combo.ComboRotation:Value() - 1     	
        	if OrbMode() == "Combo" and spell.name:lower():find("attack") and spell.target and spell.target.valid and spell.target.type == "AIHeroClient" then         		
        		if Menu.Combo.Q.Use:Value() and (ComboRotation == 0 or myHero:CanUseSpell(ComboRotation) ~= READY) and Q.IsReady() then     			
        			CastQ(spell.target)         		
        		elseif Menu.Combo.E.Use:Value() and (ComboRotation == 2 or myHero:CanUseSpell(ComboRotation) ~= READY) and E.IsReady() then   			
        			CastE(spell.target, Menu.Combo.E.Mode:Value(), Menu.Combo.E.Range:Value())         		
        		elseif Menu.Combo.W.Use:Value() and (ComboRotation == 1 or myHero:CanUseSpell(ComboRotation) ~= READY) and W.IsReady() then       			
        			CastW(spell.target, Menu.Combo.W.UseFast:Value())         		
        		end         	
        	elseif OrbMode() == "LaneClear" and GetPercentMP(myHero) >= Menu.LaneClear.Mana:Value() and spell.name:lower():find("attack") and spell.target and spell.target.valid and spell.target.type == "obj_AI_Minion" and spell.target.name:lower():find("minion_") then         		
        		if Menu.LaneClear.Q.Use:Value() and Q.IsReady() then         			
        			CastQ(spell.target)         		
        		elseif Menu.LaneClear.E.Use:Value() and E.IsReady() then         			
        			CastE(spell.target, Menu.LaneClear.E.Mode:Value(), Menu.LaneClear.E.Range:Value())         		
        		elseif Menu.LaneClear.W.Use:Value() and W.IsReady() then         			
        			CastW(spell.target, true)         		
        		end         	
        	elseif OrbMode() == "LaneClear" and GetPercentMP(myHero) >= Menu.JungleClear.Mana:Value() and spell.name:lower():find("attack") and spell.target and spell.target.valid and spell.target.type == "obj_AI_Minion" and spell.target.name:lower():find("sru_") then         		
        		if Menu.JungleClear.Q.Use:Value() and Q.IsReady() then         			
        			CastQ(spell.target)         		
        		elseif Menu.JungleClear.E.Use:Value() and E.IsReady() then         			
        		        CastE(spell.target, Menu.JungleClear.E.Mode:Value(), Menu.JungleClear.E.Range:Value())         		
        		elseif Menu.JungleClear.W.Use:Value() and W.IsReady() then         			
        			CastW(spell.target, true)         		
        		end         	
        	end         
        end 
end 

local Load = function()        
        require("OpenPredict") 
        require("MapPosition")          

        Menu = MenuConfig("Lucian", "Lucian")          
        Menu:SubMenu("Combo", "[Lucian] Combo")         
        Menu.Combo:SubMenu("Q", "[Q] Piercing Light")         
        Menu.Combo.Q:Boolean("Use", "Use Q In Combo", true)     
        Menu.Combo.Q:Boolean("Use2", "Use Extended Q In Combo", true)         
        Menu.Combo:SubMenu("W", "[W] Ardent Blaze")         
        Menu.Combo.W:Boolean("Use", "Use W In Combo", true)         
        Menu.Combo.W:Boolean("UseFast", "Use Fast W In Combo", true)         
        Menu.Combo:SubMenu("E", "[E] Relentless Pursuit")         
        Menu.Combo.E:Boolean("Use", "Use E In Combo", true)         
        Menu.Combo.E:DropDown("Mode", "E Mode", 1, {"Side", "Mouse", "Target"})         
        Menu.Combo.E:Slider("Range", "Dash Range", 225, 100, 425, 10)         
        Menu.Combo:DropDown("ComboRotation", "Combo Rotation Priority", 3, { "Q", "W", "E" })
        Menu:SubMenu("Harass", "[Lucian] Harass")         
        Menu.Harass:SubMenu("Q", "[Q] Piercing Light")         
        Menu.Harass.Q:Boolean("Use", "Use Q In Harass", true)         
        Menu.Harass.Q:Boolean("Use2", "Use Extended Q In Harass", true)         
        Menu.Harass:SubMenu("W", "[W] Ardent Blaze")         
        Menu.Harass.W:Boolean("Use", "Use W In Harass", true)        
        Menu.Harass:SubMenu("WhiteList", "White List For Harass") 	
        for i, enemy in pairs(GetEnemyHeroes()) do 
        	Menu.Harass.WhiteList:Boolean("S"..enemy.charName, "-> "..enemy.charName, true) 
        end         
        Menu.Harass:Slider("Mana", "Min. Mana(%) For Harass", 60, 0, 100, 1)         
        Menu:SubMenu("AutoHarass", "[Lucian] Auto Harass")         
        Menu.AutoHarass:SubMenu("Q", "[Q] Piercing Light")         
        Menu.AutoHarass.Q:Boolean("Use2", "Use Extended Q In Auto Harass", true)         
        Menu.AutoHarass:SubMenu("WhiteList", "White List For Auto Harass") 	
        for i, enemy in pairs(GetEnemyHeroes()) do 
        	Menu.AutoHarass.WhiteList:Boolean("S"..enemy.charName, "-> "..enemy.charName, true) 
        end         
        Menu.AutoHarass:Slider("Mana", "Min. Mana(%) For Auto Harass", 60, 0, 100, 1)         
        Menu.AutoHarass:Boolean("Use", "Use Auto Harass", true)         
        Menu:SubMenu("LaneClear", "[Lucian] Lane Clear")         
        Menu.LaneClear:SubMenu("Q", "[Q] Piercing Light")         
        Menu.LaneClear.Q:Boolean("Use", "Use Q In Lane Clear", true)         
        Menu.LaneClear:SubMenu("W", "[W] Ardent Blaze")         
        Menu.LaneClear.W:Boolean("Use", "Use W In Lane Clear", true)         
        Menu.LaneClear:SubMenu("E", "[E] Relentless Pursuit")         
        Menu.LaneClear.E:Boolean("Use", "Use E In Lane Clear", true)         
        Menu.LaneClear.E:DropDown("Mode", "E Mode", 1, {"Side", "Mouse", "Target"})         
        Menu.LaneClear.E:Slider("Range", "Dash Range", 225, 100, 425, 10)         
        Menu.LaneClear:Slider("Mana", "Min. Mana(%) For Lane Clear", 60, 0, 100, 1)         
        Menu:SubMenu("JungleClear", "[Lucian] Jungle Clear")         
        Menu.JungleClear:SubMenu("Q", "[Q] Piercing Light")         
        Menu.JungleClear.Q:Boolean("Use", "Use Q In Jungle Clear", true)         
        Menu.JungleClear:SubMenu("W", "[W] Ardent Blaze")         
        Menu.JungleClear.W:Boolean("Use", "Use W In Jungle Clear", true)         
        Menu.JungleClear:SubMenu("E", "[E] Relentless Pursuit")         
        Menu.JungleClear.E:Boolean("Use", "Use E In Jungle Clear", true)         
        Menu.JungleClear.E:DropDown("Mode", "E Mode", 1, {"Side", "Mouse", "Target"})         
        Menu.JungleClear.E:Slider("Range", "Dash Range", 225, 100, 425, 10)         
        Menu.JungleClear:Slider("Mana", "Min. Mana(%) For Lane Clear", 60, 0, 100, 1)         
        Menu:SubMenu("KS", "[Lucian] Kill Secure") 	
        Menu.KS:SubMenu("Q", "[Q] Piercing Light") 	
        Menu.KS.Q:Boolean("Use", "KS With Q", true) 	
        Menu.KS:SubMenu("W", "[W] Ardent Blaze") 	
        Menu.KS.W:Boolean("Use", "KS With W", true) 	
        Menu.KS:SubMenu("WhiteList", "White List For KS") 	
        for i, enemy in pairs(GetEnemyHeroes()) do 
        	Menu.KS.WhiteList:Boolean("S"..enemy.charName, "-> "..enemy.charName, true) 
        end 	
        Menu.KS:Boolean("Use", "Use KS", true) 	Menu:SubMenu("SkinChanger", "[Lucian] Skin Changer")        
        Menu.SkinChanger:DropDown('skin',"Select A Skin:", 1, {"Classic", "Hired Gun Lucian", "Striker Lucian", "Yellow Chroma", "Red Chroma", "Blue Chroma", "PROJECT: Lucian", "Heartseeker Lucian"}, function(model) HeroSkinChanger(myHero, model - 1) end, true)         
        Menu:SubMenu("Draw", "[Lucian] Drawings") 	
        Menu.Draw:SubMenu("Q", "[Q] Piercing Light") 	
        Menu.Draw.Q:Boolean("Range", "Draw Q Range", true)         
        Menu.Draw.Q:ColorPick("Color", "Q Color", {100, 255, 255, 255}) 	
        Menu.Draw.Q:Boolean("Range2", "Draw Extended Q Range", true)         
        Menu.Draw.Q:ColorPick("Color2", "Extended Q Color", {100, 255, 255, 255}) 	
        Menu.Draw.Q:Boolean("Rec", "Draw Q Rectangle", true) 	
        Menu.Draw.Q:ColorPick("Color3", "Rectangle Q Color", {100, 255, 255, 255}) 	
        Menu.Draw:SubMenu("W", "W] Ardent Blaze") 	
        Menu.Draw.W:Boolean("Range", "Draw W Range", true) 	
        Menu.Draw.W:ColorPick("Color", "W Color", {100, 255, 255, 255}) 	
        Menu.Draw:SubMenu("E", "[E] Relentless Pursuit") 	
        Menu.Draw.E:Boolean("Range", "Draw E Range", true) 	
        Menu.Draw.E:ColorPick("Color", "E Color", {100, 255, 255, 255}) 	
        Menu.Draw:SubMenu("R", "[R] The Culling") 	
        Menu.Draw.R:Boolean("Range", "Draw R Range", true) 	
        Menu.Draw.R:ColorPick("Color", "R Color", {100, 255, 255, 255}) 	
        Menu.Draw:Boolean("Disable", "Disable All Drawings", false) 	
        Menu:SubMenu("WJ", "[Lucian] Walljump") 	
        Menu.WJ:KeyBinding("Key", "Walljump Key", string.byte("G"))        
        Menu:SubMenu("Info", "[Lucian] Script Info")      
        Menu.Info:Info(" ", "Script Version: "..ScrVer)        
        Menu.Info:Info(" ", "League Version: "..LoLVer)  

        Q    = { range = 650                                                                                                }         
        Q2   = { range = 900 , delay = 0.35, speed = math.huge, width = 25, collision = false, aoe = false, type = "linear" }         
        W    = { range = 1000, delay = 0.30, speed = 1600     , width = 80, collision = true , aoe = true , type = "linear" }         
        E    = { range = 425                                                                                                }         
        R    = { range = 1200, delay = 0.10, speed = 2500     , width = 110                                                 }       

        Q.IsReady = function() return myHero:CanUseSpell(_Q) == READY end         
        W.IsReady = function() return myHero:CanUseSpell(_W) == READY end         
        E.IsReady = function() return myHero:CanUseSpell(_E) == READY end         
        R.IsReady = function() return myHero:CanUseSpell(_R) == READY end  

        Q.GetDamage = function(unit) return myHero:CalcDamage(unit, (45 + 35 * myHero:GetSpellData(_Q).level + myHero.addDamage * ((50 + 10 * myHero:GetSpellData(_Q).level)/100))) end         
        W.GetDamage = function(unit) return myHero:CalcMagicDamage(unit, (20 + 40 * myHero:GetSpellData(_W).level + myHero.ap * 0.9)) end         
        R.GetDamage = function(unit) return myHero:CalcDamage(unit, (5 + 15 * myHero:GetSpellData(_R).level + myHero.totalDamage * 0.2 + myHero.ap * 0.1) * (15 + 5 * myHero:GetSpellData(_Q).level)) end          

        Callback.Add("Tick", function() Tick() end)         
        Callback.Add("Draw", function() Draw() end)         
        Callback.Add("SpellCast", function(spell) SpellCast(spell) end)         
        Callback.Add("ProcessSpellComplete", function(unit, spell) AfterAttack(unit, spell) end)  
        Alert("Loaded") 
end 

OnLoad(function() Load() end)
