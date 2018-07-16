if GetObjectName(GetMyHero()) ~= "XinZhao" then return end
local ver = "5"

local XinMenu = MenuConfig("Xin", "Xin")
XinMenu:Menu("Combo", "combo stuff")
XinMenu.Combo:Boolean("qreset", "q aa reset", true)
XinMenu.Combo:Boolean("qreset1", "only in combo?", true)
XinMenu.Combo:Boolean("wcast", "w cast", true)
XinMenu.Combo:Boolean("edash", "e dash", true)
XinMenu.Combo:Boolean("rks", "r ks", true)
XinMenu.Combo:Boolean("rteam", "r teamfight ", true)
XinMenu.Combo:Slider("rcount", "enemy count", 3, 1, 5, 1)
XinMenu.Combo:Boolean("items", "items", true)

XinMenu:Menu("Clear", "clear stuff")
XinMenu.Clear:Boolean("qclear", "q cast", true)
XinMenu.Clear:Boolean("wclear", "w cast", true)
XinMenu.Clear:Boolean("eclear", "e cast", true)

OnTick(function(myHero)
laneclear()
items()
wcast()
edash()
rks()
rcount()
end)

function items()
--items
local enemy = GetCurrentTarget()
	if KeyIsDown(32) and XinMenu.Combo.items:Value() and ValidTarget(enemy, 400) then
		CastOffensiveItems(enemy)
	end
end

function laneclear()
--ugh
	if KeyIsDown(86) == true then
		if XinMenu.Clear.eclear:Value() then
			CastSpell(_W)
		end
		for i,dude in pairs(minionManager.objects) do
			if GetTeam(dude) == MINION_JUNGLE and IsReady(_Q) and ValidTarget(dude, 200) and XinMenu.Clear.qclear:Value() then
				CastSpell(_Q)
			end
			if GetTeam(dude) == MINION_JUNGLE and IsReady(_E) and ValidTarget(dude, GetCastRange(myHero, _E)) and XinMenu.Clear.eclear:Value() then
				CastTargetSpell(dude, _E)
			end
			if GetTeam(dude) == MINION_ENEMY and IsReady(_Q) and ValidTarget(dude, 200) and XinMenu.Clear.qclear:Value() then
				CastSpell(_Q)
			end
			if GetTeam(dude) == MINION_ENEMY and IsReady(_E) and ValidTarget(dude, GetCastRange(myHero, _E)) and XinMenu.Clear.eclear:Value() then
				CastTargetSpell(dude, _E)
			end
		end	
	end
end

function rcount()
--r enemy count based
local enemy = GetCurrentTarget()
	if ValidTarget(enemy, 185) and IsReady(_R) and EnemiesAround(GetOrigin(enemy),185) >= XinMenu.Combo.rcount:Value()  and XinMenu.Combo.rteam:Value() then
		CastSpell(_R)
	end
end

function rks()
local enemy = GetCurrentTarget()
	if EnemiesAround(GetOrigin(myHero),185) > 0 then
		for i,dude in pairs(minionManager.objects) do
			if GetTeam(dude) == MINION_ENEMY and IsReady(_R) and ValidTarget(dude, GetCastRange(myHero, 185)) and XinMenu.Combo.rks:Value() then
				CastSpell(_R)
			end
		end
	end
end

function wcast()
local enemy = GetCurrentTarget()
	if KeyIsDown(32) and ValidTarget(enemy, 300) and XinMenu.Combo.wcast:Value() then
        	CastSkillShot(_W, enemy.x, enemy.y, enemy.z)
	end
end

function edash()
local enemy = GetCurrentTarget()
	if KeyIsDown(32) and ValidTarget(enemy, 600) and XinMenu.Combo.edash:Value() then
		CastTargetSpell(enemy, _E)
	end
end

OnProcessSpellComplete(function(unit, spell)
	if KeyIsDown(32) == false and XinMenu.Combo.qreset:Value() ~= false then return end
	if XinMenu.Combo.qreset:Value() and unit == myHero then
		if spell.name == "XinZhaoBasicAttack" or spell.name == "XinZhaoBasicAttack2" or spell.name == "XinZhaoCritAttack" and Ready(_Q) then
			CastSpell(_Q)
		end
	end
end )
