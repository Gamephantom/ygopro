--極星將テュール
function c2333365.initial_effect(c)
	--self destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c2333365.descon)
	c:RegisterEffect(e1)
	--battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetTarget(c2333365.tg)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c2333365.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x42)
end
function c2333365.descon(e)
	local c=e:GetHandler()
	return not Duel.IsExistingMatchingCard(c2333365.filter,c:GetControler(),LOCATION_MZONE,0,1,c)
end
function c2333365.tg(e,c)
	return c:GetCode()~=2333365 and c:IsSetCard(0x42)
end
