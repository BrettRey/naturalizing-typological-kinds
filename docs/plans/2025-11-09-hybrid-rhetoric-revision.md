# Hybrid Rhetoric Revision Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Enhance paper's rhetorical effectiveness by combining Phil-Ling's sentence-level clarity improvements with strategic structural reordering and metaphor elevation.

**Architecture:** Three-phase approach: (1) Quick wins - metaphor and sentence fixes that don't require reordering, (2) Structural surgery - section reordering and content migration, (3) Elevation - strengthen opening/closing and integrate master metaphor throughout.

**Tech Stack:** LaTeX, LuaLaTeX compiler, Charis SIL font

---

## Phase 1: Quick Wins (Sentence-Level & Metaphor Fixes)

### Task 1: Replace "hygiene" metaphor with "firewall"

**Files:**
- Modify: `main.tex:61` (abstract)
- Modify: `main.tex:232` (section heading)
- Modify: `main.tex:244` (protocol explanation)

**Step 1: Read current abstract line 61**

Run: `Read main.tex offset=60 limit=5`
Verify: Contains "syntax–semantics hygiene protocol"

**Step 2: Replace in abstract**

```latex
% Before:
a syntax–semantics hygiene protocol diagnoses targets independently

% After:
a syntax–semantics firewall separates diagnostic evidence from morphosyntactic form
```

**Step 3: Update section heading (line 232)**

```latex
% Before:
\subsection{Why independence is non-negotiable}\label{subsec:independence-why}

% After:
\subsection{Why the firewall is non-negotiable}\label{subsec:independence-why}
```

**Step 4: Update protocol explanation (line 244)**

```latex
% Before:
The hygiene protocol enforces independence by design.

% After:
The firewall enforces independence by design.
```

**Step 5: Global search and replace**

Run: `grep -n "hygiene" main.tex`
Replace all remaining instances with "firewall"

**Step 6: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation, 31 pages

**Step 7: Commit**

```bash
git add main.tex
git commit -m "refactor: replace 'hygiene' with 'firewall' metaphor for clarity"
```

---

### Task 2: Improve abstract opening (lines 58-59)

**Files:**
- Modify: `main.tex:58-59`

**Step 1: Read current abstract**

Verify current text:
```latex
Typological universals often dissolve because analysts collapse language-internal categories with the cross-linguistic comparanda they are meant to instantiate.
```

**Step 2: Rewrite for impact**

```latex
% Before:
Typological universals often dissolve because analysts collapse language-internal categories with the cross-linguistic comparanda they are meant to instantiate.

% After:
Why do typological universals keep dissolving? Because we measure the wrong things. We count articles and call it definiteness. We track nominative case and call it subjecthood. We confuse what we compare with how languages realize it, and the universals evaporate.
```

**Step 3: Verify length**

Abstract should remain under 250 words total

**Step 4: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation

**Step 5: Commit**

```bash
git add main.tex
git commit -m "enhance: rewrite abstract opening for immediate impact"
```

---

### Task 3: Simplify formal definition (lines 147-153)

**Files:**
- Modify: `main.tex:147-153`

**Step 1: Read current passage**

Verify contains nested parentheses and 78-word sentence

**Step 2: Rewrite with active voice and shorter sentences**

```latex
% Before:
Formally: let $\mathcal{C}$ denote the union of Level~I and Level-II comparanda (comparative functions, comparative categories, semantic targets, and discourse roles). $\mathcal{C}$ is a \textbf{working hypothesis}---a provisional inventory subject to revision as empirical coverage expands. For every language $L$ we define a mapping...

% After:
We start with a working hypothesis: an inventory $\mathcal{C}$ of Level-I and Level-II comparanda (functions, categories, semantic targets, discourse roles). This inventory is provisional---it grows as we study more languages. For each language $L$, we then define a mapping...
```

**Step 3: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation

**Step 4: Commit**

```bash
git add main.tex
git commit -m "refactor: simplify formal definition with active voice"
```

---

### Task 4: Add plain-English gloss for naturalization (lines 385-387)

**Files:**
- Modify: `main.tex:385-387`

**Step 1: Read current passage**

Verify contains "weak homeostatic property cluster (HPC) kinds" without gloss

**Step 2: Rewrite with concrete analogy first**

```latex
% Before:
I propose treating such concepts as \emph{naturalized comparative concepts}---weak homeostatic property cluster (HPC) kinds operating at the cross-linguistic level (recall Section~\ref{sec:orientation}).

% After:
Some comparative concepts earn \emph{naturalized} status: they behave like stable scientific kinds because independent mechanisms converge to maintain them. Think of them as cross-linguistic habits that keep recurring, not as universal essences. Formally, they're weak homeostatic property cluster (HPC) kinds operating at the cross-linguistic level.
```

**Step 3: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation

**Step 4: Commit**

```bash
git add main.tex
git commit -m "enhance: add concrete gloss before HPC jargon"
```

---

### Task 5: Soften "solution rests on three pillars" (line 732)

**Files:**
- Modify: `main.tex:732`

**Step 1: Read current passage**

Verify contains "The solution rests on three pillars"

**Step 2: Rewrite to invite alternatives**

```latex
% Before:
The solution rests on three pillars

% After:
The framework builds on three commitments
```

**Step 3: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation

**Step 4: Commit**

```bash
git add main.tex
git commit -m "refactor: soften closure in conclusion"
```

---

### Task 6: Strengthen key sentences for memorability

**Files:**
- Modify: `main.tex:101-102` (Section 2 opening)
- Modify: `main.tex:104-105` (Dual-use terminology)
- Modify: `main.tex:234-236` (Why firewall matters)

**Step 1: Section 2 opening (lines 101-102)**

```latex
% Before:
Systematic errors in published typological research trace to a single source: conflating comparanda (categories_Cross, functions_Cross, targets_Cross, roles_Cross) with language-internal categories_L and L-functions, or meanings with forms.

% After:
Typology's systematic errors share a single source: we conflate what we compare with how languages realize it. Meanings become forms. Functions become categories. Measurement dissolves.
```

**Step 2: Dual-use terminology (lines 104-105)**

```latex
% Before:
\emph{Dual-use terminology and category–function conflation} (obstacle a) arises when the same label is pressed into service for different ontological levels, encouraging analysts (or readers) to treat unlike phenomena as identical.

% After:
\emph{Dual-use terminology} is typology's original sin. When 'determiner' names both a function and a category, we stop distinguishing them. Confusion becomes invisible.
```

**Step 3: Why firewall matters (lines 234-236)**

```latex
% Before:
Rule~B (\textbf{No meaning-as-form identity}) isn't merely a coding convenience~-- it's theoretically essential. Without it, typology commits a category error: treating a semantic target as if it were a morphological exponent.

% After:
Rule B is not a convenience. It is a necessity. Conflate meanings with forms, and comparison becomes impossible. You measure articles, not definiteness. Case morphology, not agentivity. The exponent, not the target.
```

**Step 4: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation

**Step 5: Commit**

```bash
git add main.tex
git commit -m "enhance: add aphoristic compression to key claims"
```

---

## Phase 2: Structural Surgery

### Task 7: Create backup and new branch

**Files:**
- Create: `main-original.tex` (backup)

**Step 1: Create backup**

```bash
cp main.tex main-original.tex
```

**Step 2: Create git branch**

```bash
git checkout -b rhetoric-reordering
```

**Step 3: Commit backup**

```bash
git add main-original.tex
git commit -m "backup: preserve original structure before reordering"
```

---

### Task 8: Expand Section 2.2 (Concrete illustrations)

**Files:**
- Modify: `main.tex:123-139` (expand from 4 to 6 examples)

**Step 1: Read current Section 2.2**

Verify currently has 4 examples (definiteness, adjectives, proper names, agentivity)

**Step 2: Add two more vivid examples**

Insert after line 139:

```latex
\ex\label{ex:animacy-conflation} \textbf{Animacy (obstacle b: cluster reduction)}
WALS 47A codes languages as "having animacy distinctions" if pronouns or agreement mark animate vs. inanimate. But ANIMACY_Cross is a semantic dimension with diagnostics: does the referent exhibit agency? Can it serve as possessor? The conflation: treating a pronoun paradigm (ANIMACY_Eng) as if it were the semantic target (ANIMACY_Cross). Result: languages with covert animacy effects (Spanish *se*, Mandarin classifiers) are coded as lacking the distinction.

\ex\label{ex:topic-conflation} \textbf{Topic (obstacle d: false universalization)}
Many accounts treat sentence-initial position + definite article as diagnostic for TOPIC_Cross. This works for Germanic and Romance. But Japanese marks topics with \emph{wa}, often sentence-medial. Mandarin allows topic-comment structures without articles. Salish allows predicate-initial topics. The false universal: "topics are sentence-initial NPs." The correction: TOPIC_Cross is a discourse role diagnosed independently of position or marking.
```

**Step 3: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation, Section 2.2 now ~2 pages

**Step 4: Commit**

```bash
git add main.tex
git commit -m "expand: add animacy and topic examples to Section 2.2"
```

---

### Task 9: Create new Section 1 from expanded Section 2

**Files:**
- Modify: `main.tex` (major reordering)

**Step 1: Save current Section 1 (Orientation) as temp**

Lines 66-98 become new Section 2

**Step 2: Move expanded Section 2 to become new Section 1**

```latex
\section{Where typology goes wrong}\label{sec:failures}

[Current Section 2 content - obstacles and 6 concrete illustrations]
```

**Step 3: Retitle old Section 1 as Section 2**

```latex
\section{A three-level solution}\label{sec:orientation}

[Current Table 1 and three-level explanation]
```

**Step 4: Update all section references**

Use search-replace:
- `Section~\ref{sec:orientation}` in early text → update to `Section~\ref{sec:failures}` where discussing problems
- Keep references pointing to three-level framework as `Section~\ref{sec:orientation}`

**Step 5: Compile and verify all cross-references**

Run: `lualatex -interaction=nonstopmode main.tex`
Run: `lualatex -interaction=nonstopmode main.tex` (second pass for refs)
Expected: All references resolve correctly

**Step 6: Commit**

```bash
git add main.tex
git commit -m "refactor: move failure diagnosis to Section 1, orientation to Section 2"
```

---

### Task 10: Move measurement model details to appendix

**Files:**
- Modify: `main.tex:506-579` (compress to 3 paragraphs)
- Create: `appendix-measurement.tex`

**Step 1: Extract full technical specification**

Create `appendix-measurement.tex` with lines 506-579:

```latex
\section{Formal Measurement Model}\label{appendix:measurement}

\subsection{Two-Layer Hierarchical Model}

[Full technical content from lines 506-579]

\subsection{Stan Implementation}

[Current Stan code if present]
```

**Step 2: Replace main text with intuitive summary**

Replace lines 506-579 with:

```latex
\subsection{Deriving the measurement model from ontological commitments}\label{subsec:measurement-derivation}

The measurement structure follows directly from the three-level ontology rather than being asserted post-hoc.

**The problem:** Traditional typology uses binary tallies (language X *has* adjectives or doesn't). We need graded measurements that respect partial membership and gradient strength.

**The solution:** Separate diagnostic evidence (behavioral tests) from realization evidence (morphosyntactic forms) using a two-layer hierarchical model. Layer 1 models how behavioral diagnostics reveal latent comparandum strength $\eta_{L,c}$ without reference to forms. Layer 2 models how that latent strength causes observable forms to appear, yielding weight estimates $w_L(c,\phi)$ with uncertainty.

**The payoff:** This prevents circularity (diagnostics never condition on forms) and quantifies how strongly a language instantiates a comparandum. Figure~\ref{fig:dag} visualizes the causal structure. The full formal specification appears in Appendix~\ref{appendix:measurement}.

[Keep Figure 1 DAG here]
```

**Step 3: Add appendix to document**

At end of main.tex before `\end{document}`:

```latex
\appendix
\input{appendix-measurement}
```

**Step 4: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation, main text ~3-4 pages shorter

**Step 5: Commit**

```bash
git add main.tex appendix-measurement.tex
git commit -m "refactor: move measurement model details to appendix"
```

---

### Task 11: Create "Anticipated Objections" section

**Files:**
- Modify: `main.tex` (insert new section after Section 2)

**Step 1: Identify insertion point**

After Section 2 (three-level solution), before Section 3 (matrix)

**Step 2: Extract 5 objections from current Section 11**

Create new section:

```latex
\section{Anticipated objections}\label{sec:objections}

Skeptics will raise five immediate concerns. We address them now before presenting the apparatus, so readers can evaluate the framework without lingering doubts.

\subsection{Isn't this just universals with extra steps?}

No. Naturalization differs from universalism in four ways: it's gradient (strong/weak/contested), empirically defeasible (demotion criteria exist), mechanistically explained (not stipulated), and allows family-specific variation. See Section~\ref{subsec:essence} for detailed contrast.

\subsection{How can we operationalize this without drowning in complexity?}

The apparatus is complex, but so is the phenomenon. We provide: (1) executable codebook (Section~\ref{sec:codebook}), (2) decision flowcharts (Figure~\ref{fig:workflow}), (3) worked examples (Section~\ref{sec:illustrations}), (4) reliability thresholds (Cohen's $\kappa > 0.7$). Complexity is managed, not eliminated.

\subsection{What about languages like Salish with flexible word classes?}

The framework handles this gracefully. Boundary crispness is itself a measurable property: Salish would show low inter-category distinctiveness in the $M_L$ matrix (categories_Sal would have overlapping weight profiles). This isn't a bug—it's data. See Section~\ref{subsec:independence-worry} for full treatment.

\subsection{Doesn't the firewall create circularity?}

No. The two-layer model (Section~\ref{subsec:measurement-derivation}) ensures diagnostics (Layer 1) never condition on forms (Layer 2). Independence is enforced structurally via the DAG (Figure~\ref{fig:dag}): $(F \perp d \mid \eta)$. This is the opposite of circular.

\subsection{Is this empirically tractable?}

Yes, but demanding. Section~\ref{subsec:implementation} acknowledges: multi-year effort, inter-rater training, phylogenetic sampling, LLM-assisted coding with validation. The theory provides the target; implementation requires coordinated empirical effort. Tractable doesn't mean easy.
```

**Step 3: Remove redundant content from Section 11**

Keep only substantive philosophical replies (essence worry, independence worry). Remove objections now covered in Section 3.

**Step 4: Update cross-references**

Ensure forward references to Section 3 work correctly

**Step 5: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation

**Step 6: Commit**

```bash
git add main.tex
git commit -m "add: anticipated objections section after three-level framework"
```

---

## Phase 3: Elevation (Master Metaphor & Framing)

### Task 12: Introduce eye analogy in abstract

**Files:**
- Modify: `main.tex:58-64` (abstract)

**Step 1: Add eye analogy sentence to abstract**

Insert before final sentence:

```latex
Just as camera eyes evolved independently in vertebrates and cephalopods through convergent mechanisms, noun-like categories arise independently across languages through recurrent discourse pressures.
```

**Step 2: Verify abstract length**

Total should remain under 250 words

**Step 3: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation

**Step 4: Commit**

```bash
git add main.tex
git commit -m "enhance: introduce octopus eye analogy in abstract"
```

---

### Task 13: Rename "Interlude" to integrate eye analogy

**Files:**
- Modify: `main.tex:447` (section heading)

**Step 1: Change section title**

```latex
% Before:
\section{Interlude: what eyes buy us}\label{sec:eyes}

% After:
\section{Convergent mechanisms: the octopus eye model}\label{sec:eyes}
```

**Step 2: Add reprise references in key sections**

After line 432 (end of mechanisms catalog):

```latex
This is convergent evolution at work—the octopus eye principle applied to grammar. Independent lineages recruit similar solutions because functional demands remain stable.
```

After line 563 (naturalization evaluation):

```latex
Just as vertebrate and cephalopod eyes share structure without shared ancestry, naturalized categories show cross-linguistic stability without Universal Grammar.
```

**Step 3: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation

**Step 4: Commit**

```bash
git add main.tex
git commit -m "integrate: weave eye analogy throughout argument"
```

---

### Task 14: Add concrete example to Table 1

**Files:**
- Modify: `main.tex:78-90` (Table 1)

**Step 1: Add fourth column to table**

```latex
\begin{table}[t]
\centering
\begin{tabular}{llll}
\toprule
\textbf{Level} & \textbf{Contents} & \textbf{Diagnostic focus} & \textbf{Example (English + Japanese)} \\
\midrule
Level-I: & Semantic targets & Behavioural diagnostics & \textsc{definiteness}\textsubscript{\Cross}: tested via anaphora \\
cross-linguistic & (\textsc{definiteness}\textsubscript{\Cross}, & (anaphora, scope, & (Eng: \emph{the cat… it}; \\
comparanda & \textsc{specificity}\textsubscript{\Cross}, \textsc{role}\textsubscript{\Cross}) & continuity) & Jpn: \emph{sono neko… sore}) \\
\addlinespace
Level-II: & Syntactic functions & Portable diagnostics & \textsc{subject}\textsubscript{\Cross}: tested via extraction \\
cross-linguistic & (\textsc{subject}\textsubscript{\Cross}, \textsc{object}\textsubscript{\Cross}, & (alignment, extraction, & (Eng: \emph{What did she buy?}; \\
comparanda & \textsc{determiner}\textsubscript{\Cross}) & control, binding) & Jpn: \emph{Nani-o katta?}) \\
\addlinespace
Level-III: & Language-internal functions & L-specific evidence & \textsc{subject}\textsubscript{Eng}: nominative NP \\
language- & (\textsc{subject}\textsubscript{Eng}, \textsc{verb}\textsubscript{Jpn}, \textsc{determiner}\textsubscript{Tha}) & (morphology, distribution, & controlling agreement; \\
specific & and categories (\textsc{V}\textsubscript{Eng}, \textsc{NP}\textsubscript{Jpn}, etc.) & paradigms) & \textsc{subject}\textsubscript{Jpn}: \emph{ga}-marked NP \\
\bottomrule
\end{tabular}
\caption{Three-level ontological separation with concrete examples}
\label{tab:levels}
\end{table}
```

**Step 2: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation, table fits on one page

**Step 3: Commit**

```bash
git add main.tex
git commit -m "enhance: add concrete examples column to Table 1"
```

---

### Task 15: Rewrite conclusion for elevation

**Files:**
- Modify: `main.tex:731-736` (conclusion)

**Step 1: Read current conclusion**

Verify it's currently a summary

**Step 2: Rewrite to mobilize**

```latex
\section{Conclusion}\label{sec:conclusion}

If typology continues conflating comparanda with realizations, we will keep rediscovering the grammar of English disguised as universal principles. The conflation isn't innocent—it generates spurious universals, masks functional persistence, and mischaracterizes variation.

The framework builds on three commitments: comparanda discipline (explicit mappings $M_L(c,\phi)$ separating cross-linguistic functions from language-internal categories), diagnostic independence (testing meanings via behavioral evidence before examining morphosyntactic forms), and measurement accountability (latent variable models with declared thresholds, making naturalization empirically defeasible).

The question is not whether this framework is convenient—it isn't. The question is whether we are willing to measure what we claim to compare. Octopuses and humans share camera eyes not because evolution mandates them, but because light detection requires convergent solutions. Typology's task is to identify which linguistic categories reflect similar convergence—and which are merely inherited descriptive templates.

\subsection{Three pilot studies}

The framework is empirically tractable. Three studies can test its core predictions within 18 months:

\begin{enumerate}
\item \textbf{Regeneration pathways (12 languages, 6 families):} Test whether languages with robust classifier systems favor demonstrative→article pathways while languages with strong possessive morphology favor genitive→article pathways. Success criterion: macro-F1 $\geq 0.75$ on held-out families.

\item \textbf{Mechanism competition (oral vs. literate traditions, 30 languages):} Test whether oral traditions show faster regeneration but faster erosion compared to literate traditions. Success criterion: hazard ratio $>2.0$ for regeneration, $<0.5$ for erosion.

\item \textbf{Adjective naturalization test (50 languages, 10 families):} Code \textsc{modifier}\textsubscript{\Cross} realizations and test projectibility. Success criterion: ROC-AUC $\geq 0.70$ on held-out families, or explicit demotion to "too thin" status with documented failure mode.
\end{enumerate}

These pilots require coordination: fieldworkers for diagnostic protocols, corpus linguists for historical pathways, statisticians for hierarchical models. The theory provides the target. Implementation requires sustained collaboration.

Typology stands at a choice point. Continue conflating levels, and universals will keep dissolving. Separate comparanda from realizations, enforce diagnostic independence, and demand measurement accountability—and we transform typology from a label-based enterprise into a measurement science.
```

**Step 3: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation

**Step 4: Commit**

```bash
git add main.tex
git commit -m "enhance: rewrite conclusion to elevate and mobilize"
```

---

### Task 16: Add forward-pointing roadmap sentence

**Files:**
- Modify: `main.tex:96-98` (end of orientation)

**Step 1: Read current roadmap**

Verify ends with dutiful outline

**Step 2: Add challenge after roadmap**

```latex
The paper proceeds as follows. Section~\ref{sec:failures} diagnoses four recurrent conflation errors... [existing roadmap text]

The framework issues a challenge: specify your comparanda, test them independently, and declare your thresholds—or admit you are measuring labels, not categories.
```

**Step 3: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation

**Step 4: Commit**

```bash
git add main.tex
git commit -m "enhance: add gauntlet-throwing sentence after roadmap"
```

---

### Task 17: Create visual workflow diagram

**Files:**
- Create: `figures/firewall-workflow.tex`
- Modify: `main.tex:246` (insert figure reference)

**Step 1: Create TikZ diagram**

Create `figures/firewall-workflow.tex`:

```latex
\begin{figure}[t]
\centering
\begin{tikzpicture}[
  node distance=1.5cm,
  box/.style={rectangle, draw=black, thick, minimum width=4cm, minimum height=1cm, align=center},
  arrow/.style={->, thick}
]

\node[box] (step1) {1. Establish diagnostic traction};
\node[box, below of=step1] (step2) {2. Apply diagnostics\\(withhold forms)};
\node[box, below of=step2] (step3) {3. Identify candidate realizations};
\node[box, below of=step3] (step4) {4. Score mappings\\(sensitivity × precision)};
\node[box, below of=step4] (step5) {5. Record provenance \& reliability};

\draw[arrow] (step1) -- (step2);
\draw[arrow] (step2) -- (step3);
\draw[arrow] (step3) -- (step4);
\draw[arrow] (step4) -- (step5);

% Firewall annotation
\draw[dashed, red, thick] ([xshift=-2.5cm]step2.west) -- ([xshift=2.5cm]step2.east);
\draw[dashed, red, thick] ([xshift=-2.5cm]step3.west) -- ([xshift=2.5cm]step3.east);
\node[right=0.5cm of step2.east, text=red] {FIREWALL};
\node[right=0.5cm of step3.east, text=red] {FIREWALL};

\end{tikzpicture}
\caption{Anti-circularity workflow: diagnose the target (steps 1-2) before examining forms (steps 3-5). The firewall between steps 2 and 3 enforces independence.}
\label{fig:workflow}
\end{figure}
```

**Step 2: Reference in main text**

After line 246:

```latex
For each Level~I comparandum $c$ (semantic target or discourse role) and each language $L$, follow this five-step protocol that enforces independence of diagnostics from morphosyntactic form (Figure~\ref{fig:workflow}):
```

**Step 3: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation, figure appears

**Step 4: Commit**

```bash
git add figures/firewall-workflow.tex main.tex
git commit -m "add: visual workflow diagram for firewall protocol"
```

---

### Task 18: Convert naturalization criteria to checklist

**Files:**
- Modify: `main.tex:421-436` (Section 5.2)

**Step 1: Read current paragraph format**

Verify three criteria in prose

**Step 2: Convert to actionable checklist**

```latex
\subsection{Criteria for naturalization}\label{subsec:naturalization-criteria}
Not all comparative concepts qualify for naturalized status. The bar should be high—we want to avoid reinstating the spurious universals we're trying to eliminate.

\textbf{Naturalization checklist:} A comparative concept earns promotion when:
\begin{itemize}[label=$\Box$]
\item \textbf{Cross-linguistic clustering:} Diagnostics cluster reliably across $\geq 3$ genealogically independent families (e.g., Indo-European + Niger-Congo + Sino-Tibetan)
\item \textbf{Identifiable mechanisms:} Cognitive, diachronic, or discourse pressures are specified with concrete evidence (grammaticalization pathways, acquisition trajectories, discourse-functional asymmetries)
\item \textbf{Predictive purchase:} Mechanisms generate falsifiable predictions about erosion, regeneration, or trade-offs that can be tested on held-out data
\end{itemize}

\textbf{Failure triggers reassessment:}
\begin{itemize}[label=$\times$]
\item Diagnostics systematically fail in well-described non-European languages $\to$ \textbf{too thin}
\item Stability traces to shared descriptive templates, not convergent evolution $\to$ \textbf{genealogical artifact}
\item No plausible mechanisms despite searching $\to$ \textbf{indeterminate}
\end{itemize}

Reassessment becomes necessary when new evidence challenges previously naturalized status: broader sampling reveals the pattern was genealogically/areally restricted; proposed mechanisms prove inadequate; or predictions fail in held-out data. In such cases, we revise the classification: downgrade from naturalized to instrumental comparative concept, restrict naturalization claims to specific families/areas, or tag with failure modes.
```

**Step 3: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation, checklists render correctly

**Step 4: Commit**

```bash
git add main.tex
git commit -m "enhance: convert naturalization criteria to actionable checklist"
```

---

### Task 19: Final compilation and verification

**Files:**
- Verify: `main.tex`
- Verify: `appendix-measurement.tex`
- Verify: `figures/firewall-workflow.tex`

**Step 1: Full clean compilation**

```bash
rm -f main.aux main.bbl main.bcf main.blg main.log main.out main.run.xml
lualatex -interaction=nonstopmode main.tex
biber main
lualatex -interaction=nonstopmode main.tex
lualatex -interaction=nonstopmode main.tex
```

**Step 2: Verify page count**

Expected: 30-32 pages (compressed from measurement model move)

**Step 3: Verify all references resolve**

Check for "??" in PDF output
Expected: No undefined references

**Step 4: Verify figures compile**

Check Figure 1 (DAG) and Figure 2 (workflow) appear correctly
Expected: Both figures render without errors

**Step 5: Create comparison PDF**

```bash
cp main.pdf main-revised.pdf
cp main-original.tex main-temp.tex
mv main-temp.tex main.tex
lualatex -interaction=nonstopmode main.tex
cp main.pdf main-before.pdf
git checkout main.tex
```

**Step 6: Final commit**

```bash
git add -A
git commit -m "feat: complete hybrid rhetoric revision

- Phase 1: Sentence-level clarity (firewall metaphor, active voice, aphoristic compression)
- Phase 2: Structural reordering (failures first, measurement to appendix, objections early)
- Phase 3: Elevation (eye analogy throughout, mobilizing conclusion, visual workflows)

Result: Paper maintains rigor while improving accessibility and persuasive force."
```

---

## Testing & Validation

### Validation 1: Readability Check

**Step 1: Check abstract**

Verify abstract:
- Opens with vivid problem statement
- Contains eye analogy
- Under 250 words

**Step 2: Check section flow**

Verify:
- Section 1 diagnoses problems (6 concrete examples)
- Section 2 presents three-level solution
- Section 3 addresses objections
- Sections 4-10 build apparatus
- Section 11 elevates and mobilizes

**Step 3: Check metaphor consistency**

Search for "hygiene" - should be zero results
Search for "firewall" - should appear consistently

---

### Validation 2: Technical Integrity

**Step 1: Verify all math notation intact**

Check key equations:
- Weight function definition (Section 3.1)
- Two-layer model (Appendix A)
- Failure mode definitions (Section 5.1)

**Step 2: Verify all cross-references**

Run: `grep "ref{" main.tex | wc -l`
All refs should resolve in PDF

**Step 3: Verify bibliography**

Run: `grep "cite" main.tex | wc -l`
All citations should appear in references

---

### Validation 3: Rhetoric Quality

**Step 1: Read abstract aloud**

Does it hook the reader immediately?
Expected: Yes - problem statement stings

**Step 2: Read Section 1 aloud**

Do the 6 examples feel vivid and recognizable?
Expected: Yes - typologists have seen these errors

**Step 3: Read conclusion aloud**

Does it elevate and mobilize?
Expected: Yes - ends with challenge and pilot studies

---

## Plan Complete

**Total estimated time:** 6-8 hours
- Phase 1 (Quick wins): 2 hours
- Phase 2 (Structural surgery): 3-4 hours
- Phase 3 (Elevation): 2 hours
- Testing: 30 minutes

**Key files modified:**
- `main.tex` (major revisions throughout)
- `appendix-measurement.tex` (created)
- `figures/firewall-workflow.tex` (created)
- `main-original.tex` (backup)

**Git commits:** 19 atomic commits with clear messages

**Compilation:** Clean compile expected throughout, ~30-32 pages final

---

**Plan saved to:** `docs/plans/2025-11-09-hybrid-rhetoric-revision.md`
