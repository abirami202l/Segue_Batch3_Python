# Set 1 – INVEST Analysis

## INVEST criteria
- **Independent:** The story can be developed and tested with minimal dependency on other stories.
- **Negotiable:** The story describes an outcome, leaving implementation details open for discussion.
- **Valuable:** It provides a recognisable benefit to a customer or business stakeholder.
- **Estimable:** The team understands enough to estimate the effort.
- **Small:** It can reasonably be completed within one Sprint.
- **Testable:** Its completion can be checked using observable results.

## Story-by-story review

| Story ID | I-N-V-E-S-T review | Result | Reason |
|---|---|---|---|
| GROC-01 | I✓ N✓ V✓ E✓ S✓ T✓ | Pass | One category-listing capability; can be delivered independently. |
| GROC-02 | I✓ N✓ V✓ E✓ S✓ T✓ | Pass | Search can be tested with known product names and results. |
| GROC-03 | I✓ N✓ V✓ E✓ S✓ T✓ | Pass | Price and availability display is a focused, observable outcome. |
| GROC-04 | I✓ N✓ V✓ E✓ S✓ T✓ | Pass | A simple category filter is small and testable. |
| GROC-05 | I✓ N✓ V✓ E✓ S✓ T✓ | Pass | Adding one item is independently demonstrable. |
| GROC-06 | I✓ N✓ V✓ E✓ S✓ T✓ | Pass | Quantity update and removal can be verified in the cart. |
| GROC-07 | I✓ N✓ V✓ E✓ S✓ T✓ | Pass | Cart total is a discrete customer benefit with calculable expected values. |
| GROC-08 | I✓ N✓ V✓ E✓ S✓ T✓ | Pass | Address entry is a focused customer-facing capability. |
| GROC-09 | I✓ N✓ V✓ E✓ S✓ T✓ | Pass | Online payment is a distinct outcome; provider-specific details remain negotiable. |
| GROC-10 | I✓ N✓ V✓ E✓ S✓ T✓ | Pass | Slot selection has clear availability rules and can be estimated. |
| GROC-11 | I✓ N✓ V✓ E✓ S✓ T✓ | Pass | A customer can view a defined set of order states. |
| GROC-12 | I✓ N✓ V✓ E✓ S✓ T✓ | Pass | A confirmation message is a small, independently testable outcome. |

All 12 stories pass the initial INVEST review. Their boundaries are intentionally narrow: for example, searching, viewing product details and filtering are separate customer-visible outcomes. This makes the backlog easier to order and estimate.

## Stories that need refinement
No story in the current 12-story backlog fails INVEST. Therefore, no rewrite is required for compliance. During refinement, the Product Owner should still check dependencies such as product data availability and payment-provider access. A dependency does not automatically make a story fail INVEST, but it must be made visible and managed.
