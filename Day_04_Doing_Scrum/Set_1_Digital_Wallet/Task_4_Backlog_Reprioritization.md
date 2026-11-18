# Set 1 – Task 4: Backlog Re-prioritisation – Refund-to-Wallet Request (Day 4)

## Situation
On Day 4 the business requests **refund-to-wallet** (refund cancelled/failed payments into the user's wallet). A new story **WAL-111** is created.

> **Assumption (illustrative):** The team estimates WAL-111 at **5 points** in a quick refinement on Day 4. Day 4 status: WAL-101 is nearly done; WAL-103 and WAL-104 are started; WAL-105 and WAL-110 are not started.

## Impact analysis

| Item | Points | Status | Decision |
|---|---|---|---|
| WAL-111 Refund-to-wallet | 5 | New | **Added** to sprint |
| WAL-105 PIN reset | 3 | Not started | **Removed** → top of product backlog |
| WAL-110 Rounding bug fix | 2 | Not started | **Removed** → top of product backlog |

Scope after change: 23 + 5 − (3 + 2) = **23 points**. Total sprint scope stays equal to velocity, so no overload.

Why these two were removed: they are not in the Sprint Goal and have not started, so removing them has no wasted effort and does not threaten the goal. WAL-103 and WAL-104 are protected as they are in the goal and already in progress.

*(If the PO later decides the rounding bug is urgent, it can return only by swapping out another item of equal size, again with the PO's agreement and without endangering the Sprint Goal.)*

## Re-ordered backlog (after change)

| Rank | Key | Story | Points | In sprint? |
|---|---|---|---|---|
| 1 | WAL-101 | Add money via UPI | 5 | Yes |
| 2 | WAL-104 | P2P transfer | 8 | Yes |
| 3 | WAL-103 | Transaction history | 5 | Yes |
| 4 | WAL-111 | Refund-to-wallet | 5 | Yes (added) |
| 5 | WAL-105 | PIN reset | 3 | No (moved out) |
| 6 | WAL-110 | Rounding fix | 2 | No (moved out) |
| 7+ | WAL-102, 106, 109, 108, 107 | unchanged | | No |

## Who decides

| Role | Decision |
|---|---|
| **Product Owner** | Decides what is added and removed, and the new priority order. Only the PO can change the Sprint Backlog scope trade-off in terms of business value. |
| **Developers** | Estimate WAL-111, confirm the swap fits capacity, and can say no if the sprint becomes unachievable. |
| **Scrum Master** | Facilitates the conversation, keeps the Sprint Goal visible, updates the board and burndown, and shields the team from further unplanned requests. |
| **Business / stakeholders** | Request through the PO. They do not directly add work to the sprint. |

## Jira actions
1. Create WAL-111 and set 5 points.
2. Move WAL-111 into the active sprint.
3. Move WAL-105 and WAL-110 back to the backlog and re-rank them.
4. Note the scope change on the burndown (net 0).
