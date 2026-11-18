# Set 1 – Prioritisation and Estimation

## MoSCoW prioritisation
- **Must Have:** Essential for a usable first release and the core ordering journey.
- **Should Have:** Important, but the MVP can operate temporarily without it.
- **Could Have:** Useful enhancement if capacity permits.
- **Won't Have Now:** Explicitly excluded from the current release; it may be reconsidered later.

## Fibonacci estimation and Planning Poker
The team uses the Fibonacci-like scale **1, 2, 3, 5, 8, 13**. Developers privately select a value, reveal estimates together, discuss differences and vote again until they reach a shared estimate. Points represent relative effort, complexity and uncertainty, not hours.

### Reference story
**GROC-03 (2 points)** is selected as the reference story. Displaying a product's existing price and availability is a small, familiar piece of work with limited business rules. The team can compare other stories against this baseline. For example, adding an item to a cart is slightly more involved (3 points), while online payment is more complex and uncertain (8 points).

## Prioritised and estimated backlog

| Story ID | Epic | User story | MoSCoW priority | Story points |
|---|---|---|---|---|
| GROC-01 | Browse and Search | As a customer, I want to view grocery categories so that I can find products by type. | Must Have | 3 |
| GROC-02 | Browse and Search | As a customer, I want to search for a grocery by name so that I can locate an item quickly. | Must Have | 3 |
| GROC-03 | Browse and Search | As a customer, I want to view a product's price and availability so that I can decide whether to buy it. | Must Have | 2 |
| GROC-04 | Browse and Search | As a customer, I want to filter products by category so that I can narrow the displayed items. | Should Have | 3 |
| GROC-05 | Cart and Checkout | As a customer, I want to add a product to my cart so that I can collect items before ordering. | Must Have | 3 |
| GROC-06 | Cart and Checkout | As a customer, I want to change or remove cart quantities so that my order reflects what I need. | Must Have | 3 |
| GROC-07 | Cart and Checkout | As a customer, I want to review my cart total before checkout so that I know the expected cost. | Must Have | 2 |
| GROC-08 | Cart and Checkout | As a customer, I want to enter a delivery address so that the supermarket knows where to deliver my order. | Must Have | 5 |
| GROC-09 | Cart and Checkout | As a customer, I want to pay for my order online so that I can complete the purchase without visiting the store. | Must Have | 8 |
| GROC-10 | Cart and Checkout | As a customer, I want to choose an available delivery slot so that I can receive groceries at a suitable time. | Must Have | 5 |
| GROC-11 | Delivery Tracking | As a customer, I want to view my order status so that I know whether it is being prepared or delivered. | Should Have | 3 |
| GROC-12 | Delivery Tracking | As a customer, I want to receive a separate order confirmation notification so that I have a record that my order was placed. | Won't Have Now | 2 |

## Total estimate
Total backlog = 3 + 3 + 2 + 3 + 3 + 3 + 2 + 5 + 8 + 5 + 3 + 2 = **42 story points**.

## Release ordering
1. Complete Must Have stories that establish product discovery, cart, address, payment and slot selection.
2. Add order-status visibility as a Should Have.
3. Add category filtering if capacity permits. A separate order-confirmation notification is explicitly deferred; the MVP still displays an on-screen result after successful checkout.
4. “Won't Have Now” items such as loyalty rewards, multi-store fulfilment and subscription ordering are outside this initial 12-story MVP backlog.
