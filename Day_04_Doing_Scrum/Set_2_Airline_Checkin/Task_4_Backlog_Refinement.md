# Set 2 – Task 4: Refinement Session – Next Sprint's Top Five Stories

> Illustrative data. Refinement is a timeboxed (≈ 1 hour) session: PO presents, team clarifies, splits and re-estimates using Planning Poker (Fibonacci).

## Top five stories (before refinement)

| Rank | Key | Story | Estimate | Observation |
|---|---|---|---|---|
| 1 | AIR-204 | Download boarding pass as PDF | 5 | Clear |
| 2 | AIR-205 | Email/SMS boarding pass | 3 | Clear |
| 3 | AIR-206 | Extra baggage during check-in | 5 | Needs pricing rules from PO |
| 4 | AIR-208 | Multi-passenger check-in on one PNR | **13** | **Oversized – cannot be finished and tested safely in one sprint with other work** |
| 5 | AIR-209 | Check-in reminder notification | 3 | Clear |

Total before: 29 points.

## Splitting the oversized story (AIR-208, 13 pts)

Split vertically (each piece delivers working, testable value), not by technical layer.

| New key | Story | Acceptance focus | Re-estimate (poker result) |
|---|---|---|---|
| AIR-208a | Select several passengers from one PNR and check them in together (happy path) | All selected passengers get checked in | 3 |
| AIR-208b | Choose a seat per passenger | Seat conflicts blocked; adjacent-seat hint | 5 |
| AIR-208c | Generate one boarding pass per passenger | One PDF/email per passenger | 3 |
| AIR-208d | Handle partial failure (one passenger ineligible, others succeed) | Clear error per passenger, no double check-in | 3 |

Sum of parts = 3 + 5 + 3 + 3 = **14 points**. The total is slightly larger than the original 13 because splitting exposed hidden work (partial-failure handling). This is normal; the original 13 was too optimistic.

## Planning Poker re-estimate record (AIR-208 pieces)

| Story | Round 1 votes | Round 2 | Agreed |
|---|---|---|---|
| 208a | 3, 3, 5, 3, 2, 3 | – | 3 |
| 208b | 5, 8, 5, 5, 3, 5 | 5, 5, 5, 5, 5, 5 | 5 |
| 208c | 3, 3, 3, 2, 3, 3 | – | 3 |
| 208d | 3, 5, 3, 3, 5, 3 | 3, 3, 3, 3, 3, 3 | 3 |

## Re-prioritised top of the backlog after refinement

| Rank | Key | Story | Points |
|---|---|---|---|
| 1 | AIR-204 | Boarding pass PDF | 5 |
| 2 | AIR-205 | Email/SMS boarding pass | 3 |
| 3 | AIR-208a | Multi-passenger check-in (happy path) | 3 |
| 4 | AIR-209 | Check-in reminder | 3 |
| 5 | AIR-206 | Extra baggage (pending pricing rules) | 5 |
| next | AIR-208b, 208c, 208d | rest of group check-in | 5, 3, 3 |

All five top stories are now ≤ 5 points. AIR-206 stays lower because of an open question to the PO (baggage pricing). That is an action for the PO before Sprint Planning. Stories that are ready for planning in the next sprint: 5 + 3 + 3 + 3 = 14 points (before AIR-206).
