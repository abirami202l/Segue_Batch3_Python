# Set 3 – Task 3: Blocked Developer – Stand-up Statement and Scrum Master Follow-up

> Fictional names. Situation: Day 6 stand-up. LRN-304 (Progress dashboard) needs the Progress API from the Learning-Analytics team, but its **API contract** (endpoints, fields, auth) has not been delivered.

## Stand-up statement (Sneha, Developer)

- **Yesterday:** Built the progress dashboard UI (charts, completion bar) using mock JSON. Unit tests written for the components. LRN-304 is about 80 % built.
- **Today:** I can't connect the dashboard to real data. I will keep polishing the UI and add error and empty states against the mock.
- **Impediment:** 🚧 I'm blocked on **missing API contract for the Progress API** (Learning-Analytics team). Without the field names and response format I can't finish integration or write integration tests. I need it by tomorrow noon (Day 7) to keep LRN-304 on track.

## Scrum Master's follow-up action

| # | Action | When |
|---|---|---|
| 1 | Flag LRN-304 as **Blocked** in Jira and log impediment IMP-01 (description, impact, owner = Scrum Master) | Immediately after stand-up |
| 2 | Contact the Learning-Analytics team lead directly and ask for a draft contract (even a rough OpenAPI file) with a due time of tomorrow 12:00 | Within 1 hour |
| 3 | Offer a 30-minute contract-definition session with Sneha and the API owner; agree the response schema together | Today |
| 4 | Tell the Product Owner that LRN-304 (a Sprint Goal story) is at risk and what the team is doing | Today |
| 5 | If no contract by tomorrow noon (Day 7): escalate to the Learning-Analytics manager and the Product Owner; the team agrees the contract it needs and builds against it, with a "verify when real API is available" task | Day 7 |
| 6 | Report status at the next stand-up and update the log | Day 7 |

**Retrospective follow-up:** add "API contracts agreed before a story enters the sprint" to the Definition of Ready.
