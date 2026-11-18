# Set 1 – Acceptance Criteria

Acceptance criteria describe observable behaviour that must be true for a story to be accepted. The following examples cover five stories and include a negative scenario.

## GROC-01 – View grocery categories
**Scenario: Categories are displayed**
- **Given** the customer has opened the grocery catalogue
- **When** the catalogue finishes loading
- **Then** the available grocery categories are displayed with readable category names

## GROC-02 – Search for a grocery
**Scenario: Matching products are found**
- **Given** the catalogue contains products with searchable names
- **When** the customer enters a product name and submits the search
- **Then** products whose names match the search are displayed

**Negative scenario: No matching product**
- **Given** the catalogue contains no product matching the entered term
- **When** the customer submits that search
- **Then** a clear “No products found” message is displayed and the customer can edit the search

## GROC-05 – Add a product to the cart
**Scenario: Product is added**
- **Given** a product is available for purchase
- **When** the customer selects “Add to cart”
- **Then** the product appears in the cart with quantity one and the cart count is updated

## GROC-07 – Review cart total
**Scenario: Cart total is calculated**
- **Given** the cart contains one or more products with displayed prices and quantities
- **When** the customer opens the cart
- **Then** each line total and the subtotal are displayed using quantity multiplied by unit price

## GROC-10 – Choose a delivery slot
**Scenario: Available slot is selected**
- **Given** the customer has entered a delivery address and available slots exist for that area
- **When** the customer selects a slot and continues
- **Then** the selected slot is shown in the order summary

**Negative scenario: Slot is no longer available**
- **Given** a delivery slot became full before the customer confirmed it
- **When** the customer attempts to select that slot
- **Then** the application prevents selection and displays other available slots
