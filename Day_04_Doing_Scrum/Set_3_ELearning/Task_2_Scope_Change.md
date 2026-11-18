# Set 3 – Task 2: Change-Impact Note – "Certificate Download" Request (Day 6)

## Request
On Day 6 of 10, the Product Owner asks for a **certificate download** feature (PDF certificate on course completion) for an upcoming launch. A story **LRN-310** is created.

> **Assumption (illustrative):** The team estimates LRN-310 at **5 points** (PDF template, generation service, download endpoint, tests). Status on Day 6: LRN-301 Done; LRN-303 In Review; LRN-302 and LRN-304 In Progress; LRN-307 and LRN-309 not started.

## Impact analysis

| Question | Answer |
|---|---|
| Does it fit without change? | No. Sprint is full at 30 points with 4 days left. Adding 5 points would make 35, which is above velocity. |
| Is it part of the Sprint Goal? | No. The goal (find, watch, quiz, progress) does not depend on certificates. |
| Is the launch date fixed? | Yes (per PO), so the feature has real urgency. |

## Decision: what can be swapped out

| Item | Points | State | Decision | Reason |
|---|---|---|---|---|
| LRN-310 Certificate download | 5 | New | **Add** | PO priority for launch |
| LRN-309 Quiz-graded notification | 5 | Not started | **Swap out** → top of backlog | Not in Sprint Goal; no sunk effort; equal size |
| LRN-307 Course rating | 2 | Not started | **Keep** | Small, nice-to-have; can be dropped only if LRN-310 slips |

Result: 30 − 5 + 5 = **30 points**. Scope is unchanged.

## What must wait
- **LRN-309** (swapped out) goes to the top of the next sprint.
- **LRN-308, LRN-306, LRN-305** stay in the backlog; none were planned.
- Any further new request must wait for the next Sprint Planning unless the PO swaps equal-sized, unstarted work.

## How the Sprint Goal is protected
1. **Protect goal stories:** LRN-301, 302, 303, 304 are not touched; no work or people move away from them.
2. **Swap, never stack:** the sprint size stays at 30.
3. **Do not swap out started work:** stories already In Progress/In Review are not removed (avoids waste and context switching).
4. **Developers confirm feasibility:** the team agrees LRN-310 fits in the remaining 4 days; they can refuse if not.
5. **Fallback order if the sprint is at risk:** drop LRN-307 first, then re-discuss LRN-310 with the PO. Cancelling the sprint is only for the PO and only if the goal becomes obsolete, which is not the case here.
6. **Transparency:** the change is recorded in Jira, shown on the burndown, and discussed at the next stand-up.

## Decision rights

| Role | Responsibility |
|---|---|
| Product Owner | Decides priority and what is swapped |
| Developers | Estimate and agree it is achievable |
| Scrum Master | Facilitates, updates board, protects the team from more requests |

## Option table (if the PO refuses to swap)

| Option | Effect |
|---|---|
| Add LRN-310 on top | Sprint at 35; goal and quality at risk. **Not recommended.** |
| Defer LRN-310 to next sprint | Safe for goal; launch feature delayed. PO must accept the date impact. |
| Swap (chosen) | Goal protected, launch need met. **Recommended.** |
