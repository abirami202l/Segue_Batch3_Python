# Set 2 – Task 3: Impediment Log and Removal by the Scrum Master

## Impediment log entry

| Field | Detail |
|---|---|
| **ID** | IMP-01 |
| **Raised** | Day 5 of 8 (daily stand-up) by Kavya (developer on AIR-203) |
| **Description** | The payment-gateway sandbox needed for the seat-upgrade story (AIR-203) is unavailable. API calls return timeouts/503. |
| **Impact** | AIR-203 (8 pts, 33 % of the sprint) cannot be tested end to end. If unresolved beyond ~2 days, the Sprint Goal (pay for a seat upgrade) is at risk. Other stories are not affected. |
| **Owner** | Scrum Master (accountable for removal); Kavya provides technical evidence |
| **Escalation path** | 1) Gateway vendor support ticket (Level 1) → 2) Vendor account manager / airline Integration Manager (Level 2, if no response in 4 working hours) → 3) Product Owner and Engineering Manager (Level 3, if unresolved by end of Day 6) |
| **Expected resolution** | Vendor fix within 2 working days (by Day 7). Fallback is activated on Day 6 if not fixed. |
| **Status** | Open |

## How the Scrum Master removes it

| Step | When | Action |
|---|---|---|
| 1 | Day 5, immediately | Confirm the outage is not on the team's side (check credentials, network, status page). Capture logs/screenshots. |
| 2 | Day 5 | Raise a Priority-1 vendor ticket and mark AIR-203 **Blocked** (flag) in Jira, linking IMP-01. |
| 3 | Day 5 | Re-sequence work: developers on AIR-203 pair on AIR-202 and AIR-207 so no one is idle. Build payment code against the agreed API contract. |
| 4 | Day 5 | Inform the Product Owner of the risk to the Sprint Goal; do not wait for the Review. |
| 5 | Day 6 morning | Check vendor response. If no fix, escalate to Level 2 and activate the fallback: a **contract-tested stub** (e.g. WireMock) that mimics success, decline and timeout responses of the gateway. |
| 6 | Day 6–7 | Complete AIR-203 against the stub; add a task to re-verify against the real sandbox when restored. |
| 7 | Daily | Update the impediment log at each stand-up until closed. |
| 8 | Retrospective | Add "verify external environments before planning" to the DoR and discuss a standing test double. |

**Principle:** the Scrum Master removes impediments or escalates them; the team keeps working on what it can control. Stub-based testing is not a replacement for real verification, so AIR-203 is only Done once it passes in the real sandbox.
