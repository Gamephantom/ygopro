--インフェルニティ·リベンジャー
function c85475641.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(85475641,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c85475641.spcon)
	e1:SetTarget(c85475641.sptg)
	e1:SetOperation(c85475641.spop)
	c:RegisterEffect(e1)
end
function c85475641.spcon(e,tp,eg,ep,ev,re,r,rp)
	local des=eg:GetFirst()
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0 and des:IsLocation(LOCATION_GRAVE)
		and des:GetLevel()>0 and des:IsReason(REASON_BATTLE) and des:GetControler()==tp
		and des:GetPreviousControler()==tp and des:GetCode()~=85475641
end
function c85475641.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c85475641.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then return end
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)~=0 or not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetValue(eg:GetFirst():GetLevel())
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end
