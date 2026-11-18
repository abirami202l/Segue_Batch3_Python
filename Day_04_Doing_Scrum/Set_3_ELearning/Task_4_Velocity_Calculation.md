# Set 3 – Task 4: Velocity Calculation (One Story 80 % Done)

> **Data note:** The assignment's completed-points table was not included. The table below is **illustrative** and consistent with Tasks 1–3 (after the Day 6 swap of LRN-309 for LRN-310).

## Sprint outcome (illustrative)

| Key | Story | Points | Status at sprint end | % complete | Points counted |
|---|---|---|---|---|---|
| LRN-301 | Catalogue search | 5 | Done | 100 % | 5 |
| LRN-302 | Video playback with resume | 8 | Done | 100 % | 8 |
| LRN-303 | Quiz submission and scoring | 5 | Done | 100 % | 5 |
| LRN-307 | Course rating | 2 | Done | 100 % | 2 |
| LRN-310 | Certificate download | 5 | Done | 100 % | 5 |
| LRN-304 | Progress dashboard | 5 | **Not Done** (blocked on API contract, integration unfinished) | 80 % | **0** |
| | **Committed (after swap)** | **30** | | | **25** |

## Calculation

Velocity = sum of points of stories that meet the Definition of Done
= 5 + 8 + 5 + 2 + 5 = **25 points**

Commitment 30, delivered 25; completion rate = 25 / 30 = **83 %**.

## How partially done work is counted

**Rule: it is not counted. LRN-304 earns 0 points this sprint, even at 80 %.**

Why:
1. **Velocity measures delivered, usable value.** A story is either Done (meets the DoD) or not. At 80 % it cannot be released or used by a learner.
2. **The last 20 % is unpredictable.** Integration, testing and review are the parts that usually hide risk, so "80 % done" is rarely 80 % of the remaining effort.
3. **Partial credit inflates velocity.** If counted, velocity would show 25 + 4 = 29, which would make the next sprint's forecast too high.
4. **Avoids double counting.** The story returns to the Product Backlog and is re-estimated for the **remaining** work (e.g. 1–2 points). Those points are counted in the sprint in which it is finished. Total credit over time is not lost; it is just claimed when the value is delivered.

## Effects and follow-up

| Item | Action |
|---|---|
| LRN-304 | Move back to the top of backlog; re-estimate the remaining work (≈ 2 pts, illustrative) |
| Next sprint forecast | Use average of recent velocities (not just 25); note the blocker was external |
| Reporting | Burndown line for LRN-304 stays flat until Done, which is an honest signal of risk |
