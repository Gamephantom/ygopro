--閃光のイリュージョン
function c61962135.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c61962135.target)
	e1:SetOperation(c61962135.operation)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c61962135.desop)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
	--Destroy2
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c61962135.descon2)
	e3:SetOperation(c61962135.desop2)
	e3:SetLabelObject(e1)
	c:RegisterEffect(e3)
	--discard deck
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCategory(CATEGORY_DECKDES)
	e4:SetDescription(aux.Stringid(61962135,0))
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_REPEAT)
	e4:SetCountLimit(1)
	e4:SetCondition(c61962135.discon)
	e4:SetCost(c61962135.discost)
	e4:SetOperation(c61962135.disop)
	c:RegisterEffect(e4)
end
function c61962135.filter(c,e,tp)
	return c:IsSetCard(0x38) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c61962135.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c61962135.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c61962135.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c61962135.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c61962135.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)==0 then return end
		c:SetCardTarget(tc)
		e:SetLabelObject(tc)
		c:CreateRelation(tc,RESET_EVENT+0x1fe0000)
		tc:CreateRelation(c,RESET_EVENT+0x1020000)
	end
end
function c61962135.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject():GetLabelObject()
	if not tc or tc:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED) then return end
	if tc:IsRelateToCard(c) then
		Duel.Destroy(tc, REASON_EFFECT)
	end
end
function c61962135.descon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_DESTROY_CONFIRMED) then return false end
	local tc=e:GetLabelObject():GetLabelObject()
	return tc and eg:IsContains(tc) and tc:IsRelateToCard(c) and c:IsRelateToCard(tc)
end
function c61962135.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(), REASON_EFFECT)
end
function c61962135.discon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c61962135.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,2)
end
function c61962135.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetControler()~=tp or not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	Duel.DiscardDeck(tp,2,REASON_EFFECT)
end
