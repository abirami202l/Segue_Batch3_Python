# Set 2 – Acceptance Criteria for Claim Registration

The following criteria cover all four Claim Registration stories (INS-01 to INS-04). They include successful and validation-failure behaviour.

## INS-01 – Start a new claim
**Scenario: Customer starts a claim**
- **Given** the policyholder is signed in to the portal
- **When** the policyholder selects “Start a claim”
- **Then** the portal opens a new claim form and creates a draft claim reference

**Scenario: Customer is not signed in**
- **Given** a visitor is not authenticated
- **When** the visitor selects “Start a claim”
- **Then** the portal asks the visitor to sign in before displaying personal claim information

## INS-02 – Select the related policy
**Scenario: Eligible policy is selected**
- **Given** the policyholder has an active eligible policy
- **When** the policyholder views the policy list and selects one policy
- **Then** the selected policy is attached to the draft claim and its identifying details are shown for confirmation

**Scenario: No eligible policy is available**
- **Given** the policyholder has no eligible policy available for online claims
- **When** the policyholder opens the policy selection step
- **Then** the portal explains that no eligible policy is available and provides the insurer's support contact route

## INS-03 – Enter incident details
**Scenario: Valid incident details are entered**
- **Given** the policyholder is on the incident details step
- **When** the policyholder enters a valid incident date and a non-empty description
- **Then** the portal accepts the details and allows the policyholder to continue

**Validation failure: Required details are missing or invalid**
- **Given** the policyholder is on the incident details step
- **When** the policyholder submits the form with a blank description or a future incident date
- **Then** the portal highlights the invalid field, explains the validation error and does not allow the customer to continue

## INS-04 – Review and submit claim details
**Scenario: Claim is submitted**
- **Given** the policyholder has entered all required claim details
- **When** the policyholder reviews the summary and selects “Submit claim”
- **Then** the portal records the claim, displays a unique claim reference and confirms successful submission

**Scenario: Customer returns to edit**
- **Given** the policyholder is viewing the claim summary
- **When** the policyholder selects “Edit”
- **Then** the portal returns to the relevant form step with the previously entered information retained
