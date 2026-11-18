# Set 2 – Task 1: Team Capacity and Commitment

## Given (from assignment)
- 6 team members
- 8 working days in the sprint
- Focus factor 70 %

## Step 1 – Available person-days

6 members × 8 days = **48 person-days**

## Step 2 – Apply the focus factor

48 × 0.70 = **33.6 effective person-days**

(Per person: 8 × 0.70 = 5.6 effective days. In hours, assuming 8-hour days: 33.6 × 8 = 268.8 productive hours.)

## Step 3 – Convert capacity to story points

The assignment gives no historical velocity for Set 2, so a conversion rate is needed.

> **Illustrative assumption:** In the previous sprint the same team had 6 members × 10 days × 70 % = 42 effective person-days and completed **30 points**. Delivery rate = 30 / 42 = **0.714 points per effective person-day**.

Capacity in points = 33.6 × 0.714 = **24.0 points**

## Step 4 – Commitment decision

| Item | Value |
|---|---|
| Effective capacity | 33.6 person-days |
| Rate | 0.714 pts / person-day |
| Forecast | 24 points |
| **Commit** | **24 points** |

Reasoning: the forecast is 24.0 and is based on the team's own past delivery rate, so committing to 24 is realistic. If planning shows risk (for example the payment-sandbox dependency flagged in Task 2), the team should not add extra stretch stories beyond 24.

## Sensitivity check

| Focus factor | Effective days | Points |
|---|---|---|
| 60 % | 28.8 | 20.6 |
| **70 %** | **33.6** | **24.0** |
| 80 % | 38.4 | 27.4 |

Even a small drop in focus (meetings, support work) cuts about 3.4 points, which is why the commitment is not rounded up.
