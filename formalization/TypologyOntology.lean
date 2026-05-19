/-!
Private Lean sketch for "Naturalizing Typological Kinds".

This is not intended for the paper.  Its purpose is to check that the
core distinctions can be represented without making the main conflations
type-correct:

* comparative concepts are not comparanda, but specify comparanda;
* Level-I and Level-II comparanda are not Level-III realizations;
* language-internal realizations are indexed by language;
* mappings go from comparanda to language-internal realizations;
* firewall diagnostics for Level-I comparanda are represented without
  direct access to Level-III realizations;
* cross-level coupling is allowed without identity.
-/

namespace TypologyOntology

inductive Level where
  | one
  | two
  | three
deriving DecidableEq, Repr

structure Language where
  name : String
deriving DecidableEq, Repr

/- Cross-linguistic comparanda. -/

inductive LevelIComparandum where
  | semanticTarget (name : String)
  | discourseRole (name : String)
deriving DecidableEq, Repr

inductive LevelIIComparandum where
  | syntacticFunction (name : String)
  | lexicalCategory (name : String)
  | phrasalCategory (name : String)
  | clausalCategory (name : String)
  | syntacticProfile (name : String)
deriving DecidableEq, Repr

structure DecomposedProfile where
  name : String
  levelIComponents : List LevelIComparandum
  levelIIComponents : List LevelIIComparandum
deriving DecidableEq, Repr

inductive Comparandum where
  | levelI (c : LevelIComparandum)
  | levelII (c : LevelIIComparandum)
  | profile (p : DecomposedProfile)
deriving DecidableEq, Repr

def Comparandum.sort : Comparandum -> String
  | .levelI _ => "Level-I comparandum"
  | .levelII _ => "Level-II comparandum"
  | .profile _ => "decomposed profile"

def DecomposedProfile.hasComponents (p : DecomposedProfile) : Prop :=
  Not (p.levelIComponents = []) \/ Not (p.levelIIComponents = [])

def Comparandum.wellFormed : Comparandum -> Prop
  | .levelI _ => True
  | .levelII _ => True
  | .profile p => p.hasComponents

inductive DiagnosticSource where
  | behavioural
  | discourse
  | morphosyntactic
  | componentProfile
deriving DecidableEq, Repr

def DiagnosticSource.allowedFor :
    DiagnosticSource -> Comparandum -> Prop
  | .behavioural, .levelI _ => True
  | .discourse, .levelI _ => True
  | .morphosyntactic, .levelII _ => True
  | .componentProfile, .profile _ => True
  | _, _ => False

structure DiagnosticItem (c : Comparandum) where
  source : DiagnosticSource
  label : String
  allowed : source.allowedFor c

structure DiagnosticBattery (c : Comparandum) where
  items : List (DiagnosticItem c)
  nonempty : Not (items = [])

theorem no_morphosyntactic_diagnostic_for_levelI
    (c : LevelIComparandum) :
    Not (DiagnosticSource.morphosyntactic.allowedFor (.levelI c)) := by
  simp [DiagnosticSource.allowedFor]

theorem no_behavioural_diagnostic_for_levelII
    (c : LevelIIComparandum) :
    Not (DiagnosticSource.behavioural.allowedFor (.levelII c)) := by
  simp [DiagnosticSource.allowedFor]

structure ComparativeConcept where
  name : String
  picksOut : Comparandum
  wellFormed : picksOut.wellFormed
  diagnostics : DiagnosticBattery picksOut

/- Language-internal realizations.  The language index is what prevents
   a realization in one grammar from being silently reused in another. -/

inductive Realization (L : Language) where
  | syntacticFunction (name : String)
  | lexicalCategory (name : String)
  | phrasalCategory (name : String)
  | clausalCategory (name : String)
  | construction (name : String)
  | morpheme (name : String)
  | prosodicPattern (name : String)
deriving DecidableEq, Repr

/- A bounded integer proxy for weights in [0, 1].  The value 100
   corresponds to 1.0, and 0 corresponds to 0.0. -/

structure Weight where
  score : Nat
  withinBounds : score <= 100
deriving Repr

namespace Weight

def positive (w : Weight) : Prop :=
  0 < w.score

def zero : Weight :=
  { score := 0, withinBounds := by decide }

def full : Weight :=
  { score := 100, withinBounds := by decide }

end Weight

structure Reliability where
  score : Nat
  withinBounds : score <= 100
deriving Repr

/- A language-specific comparanda-to-realizations mapping. -/

structure Mapping (L : Language) where
  realizes : Comparandum -> Realization L -> Prop
  weight : Comparandum -> Realization L -> Weight
  support :
    forall c form, (weight c form).positive -> realizes c form

/- Firewall diagnostics.  Level-I diagnostics have observations and
   verdicts, but no field whose type is Realization L.  Realizations
   enter only after the comparandum has been diagnosed. -/

structure LevelIDiagnostic (L : Language) (c : LevelIComparandum) where
  observation : String
  succeeds : Prop
deriving Repr

structure LevelIIDiagnostic (L : Language) (c : LevelIIComparandum) where
  observation : String
  succeeds : Prop
deriving Repr

structure FirewallProtocol (L : Language) where
  diagnoseLevelI :
    (c : LevelIComparandum) -> LevelIDiagnostic L c -> Prop
  diagnoseLevelII :
    (c : LevelIIComparandum) -> LevelIIDiagnostic L c -> Prop

/- A dependency graph for the anti-circularity claim.  An edge
   `FirewallStep L a b` means that `b` is allowed to depend on `a`.
   The graph permits forms to enter mapping, coupling, and
   naturalization claims, but not diagnostic claims. -/

inductive EvidenceNode (L : Language) where
  | behaviouralEvidence (name : String)
  | discourseEvidence (name : String)
  | morphosyntacticEvidence (name : String)
  | levelIDiagnosis (c : LevelIComparandum)
  | levelIIDiagnosis (c : LevelIIComparandum)
  | profileDiagnosis (p : DecomposedProfile)
  | formObservation (form : Realization L)
  | mappingClaim (c : Comparandum) (form : Realization L)
  | couplingClaim (c d : Comparandum)
  | naturalizationClaim (c : Comparandum)
deriving DecidableEq, Repr

inductive FirewallStep (L : Language) :
    EvidenceNode L -> EvidenceNode L -> Prop where
  | behaviour_to_levelI (name : String) (c : LevelIComparandum) :
      FirewallStep L
        (.behaviouralEvidence name)
        (.levelIDiagnosis c)
  | discourse_to_levelI (name : String) (c : LevelIComparandum) :
      FirewallStep L
        (.discourseEvidence name)
        (.levelIDiagnosis c)
  | morphosyntax_to_levelII (name : String) (c : LevelIIComparandum) :
      FirewallStep L
        (.morphosyntacticEvidence name)
        (.levelIIDiagnosis c)
  | levelI_to_profile {c : LevelIComparandum} {p : DecomposedProfile} :
      c ∈ p.levelIComponents ->
      FirewallStep L
        (.levelIDiagnosis c)
        (.profileDiagnosis p)
  | levelII_to_profile {c : LevelIIComparandum} {p : DecomposedProfile} :
      c ∈ p.levelIIComponents ->
      FirewallStep L
        (.levelIIDiagnosis c)
        (.profileDiagnosis p)
  | form_to_mapping (c : Comparandum) (form : Realization L) :
      FirewallStep L
        (.formObservation form)
        (.mappingClaim c form)
  | levelI_to_mapping (c : LevelIComparandum) (form : Realization L) :
      FirewallStep L
        (.levelIDiagnosis c)
        (.mappingClaim (.levelI c) form)
  | levelII_to_mapping (c : LevelIIComparandum) (form : Realization L) :
      FirewallStep L
        (.levelIIDiagnosis c)
        (.mappingClaim (.levelII c) form)
  | profile_to_mapping (p : DecomposedProfile) (form : Realization L) :
      FirewallStep L
        (.profileDiagnosis p)
        (.mappingClaim (.profile p) form)
  | levelI_to_coupling (c : LevelIComparandum) (d : Comparandum) :
      FirewallStep L
        (.levelIDiagnosis c)
        (.couplingClaim (.levelI c) d)
  | levelII_to_coupling (c : LevelIIComparandum) (d : Comparandum) :
      FirewallStep L
        (.levelIIDiagnosis c)
        (.couplingClaim (.levelII c) d)
  | profile_to_coupling (p : DecomposedProfile) (d : Comparandum) :
      FirewallStep L
        (.profileDiagnosis p)
        (.couplingClaim (.profile p) d)
  | mapping_to_coupling (c d : Comparandum) (form : Realization L) :
      FirewallStep L
        (.mappingClaim c form)
        (.couplingClaim c d)
  | diagnosis_to_naturalization (c : LevelIComparandum) :
      FirewallStep L
        (.levelIDiagnosis c)
        (.naturalizationClaim (.levelI c))
  | levelII_diagnosis_to_naturalization (c : LevelIIComparandum) :
      FirewallStep L
        (.levelIIDiagnosis c)
        (.naturalizationClaim (.levelII c))
  | profile_diagnosis_to_naturalization (p : DecomposedProfile) :
      FirewallStep L
        (.profileDiagnosis p)
        (.naturalizationClaim (.profile p))
  | mapping_to_naturalization (c : Comparandum) (form : Realization L) :
      FirewallStep L
        (.mappingClaim c form)
        (.naturalizationClaim c)
  | coupling_to_naturalization (c d : Comparandum) :
      FirewallStep L
        (.couplingClaim c d)
        (.naturalizationClaim c)

inductive Path {α : Type} (Step : α -> α -> Prop) :
    α -> α -> Prop where
  | refl {a : α} : Path Step a a
  | cons {a b c : α} :
      Step a b -> Path Step b c -> Path Step a c

/- The downstream side of the graph reachable from forms. -/

def FormOriginReachable {L : Language} : EvidenceNode L -> Prop
  | .formObservation _ => True
  | .mappingClaim _ _ => True
  | .couplingClaim _ _ => True
  | .naturalizationClaim _ => True
  | _ => False

def DiagnosticNode {L : Language} : EvidenceNode L -> Prop
  | .levelIDiagnosis _ => True
  | .levelIIDiagnosis _ => True
  | .profileDiagnosis _ => True
  | _ => False

theorem form_step_preserves_form_origin
    {L : Language} {a b : EvidenceNode L}
    (ha : FormOriginReachable a)
    (hstep : FirewallStep L a b) :
    FormOriginReachable b := by
  cases hstep <;> simp [FormOriginReachable] at ha ⊢

theorem form_path_preserves_form_origin
    {L : Language} {a b : EvidenceNode L}
    (hpath : Path (FirewallStep L) a b)
    (ha : FormOriginReachable a) :
    FormOriginReachable b := by
  induction hpath with
  | refl => exact ha
  | cons hstep htail ih =>
      exact ih (form_step_preserves_form_origin ha hstep)

theorem no_form_path_to_levelI_diagnosis
    {L : Language} (form : Realization L) (c : LevelIComparandum) :
    Not
      (Path (FirewallStep L)
        (.formObservation form)
        (.levelIDiagnosis c)) := by
  intro hpath
  have hreach := form_path_preserves_form_origin hpath
    (by simp [FormOriginReachable])
  simp [FormOriginReachable] at hreach

theorem no_form_origin_path_to_diagnostic
    {L : Language} {a b : EvidenceNode L}
    (ha : FormOriginReachable a)
    (hb : DiagnosticNode b) :
    Not (Path (FirewallStep L) a b) := by
  intro hpath
  have hreach := form_path_preserves_form_origin hpath ha
  cases b <;> simp [FormOriginReachable, DiagnosticNode] at hreach hb

theorem no_form_path_to_levelII_diagnosis
    {L : Language} (form : Realization L) (c : LevelIIComparandum) :
    Not
      (Path (FirewallStep L)
        (.formObservation form)
        (.levelIIDiagnosis c)) :=
  no_form_origin_path_to_diagnostic
    (by simp [FormOriginReachable])
    (by simp [DiagnosticNode])

theorem no_form_path_to_profile_diagnosis
    {L : Language} (form : Realization L) (p : DecomposedProfile) :
    Not
      (Path (FirewallStep L)
        (.formObservation form)
        (.profileDiagnosis p)) :=
  no_form_origin_path_to_diagnostic
    (by simp [FormOriginReachable])
    (by simp [DiagnosticNode])

theorem no_mapping_path_to_levelI_diagnosis
    {L : Language} (d : Comparandum) (form : Realization L)
    (c : LevelIComparandum) :
    Not
      (Path (FirewallStep L)
        (.mappingClaim d form)
        (.levelIDiagnosis c)) := by
  intro hpath
  have hreach := form_path_preserves_form_origin hpath
    (by simp [FormOriginReachable])
  simp [FormOriginReachable] at hreach

theorem no_coupling_path_to_levelI_diagnosis
    {L : Language} (d e : Comparandum) (c : LevelIComparandum) :
    Not
      (Path (FirewallStep L)
        (.couplingClaim d e)
        (.levelIDiagnosis c)) := by
  intro hpath
  have hreach := form_path_preserves_form_origin hpath
    (by simp [FormOriginReachable])
  simp [FormOriginReachable] at hreach

theorem no_naturalization_path_to_levelI_diagnosis
    {L : Language} (d : Comparandum) (c : LevelIComparandum) :
    Not
      (Path (FirewallStep L)
        (.naturalizationClaim d)
        (.levelIDiagnosis c)) := by
  intro hpath
  have hreach := form_path_preserves_form_origin hpath
    (by simp [FormOriginReachable])
  simp [FormOriginReachable] at hreach

/- A deliberately leaky graph shows what the theorem is ruling out:
   adding even one edge from a form observation into a diagnostic claim
   creates a circular path immediately. -/

inductive LeakyFirewallStep (L : Language) :
    EvidenceNode L -> EvidenceNode L -> Prop where
  | safe {a b : EvidenceNode L} :
      FirewallStep L a b -> LeakyFirewallStep L a b
  | form_to_levelI_diagnosis
      (form : Realization L) (c : LevelIComparandum) :
      LeakyFirewallStep L
        (.formObservation form)
        (.levelIDiagnosis c)
  | form_to_levelII_diagnosis
      (form : Realization L) (c : LevelIIComparandum) :
      LeakyFirewallStep L
        (.formObservation form)
        (.levelIIDiagnosis c)

theorem leaky_form_path_to_levelI_diagnosis
    {L : Language} (form : Realization L) (c : LevelIComparandum) :
    Path (LeakyFirewallStep L)
      (.formObservation form)
      (.levelIDiagnosis c) :=
  Path.cons
    (LeakyFirewallStep.form_to_levelI_diagnosis form c)
    Path.refl

/- Temporal staging: same-time diagnostic circularity is forbidden, but
   diachronic feedback is allowed.  A form at time `t` may help create
   behavioural, discourse, or morphosyntactic evidence at time `t+1`.
   That later evidence can then support a later diagnosis. -/

structure TimedNode (L : Language) where
  time : Nat
  node : EvidenceNode L
deriving DecidableEq, Repr

namespace TimedNode

def atTime {L : Language} (time : Nat) (node : EvidenceNode L) :
    TimedNode L :=
  { time := time, node := node }

end TimedNode

inductive TemporalStep (L : Language) :
    TimedNode L -> TimedNode L -> Prop where
  | same_time {time : Nat} {a b : EvidenceNode L} :
      FirewallStep L a b ->
      TemporalStep L
        (TimedNode.atTime time a)
        (TimedNode.atTime time b)
  | mapping_to_next_behaviour
      (time : Nat) (c : LevelIComparandum)
      (form : Realization L) (label : String) :
      TemporalStep L
        (TimedNode.atTime time (.mappingClaim (.levelI c) form))
        (TimedNode.atTime (Nat.succ time) (.behaviouralEvidence label))
  | mapping_to_next_discourse
      (time : Nat) (c : LevelIComparandum)
      (form : Realization L) (label : String) :
      TemporalStep L
        (TimedNode.atTime time (.mappingClaim (.levelI c) form))
        (TimedNode.atTime (Nat.succ time) (.discourseEvidence label))
  | mapping_to_next_morphosyntax
      (time : Nat) (c : LevelIIComparandum)
      (form : Realization L) (label : String) :
      TemporalStep L
        (TimedNode.atTime time (.mappingClaim (.levelII c) form))
        (TimedNode.atTime (Nat.succ time) (.morphosyntacticEvidence label))

def TemporalFormOriginSafe {L : Language}
    (startTime : Nat) (n : TimedNode L) : Prop :=
  startTime <= n.time /\
    (n.time = startTime -> FormOriginReachable n.node)

theorem form_origin_not_diagnostic
    {L : Language} {node : EvidenceNode L} :
    FormOriginReachable node -> DiagnosticNode node -> False := by
  cases node <;> simp [FormOriginReachable, DiagnosticNode]

theorem temporal_step_preserves_form_origin_safe
    {L : Language} {startTime : Nat} {a b : TimedNode L}
    (ha : TemporalFormOriginSafe startTime a)
    (hstep : TemporalStep L a b) :
    TemporalFormOriginSafe startTime b := by
  cases hstep with
  | same_time hfirewall =>
      constructor
      · exact ha.left
      · intro hbtime
        exact form_step_preserves_form_origin (ha.right hbtime) hfirewall
  | mapping_to_next_behaviour time c form label =>
      constructor
      · exact Nat.le_trans ha.left (Nat.le_succ time)
      · intro hbtime
        have hlt : startTime < Nat.succ time :=
          Nat.lt_of_le_of_lt ha.left (Nat.lt_succ_self time)
        have hne : startTime ≠ Nat.succ time := Nat.ne_of_lt hlt
        exact False.elim (hne hbtime.symm)
  | mapping_to_next_discourse time c form label =>
      constructor
      · exact Nat.le_trans ha.left (Nat.le_succ time)
      · intro hbtime
        have hlt : startTime < Nat.succ time :=
          Nat.lt_of_le_of_lt ha.left (Nat.lt_succ_self time)
        have hne : startTime ≠ Nat.succ time := Nat.ne_of_lt hlt
        exact False.elim (hne hbtime.symm)
  | mapping_to_next_morphosyntax time c form label =>
      constructor
      · exact Nat.le_trans ha.left (Nat.le_succ time)
      · intro hbtime
        have hlt : startTime < Nat.succ time :=
          Nat.lt_of_le_of_lt ha.left (Nat.lt_succ_self time)
        have hne : startTime ≠ Nat.succ time := Nat.ne_of_lt hlt
        exact False.elim (hne hbtime.symm)

theorem temporal_path_preserves_form_origin_safe
    {L : Language} {startTime : Nat} {a b : TimedNode L}
    (hpath : Path (TemporalStep L) a b)
    (ha : TemporalFormOriginSafe startTime a) :
    TemporalFormOriginSafe startTime b := by
  induction hpath with
  | refl => exact ha
  | cons hstep htail ih =>
      exact ih (temporal_step_preserves_form_origin_safe ha hstep)

theorem no_temporal_form_path_to_same_time_diagnostic
    {L : Language} (time : Nat) (form : Realization L)
    (target : EvidenceNode L) (htarget : DiagnosticNode target) :
    Not
      (Path (TemporalStep L)
        (TimedNode.atTime time (.formObservation form))
        (TimedNode.atTime time target)) := by
  intro hpath
  have hsafe := temporal_path_preserves_form_origin_safe hpath
    (by
      constructor
      · exact Nat.le_refl time
      · intro htime
        simp [TimedNode.atTime, FormOriginReachable])
  exact form_origin_not_diagnostic (hsafe.right rfl) htarget

/- Cross-level couplings are allowed, but they carry explicit evidence
   and never make the coupled comparanda identical. -/

structure CrossLevelCoupling (c d : Comparandum) where
  notIdentity : Not (c = d)
  evidence : Prop
  supportsPrediction : Prop

theorem levelI_ne_levelII
    (a : LevelIComparandum) (b : LevelIIComparandum) :
    Not (Comparandum.levelI a = Comparandum.levelII b) := by
  intro h
  cases h

theorem levelI_ne_profile
    (a : LevelIComparandum) (p : DecomposedProfile) :
    Not (Comparandum.levelI a = Comparandum.profile p) := by
  intro h
  cases h

theorem levelII_ne_profile
    (a : LevelIIComparandum) (p : DecomposedProfile) :
    Not (Comparandum.levelII a = Comparandum.profile p) := by
  intro h
  cases h

/- Abstract naturalization and demotion predicates.  The empirical
   content is intentionally left outside Lean. -/

structure Theory where
  stable : Comparandum -> Prop
  mechanism : Comparandum -> Prop
  projectible : Comparandum -> Prop
  tooThin : Comparandum -> Prop
  tooFat : Comparandum -> Prop
  negativeProjectibility : Comparandum -> Prop
  indeterminate : Comparandum -> Prop

structure Naturalized (T : Theory) (c : Comparandum) : Prop where
  wellFormed : c.wellFormed
  hasStability : T.stable c
  hasMechanism : T.mechanism c
  hasProjectibility : T.projectible c

inductive Demotion (T : Theory) (c : Comparandum) : Prop where
  | tooThin : T.tooThin c -> Demotion T c
  | tooFat : T.tooFat c -> Demotion T c
  | negativeProjectibility :
      T.negativeProjectibility c -> Demotion T c
  | indeterminate : T.indeterminate c -> Demotion T c

theorem naturalized_projectible
    {T : Theory} {c : Comparandum} (h : Naturalized T c) :
    T.projectible c :=
  h.hasProjectibility

/- Small toy inventory. -/

def English : Language :=
  { name := "English" }

def Japanese : Language :=
  { name := "Japanese" }

def definitenessCross : Comparandum :=
  .levelI (.semanticTarget "definiteness")

def topicCross : Comparandum :=
  .levelI (.discourseRole "topic")

def subjectCross : Comparandum :=
  .levelII (.syntacticFunction "subject")

def subjectTopicCoupling :
    CrossLevelCoupling topicCross subjectCross :=
  { notIdentity := by
      unfold topicCross subjectCross
      exact levelI_ne_levelII
        (.discourseRole "topic")
        (.syntacticFunction "subject")
    evidence := True
    supportsPrediction := True }

def subjectTopicFeedback :
    CrossLevelCoupling subjectCross topicCross :=
  { notIdentity := by
      intro h
      exact subjectTopicCoupling.notIdentity h.symm
    evidence := True
    supportsPrediction := True }

def determinativeEng : Realization English :=
  .lexicalCategory "determinative"

def definiteDetEng : Realization English :=
  .morpheme "the"

def toyRealizes (c : Comparandum) (form : Realization English) : Prop :=
  c = definitenessCross /\ form = definiteDetEng

def toyWeight (c : Comparandum) (form : Realization English) : Weight :=
  if c = definitenessCross /\ form = definiteDetEng then
    Weight.full
  else
    Weight.zero

theorem toyWeight_support :
    forall c form, (toyWeight c form).positive -> toyRealizes c form := by
  intro c form hpos
  unfold toyRealizes
  unfold toyWeight at hpos
  by_cases h : c = definitenessCross /\ form = definiteDetEng
  · exact h
  · simp [h, Weight.positive, Weight.zero] at hpos

def toyEnglishMapping : Mapping English :=
  { realizes := toyRealizes
    weight := toyWeight
    support := toyWeight_support }

/- A comparative concept specifies a comparandum; it is not itself that
   comparandum.  Its diagnostic battery is typed by the comparandum,
   so a Level-I concept cannot be given a morphosyntactic diagnostic
   as its identifying evidence.  A language-internal realization can
   map to the same comparandum without being identical to it. -/

def anaphoricUptakeDiagnostic :
    DiagnosticItem definitenessCross :=
  { source := .behavioural
    label := "anaphoric uptake"
    allowed := by
      unfold definitenessCross
      simp [DiagnosticSource.allowedFor] }

def bridgingDiagnostic :
    DiagnosticItem definitenessCross :=
  { source := .discourse
    label := "bridging"
    allowed := by
      unfold definitenessCross
      simp [DiagnosticSource.allowedFor] }

def definitenessBattery :
    DiagnosticBattery definitenessCross :=
  { items := [anaphoricUptakeDiagnostic, bridgingDiagnostic]
    nonempty := by simp }

def extractionDiagnostic :
    DiagnosticItem subjectCross :=
  { source := .morphosyntactic
    label := "extraction behaviour"
    allowed := by
      unfold subjectCross
      simp [DiagnosticSource.allowedFor] }

def subjectBattery :
    DiagnosticBattery subjectCross :=
  { items := [extractionDiagnostic]
    nonempty := by simp }

def subjectConcept : ComparativeConcept :=
  { name := "subject diagnostic"
    picksOut := subjectCross
    wellFormed := by
      unfold subjectCross
      simp [Comparandum.wellFormed]
    diagnostics := subjectBattery }

def definitenessConcept : ComparativeConcept :=
  { name := "definiteness diagnostic"
    picksOut := definitenessCross
    wellFormed := by
      unfold definitenessCross
      simp [Comparandum.wellFormed]
    diagnostics := definitenessBattery }

example : definitenessConcept.picksOut = definitenessCross :=
  rfl

def emptyProfile : DecomposedProfile :=
  { name := "empty profile"
    levelIComponents := []
    levelIIComponents := [] }

theorem empty_profile_not_well_formed :
    Not (Comparandum.profile emptyProfile).wellFormed := by
  simp [
    Comparandum.wellFormed,
    DecomposedProfile.hasComponents,
    emptyProfile
  ]

theorem no_concept_for_empty_profile
    (concept : ComparativeConcept) :
    Not (concept.picksOut = .profile emptyProfile) := by
  intro h
  have hwell :
      (Comparandum.profile emptyProfile).wellFormed := by
    rw [← h]
    exact concept.wellFormed
  exact empty_profile_not_well_formed hwell

example :
    Path (FirewallStep English)
      (.behaviouralEvidence "anaphoric uptake")
      (.levelIDiagnosis (.semanticTarget "definiteness")) :=
  Path.cons
    (FirewallStep.behaviour_to_levelI
      "anaphoric uptake"
      (.semanticTarget "definiteness"))
    Path.refl

example :
    Path (FirewallStep English)
      (.formObservation definiteDetEng)
      (.mappingClaim definitenessCross definiteDetEng) :=
  Path.cons
    (FirewallStep.form_to_mapping definitenessCross definiteDetEng)
    Path.refl

example :
    Path (FirewallStep English)
      (.formObservation definiteDetEng)
      (.naturalizationClaim definitenessCross) :=
  Path.cons
    (FirewallStep.form_to_mapping definitenessCross definiteDetEng)
    (Path.cons
      (FirewallStep.mapping_to_naturalization
        definitenessCross definiteDetEng)
      Path.refl)

example :
    Not
      (Path (FirewallStep English)
        (.formObservation definiteDetEng)
        (.levelIDiagnosis (.semanticTarget "definiteness"))) :=
  no_form_path_to_levelI_diagnosis definiteDetEng
    (.semanticTarget "definiteness")

example :
    Path (TemporalStep English)
      (TimedNode.atTime 0 (.formObservation definiteDetEng))
      (TimedNode.atTime 1
        (.levelIDiagnosis (.semanticTarget "definiteness"))) :=
  Path.cons
    (TemporalStep.same_time
      (FirewallStep.form_to_mapping definitenessCross definiteDetEng))
    (Path.cons
      (TemporalStep.mapping_to_next_behaviour 0
        (.semanticTarget "definiteness")
        definiteDetEng
        "future anaphoric uptake")
      (Path.cons
        (TemporalStep.same_time
          (FirewallStep.behaviour_to_levelI
            "future anaphoric uptake"
            (.semanticTarget "definiteness")))
        Path.refl))

example :
    Not
      (Path (TemporalStep English)
        (TimedNode.atTime 0 (.formObservation definiteDetEng))
        (TimedNode.atTime 0
          (.levelIDiagnosis (.semanticTarget "definiteness")))) :=
  no_temporal_form_path_to_same_time_diagnostic
    0
    definiteDetEng
    (.levelIDiagnosis (.semanticTarget "definiteness"))
    (by simp [DiagnosticNode])

end TypologyOntology
