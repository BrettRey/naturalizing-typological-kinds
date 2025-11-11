# Naturalization Reframe Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Reframe Section 1 to present obstacles that ONLY naturalization overcomes (not Haspelmath's already-solved problems), making naturalization unmistakably the main contribution while mapping/firewall are positioned as tools.

**Architecture:** Complete rewrite of Section 1 abstract and opening. Current version inadvertently claims credit for Haspelmath's comparative-concept solutions. New version: (1) acknowledge Haspelmath solved conflation, (2) identify four obstacles that instrumentalism leaves unanswered, (3) position naturalization as providing mechanistic answers with falsifiable predictions.

**Tech Stack:** LaTeX, LuaLaTeX compiler, Charis SIL font, biblatex/biber

---

## Phase 1: Abstract Rewrite

### Task 1: Rewrite abstract to acknowledge Haspelmath's foundation

**Files:**
- Modify: `main.tex:59-64`

**Step 1: Read current abstract**

Run: `Read main.tex offset=59 limit=10`
Verify: Current abstract presents comparative concepts as our solution

**Step 2: Rewrite paragraph 1 to acknowledge Haspelmath**

Replace lines 59-60 with:

```latex
\begin{abstract}
Haspelmath's comparative concepts solved typology's conflation problem: by treating cross-linguistic categories as analyst-defined tools rather than universal entities, we can compare languages without projecting English grammar onto purportedly universal structures. We count articles without claiming they define definiteness. We track nominative case without assuming it defines subjecthood. Comparative concepts are methodological progress—they separate what we compare from how languages realize it.

But instrumentalism leaves deeper questions unanswered: which comparative concepts, if any, reflect convergent mechanisms rather than inherited descriptive templates? Why do some patterns (definiteness, nominality) recur across unrelated languages while others (adjectives) dissolve? How do we distinguish real cross-linguistic stability from genealogical artifacts? When should we stop using a concept?
```

**Step 3: Rewrite paragraph 2 to position naturalization as answering these questions**

Replace lines 62-63 with:

```latex
Some comparative concepts earn \emph{naturalized} status as homeostatic property cluster kinds—stable not because they are universal, but because independent mechanisms converge to maintain them. Just as camera eyes evolved independently in vertebrates and cephalopods through convergent solutions to light detection, nominality and definiteness recur through convergent discourse and morphosyntactic pressures. This turns comparative concepts from descriptive conveniences into testable hypotheses about linguistic evolution: we can specify mechanisms, derive falsifiable predictions about regeneration and erosion, and establish empirical criteria for when a concept should be demoted.
```

**Step 4: Keep paragraph 3 but emphasize tools-for-naturalization**

Replace line 64 with:

```latex
Naturalization requires three disciplined tools: explicit mapping functions that separate cross-linguistic comparanda from language-specific realizations, a syntax-semantics firewall that tests semantic targets independently of morphosyntactic forms, and measurement models with declared empirical thresholds for promotion and demotion. The framework is formalized in an auditable specification (\texttt{src/typology.py}) and issues risk-bearing predictions about diachronic pathways, functional trade-offs, and latent-variable diagnostics. By demanding mechanisms as well as mappings, the account preserves typology's empirical ambition while avoiding both universalist overreach and instrumental agnosticism.
```

**Step 5: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation

**Step 6: Commit**

```bash
git add main.tex
git commit -m "refactor(abstract): reframe to acknowledge Haspelmath foundation, foreground naturalization questions"
```

---

## Phase 2: Section 1 Rewrite

### Task 2: Rewrite Section 1 opening to position naturalization correctly

**Files:**
- Modify: `main.tex:67-72`

**Step 1: Read current Section 1**

Run: `Read main.tex offset=67 limit=50`
Verify: Current text presents comparative concepts as our contribution

**Step 2: Rewrite opening paragraphs**

Replace lines 67-72 with:

```latex
\section{Which comparative concepts are natural kinds?}\label{sec:naturalization-question}

Haspelmath's \parencite{Haspelmath2010,Haspelmath2025} comparative-concept programme solved typology's conflation problem. By treating cross-linguistic categories as analyst-constructed tools for comparison rather than universal entities projected from language-specific structures, the framework eliminates the confusion of measuring English articles and calling it universal definiteness, or tracking nominative case and calling it universal subjecthood. Comparative concepts separate what we compare (functions, targets, roles) from how languages realize them (categories, constructions, morphemes). This is genuine methodological progress.

But the solution is instrumentalist: all comparative concepts are treated as equally conventional, equally tool-like, equally without ontological commitment. This leaves four questions unanswered—questions that \emph{naturalization} specifically addresses. If some comparative concepts recur across unrelated languages through convergent mechanisms while others reflect inherited descriptive templates, we need criteria to distinguish them. If some patterns show stability through diachronic change while others dissolve, we need mechanistic explanations. If typology aims for empirical science rather than descriptive cataloguing, we need falsifiable predictions and demotion criteria.

The following four obstacles persist because instrumentalism provides no mechanism for asking when comparative concepts deserve promotion from descriptive tools to naturalized kinds.
```

**Step 3: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation

**Step 4: Commit**

```bash
git add main.tex
git commit -m "refactor(sec1): reframe opening to acknowledge Haspelmath, position naturalization as answering unanswered questions"
```

---

### Task 3: Rewrite four obstacles to focus on naturalization-specific problems

**Files:**
- Modify: `main.tex:74-79` (current obstacle descriptions)

**Step 1: Compress current obstacles section**

Replace lines 74-109 (entire subsection 1.1 and 1.2) with:

```latex
\subsection{Four questions instrumentalism leaves unanswered}\label{subsec:naturalization-obstacles}

\textbf{Obstacle 1: The stability question.} Comparative concepts allow comparison—but which ones reflect convergent mechanisms versus inherited templates? \textsc{definiteness}\textsubscript{\Cross} recurs in articleless languages via demonstratives, possessive frames, and classifier complexes; \textsc{nominality}\textsubscript{\Cross} emerges independently across unrelated families through similar argument-structure privileges. But \textsc{adjective}\textsubscript{\Cross} dissolves: languages realize property-concept modification via stative verbs, relative clauses, or nominal strategies with no dedicated class. Instrumentalism treats all three concepts as equally conventional. Naturalization asks: do definiteness and nominality show convergent stability because independent mechanisms maintain them, while adjective reflects descriptive convenience? Without mechanistic criteria, we cannot tell.

\textbf{Obstacle 2: The explanation gap.} Why do some patterns recur while others dissolve? Instrumentalism describes the variation but does not explain it. \textsc{subject}\textsubscript{\Cross} persists across nominative-accusative, ergative-absolutive, and Philippine-type alignment systems via extraction privileges, reflexive binding, and control—suggesting convergent functional pressures maintain the category despite diverse morphosyntactic realizations. \textsc{topic}\textsubscript{\Cross} recurs through sentence-initial position (Germanic), \emph{wa}-marking (Japanese), zero anaphora (pro-drop languages), and intonational prominence (Mandarin)—suggesting discourse continuity mechanisms stabilize the role across realization strategies. But without specifying \emph{which} cognitive, diachronic, or discourse mechanisms cause the stability, we have description without explanation. Naturalization provides mechanistic accounts: learnability bootstrapping, grammaticalization pathways, discourse-functional asymmetries.

\textbf{Obstacle 3: The testability problem.} How do we distinguish real cross-linguistic patterns from descriptive artifacts inherited from familiar languages? Instrumentalism provides no falsifiable predictions, no empirical thresholds, no criteria for when clustering is "good enough." DOM (differential object marking) correlates with specificity, animacy, definiteness, and topicality—but the correlation weakens as sampling expands beyond Indo-European and Turkic. Is this a naturalized pattern showing family-specific modulation, or a genealogical artifact mistaken for a universal? Without declared projectibility thresholds (e.g., ROC-AUC ≥ 0.70 on held-out families) and explicit demotion criteria, we cannot tell. Naturalization makes the question empirically defeasible: specify mechanisms, derive predictions, test on held-out data, demote if thresholds fail.

\textbf{Obstacle 4: The demotion problem.} When should we stop using a comparative concept? Instrumentalism offers no exit criteria, no failure modes, no protocol for recognizing that a concept has outlived its usefulness. If diagnostics for \textsc{adjective}\textsubscript{\Cross} systematically fail in well-described non-European languages, do we conclude (a) adjectives are universal but diagnostics are bad, (b) adjectives are family-specific but we keep using the label anyway, or (c) the concept should be demoted to "too thin" status with documented failure mode? Without naturalization criteria (clustering, mechanisms, predictions), we keep using concepts long after the evidence suggests we should abandon them. The framework provides explicit demotion triggers: diagnostics fail across families ($\to$ too thin), stability traces to shared templates ($\to$ genealogical artifact), mechanisms prove inadequate ($\to$ indeterminate).
```

**Step 2: Add bridging paragraph**

After the four obstacles, insert:

```latex
These obstacles persist because instrumentalism treats all comparative concepts as mere analyst conveniences without asking which ones behave like scientific kinds. The question is not whether comparative concepts are \emph{useful}—Haspelmath demonstrated they are. The question is whether \emph{some} concepts show convergent stability maintained by identifiable mechanisms, making them candidates for naturalization with testable predictions about regeneration, erosion, and trade-offs. The framework developed below provides criteria for answering this question, making naturalization empirically defeasible rather than stipulative.
```

**Step 3: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation, Section 1 now ~2-3 pages

**Step 4: Commit**

```bash
git add main.tex
git commit -m "refactor(sec1): rewrite four obstacles to focus on naturalization-specific questions, not Haspelmath's already-solved problems"
```

---

### Task 4: Rename and reframe Section 2 (Orientation) as tools section

**Files:**
- Modify: `main.tex:111-120` (Section 2 opening)

**Step 1: Read current Section 2**

Run: `Read main.tex offset=111 limit=30`
Verify: Currently frames mapping/firewall as parallel contributions

**Step 2: Rename and reframe section**

Replace lines 111-118 with:

```latex
\section{Tools for naturalization}\label{sec:tools}

Answering the naturalization question requires disciplined separation of comparanda from realizations. Two requirements conflict: cross-linguistic comparison needs predicates that travel across grammars, while grammatical analysis needs kinds that are grammar-specific. From this tension, typology accumulates measurement error and fragile generalizations. The tools below—explicit mapping functions, syntax-semantics firewall, and measurement models—are not the contribution; they are \emph{prerequisites} for testing which comparative concepts deserve naturalization.

I adopt a terminological discipline following \textcite{HuddlestonPullum2002}: \emph{function} (unqualified) denotes syntactic functions only; \emph{target} denotes semantic targets; \emph{role} denotes discourse/pragmatic roles; \emph{category} denotes syntactic categories. Subscripts distinguish comparative cross-linguistic concepts (\textsc{term}\textsubscript{\Cross}) from language-specific realizations (\textsc{term}\textsubscript{Eng}, \textsc{term}\textsubscript{Jpn}) and general language-internal references (\textsc{term}\textsubscript{$L$}) where no particular language is in focus.
```

**Step 3: Update the terminology bridge paragraph**

Keep line 118 but strengthen the naturalization framing:

```latex
The present framework builds on but extends Haspelmath's comparative-concept programme and related distinctions in \textcite{Croft2001,CroftNivre2025}. My \emph{targets} correspond to Haspelmath's \parencite{Haspelmath2025} construction-functions; my language-internal \emph{categories} and \emph{realizations} correspond to construction-strategies. The extension is \emph{naturalization}: treating some comparative concepts as defeasible hypotheses about stable scientific kinds maintained by convergent mechanisms, not merely instrumental tools. This generates falsifiable predictions about regeneration, erosion, and trade-offs that purely instrumental frameworks cannot derive, and provides explicit demotion criteria that instrumentalism lacks. Terminologically, I restrict claims of \enquote{absence} or \enquote{presence} to language-internal inventories: we cannot say \enquote{Language $L$ lacks ADJECTIVE} (treating a comparative concept as if it could be absent), but we \emph{can} say \enquote{In language $L$, no dedicated class is specialized for the property-concept modifier function; that function is realized via relative-clause and stative-verb strategies.}
```

**Step 4: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation

**Step 5: Commit**

```bash
git add main.tex
git commit -m "refactor(sec2): rename to 'Tools for naturalization', frame mapping/firewall as prerequisites not contributions"
```

---

## Phase 3: Update Later Sections to Reflect New Framing

### Task 5: Update Section 6 (Naturalized comparative concepts) to reference back to obstacles

**Files:**
- Modify: `main.tex:385-390` (Section 6 opening)

**Step 1: Read current Section 6**

Run: `Read main.tex offset=385 limit=20`
Verify: Currently introduces naturalization without connecting to obstacles

**Step 2: Add opening paragraph that connects back**

Insert before current line 385:

```latex
\section{Naturalized comparative concepts}\label{sec:naturalized}

Section~\ref{sec:naturalization-question} identified four questions that instrumentalism leaves unanswered: which concepts show convergent stability (Obstacle 1), why do some patterns recur while others dissolve (Obstacle 2), how do we distinguish real patterns from artifacts (Obstacle 3), and when should we demote a concept (Obstacle 4). This section answers those questions by specifying when comparative concepts earn promotion from instrumental tools to naturalized kinds.
```

**Step 3: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation

**Step 4: Commit**

```bash
git add main.tex
git commit -m "refactor(sec6): connect naturalization criteria back to four unanswered questions from Section 1"
```

---

### Task 6: Update conclusion to emphasize naturalization as main contribution

**Files:**
- Modify: `main.tex:731-736` (conclusion opening)

**Step 1: Read current conclusion**

Run: `Read main.tex offset=731 limit=20`
Verify: Currently presents three "commitments" as equal

**Step 2: Rewrite conclusion opening**

Replace lines 731-736 with:

```latex
\section{Conclusion}\label{sec:conclusion}

Haspelmath's comparative concepts solved the conflation problem but left a deeper question unanswered: which concepts, if any, are more than descriptive conveniences? If typology aims for explanatory science rather than instrumental description, we need criteria for when cross-linguistic patterns reflect convergent mechanisms versus inherited templates, mechanistic accounts of why some patterns recur while others dissolve, falsifiable predictions about regeneration and erosion, and explicit demotion criteria for when concepts fail.

The naturalization framework provides those criteria. Some comparative concepts—definiteness, nominality, subjecthood—show stability across unrelated languages because independent mechanisms converge to maintain them: discourse continuity pressures, argument-structure bootstrapping, grammaticalization pathways. Others—adjectives, animacy hierarchies, topic-initial structures—reflect family-specific patterns or descriptive templates mistaken for universals. The framework makes the distinction empirically testable through declared projectibility thresholds, identifies which mechanisms stabilize which concepts, and issues falsifiable predictions about diachronic pathways and functional trade-offs.

The apparatus—explicit mapping functions, syntax-semantics firewall, two-layer measurement models—are tools for testing naturalization, not the contribution itself. The contribution is transforming comparative concepts from instrumental conveniences into testable hypotheses about linguistic evolution.
```

**Step 3: Compile and verify**

Run: `lualatex -interaction=nonstopmode main.tex`
Expected: Clean compilation

**Step 4: Commit**

```bash
git add main.tex
git commit -m "refactor(conclusion): emphasize naturalization as answering Haspelmath's unanswered questions, position tools as means not ends"
```

---

## Phase 4: Final Verification and Cleanup

### Task 7: Global search for misframed claims

**Files:**
- Check: `main.tex` (entire document)

**Step 1: Search for phrases that claim credit for Haspelmath's work**

Run: `grep -n "conflate\|conflation" main.tex`
Expected: All references should acknowledge Haspelmath solved this

**Step 2: Search for phrases that position mapping/firewall as main contribution**

Run: `grep -n "three-level framework\|three components\|three commitments" main.tex`
Expected: All should frame these as tools for naturalization

**Step 3: Search for missing connections to naturalization question**

Run: `grep -n "Obstacle [1-4]\|four questions\|four obstacles" main.tex`
Expected: Later sections should reference back to these obstacles

**Step 4: Document any remaining issues**

If issues found, create list for manual review
Expected: No major issues, minor wording tweaks only

**Step 5: Commit if changes made**

```bash
git add main.tex
git commit -m "fix: correct remaining mismatch between framing and content"
```

---

### Task 8: Full clean compilation and page count check

**Files:**
- Verify: `main.tex`
- Output: `main.pdf`

**Step 1: Clean auxiliary files**

Run:
```bash
cd "/Users/brettreynolds/Documents/LLM-CLI projects/Functions_as_Comparanda__Categories_as_Kinds__A_Homeostatic_Approach_to_Typology"
rm -f main.aux main.bbl main.bcf main.blg main.log main.out main.run.xml
```

**Step 2: Full compilation sequence**

Run:
```bash
lualatex -interaction=nonstopmode main.tex
biber main
lualatex -interaction=nonstopmode main.tex
lualatex -interaction=nonstopmode main.tex
```

Expected: All passes clean, no undefined references

**Step 3: Check page count**

Run: `pdfinfo main.pdf | grep Pages`
Expected: 31-32 pages (similar to current length)

**Step 4: Verify all citations resolve**

Run: `grep "?" main.pdf`
Expected: No unresolved references

**Step 5: Final commit**

```bash
git add main.pdf
git commit -m "build: recompile after naturalization reframe"
```

---

## Testing & Validation

### Validation 1: Haspelmath's Questions Answered

**Check abstract:**
- ☐ Acknowledges Haspelmath solved conflation
- ☐ Identifies questions instrumentalism leaves unanswered
- ☐ Positions naturalization as answering those questions

**Check Section 1:**
- ☐ Opens with credit to Haspelmath
- ☐ Four obstacles focus on naturalization-specific problems
- ☐ No obstacles that Haspelmath already solved

**Check later sections:**
- ☐ Section 2 titled "Tools for naturalization"
- ☐ Section 6 connects back to four obstacles
- ☐ Conclusion emphasizes naturalization as main contribution

### Validation 2: Naturalization as Unmistakable Goal

**Skim test:**
- ☐ Abstract: naturalization question in paragraph 1
- ☐ Section 1 title: Contains "natural kinds" or "naturalization"
- ☐ Section 2 title: Contains "tools" not "framework"
- ☐ Section 6: Answers the four obstacles explicitly
- ☐ Conclusion: naturalization as transforming typology

**Search test:**

Run: `grep -c "naturali[zs]" main.tex`
Expected: 30+ mentions (prominently featured)

Run: `grep -c "comparative concept" main.tex`
Expected: 50+ mentions (Haspelmath's foundation acknowledged throughout)

### Validation 3: Tools Positioned Correctly

**Mapping/firewall framing:**
- ☐ Never called "the contribution" or "the solution"
- ☐ Always framed as "prerequisites" or "tools" or "apparatus"
- ☐ Presented in service of naturalization, not parallel to it

**Three-level ontology:**
- ☐ Still present (it's a good tool)
- ☐ Framed as separating levels FOR naturalization testing
- ☐ Not presented as the main innovation

---

## Plan Complete

**Total estimated time:** 3-4 hours
- Phase 1 (Abstract rewrite): 30 minutes
- Phase 2 (Section 1 rewrite): 90 minutes
- Phase 3 (Later sections update): 60 minutes
- Phase 4 (Verification): 30 minutes

**Key changes:**
- Abstract: Acknowledges Haspelmath foundation, positions naturalization as answering unanswered questions
- Section 1: Four obstacles that ONLY naturalization solves (not conflation problems)
- Section 2: Renamed "Tools for naturalization", mapping/firewall as prerequisites
- Section 6: Explicitly answers the four obstacles
- Conclusion: Naturalization as main contribution, tools as means

**Git commits:** 8 atomic commits with clear messages

**Compilation:** Clean compile expected throughout, ~31-32 pages final

**Result:** Naturalization unmistakably the main contribution; Haspelmath's work properly acknowledged; mapping/firewall positioned as tools not goals.

---

**Plan saved to:** `docs/plans/2025-11-10-naturalization-reframe.md`
