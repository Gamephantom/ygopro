--死霊騎士デスカリバー·ナイト
function c78700060.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--Negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(78700060,1))
	e2:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c78700060.condition)
	e2:SetCost(c78700060.cost)
	e2:SetTarget(c78700060.target)
	e2:SetOperation(c78700060.operation)
	c:RegisterEffect(e2)
end
function c78700060.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local te=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_EFFECT)
	return Duel.GetChainInfo(ev,CHAININFO_TYPE)==TYPE_MONSTER and Duel.IsChainInactivatable(ev)
end
function c78700060.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleaseable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c78700060.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	local loc=eg:GetFirst():GetLocation()
	if eg:GetFirst():IsDestructable() and loc~=LOCATION_DECK then
		eg:GetFirst():CreateEffectRelation(e)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c78700060.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetCurrentChain()~=ev+1 then return	end
	Duel.NegateActivation(ev)
	local ec=eg:GetFirst()
	local loc=ec:GetLocation()
	if ec:IsRelateToEffect(e) and loc~=LOCATION_DECK then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
