--サイバー·エンド·ドラゴン
function c1546123.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	Auxiliary.AddFusionProcCodeRep(c,70095154,3,false,true)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
c1546123.material_count=1
c1546123.material={70095154}
