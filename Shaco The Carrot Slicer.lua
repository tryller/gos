if GetObjectName(myHero) ~= 'Shaco' then return end

require ('Inspired')

--Menu
Shaco = Menu('Shaco', 'Shaco')
--Shaco Combo Menu
Shaco:SubMenu('Combo', 'Combo')
Shaco.Combo:Boolean('Q', 'Use Q', false)
Shaco.Combo:Boolean('W', 'Use W', true)
Shaco.Combo:Boolean('E', 'Use E', true)
--Jungle Clear Menu
Shaco:SubMenu('Jungle', 'JungleClear')
Shaco.Jungle:Boolean('W', 'Use W', true)
Shaco.Jungle:Boolean('E', 'Use E', true)
Shaco.Jungle:Key('Jung', 'Jungle', string.byte('V'))
--LaneClear Menu
Shaco:SubMenu('LaneClear', 'Lane Clear')
Shaco.LaneClear:Boolean('LC', 'LaneClear', true)
Shaco.LaneClear:Boolean('W', 'Use W', true)
Shaco.LaneClear:Boolean('E', 'Use E', true)
Shaco.LaneClear:Key('LC', 'LaneClear', string.byte('c'))
--Misc Menu
Shaco:SubMenu("Misc","Misc")
Shaco.Misc:Boolean("ATR","Auto R <",true)
Shaco.Misc:Slider("UltHP", "Hp to Auto R", 20, 0, 100, 5)

OnTick(function(myHero)
if IOW:Mode() == 'Combo' then
Combo()
end
JungleClear()
LaneClear()
AutoUltimate()

end)

function Combo()
local mousepos = GetMousePos()
local unit = GetCurrentTarget()
-- GetPredictionForPlayer(startPosition, targetUnit, targetUnitMoveSpeed, spellTravelSpeed, spellDelay, spellRange, spellWidth, collision, addHitBox)
local Qpos = GetPredictionForPlayer(myHeroPos(),unit,GetMoveSpeed(unit),300,300,GetCastRange(myHero,_Q),250,false,false)
if Ready(_Q) and IsInDistance(unit, GetCastRange(myHero,_Q)) and Qpos.HitChance == 1 then
  CastSkillShot(_Q,Qpos.PredPos.x,Qpos.PredPos.y,Qpos.PredPos.z)
elseif Ready(_Q) and not IsInDistance(unit, GetCastRange(myHero,_Q)) and ValidTarget (unit, 1400) then
	CastSkillShot(_Q,mousepos.x,mousepos.y,mousepos.z)
end


if Shaco.Combo.W:Value() then
 if Ready(_W) and ValidTarget(unit, 425) then
   CastSkillShot(_W,mousepos.x,mousepos.y,mousepos.z)
 end
end

if Shaco.Combo.E:Value() then
 if Ready(_E) and ValidTarget(unit, 625) then
  CastTargetSpell(unit, _E)
 end
end
end

function JungleClear()
local mousepos = GetMousePos()
if Shaco.Jungle.Jung:Value() then
		for _,J in pairs(minionManager.objects) do

			if CanUseSpell(myHero, _W) == READY and Shaco.Jungle.W:Value() and ValidTarget(J, 425) then
				CastSkillShot(_W,mousepos.x,mousepos.y,mousepos.z)
				end

				if CanUseSpell(myHero, _E) == READY and Shaco.Jungle.E:Value() and ValidTarget(J, 625) then
				CastTargetSpell(J, _E)
				end
		end
	end
end

function LaneClear()
local mousepos = GetMousePos()
if Shaco.LaneClear.LC:Value() then
	if Shaco.LaneClear.LC:Value() then

		 if IOW:Mode() == 'LaneClear' then

		 local BestPos = GetLineFarmPosition(625, 85, MINION_ENEMY)

				if CanUseSpell(myHero, _W) == READY and Shaco.LaneClear.W:Value() and ValidTarget(M, 425) then
				CastSkillShot(_W)
				end

				if CanUseSpell(myHero, _E) == READY and Shaco.LaneClear.E:Value() and ValidTarget(M, 625) then
				CastTargetSpell(BestPos,_E)
				end

		end
	end
end
end

function AutoUltimate()

 if Shaco.Misc.ATR:Value() then
  if GotBuff(myHero, "recall") ~= 1 then
  if CanUseSpell(myHero, _R) == READY and EnemiesAround(myHeroPos(), 650) >= 1 and (GetCurrentHP(myHero)/GetMaxHP(myHero))*100 < Shaco.Misc.UltHP:Value() then
 CastSpell( _R)
   end
  end
 end

end

OnDraw(function()
if Ready(_E) then
  DrawCircle(myHeroPos().x,myHeroPos().y,myHeroPos().z,GetCastRange(myHero,_E),3,100,0xFFFFFFFF)
end


if Ready(_Q) then
  DrawCircle(myHeroPos().x,myHeroPos().y,myHeroPos().z,GetCastRange(myHero,_Q),3,100,GoS.Blue)
end


if Ready(_W) then
  DrawCircle(myHeroPos().x,myHeroPos().y,myHeroPos().z,GetCastRange(myHero,_W),3,100,GoS.Green)
end

if Ready(_R) then
  DrawCircle(myHeroPos().x,myHeroPos().y,myHeroPos().z,GetCastRange(myHero,_R),3,100,GoS.Red)
end
end)

