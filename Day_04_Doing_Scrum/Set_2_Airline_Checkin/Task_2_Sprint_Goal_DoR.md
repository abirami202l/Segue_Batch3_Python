# Set 2 – Task 2: Sprint Goal, Story Selection and Definition of Ready Check

> **Data note:** No backlog was supplied for Set 2. Stories AIR-201 to AIR-209 are **illustrative**.

## Illustrative backlog (priority order)

| Rank | Key | Story | Points |
|---|---|---|---|
| 1 | AIR-201 | As a passenger, I check in online using my PNR and last name | 5 |
| 2 | AIR-202 | As a passenger, I select my seat on an interactive seat map | 8 |
| 3 | AIR-203 | As a passenger, I pay to upgrade my seat | 8 |
| 4 | AIR-207 | As the airline, I block check-in outside the 48h–1h window | 3 |
| 5 | AIR-204 | As a passenger, I download my boarding pass as PDF | 5 |
| 6 | AIR-205 | As a passenger, I receive my boarding pass by email/SMS | 3 |
| 7 | AIR-206 | As a passenger, I add extra baggage during check-in | 5 |
| 8 | AIR-208 | As a group traveller, I check in multiple passengers on one PNR | 13 |
| 9 | AIR-209 | As a passenger, I get a check-in reminder notification | 3 |

## Selected stories (capacity = 24 points, from Task 1)

| Key | Story | Points | Running total |
|---|---|---|---|
| AIR-201 | Check-in via PNR | 5 | 5 |
| AIR-202 | Seat map selection | 8 | 13 |
| AIR-203 | Seat upgrade with payment | 8 | 21 |
| AIR-207 | Check-in window validation | 3 | **24** |

## Sprint Goal

> **By the end of the sprint, a passenger within the check-in window can check in online with their PNR, choose a seat and pay for a seat upgrade, and the full flow is verified by automated tests and accepted against the acceptance criteria.**

## Definition of Ready check

Criteria: **A** user story written, **B** acceptance criteria clear and testable, **C** estimated by the team, **D** dependencies identified and available, **E** UX design / mock-up ready, **F** fits in one sprint.

| Story | A | B | C | D | E | F | Result |
|---|---|---|---|---|---|---|---|
| AIR-201 | ✔ | ✔ | ✔ (5) | ✔ PNR service available | ✔ | ✔ | **Ready** |
| AIR-202 | ✔ | ✔ | ✔ (8) | ✔ Seat-inventory API available | ✔ | ✔ (large but < sprint) | **Ready** |
| AIR-203 | ✔ | ✔ | ✔ (8) | ⚠ Depends on payment-gateway sandbox (external) | ✔ | ✔ | **Ready with risk** – dependency not secured |
| AIR-207 | ✔ | ✔ | ✔ (3) | ✔ | n/a (no UI) | ✔ | **Ready** |

**Reflection:** AIR-203 had an external dependency that was assumed rather than confirmed. A stricter DoR ("dependency environment access verified before planning") would have exposed the risk before the sprint started. This is the root cause of the impediment in Task 3.
