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

structure ComparativeConcept where
  name : String
  picksOut : Comparandum
  diagnostics : String
deriving Repr

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
   naturalization claims, but not Level-I diagnosis. -/

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
   comparandum.  A language-internal realization can map to the same
   comparandum without being identical to it. -/

def definitenessConcept : ComparativeConcept :=
  { name := "definiteness diagnostic"
    picksOut := definitenessCross
    diagnostics := "anaphoric uptake, uniqueness, bridging, anti-novelty" }

example : definitenessConcept.picksOut = definitenessCross :=
  rfl

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

end TypologyOntology
