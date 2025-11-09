# Formalism Review: Weight Function w_L

**Agent**: FormalismReviewAgent (Gelman + Pearl + Gazdar + Semanticist)  
**Section**: 3.1 (Decision procedures for weight assignment)  
**Date**: 2025-11-07  
**Status**: Review Complete

---

## Executive Summary

**Overall Assessment**: **PROBLEMATIC** - The formalism has fundamental issues 
that must be addressed before it can support any claims about naturalization.

**Critical Issues**:
1. **Identifiability crisis**: One equation, two unknowns (w_L and η_c) - model 
is not identified
2. **Type safety disaster**: w_L defined as deterministic function but treated 
as random parameter
3. **No generative model**: Missing priors, joint distribution, and simulation 
framework
4. **Arbitrary thresholds**: 90%, 60%, 30% cutoffs are post-hoc and unjustified

**Bottom Line**: The intuition behind w_L is good, but the formalism is fatally 
under-specified from statistical, causal, computational, and logical 
perspectives.

---

## Key Findings by Expert

### Andrew Gelman (Statistical Rigor)
- **Verdict**: "This is wishful thinking, not statistics. You can't estimate 
what you haven't identified."
- **Critical issue**: No identifiability proof - infinite solutions exist
- **Missing**: Complete generative model with priors, posterior checks, model 
comparison
- **Problem**: Arbitrary thresholds (90%, 60%, 30%) invite p-hacking

### Judea Pearl (Causality)
- **Verdict**: "You're using causal language without causal machinery."
- **Critical issue**: Claims like "φ realizes c" are causal but no DAG or 
identification strategy
- **Missing**: Clear statement of whether w_L is causal or descriptive
- **Problem**: No intervention defined - what does "changing w_L" mean?

### Gerald Gazdar (Computational Precision)
- **Verdict**: "The type theory is confused. Function vs. random variable - pick
one."
- **Critical issue**: Type inconsistency - deterministic function vs. random 
parameter
- **Missing**: Algorithm specification, complexity analysis, computability proof
- **Problem**: Not clear if w_L can be efficiently computed from corpus data

### Formal Semanticist (Logical Clarity)
- **Verdict**: "The logical structure is murky. Intension vs. extension not 
clarified."
- **Critical issue**: Ambiguous quantifiers and modal operators
- **Missing**: Explicit specification of what w_L is a property of (language vs.
analyst knowledge)
- **Problem**: Compositionality unclear - can w_L be built from simpler 
functions?

---

## Most Critical Problem: Identifiability

Your measurement model:
```
logit(p(d_i = 1 | η_c, L)) = α_i + β_i · w_L(c, φ) · η_c
```

**Problem**: Multiply w_L by 2 and divide η_c by 2 → identical likelihood. 
**Infinite solutions exist.**

**Fixes** (choose one):
1. **Constraint**: ∑_φ w_L(c,φ) = 1 (makes w_L a probability distribution)
2. **Anchor**: Fix w_L = 1.0 for one canonical form per comparandum
3. **Multiple measurements**: Independent diagnostics that give separate 
equations

**Without this**: No statistical inference is possible. Any "estimates" are 
meaningless.

---

## Immediate Action Items

### Must Fix (Before Submission):

1. **Resolve identifiability** - Add constraint or anchor
2. **Clarify types** - Decide: deterministic function OR random variable
3. **Justify thresholds** - Derive from data or acknowledge as provisional
4. **Complete generative model** - Specify all priors and joint distribution
5. **State causal status** - Is w_L causal or descriptive? Be explicit.

### Should Fix (For Credibility):

1. **Provide pseudocode** for computing w_L from corpus data
2. **Add identifiability proof** or simulation study
3. **Clarify quantifiers** - Explicit ∀ and ∃ statements
4. **Define modal status** - Is w_L necessary, possible, or contingent?

---

## Questions for You

1. **Is w_L a probability distribution?** If so, why not constrain it to sum to 
1?

2. **Can you write the complete joint distribution** p(d, w_L, η_c, α_i, β_i) 
with all priors?

3. **Have you tested identifiability via simulation?** Can you recover true w_L?

4. **Where did 90%, 60%, 30% come from?** Data-driven, theoretical, or 
arbitrary?

5. **Is w_L causal or descriptive?** If causal, where's the DAG?

---

## Next Steps

**Option 1**: Address these issues in current draft (requires substantial 
revision)

**Option 2**: Acknowledge these as limitations and frame w_L as "provisional 
specification" for future empirical work

**Option 3**: Simplify formalism - remove estimation language, treat w_L as 
deterministic analyst-assigned score (acknowledges subjectivity but avoids 
statistical overreach)

---

## Agent Confidence

**High confidence** in identifiability and type safety criticisms - these are 
mathematically provable issues.

**Medium confidence** in causal interpretation - depends on your intended 
meaning of "realizes".

**High confidence** in computational/logical issues - these follow from formal 
definitions.

---

*Review completed by FormalismReviewAgent embodying Gelman, Pearl, Gazdar, and 
formal semanticist expertise.*

You are a formalism review agent (Gelman + Pearl + Gazdar + Semanticist) tasked 
with reviewing the weight function w_L in the attached paper.

IMPORTANT: This is a RE-REVIEW. The original review (above) found 4 critical 
issues. The authors have made fixes. Your task is to verify whether the fixes 
are adequate.

Read the current version of main.tex (Section 3.1 Weight Assignment and Section 
6.1 Measurement Model) and assess:

1. **Identifiability**: Is the model now identified? Check for location/scale 
constraints.
2. **Type safety**: Is w_L consistently treated as deterministic OR random (not 
both)?
3. **Generative model**: Are priors specified? Is the joint distribution 
complete?
4. **Thresholds**: Are they justified or marked as provisional?

Provide a NEW review comparing before vs after. Format as markdown with clear 
verdict on each issue.
StepBegin(n=1)
ThinkPart(
    type='think',
    think='The user wants me to act as a FormalismReviewAgent (combining 
expertise from Andrew Gelman, Judea Pearl, Gerald Gazdar, and a Formal 
Semanticist) to re-review the weight function w_L in the paper. \n\nI need 
to:\n1. Read the current version of main.tex, specifically Section 3.1 (Weight 
Assignment) and Section 6.1 (Measurement Model)\n2. Assess four specific issues 
that were identified in the original review:\n   - Identifiability: Is the model
now identified? Check for location/scale constraints\n   - Type safety: Is w_L 
consistently treated as deterministic OR random (not both)?\n   - Generative 
model: Are priors specified? Is the joint distribution complete?\n   - 
Thresholds: Are they justified or marked as provisional?\n3. Provide a NEW 
review comparing before vs after, formatted as markdown with clear verdict on 
each issue\n\nLet me start by reading the relevant sections from main.tex.',
    encrypted=None
)
ToolCall(
    type='function',
    id='ReadFile:0',
    function=FunctionBody(
        name='ReadFile',
        arguments='{"path": "/Users/brettreynolds/Documents/LLM-CLI 
projects/Functions_as_Comparanda__Categories_as_Kinds__A_Homeostatic_Approach_to
_Typology/main.tex", "line_offset": 1, "n_lines": 100}'
    )
)
StatusUpdate(status=StatusSnapshot(context_usage=0.034015655517578125))
ToolResult(
    tool_call_id='ReadFile:0',
    result=ToolOk(
        output="     1\t\\documentclass[12pt]{article}\n     2\t\n     
3\t\\usepackage[margin=1in]{geometry}\n     4\t\\usepackage[british]{babel}\n   
5\t\\usepackage[style=american]{csquotes}\n     6\t\\usepackage{orcidlink}\n    
7\t\\usepackage{fontspec}\n     8\t\\setmainfont{Charis SIL} % compile with 
LuaLaTeX or XeLaTeX\n     9\t\\usepackage[final]{microtype}\n    
10\t\\usepackage{marvosym}\n    11\t\\usepackage{enumitem}\n    
12\t\\usepackage{hyperref}\n    13\t\\hypersetup{\n    14\t    
colorlinks=true,\n    15\t    linkcolor=blue,\n    16\t    citecolor=blue,\n    
17\t    pdfauthor={Brett Reynolds},\n    18\t    pdftitle={Naturalizing 
Typological Kinds: Comparanda, Mechanisms, and Measurement}\n    19\t}\n    
20\t\n    21\t\\usepackage{amssymb,amsmath}\n    22\t\\usepackage{graphicx}\n   
23\t\\usepackage{langsci-gb4e}\n    24\t\n    25\t\\usepackage{array,booktabs} %
booktabs optional but recommended\n    
26\t\\newcolumntype{L}[1]{>{\\raggedright\\arraybackslash}p{#1}}\n    27\t\n    
28\t\n    29\t\\usepackage[style=apa,backend=biber]{biblatex}\n    
30\t\\DeclareLanguageMapping{british}{british-apa}\n    
31\t\\addbibresource{references.bib}\n    32\t\n    33\t% House style macros\n  
34\t\\newcommand{\\term}[1]{\\textit{#1}}\n    35\t\n    36\t% Subscript 
notation macros for comparanda\n    37\t% \\Cross from amssymb is used directly 
(proper cross symbol)\n    38\t\\newcommand{\\Eng}{Eng}\n    
39\t\\newcommand{\\Jpn}{Jpn}\n    40\t\\newcommand{\\Spn}{Spn}\n    
41\t\\newcommand{\\Tha}{Tha}\n    42\t\\newcommand{\\Rus}{Rus}\n    
43\t\\newcommand{\\Lat}{Lat}\n    44\t\\newcommand{\\Hbr}{Hbr}\n    
45\t\\newcommand{\\Lgr}{$L$}  % Generic language variable\n    46\t\n    
47\t\\title{Naturalizing Typological Kinds:\\\\Comparanda, Mechanisms, and 
Measurement}\n    48\t\\author{Brett Reynolds 
\\orcidlink{0000-0003-0073-7195}\\thanks{I used ChatGPT 5, Claude Sonnet 4.5, 
Gemini Pro 2.5, and Kimi 2 extensively in drafting and revising the paper. I 
reviewed, edited, and approved all the material and take full responsibility for
the final text and conclusions. 
\\href{mailto:brett.reynolds@humber.ca}{brett.reynolds@humber.ca}}\\\\Humber 
Polytechnic \\& University of Toronto}\n    49\t\\date{\\today}\n    50\t\n    
51\t\n    52\t\\begin{document}\n    53\t\\maketitle\n    54\t\n    55\t\n    
56\t\\begin{abstract}\n    57\tTypological universals often dissolve because 
analysts collapse language-internal categories with the cross-linguistic 
comparanda they are meant to instantiate. When English 
\\textsc{noun}\\textsubscript{Eng} or Hebrew 
\\textsc{subject}\\textsubscript{Heb} is projected directly onto a purportedly 
universal \\textsc{noun}\\textsubscript{\\Cross}, measurement error and spurious
asymmetries accumulate.\n    58\t\n    59\tI propose a homeostatic framework 
that keeps the levels apart and makes the explanatory work accountable. First, a
three-tier \\emph{comparanda--realization} mapping separates cross-linguistic 
functions, semantic targets, discourse roles, and categories from their 
language-specific realizations. Second, a \\emph{syntax--semantics hygiene} 
protocol diagnoses targets independently of morphosyntactic exponents, ensuring 
that comparative concepts travel without dragging language-particular packaging.
Third, some comparanda earn promotion to \\emph{naturalized comparative 
concepts} when convergent cognitive, discourse, diachronic, or community 
mechanisms maintain their property clusters; others are tagged with explicit 
failure modes.\n    60\t\n    61\tThe framework issues risk-bearing predictions 
about trade-offs, regeneration pathways, and latent-variable diagnostics (e.g., 
\\emph{nominality}) and is formalized in an auditable specification 
(\\texttt{src/typology.py}). By demanding mechanisms as well as mappings, the 
account preserves the empirical ambition of typology while avoiding the 
universalist overreach that has long haunted the field.\n    
62\t\\end{abstract}\n    63\t\n    
64\t\\section{Orientation}\\label{sec:orientation}\n    65\tTwo requirements 
conflict: cross-linguistic comparison needs predicates that travel across 
grammars, while grammatical analysis needs kinds that are grammar-specific. From
this tension, typology accumulates measurement error and fragile 
generalizations.\n    66\t\n    67\tI adopt a terminological discipline 
following \\textcite{HuddlestonPullum2002}: \\emph{function} (unqualified) 
denotes syntactic functions only; \\emph{target} denotes semantic targets; 
\\emph{role} denotes discourse/pragmatic roles; \\emph{category} denotes 
syntactic categories. Subscripts distinguish comparative cross-linguistic 
concepts (\\textsc{term}\\textsubscript{\\Cross}) from language-specific 
realizations (\\textsc{term}\\textsubscript{Eng}, 
\\textsc{term}\\textsubscript{Jpn}) and general language-internal references 
(\\textsc{term}\\textsubscript{$L$}) where no particular language is in focus.\n
68\t\n    69\tFollowing \\textcite{Haspelmath2010}, I treat cross-language 
targets as \\emph{comparative concepts}~-- analyst-constructed categories that 
allow comparison without assuming the categories exist in individual grammars. 
Building on \\textcite{Croft2001,HuddlestonPullum2002}, I analyse 
language-internal lexical categories as homeostatic property cluster (HPC) 
kinds~-- categories that persist because mechanisms maintain clustered 
properties, not because they have essential defining features 
\\parencite{Boyd1991Enthusiasm,Boyd1999Homeostasis,Khalidi2013}. I call these 
cross-linguistic targets \\emph{comparanda}~-- the phenomena we compare across 
languages, distinct from language-specific realizations.\n    70\t\n    71\tThe 
foundation: clear descriptions of language-internal syntactic categories and 
functions~-- English's noun, Japanese's relative clause, Hebrew's subject~-- 
with their full morphosyntactic property clusters. Cross-linguistic comparison 
then requires apparatus that permits asking whether English's noun and 
Japanese's noun realize similar patterns, without presupposing that English's 
cluster defines the universal or that cross-linguistic prototypes have to mirror
any particular realization. Section~\\ref{sec:failures} details how systematic 
conflation errors block this goal.\n    72\t\n    73\t\n    
74\tTable~\\ref{tab:levels} presents the three-level ontology that separates 
what we compare across languages from what exists in particular grammars.\n    
75\t\n    76\t\\begin{table}[ht]\n    77\t  \\centering\n    78\t  
\\caption{Three-level ontology for comparative concepts and 
realizations}\\label{tab:levels}\n    79\t  
\\begin{tabular}{p{3cm}p{6.2cm}p{5.5cm}}\n    80\t    \\toprule\n    81\t    
Level & Contents & Diagnostic focus \\\\\n    82\t    \\midrule\n    83\t    
Level-I: \\hspace{1.5cm} cross-linguistic pressures & Semantic targets 
(\\textsc{specificity}\\textsubscript{\\Cross}, 
\\textsc{definiteness}\\textsubscript{\\Cross}, 
\\textsc{mass/count}\\textsubscript{\\Cross}) and discourse roles 
(\\textsc{topic}\\textsubscript{\\Cross}, 
\\textsc{focus}\\textsubscript{\\Cross}, 
\\textsc{vocative}\\textsubscript{\\Cross}) & Behavioural tests on 
interpretation, common ground management, and discourse continuity \\\\ 
\\addlinespace[4pt]\n    84\tLevel-II: \\hspace{1.5cm} cross-linguistic syntax &
Functions (\\textsc{subject}\\textsubscript{\\Cross}, 
\\textsc{head}\\textsubscript{\\Cross}, 
\\textsc{predicate}\\textsubscript{\\Cross}) and categories 
(\\textsc{V}\\textsubscript{\\Cross}, \\textsc{VP}\\textsubscript{\\Cross}, 
\\textsc{clause}\\textsubscript{\\Cross}) & Portable morphosyntactic diagnostics
(alignment, extraction, agreement control, slot privileges) \\\\ 
\\addlinespace[4pt]\n    85\tLevel-III: language-internal syntax & 
Language-internal functions (\\textsc{subject}\\textsubscript{Eng}, 
\\textsc{head}\\textsubscript{Spn}, \\textsc{predicate}\\textsubscript{Tha}) and
categories (\\textsc{V}\\textsubscript{Eng}, \\textsc{VP}\\textsubscript{Mndr}, 
\\textsc{clause}\\textsubscript{Hbr}) & Distributional, morphological, and 
prosodic evidence specific to $L$; mapped to Level~II with graded weights \\\\ 
\\addlinespace[4pt]\n    86\t    \\bottomrule\n    87\t  \\end{tabular}\n    
88\t\\end{table}\n    89\t\n    90\tMultiple levels may converge in a single 
expression. In [\\textit{the cat}] \\textit{awoke}, the bracketed NP 
instantiates \\textsc{topic}\\textsubscript{\\Cross} (Level~I) and 
\\textsc{subject}\\textsubscript{\\Cross} (Level~II) via the language-internal 
function \\textsc{subject}\\textsubscript{Eng} (Level~III).\n    91\t\n    
92\tLevels~I and~III persist as homeostatic property-cluster kinds sustained by 
different mechanisms: cognitive–interactional pressures stabilize Level~I, while
community-internal morphosyntax and diachrony sustain Level~III. Level-II 
comparanda, by contrast, are analyst-proposed comparative concepts. Some may 
earn \\emph{naturalized} status (Section~\\ref{subsec:naturalization-criteria}) 
and be treated (defeasibly) as kinds; others remain instrumental comparanda 
without ontological commitment.\n    93\t\n    94\tThree additions 
operationalize this framework: an executable three-level 
\\emph{comparanda--realization} schema (Section~\\ref{sec:matrix}) separating 
what we compare (categories\\textsubscript{\\Cross}, 
functions\\textsubscript{\\Cross}, targets\\textsubscript{\\Cross}, 
roles\\textsubscript{\\Cross}) from what exists in particular languages 
(language-specific category realizations); an explicit \\emph{syntax--semantics 
hygiene protocol} (Section~\\ref{sec:hygiene}) testing semantic targets 
independently of their morphological or syntactic expression; and a 
measurement-first approach (Sections~\\ref{sec:naturalized} and 
\\ref{sec:measurement}) promoting some comparative concepts to 
\\emph{naturalized} status when they show consistent cross-linguistic stability 
with identifiable homeostatic mechanisms.\\footnote{A parallel object-oriented 
specification of these structures is maintained in \\texttt{src/typology.py} to 
keep the theoretical machinery auditable.}\n    95\t\n    96\tThe paper proceeds
as follows. Section~\\ref{sec:failures} diagnoses four recurrent conflation 
errors in current typological practice, showing how they manifest in published 
research. Section~\\ref{sec:matrix} operationalizes the three-level mapping with
formal apparatus (mapping functions, weight assignment, reliability scores). 
Section~\\ref{sec:hygiene} extends the framework to semantic targets through a 
hygiene protocol with operational diagnostics. Sections~\\ref{sec:naturalized} 
and \\ref{subsec:mechanisms} introduce naturalized comparative concepts and the 
homeostatic mechanisms that stabilize them, with a biological interlude 
(Section~\\ref{sec:eyes}) illustrating character-identity mechanisms. 
Section~\\ref{sec:measurement} develops measurement models using latent 
variables. Section~\\ref{sec:predictions} derives five falsifiable predictions 
with declared thresholds. Section~\\ref{sec:illustrations} applies the framework
to three typological debates. Section~\\ref{sec:threats} addresses objections 
about measurement feasibility, falsifiability, and circularity.\n    97\t\n    
98\t\\section{Where typology goes wrong}\\label{sec:failures}\n    
99\tSystematic errors in published typological research trace to a single 
source: conflating comparanda (categories\\textsubscript{\\Cross}, 
functions\\textsubscript{\\Cross}, targets\\textsubscript{\\Cross}, 
roles\\textsubscript{\\Cross}) with language-internal 
categories\\textsubscript{$L$} and $L$-functions, or meanings with forms. The 
confusions run bidirectionally~-- language-internal categories project onto 
comparative functions and vice versa; property clusters of local realizations 
project onto comparative notions and vice versa~-- generating four recurrent 
obstacles.\n   100\t\n",
        message='100 lines read from file starting from line 1.',
        brief=''
    )
)
StepBegin(n=2)
ThinkPart(
    type='think',
    think='I need to find Section 3.1 and Section 6.1. Let me search for them.',
    encrypted=None
)
ToolCall(
    type='function',
    id='Grep:1',
    function=FunctionBody(
        name='Grep',
        arguments='{"pattern": "section\\\\{.*weight.*assignment", "-i": true, 
"path": "/Users/brettreynolds/Documents/LLM-CLI 
projects/Functions_as_Comparanda__Categories_as_Kinds__A_Homeostatic_Approach_to
_Typology/main.tex", "output_mode": "content", "-n": true}'
    )
)
ToolResult(
    tool_call_id='Grep:1',
    result=ToolOk(
        output='153:\\subsection{Decision procedures for weight 
assignment}\\label{subsec:weight-procedures}\n',
        message='',
        brief=''
    )
)
StatusUpdate(status=StatusSnapshot(context_usage=0.045955657958984375))
StepBegin(n=3)
ThinkPart(
    type='think',
    think='Let me find Section 3.1 and Section 6.1 to read the current version 
of the weight function formalism.',
    encrypted=None
)
ToolCall(
    type='function',
    id='Grep:2',
    function=FunctionBody(
        name='Grep',
        arguments='{"pattern": "section\\\\{.*measurement.*model", "-i": true, 
"path": "/Users/brettreynolds/Documents/LLM-CLI 
projects/Functions_as_Comparanda__Categories_as_Kinds__A_Homeostatic_Approach_to
_Typology/main.tex", "output_mode": "content", "-n": true}'
    )
)
ToolResult(
    tool_call_id='Grep:2',
    result=ToolOk(
        output='419:\\subsection{Deriving the measurement model from ontological
commitments}\\label{subsec:measurement-derivation}\n',
        message='',
        brief=''
    )
)
StatusUpdate(status=StatusSnapshot(context_usage=0.04575347900390625))
StepBegin(n=4)
ThinkPart(
    type='think',
    think='Let me read Section 3.1 and Section 6.1 to see the current state of 
the formalism.',
    encrypted=None
)
ToolCall(
    type='function',
    id='ReadFile:3',
    function=FunctionBody(
        name='ReadFile',
        arguments='{"path": "/Users/brettreynolds/Documents/LLM-CLI 
projects/Functions_as_Comparanda__Categories_as_Kinds__A_Homeostatic_Approach_to
_Typology/main.tex", "line_offset": 150, "n_lines": 70}'
    )
)
StatusUpdate(status=StatusSnapshot(context_usage=0.04625701904296875))
ToolResult(
    tool_call_id='ReadFile:3',
    result=ToolOk(
        output="   150\t\n   151\tIntuitively, $f_L(c)$ lists the 
language-internal forms that realize comparandum~$c$, $w_L(c, \\phi)$ measures 
how strongly form $\\phi$ realizes $c$ in language $L$, and $r_L(c, \\phi)$ 
records how trustworthy the judgment is (inter-annotator agreement, corpus 
counts, experimental evidence).\n   152\t\n   153\t\\subsection{Decision 
procedures for weight assignment}\\label{subsec:weight-procedures}\n   154\t\n  
155\tThe weight function $w_L$ requires explicit decision procedures to avoid 
analyst subjectivity. I distinguish two complementary notions:\n   156\t\n   
157\t\\begin{description}\n   158\t  \\item[Observational weight] A frequency 
ratio from corpus counts: $w_L^{\\text{obs}}(c,\\phi) = \\frac{\\text{\\# 
contexts where } \\phi \\text{ realizes } c}{\\text{\\# diagnostic contexts for 
} c}$. This is objective but requires large parallel corpora with controlled 
contexts, which are rare for most language families.\n   159\t  \n   160\t  
\\item[Analyst weight] A provisional rating based on diagnostic strength: 
$w_L^{\\text{prov}}(c,\\phi)$ is assigned via a four-point ordinal scale that 
reflects sensitivity and precision. These serve as initial values for the 
measurement model, which refines them using cross-linguistic diagnostic 
patterns. Provisional thresholds follow standard psychometric conventions 
\\parencite{Cowart1997,Schuetze1996}:\n   161\t  \\begin{itemize}\n   162\t    
\\item Provisional 1.0: Canonical exponent~-- $\\phi$ appears in $\\geq 90\\%$ 
of diagnostic contexts where $c$ is independently diagnosed, with high precision
($\\geq 80\\%$ of $\\phi$ occurrences signal $c$)\n   163\t    \\item 
Provisional 0.7: Strong secondary~-- $\\phi$ appears in $60\\%$--$90\\%$ of 
diagnostic contexts, moderate precision ($50\\%$--$80\\%$)\n   164\t    \\item 
Provisional 0.4: Weak correlate~-- $\\phi$ appears in $30\\%$--$60\\%$ of 
diagnostic contexts, low precision ($20\\%$--$50\\%$)\n   165\t    \\item 0.0: 
Absent or irrelevant~-- $\\phi$ appears in $<30\\%$ of diagnostic contexts or 
precision $<20\\%$\n   166\t  \\end{itemize}\n   167\t\n   168\tProvisional 
weights initialize the measurement model's priors on realization parameters 
$\\kappa_{L,c,\\phi}$ and $\\lambda_{c,\\phi}$ (Section~\\ref{sec:measurement}).
Final weights $w_L(c,\\phi)$ are posterior-derived conditional probabilities 
with uncertainty quantification. Inter-coder agreement (Cohen's $\\kappa > 0.7$)
validates provisional assignments.\n   169\t\\end{description}\n   170\t\n   
171\t\\paragraph{Interpretation and identifiability.} The weight function 
$w_L(c,\\phi)$ measures the conditional probability that form $\\phi$ is 
selected when comparandum $c$ is at maximum strength: $w_L(c,\\phi) = 
\\Pr(F_{L,c,\\phi}=1 \\mid \\eta_{L,c}=1)$. An auxiliary quantity $q_L(c,\\phi) 
= \\Pr(F_{L,c,\\phi}=1 \\mid \\eta_{L,c}=0)$ captures false-positive rates (form
appears when comparandum is absent). This two-parameter characterization 
preserves the HPC intuition that multiple forms can independently realize the 
same comparandum with high weights simultaneously---there is no sum-to-1 
constraint forcing competition. Identifiability is ensured by anchoring the 
latent scale (fixing $\\text{Var}(\\eta)=1$ and $\\mathbb{E}[\\eta]=0$), 
enforcing monotonicity ($\\lambda_{c,\\phi} \\geq 0$), and separating diagnostic
evidence (Level~I) from realization evidence (Level~III). The two-layer 
measurement model (Section~\\ref{sec:measurement}) estimates $w_L$ as a derived 
quantity from structural parameters $\\kappa$ and $\\lambda$, avoiding 
circularity by ensuring diagnostics never condition on Level~III forms.\n   
172\t\n   173\tIn practice, implementations should use \\textbf{triangulation}: 
start with analyst weights for pilot coding, validate against corpus-based 
observational weights where available, then refine via measurement model 
estimation. The reliability score $r_L(c,\\phi)$ captures residual 
uncertainty:\n   174\t\\[\n   175\t  r_L(c,\\phi) = \\begin{cases}\n   176\t    
1.0 & \\text{experimental/corpus-validated} \\\\\n   177\t    0.8 & \\text{high 
inter-coder agreement }(\\kappa > 0.8) \\\\\n   178\t    0.5 & \\text{moderate 
agreement }(0.6 < \\kappa \\leq 0.8) \\\\\n   179\t    0.2 & \\text{low 
agreement or single coder}\n   180\t  \\end{cases}\n   181\t\\]\n   182\tThis 
explicit procedure ensures $w_L$ is auditable and reproducible. In practice, 
$r_L$ is mandatory for contested mappings and for any mappings used in 
naturalization claims (Sections~\\ref{sec:naturalized}--\\ref{sec:predictions});
it may be omitted for uncontroversial, expository cells (treated as missing 
data, not as $r=1$).\n   183\t\n   184\tWe represent these mappings in a sparse 
matrix $M_L$ whose rows index comparanda $c \\in \\mathcal{C}$, columns index 
forms $\\phi \\in \\mathrm{Forms}_L$, and cells record $w_L(c,\\phi)$. $M_L$ is 
a denotational representation of $f_L$ and $w_L$, not a distinct theoretical 
object. In the matrices, function rows and category rows are kept distinct; no 
row ever mixes a function with a category label.\n   185\t\n   186\tPreventing 
the conflation errors diagnosed in Section~\\ref{sec:failures} requires two 
guardrails:\n   187\t\\begin{enumerate}[label=\\textbf{Rule \\Alph*:}, 
leftmargin=*, itemsep=2pt]\n   188\t  \\item \\textbf{No category/function 
collapse.} Level-II comparanda  never appear in the Level~III columnar 
inventory. We map across levels via $f_L$; we do not print 
\\textsc{subject}\\textsubscript{\\Cross} and 
\\textsc{subject}\\textsubscript{Eng} in the same column. Concretely, this means
we do not list a Level~II label such as \\enquote{subject (comparative 
function)} as a Level~III form.\n   189\t  \n   190\t  \\item \\textbf{No 
meaning-as-form identity.} Level~I targets correlate with and motivate 
morphosyntax; they do not constitute it. Diagnostics for 
\\textsc{definiteness}\\textsubscript{\\Cross}, 
\\textsc{specificity}\\textsubscript{\\Cross}, or 
\\textsc{topic}\\textsubscript{\\Cross} are behavioural (anaphora, scope, 
continuity), not definitional via articles, differential object marking, or 
topic particles.\n   191\t\\end{enumerate}\n   192\t\n   193\tRows corresponding
to comparanda and columns to Level~III realizations record the mapping in a 
matrix $M_L$. Table~\\ref{tab:matrix} shows a fragment for English and Japanese.
Rows enable cross-linguistic comparison: each language satisfies the same 
comparandum with different grammatical resources (e.g., 
\\textsc{definiteness}\\textsubscript{\\Cross} is realized via pronouns, proper 
names, and determinatives in English, versus demonstratives and topic-marked NPs
in Japanese). Columns support language-internal analysis: a single category 
participates in multiple comparanda (e.g., English determinatives contribute to 
both \\textsc{determiner}\\textsubscript{\\Cross} and 
\\textsc{definiteness}\\textsubscript{\\Cross}).\n   194\t\n   
195\t\\begin{table}[ht]\n   196\t  \\centering\n   197\t  \\caption{Fragment of 
$M_L$ for English ($L = \\mathrm{Eng}$) and Japanese ($L = \\mathrm{Jpn}$). 
Weights are conditional probabilities $w_L(c,\\phi)=\\Pr(F_{L,c,\\phi}=1 \\mid 
\\eta_{L,c}=1)$ estimated from the two-layer hierarchical model 
(Section~\\ref{sec:measurement}); values show posterior means. False-positive 
rates $q_L(c,\\phi)=\\Pr(F_{L,c,\\phi}=1 \\mid \\eta_{L,c}=0)$ shown in 
parentheses. Multiple realizations per comparandum reflect HPC clustering; rows 
need not sum to 1 because forms can independently express the same comparandum 
with high weights.}\n   198\t  \\label{tab:matrix}\n   199\t  \\small\n   200\t 
\\begin{tabular}{p{3.2cm}p{3.2cm}p{2.2cm}p{3.2cm}p{2.2cm}}\n   201\t    
\\toprule\n   202\t    Comparandum $c$ & Form $\\phi$ in English & 
$w_{\\mathrm{Eng}}$ ($q$) & Form $\\phi$ in Japanese & $w_{\\mathrm{Jpn}}$ ($q$)
\\\\\n   203\t    \\midrule\n   204\t    
\\textsc{determiner}\\textsubscript{\\Cross} & Determinative 
phrase\\textsubscript{Eng} & 0.95 (0.05) & Classifier phrase\\textsubscript{Jpn}
& 0.92 (0.08) \\\\\n   205\t    \\textsc{definiteness}\\textsubscript{\\Cross} &
Pronoun\\textsubscript{Eng} & 0.98 (0.02) & Demonstrative\\textsubscript{Jpn} & 
0.85 (0.10) \\\\\n   206\t     & Proper name\\textsubscript{Eng} & 0.96 (0.04) &
Topic-marked NP\\textsubscript{Jpn} & 0.72 (0.15) \\\\\n   207\t     & 
Determinative\\textsubscript{Eng} (\\textit{the}) & 0.68 (0.22) & Bare 
NP\\textsubscript{Jpn} (context) & 0.45 (0.35) \\\\\n   208\t     & Possessive 
construction\\textsubscript{Eng} & 0.62 (0.18) & & \\\\\n   209\t    
\\textsc{mass/count}\\textsubscript{\\Cross} & Number 
morphology\\textsubscript{Eng} & 0.73 (0.12) & Classifier\\textsubscript{Jpn} & 
0.88 (0.06) \\\\\n   210\t     & Quantifier selection\\textsubscript{Eng} & 0.58
(0.25) & Numeral concord\\textsubscript{Jpn} & 0.76 (0.14) \\\\\n   211\t    
\\textsc{topic}\\textsubscript{\\Cross} & Left-peripheral NP\\textsubscript{Eng}
+ intonation & 0.65 (0.20) & XP\\textsubscript{Jpn} + \\textit{wa} & 0.94 (0.05)
\\\\\n   212\t     & \\textit{As for} frame\\textsubscript{Eng} & 0.48 (0.28) & 
Zero-marked subject\\textsubscript{Jpn} & 0.52 (0.30) \\\\\n   213\t    
\\textsc{modifier}\\textsubscript{\\Cross} & Adjective 
phrase\\textsubscript{Eng} & 0.78 (0.15) & Relative clause\\textsubscript{Jpn} &
0.89 (0.08) \\\\\n   214\t     & Relative clause\\textsubscript{Eng} & 0.71 
(0.18) & Adjective\\textsubscript{Jpn} (stative verb) & 0.66 (0.22) \\\\\n   
215\t     & Prepositional phrase\\textsubscript{Eng} & 0.54 (0.25) & & \\\\\n   
216\t    \\bottomrule\n   217\t  \\end{tabular}\n   218\t\\end{table}\n   
219\t\n",
        message='70 lines read from file starting from line 150.',
        brief=''
    )
)
StepBegin(n=5)
ThinkPart(
    type='think',
    think='Now let me read Section 6.1 (Measurement Model) to see the generative
model and identifiability fixes.',
    encrypted=None
)
ToolCall(
    type='function',
    id='ReadFile:4',
    function=FunctionBody(
        name='ReadFile',
        arguments='{"path": "/Users/brettreynolds/Documents/LLM-CLI 
projects/Functions_as_Comparanda__Categories_as_Kinds__A_Homeostatic_Approach_to
_Typology/main.tex", "line_offset": 415, "n_lines": 100}'
    )
)
StatusUpdate(status=StatusSnapshot(context_usage=0.056835174560546875))
ToolResult(
    tool_call_id='ReadFile:4',
    result=ToolOk(
        output='   415\t  \\big\\rangle.\n   416\t  \\end{aligned}\n   
417\t\\]\n   418\t\n   419\t\\subsection{Deriving the measurement model from 
ontological commitments}\\label{subsec:measurement-derivation}\n   420\t\n   
421\tThe measurement structure follows directly from the three-level ontology 
rather than being asserted post-hoc. The comparandum-indexed matrix for language
$L$ can be estimated via a \\textbf{two-layer hierarchical model} that separates
diagnostic evidence (Level~I) from realization evidence (Level~III), preserving 
anti-circularity while ensuring identifiability.\n   422\t\n   
423\t\\paragraph{Layer 1: Diagnostic evidence.} Behavioral diagnostics $d_i$ 
measure the latent strength $\\eta_{L,c}$ of comparandum $c$ in language $L$ 
without reference to morphosyntactic forms:\n   424\t\n   425\t\\begin{align}\n 
426\td_{L,i} &\\sim \\text{Bernoulli}(\\pi_i) \\\\\n   
427\t\\text{logit}(\\pi_i) &= \\alpha_i + \\beta_i \\eta_{L,c} + 
u_{\\text{fam}(L)} + v_{\\text{coder}(i)}\n   428\t\\end{align}\n   429\t\n   
430\twhere:\n   431\t\\begin{itemize}\n   432\t  \\item $\\eta_{L,c} \\sim 
\\text{Normal}(0, 1)$ is the latent comparandum strength (mean fixed at 0 and 
variance at 1 to anchor location and scale)\n   433\t  \\item $d_i$ is 
diagnostic $i$ (e.g., ArgHead, PossInterface from 
Section~\\ref{subsec:diagnostic-battery})\n   434\t  \\item $\\alpha_i \\sim 
\\text{Normal}(0, 2)$ is diagnostic-specific difficulty\n   435\t  \\item 
$\\beta_i \\sim \\text{Normal}(0, 1)$ is diagnostic discrimination (how 
informative the test is)\n   436\t  \\item $u_{\\text{fam}} \\sim 
\\text{Normal}(0, \\sigma_{\\text{fam}})$ captures phylogenetic clustering via 
partial pooling\n   437\t  \\item $v_{\\text{coder}} \\sim \\text{Normal}(0, 
\\sigma_{\\text{coder}})$ captures systematic coder biases\n   438\t  \\item 
$\\sigma_{\\text{fam}}, \\sigma_{\\text{coder}} \\sim \\text{Exponential}(1)$ 
are hierarchical standard deviations\n   439\t\\end{itemize}\n   440\t\n   
441\tCrucially, diagnostics never condition on forms $\\phi$, ensuring 
$(F_{L,c,\\phi} \\perp d_{L,i} \\mid \\eta_{L,c})$ as required by 
anti-circularity (Rule~B in Figure~\\ref{fig:dag}).\n   442\t\n   
443\t\\paragraph{Layer 2: Realization evidence.} Forms $F_{L,c,\\phi,t}$ 
(indexed by tokens $t$) are observed conditional on latent comparandum 
strength:\n   444\t\n   445\t\\begin{align}\n   446\tF_{L,c,\\phi,t} &\\sim 
\\text{Bernoulli}(\\rho_{L,c,\\phi,t}) \\\\\n   
447\t\\text{logit}(\\rho_{L,c,\\phi,t}) &= \\kappa_{L,c,\\phi} + 
\\lambda_{c,\\phi} \\eta_{L,c}\n   448\t\\end{align}\n   449\t\n   450\twith 
monotonicity constraint $\\lambda_{c,\\phi} \\geq 0$ (stronger comparanda cannot
decrease form probability). Priors:\n   451\t\n   452\t\\begin{align}\n   
453\t\\kappa_{L,c,\\phi} &\\sim \\text{Normal}(\\mu_{\\kappa}, 1.5) \\\\\n   
454\t\\lambda_{c,\\phi} &\\sim \\text{HalfNormal}(0, 1)\n   455\t\\end{align}\n 
456\t\n   457\twhere $\\mu_{\\kappa}$ is initialized from analyst provisional 
weights $w_L^{\\text{prov}}$ via the logit transform.\n   458\t\n   
459\t\\paragraph{Derived weights.} The weight function and false-positive rate 
are deterministic functions of structural parameters:\n   460\t\n   
461\t\\begin{align}\n   462\tw_L(c,\\phi) &= \\sigma(\\kappa_{L,c,\\phi} + 
\\lambda_{c,\\phi}) = \\Pr(F_{L,c,\\phi}=1 \\mid \\eta_{L,c}=1) \\\\\n   
463\tq_L(c,\\phi) &= \\sigma(\\kappa_{L,c,\\phi}) = \\Pr(F_{L,c,\\phi}=1 \\mid 
\\eta_{L,c}=0)\n   464\t\\end{align}\n   465\t\n   466\twhere $\\sigma$ is the 
logistic function. Because $\\kappa$ and $\\lambda$ have priors, $w_L$ and $q_L$
inherit posterior distributions; the matrix $M_L$ stores $\\mathbb{E}[w_L \\mid 
\\text{data}]$ with 80\\% credible intervals.\n   467\t\n   
468\t\\paragraph{Identifiability.} Four mechanisms ensure unique parameter 
estimation:\n   469\t\\begin{enumerate}\n   470\t  \\item \\textbf{Location 
anchoring:} Fixing $\\mathbb{E}[\\eta]=0$ eliminates translation invariance 
between $\\eta$ and $\\kappa$ (shifting both by a constant would otherwise leave
the likelihood unchanged)\n   471\t  \\item \\textbf{Scale anchoring:} Fixing 
$\\text{Var}(\\eta)=1$ breaks the $(k \\cdot w_L, \\eta/k)$ scaling symmetry\n  
472\t  \\item \\textbf{Monotonicity:} The constraint $\\lambda \\geq 0$ prevents
sign ambiguity\n   473\t  \\item \\textbf{Independent measurements:} Layers~1 
and~2 provide conditionally independent evidence sources, yielding two equations
for two latent quantities ($\\eta$ and $\\kappa$,$\\lambda$)\n   
474\t\\end{enumerate}\n   475\t\n   476\tAny alternative parameterization would 
violate at least one constraint, ensuring the posterior is proper.\n   477\t\n  
478\t\\paragraph{Estimation workflow.}\n   479\t\\begin{enumerate}\n   480\t  
\\item Fit Layer~1 to obtain posterior draws of $\\eta_{L,c}$ from diagnostic 
data alone\n   481\t  \\item Condition on $\\eta_{L,c}$ samples while fitting 
Layer~2, yielding joint posterior samples of $(\\kappa, \\lambda)$\n   482\t  
\\item Transform samples to $(w_L, q_L)$ and compute posterior summaries\n   
483\t  \\item Validate via posterior predictive checks: does the model generate 
diagnostic and form patterns consistent with observed data?\n   
484\t\\end{enumerate}\n   485\t\n   486\tThis is a multilevel model because 
languages share evolutionary history: the phylogenetic random effect 
$u_{\\text{fam}}$ implements partial pooling by genealogy, preventing spurious 
correlations from areal clustering. The latent comparandum strength 
$\\eta_{L,c}$ is anchored at $\\mathbb{E}[\\eta]=0$ with $\\text{Var}(\\eta)=1$ 
to ensure both location and scale identifiability. The two-layer structure 
formalizes the paper\'s core methodological commitment: Level~I comparanda 
($\\eta$) are diagnosed \\textit{first} from behavioral evidence alone 
(Layer~1), then Level~III realizations ($\\kappa$, $\\lambda$) are estimated 
\\textit{conditional} on that diagnosis (Layer~2). This workflow embodies 
Rule~B: withhold candidate forms when diagnosing semantic targets.\n   487\t\n  
488\tThe same logic extends to other comparative concepts: 
\\textsc{adjectivality}\\textsubscript{\\Cross} (modification, predication, 
gradability, comparison), \\textsc{verbiness}\\textsubscript{\\Cross} 
(predicate-head privileges, tense-aspect-mood morphology, argument structure). 
Each gets its own diagnostic vector and measurement model. Semantic targets are 
tested independently (Section~\\ref{sec:hygiene}) and linked to categories only 
via the observed mappings in the matrix $M_L$ (Rule~B).\n   489\t\n   
490\tNaturalization candidates are evaluated against declared projectibility 
metrics (ROC-AUC for classifiers, macro-F1 for multi-class prediction) with 
thresholds that have to  hold in held-out test data before promotion. Failure to
meet these thresholds triggers explicit failure modes: too thin, too fat, 
negative, or indeterminate. The framework thus builds measurement discipline 
into the theoretical machinery.\n   491\t\n   492\t\\section{A reproducible 
codebook (excerpt)}\\label{sec:codebook}\n   493\tMeasurement discipline 
requires operational codebooks: explicit diagnostics, decision rules, 
reliability checks, and provenance tracking for every comparandum (function, 
target, role) and every category. Below are four illustrative entries showing 
the required structure. A full implementation would provide this level of detail
for every row in the comparanda inventory and every category under evaluation.\n
494\t\n   495\t\n   496\t\\begin{exe}\n   497\t\\ex \\textbf{Comparative 
category: \\textsc{noun}\\textsubscript{\\Cross}.} Diagnostics: argument-head 
privileges; possessive/quantificational interfaces; nominal morphology; 
predication and modification profiles. Record which language-internal categories
realize it and how strongly (e.g., \\textsc{noun}\\textsubscript{Eng}, 
\\textsc{classifier}\\textsubscript{Tha}) and track the evidence supporting each
weight.\n   498\t\\ex \\textbf{Syntactic function: 
\\textsc{determiner}\\textsubscript{\\Cross}.} Diagnostics: dedicated articles 
(definite/indefinite); demonstratives in selectional use (not just deictic); 
classifier/measure structures licensing numeral combination; distribution of 
bare NPs in argument positions (\\textsc{subject}\\textsubscript{\\Cross}, 
\\textsc{object}\\textsubscript{\\Cross}). Code gradient strength 0--3 (absent 
$\\to$ fully grammaticalized). Record specific exponents (morphemes, 
constructions) and genealogical provenance (inherited, innovated, 
contact-induced).\n   499\t\n   500\t\\ex \\textbf{Semantic target: 
\\textsc{definiteness}\\textsubscript{\\Cross}.} Diagnostics: anaphoric uptake 
(can the referent be picked up by pronouns or repeated definites in subsequent 
discourse?); uniqueness and bridging (does the expression trigger \\enquote{only
one} inferences or support part-whole bridging?); anti-novelty contexts (is the 
expression blocked in presentational or existential constructions where the 
referent has to be new?). Code strength of evidence on a gradient scale. Do 
\\emph{not} use presence of articles as a diagnostic criterion~-- that would 
bake in the very conflation we\'re trying to avoid.\n   501\t\n   502\t\\ex 
\\textbf{Discourse role: \\textsc{topic}\\textsubscript{\\Cross}.} Diagnostics: 
sentence-initial position preference; aboutness tests (\\enquote{As for X, 
\\dots}); persistence across discourse spans; compatibility with focus 
operators. Code strength 0--3. Record whether topic is marked morphologically 
(particles, case), positionally (preverbal/post-verbal), or both. Note 
interaction with \\textsc{subject}\\textsubscript{\\Cross} function and 
information structure.\n   503\t\\end{exe}\n   504\t\n   505\tA valid 
implementation requires guarding against researcher degrees of freedom. 
Diagnostics should be preregistered before examining cross-linguistic data; 
post-hoc selection capitalizes on chance. Weight-assignment criteria (when does 
a realization count as 0.5 vs 0.7?) have to  be established via training data 
and inter-rater agreement; thresholds chosen to maximize apparent clustering are
circular. Inter-rater reliability should reach Cohen\'s $\\kappa > 0.7$ on 
comparandum--category mappings, with disagreements resolved via pre-specified 
decision rules rather than negotiation toward desired outcomes. Cross-validation
requires reserving a subset of languages (e.g., 20\\%) for held-out testing; 
patterns that fail to replicate in unseen data indicate overfitting. Finally, 
coding needs to stratify by genealogy, area, and literacy availability 
(Section~\\ref{sec:predictions}); ignoring these risks attributing 
mechanism-driven patterns to spurious correlates. These precautions sketch an 
implementation blueprint: the present paper confines itself to the theoretical 
scaffolding while pointing to the statistical toolkit future empirical work 
needs to mobilize. The apparatus is designed for iterative refinement: initial 
codings reveal where diagnostics fail, prompting revision of the comparative 
concept or recognition that it lacks naturalized status. The specific metrics 
and models mentioned (Cohen\'s $\\kappa$, factor analysis, IRT) are illustrative
examples that operationalize the constraints, not mandatory choices; alternative
methods meeting the same standards are equally admissible.\n   506\t\n   
507\t\\subsection{Implementation realities for empirical 
collaborators}\\label{subsec:implementation}\n   508\t\n   509\tSince this is a 
theoretical paper, I note these as collaboration prerequisites:\n   510\t\n   
511\t\\paragraph{Coding burden} Populating $M_L$ for even 50 languages with 
required reliability is a multi-year, multi-researcher project. The "LLMs as 
research assistants" footnote is realistic, but requires explicit prompt 
engineering, validation pipelines, and error propagation protocols.\n   512\t\n 
513\t\\paragraph{Diagnostic design} Definiteness diagnostics (anaphoric uptake, 
bridging) require controlled discourse contexts that don\'t exist for most 
languages. Adaptation to elicited narratives or corpus-mining heuristics is 
necessary, with validation against expert judgments.\n   514\t\n',
        message='100 lines read from file starting from line 415.',
        brief=''
    )
)
StepBegin(n=6)
<kimi_cli.wire.message.StepInterrupted object at 0x10d0ef620>
LLM provider error: Error code: 429 - {'error': {'message': 'Your account 
org-eb81a0a554e848f2bce8d46e805edc1a<ak-f68xj7gadmh111g8obji> request reached 
organization max RPM: 3, please try again after 1 seconds', 'type': 
'rate_limit_reached_error'}}
