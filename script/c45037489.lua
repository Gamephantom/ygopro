--フルール·ド·シュヴァリエ
function c45037489.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,c45037489.tfilter,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45037489,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c45037489.discon)
	e1:SetTarget(c45037489.distg)
	e1:SetOperation(c45037489.disop)
	c:RegisterEffect(e1)
end
function c45037489.tfilter(c)
	local code=c:GetCode()
	return code==19642774 or code==20932152
end
function c45037489.discon(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or tp~=Duel.GetTurnPlayer() then return false end
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainInactivatable(ev)
end
function c45037489.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if eg:GetFirst():IsDestructable() then
		eg:GetFirst():CreateEffectRelation(e)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c45037489.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsFaceup() or not c:IsRelateToEffect(e) then return end
	Duel.NegateActivation(ev)
	local ec=eg:GetFirst()
	if ec:IsRelateToEffect(e) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
