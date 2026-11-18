# Set 2 – Planning Poker Estimation

## Estimation scale
The team uses **1, 2, 3, 5, 8 and 13** story points. A point value expresses relative effort, complexity and uncertainty. It is not a number of hours or a delivery-date promise.

## Planning Poker exercise
1. The Product Owner explains the story and answers questions about the customer outcome.
2. Developers discuss assumptions, acceptance criteria and dependencies.
3. Each Developer privately selects a card from the agreed scale.
4. Everyone reveals estimates at the same time.
5. If estimates differ, the highest and lowest estimators explain their reasoning.
6. The team clarifies the story and votes again until it agrees a value.

## Example outlier discussion
For **INS-06 – Upload a supporting document**, suppose the first vote is **3, 5, 5, 8, 13**. The 13-point estimate is an outlier. That Developer explains concern about file size, file-type validation and interrupted uploads. Other Developers point out that the first release only needs a limited set of accepted document formats and a clear upload result. The team records those assumptions in the acceptance criteria and agrees **5 points**. If the broader upload requirements later emerge, the Product Owner can create a separate story rather than silently expanding INS-06.

## Estimated backlog

| Story ID | Epic | User story (short title) | Agreed points |
|---|---|---|---:|
| INS-01 | Claim Registration | to start a new claim | 5 |
| INS-02 | Claim Registration | to select the policy related to my claim | 3 |
| INS-03 | Claim Registration | to enter the incident date and description | 3 |
| INS-04 | Claim Registration | to review and submit my claim details | 5 |
| INS-05 | Document Upload | to see the documents required for my claim type | 3 |
| INS-06 | Document Upload | to upload a supporting document | 5 |
| INS-07 | Document Upload | to see whether each document was received | 3 |
| INS-08 | Document Upload | to replace an unreadable uploaded document | 3 |
| INS-09 | Claim Tracking | to view the current status of a claim | 3 |
| INS-10 | Claim Tracking | to view the latest claim update | 3 |
| INS-11 | Claim Tracking | to view a request for additional information | 5 |
| INS-12 | Settlement Notifications | to receive a notification when my claim status changes | 3 |
| INS-13 | Settlement Notifications | to receive a settlement decision notification | 3 |
| INS-14 | Settlement Notifications | to view the settlement amount and payment status when approved | 5 |

## Total backlog estimate
5 + 3 + 3 + 5 + 3 + 5 + 3 + 3 + 3 + 3 + 5 + 3 + 3 + 5 = **52 story points**.

## Estimation assumptions
- The portal uses an existing customer sign-in service.
- Policy and claim data are available through approved insurer systems.
- The first release supports a defined set of common document formats and size limits.
- Notification delivery uses an existing approved channel.
- Security, access control and privacy checks are included in the team's Definition of Done.
