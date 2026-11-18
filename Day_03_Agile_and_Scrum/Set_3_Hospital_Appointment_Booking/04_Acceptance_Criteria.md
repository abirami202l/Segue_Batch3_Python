# Set 3 – Acceptance Criteria

The following Given/When/Then criteria cover booking and cancellation, including the required negative scenario for a slot that has already been taken.

## HOSP-03 – View available appointment slots
**Scenario: Available slots are displayed**
- **Given** the patient has selected a doctor and a date
- **When** the patient opens the appointment availability view
- **Then** the application displays the slots that are open for that doctor and date

## HOSP-04 – Book an available appointment slot
**Scenario: Booking succeeds**
- **Given** the patient has selected a slot that is still available
- **When** the patient confirms the booking
- **Then** the application reserves the slot, creates an appointment record and displays a booking reference with the doctor, date and time

**Negative scenario: Slot has already been taken**
- **Given** the patient selected a slot that another patient has booked before confirmation
- **When** the patient attempts to confirm the booking
- **Then** the application does not create a duplicate appointment, explains that the slot is no longer available and displays other available slots

## HOSP-05 – View booking confirmation
**Scenario: Confirmation is available**
- **Given** the appointment booking has been completed successfully
- **When** the patient opens the confirmation
- **Then** the doctor name, department, appointment date, time and booking reference are displayed

## HOSP-08 – Cancel an eligible appointment
**Scenario: Cancellation succeeds**
- **Given** the patient has an upcoming appointment that is eligible for cancellation under hospital policy
- **When** the patient confirms the cancellation
- **Then** the appointment status changes to Cancelled and the patient sees a cancellation confirmation

**Negative scenario: Appointment is not eligible for cancellation**
- **Given** the appointment is inside the hospital's restricted cancellation period or is already completed
- **When** the patient attempts to cancel it
- **Then** the application prevents cancellation and explains how the patient can contact the hospital

## HOSP-07 – Reschedule an eligible appointment
**Scenario: Appointment is moved**
- **Given** the patient has an eligible upcoming appointment and another slot is available
- **When** the patient selects the new slot and confirms the change
- **Then** the old slot is released, the new slot is reserved and the updated appointment details are displayed
