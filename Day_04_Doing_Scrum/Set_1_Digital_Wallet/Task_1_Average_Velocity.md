# Set 1 – Task 1: Average Velocity, Sprint Selection and Sprint Goal

> **Data note:** The assignment says a backlog is "supplied" but it was not in the provided document. The backlog below (WAL-101 to WAL-110) is **illustrative data created for this submission**. Velocities 21, 24, 23 are from the assignment.

## 1. Average velocity

| Sprint | Velocity (points) |
|---|---|
| Sprint N-3 | 21 |
| Sprint N-2 | 24 |
| Sprint N-1 | 23 |
| **Total** | **68** |

Average velocity = (21 + 24 + 23) / 3 = 68 / 3 = **22.67 ≈ 23 points** (observed range 21–24).

Commitment is set to **23 points**, the rounded average, which sits inside the historical range.

## 2. Illustrative product backlog (priority order)

| Rank | Key | Story | Points |
|---|---|---|---|
| 1 | WAL-101 | As a user, I add money to my wallet via UPI | 5 |
| 2 | WAL-104 | As a user, I send money to another wallet (P2P) | 8 |
| 3 | WAL-103 | As a user, I view my transaction history | 5 |
| 4 | WAL-105 | As a user, I reset my wallet PIN | 3 |
| 5 | WAL-110 | Fix: wallet balance rounding error (bug) | 2 |
| 6 | WAL-102 | As a user, I view my wallet balance on the home screen | 3 |
| 7 | WAL-106 | As a user, I get push notifications for transactions | 3 |
| 8 | WAL-109 | As a user, I log in with biometrics | 5 |
| 9 | WAL-108 | As a user, I see spending analytics | 5 |
| 10 | WAL-107 | As a user, I pay utility bills | 8 |

## 3. Stories selected for the sprint

| Key | Story | Points | Running total |
|---|---|---|---|
| WAL-101 | Add money via UPI | 5 | 5 |
| WAL-104 | P2P transfer | 8 | 13 |
| WAL-103 | Transaction history | 5 | 18 |
| WAL-105 | PIN reset | 3 | 21 |
| WAL-110 | Balance rounding bug fix | 2 | **23** |

Total = 5 + 8 + 5 + 3 + 2 = **23 points = average velocity**. 

Selection rationale: top five by priority; they exactly fill 23 points. WAL-105 and WAL-110 are the lowest-ranked items, so they are the natural "flex" items if scope must change (used in Task 4).

## 4. Sprint Goal (measurable)

> **By the end of Day 10, a wallet user can top up via UPI, send money to another user (P2P) and see both transactions in their history, with all three flows passing automated tests (≥ 80 % unit-test coverage on payment services) and no open Sev-1 or Sev-2 defects.**

How it is measurable:
- Three demonstrable flows (top-up, P2P, history).
- Coverage threshold: ≥ 80 %.
- Defect threshold: zero open Sev-1/Sev-2.
- Pass/fail is verifiable at Sprint Review.

PIN reset and the rounding fix support the sprint but are deliberately **not** in the goal, so they can be traded off without breaking it.
