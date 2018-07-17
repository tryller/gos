local ver = "0.12"

if GetObjectName(GetMyHero()) ~= "Jax" then return end

require("DamageLib")

local mainMenu = Menu("Jax", "Jax")

mainMenu:SubMenu("Combo", "Combo")

mainMenu.Combo:Boolean("Q", "Use Q in combo", true)
mainMenu.Combo:Boolean("W", "Use W in combo", true)
mainMenu.Combo:Boolean("E", "Use E in combo", true)
mainMenu.Combo:Boolean("R", "Use R in combo", true)
mainMenu.Combo:Slider("RX", "X Enemies to Cast R",3,1,5,1)
mainMenu.Combo:Boolean("Cutlass", "Use Cutlass", true)
mainMenu.Combo:Boolean("Tiamat", "Use Tiamat", true)
mainMenu.Combo:Boolean("BOTRK", "Use BOTRK", true)
mainMenu.Combo:Boolean("RHydra", "Use RHydra", true)
mainMenu.Combo:Boolean("YGB", "Use GhostBlade", true)
mainMenu.Combo:Boolean("Gunblade", "Use Gunblade", true)
mainMenu.Combo:Boolean("Randuins", "Use Randuins", true)


mainMenu:SubMenu("AutoMode", "AutoMode")
mainMenu.AutoMode:Boolean("Ghost", "Auto Ghost", false)
mainMenu.AutoMode:Boolean("Q", "Auto Q", false)
mainMenu.AutoMode:Boolean("W", "Auto W", false)
mainMenu.AutoMode:Boolean("E", "Auto E", false)
mainMenu.AutoMode:Boolean("R", "Auto R", false)

mainMenu:SubMenu("LaneClear", "LaneClear")
mainMenu.LaneClear:Boolean("Q", "Use Q", true)
mainMenu.LaneClear:Boolean("W", "Use W", true)
mainMenu.LaneClear:Boolean("E", "Use E", true)
mainMenu.LaneClear:Boolean("RHydra", "Use RHydra", true)
mainMenu.LaneClear:Boolean("Tiamat", "Use Tiamat", true)

mainMenu:SubMenu("Harass", "Harass")
mainMenu.Harass:Boolean("Q", "Use Q", true)
mainMenu.Harass:Boolean("W", "Use W", true)

mainMenu:SubMenu("KillSteal", "KillSteal")
mainMenu.KillSteal:Boolean("Q", "KS w Q", true)
mainMenu.KillSteal:Boolean("E", "KS w E", true)

mainMenu:SubMenu("AutoIgnite", "AutoIgnite")
mainMenu.AutoIgnite:Boolean("Ignite", "Ignite if killable", true)

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

OnTick(function (myHero)
	local target = GetCurrentTarget()
        local YGB = GetItemSlot(myHero, 3142)
	local RHydra = GetItemSlot(myHero, 3074)
	local Tiamat = GetItemSlot(myHero, 3077)
        local Gunblade = GetItemSlot(myHero, 3146)
        local BOTRK = GetItemSlot(myHero, 3153)
        local Cutlass = GetItemSlot(myHero, 3144)
        local Randuins = GetItemSlot(myHero, 3143)
        
        --Harass
          if Mode() == "Harass" then
            if mainMenu.Harass.Q:Value() and Ready(_Q) and ValidTarget(target, 700) then
				if target ~= nil then 
                                      CastTargetSpell(target, _Q)
                                end
            end

            if mainMenu.Harass.W:Value() and Ready(_W) and ValidTarget(target, 700) then
				CastSpell(_W)
            end     
          end

	--COMBO
	  if Mode() == "Combo" then
            if mainMenu.Combo.YGB:Value() and YGB > 0 and Ready(YGB) and ValidTarget(target, 700) then
			CastSpell(YGB)
            end

            if mainMenu.Combo.Randuins:Value() and Randuins > 0 and Ready(Randuins) and ValidTarget(target, 500) then
			CastSpell(Randuins)
            end

            if mainMenu.Combo.BOTRK:Value() and BOTRK > 0 and Ready(BOTRK) and ValidTarget(target, 550) then
			 CastTargetSpell(target, BOTRK)
            end

            if mainMenu.Combo.Cutlass:Value() and Cutlass > 0 and Ready(Cutlass) and ValidTarget(target, 700) then
			 CastTargetSpell(target, Cutlass)
            end

            if mainMenu.Combo.E:Value() and Ready(_E) and ValidTarget(target, 700) then
			 CastSpell(_E)
	    end

            if mainMenu.Combo.Q:Value() and Ready(_Q) and ValidTarget(target, 700) then
		     if target ~= nil then 
                         CastTargetSpell(target, _Q)
                     end
            end

            if mainMenu.Combo.Tiamat:Value() and Tiamat > 0 and Ready(Tiamat) and ValidTarget(target, 350) then
			CastSpell(Tiamat)
            end

            if mainMenu.Combo.Gunblade:Value() and Gunblade > 0 and Ready(Gunblade) and ValidTarget(target, 700) then
			CastTargetSpell(target, Gunblade)
            end

            if mainMenu.Combo.RHydra:Value() and RHydra > 0 and Ready(RHydra) and ValidTarget(target, 400) then
			CastSpell(RHydra)
            end

	    if mainMenu.Combo.W:Value() and Ready(_W) and ValidTarget(target, 700) then
			CastSpell(_W)
	    end
	    
	    
            if mainMenu.Combo.R:Value() and Ready(_R) and ValidTarget(target, 700) and (EnemiesAround(myHeroPos(), 700) >= mainMenu.Combo.RX:Value()) then
			CastSpell(_R)
            end

          end

         --AUTO IGNITE
	for _, enemy in pairs(GetEnemyHeroes()) do
		
		if GetCastName(myHero, SUMMONER_1) == 'SummonerDot' then
			 Ignite = SUMMONER_1
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end

		elseif GetCastName(myHero, SUMMONER_2) == 'SummonerDot' then
			 Ignite = SUMMONER_2
			if ValidTarget(enemy, 600) then
				if 20 * GetLevel(myHero) + 50 > GetCurrentHP(enemy) + GetHPRegen(enemy) * 3 then
					CastTargetSpell(enemy, Ignite)
				end
			end
		end

	end

        for _, enemy in pairs(GetEnemyHeroes()) do
                
                if IsReady(_Q) and ValidTarget(enemy, 700) and mainMenu.KillSteal.Q:Value() and GetHP(enemy) < getdmg("Q",enemy) then
		         if target ~= nil then 
                                      CastTargetSpell(target, _Q)
		         end
                end 

                if IsReady(_E) and ValidTarget(enemy, 187) and mainMenu.KillSteal.E:Value() and GetHP(enemy) < getdmg("E",enemy) then
		                      CastSpell(_E)
  
                end
      end

      if Mode() == "LaneClear" then
      	  for _,closeminion in pairs(minionManager.objects) do
	        if mainMenu.LaneClear.Q:Value() and Ready(_Q) and ValidTarget(closeminion, 700) then
	        	CastTargetSpell(closeminion, _Q)
                end

                if mainMenu.LaneClear.W:Value() and Ready(_W) and ValidTarget(closeminion, 700) then
	        	CastSpell(_W)
	        end

                if mainMenu.LaneClear.E:Value() and Ready(_E) and ValidTarget(closeminion, 187) then
	        	CastSpell(_E)
	        end

                if mainMenu.LaneClear.Tiamat:Value() and ValidTarget(closeminion, 350) then
			CastSpell(Tiamat)
		end
	
		if mainMenu.LaneClear.RHydra:Value() and ValidTarget(closeminion, 400) then
                        CastTargetSpell(closeminion, RHydra)
      	        end
          end
      end
        --AutoMode
        if mainMenu.AutoMode.Q:Value() then        
          if Ready(_Q) and ValidTarget(target, 700) then
		      CastTargetSpell(target, _Q)
          end
        end 
        if mainMenu.AutoMode.W:Value() then        
          if Ready(_W) and ValidTarget(target, 700) then
	  	      CastSpell(_W)
          end
        end
        if mainMenu.AutoMode.E:Value() then        
	  if Ready(_E) and ValidTarget(target, 125) then
		      CastSpell(_E)
	  end
        end
        if mainMenu.AutoMode.R:Value() then        
	  if Ready(_R) and ValidTarget(target, 700) then
		      CastSpell(_R)
	  end
        end
                
	--AUTO GHOST
	if mainMenu.AutoMode.Ghost:Value() then
		if GetCastName(myHero, SUMMONER_1) == "SummonerHaste" and Ready(SUMMONER_1) then
			CastSpell(SUMMONER_1)
		elseif GetCastName(myHero, SUMMONER_2) == "SummonerHaste" and Ready(SUMMONER_2) then
			CastSpell(Summoner_2)
		end
	end
end)

OnProcessSpell(function(unit, spell)
	local target = GetCurrentTarget()        
	if unit.isMe and spell.name:lower():find("jaxempowertwo") then 
		ResetAA()	
	end        

	if unit.isMe and spell.name:lower():find("itemtiamatcleave") then
		ResetAA()
	end	

	if unit.isMe and spell.name:lower():find("itemravenoushydracrescent") then
		ResetAA()
	end
end) 
