# Implementation Protocol for Formalism Fixes

**Purpose**: Define the workflow for implementing conceptual fixes proposed by Kimi/ChatGPT5

---

## Phase 1: Conceptual Design (Kimi/ChatGPT5)

**Input**: `reviews/handoff-to-conceptual-agents.md`

**Output**: `reviews/formalism-fix-proposal-[agent-name].md`

**Brett's role**:
- Share handoff document with Kimi/ChatGPT5
- Answer clarification questions
- Evaluate proposal for theoretical soundness
- Select which proposal to implement (if multiple)

---

## Phase 2: Implementation Planning (Claude - me)

**Input**: Selected proposal from Phase 1

**My tasks**:
1. Read the proposal completely
2. Extract all concrete changes into implementation checklist
3. Identify dependencies (which changes must happen in sequence)
4. Flag any ambiguities or missing specifications
5. Create TodoWrite task list

**Output**: Clarification questions (if needed) OR implementation task list

---

## Phase 3: Execution (Claude - me)

**Process**:
1. Work through task list sequentially
2. Make edits using Edit tool (preserving line numbers for verification)
3. Check cross-references after each major change
4. Mark todos as completed after verification

**Verification steps**:
- After each section edited: Check notation consistency with §3.1
- After Table 2 changes: Verify weights match new constraints
- After measurement model changes: Check mathematical coherence
- After all changes: Full compilation test

---

## Phase 4: Review (Claude - me)

**My deliverable**: `reviews/implementation-report.md`

**Contents**:
1. **Changes summary**: What was changed in each section (with line numbers)
2. **Consistency checks**: Notation, cross-references, constraints verified
3. **Compilation status**: PDF builds cleanly, no warnings
4. **Identified issues**: Any problems encountered during implementation
5. **Recommendations**: Suggested next steps (if any)

---

## Phase 5: Validation (Brett)

**Your tasks**:
1. Review `implementation-report.md`
2. Check PDF for correctness
3. Verify theoretical integrity maintained
4. Identify any remaining issues

**Feedback loop**:
- If issues found → I fix them (Phase 3 continues)
- If major conceptual problems → Back to Phase 1
- If ready → Move to broader review (other sections)

---

## Handoff Points

### From Conceptual Agent → Claude

**Required elements in proposal**:
- [ ] Clear executive decision (which option chosen)
- [ ] Complete formal specification with constraints
- [ ] Section-by-section change instructions
- [ ] Expected effects on Table 2, measurement model, predictions
- [ ] Explicit statement of what should NOT change (theoretical commitments)

**Format**: Concrete enough that I can implement without making conceptual decisions

### From Claude → Brett

**Required elements in implementation report**:
- [ ] List of all files modified (with line numbers)
- [ ] Description of each change made
- [ ] Verification that constraints are satisfied throughout
- [ ] Compilation status (clean build, no errors/warnings)
- [ ] Any deviations from proposal (with justification)

---

## Success Metrics

**Implementation succeeds if**:
1. All changes from proposal are executed faithfully
2. Notation is consistent across all sections
3. Mathematical constraints are satisfied (e.g., weights sum to 1)
4. Cross-references remain valid
5. PDF compiles cleanly
6. No new conceptual issues introduced

**Implementation fails if**:
1. Notation inconsistencies introduced
2. Mathematical errors in revised formulas
3. Cross-references broken
4. Compilation fails
5. Changes don't fully resolve identifiability/type issues

---

## Emergency Protocol

**If I encounter ambiguity during implementation**:
1. STOP - do not make conceptual decisions
2. Document the ambiguity clearly
3. Provide 2-3 possible interpretations
4. Ask Brett for clarification
5. Wait for guidance before proceeding

**If proposal has internal contradictions**:
1. STOP - do not choose between contradictory instructions
2. Document the contradiction with specific examples
3. Explain why both cannot be simultaneously satisfied
4. Ask Brett to resolve with conceptual agent
5. Wait for revised proposal

---

## Timeline Expectations

**Phase 2 (Implementation planning)**: ~5-10 minutes
**Phase 3 (Execution)**: ~20-30 minutes (depending on scope)
**Phase 4 (Review)**: ~10 minutes
**Total**: ~45 minutes from receiving proposal to implementation report

*Note: Timeline assumes proposal is clear and complete. Ambiguities or contradictions will extend timeline due to clarification loop.*

---

## Current Status

- [x] Phase 1 handoff document created: `handoff-to-conceptual-agents.md`
- [ ] Phase 1 proposal received from Kimi/ChatGPT5
- [ ] Phase 2 implementation planning
- [ ] Phase 3 execution
- [ ] Phase 4 implementation report
- [ ] Phase 5 validation by Brett

**Waiting on**: Proposal from conceptual design agent(s)
