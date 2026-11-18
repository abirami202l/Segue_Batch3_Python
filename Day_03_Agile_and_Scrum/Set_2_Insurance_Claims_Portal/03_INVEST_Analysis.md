# Set 2 – INVEST Analysis

## INVEST review of all stories

| Story ID | Result | Review |
|---|---|---|
| INS-01 | Pass | Starting a claim is a discrete customer outcome; detailed fields are separate stories. |
| INS-02 | Pass | Policy selection is independently demonstrable once the customer has started a claim. |
| INS-03 | Pass | Incident details form one focused customer-visible step. |
| INS-04 | Pass | Review and submission is a clear confirmation step with testable outcomes. |
| INS-05 | Pass | Displaying required evidence guidance is small and customer-visible. |
| INS-06 | Pass | Uploading one supporting document is a bounded capability. |
| INS-07 | Pass | Receipt status for submitted documents is independently testable. |
| INS-08 | Pass | Replacing an unreadable document is a separate customer action. |
| INS-09 | Pass | A defined status view provides value without requiring detailed history. |
| INS-10 | Pass | Latest update is a bounded information display. |
| INS-11 | Pass | A request for information and its instructions are a customer-visible outcome. |
| INS-12 | Pass | A status-change notification has a clear trigger and result. |
| INS-13 | Pass | A decision notification is distinct from general status alerts. |
| INS-14 | Pass | Settlement amount and payment status are focused information for an approved claim. |

All 14 refined stories pass the INVEST review. The backlog avoids broad items such as “manage the complete claim” and “handle all documents”. Those phrases would be difficult to estimate and test.

## Vertical splitting of oversized capabilities
The initial broad concept **“Submit and manage an insurance claim”** was too large because it combined several customer outcomes. It was split vertically into:
- **INS-01:** Start a new claim.
- **INS-02:** Select the relevant policy.
- **INS-03:** Enter incident details.
- **INS-04:** Review and submit the claim.

Each slice gives the policyholder a meaningful step in the journey and can be demonstrated. It is not split into frontend, backend or database tasks.

The broad concept **“Upload all claim documents”** was also too large. It was refined into:
- **INS-05:** See the documents required.
- **INS-06:** Upload a supporting document.
- **INS-07:** See receipt status.
- **INS-08:** Replace an unreadable document.

This is vertical slicing because every item represents customer-visible functionality rather than an internal technical layer.

## INVEST summary
- **Independent:** Stories are separable backlog items, although the end-to-end journey has natural sequencing.
- **Negotiable:** The wording describes outcomes and leaves screen layout and implementation details open.
- **Valuable:** Each story improves claim submission, evidence handling, progress visibility or decision awareness.
- **Estimable:** The scope and expected outcome are sufficiently clear for relative estimation.
- **Small:** The broad capabilities have been divided into manageable slices.
- **Testable:** Each story can be checked through explicit acceptance criteria and observable portal behaviour.
