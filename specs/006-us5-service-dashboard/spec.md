# Feature Specification: Service & Health Dashboard
 
 **Feature Branch**: `006-us5-service-dashboard`
 **Parent Epic**: `001-zeroclaw-integration`
 **Created**: 2026-02-18
 **Status**: Draft
 **Priority**: P3
 
 ## Overview
 
 Users can view the status of the ZeroClaw service, manage its lifecycle (start, stop, restart), and run diagnostics to ensure the system is healthy. This provides a GUI for `zeroclaw status`, `zeroclaw doctor`, and `zeroclaw service` commands.
 
 **Why this matters**: Provides visibility into the system's health and allows users to manage the background service without dropping to the terminal.
 
 **Dependency**: Requires US1 (Connect and Chat) to be completed first.
 
 ## Target User
 
 System administrators and power users who need to ensure the ZeroClaw runtime is operational and troubleshoot issues.
 
 ## User Scenarios & Acceptance Criteria
 
 ### Primary User Journey
 
 **Independent Test**: User opens the dashboard, sees the service is running, and can stop/start it via buttons. User runs a diagnostic check and views the results.
 
 **Acceptance Scenarios**:
 
 1. **Given** the dashboard is open, **When** the service is running, **Then** a green status indicator is shown with uptime details.
 2. **Given** the service is stopped, **When** user clicks "Start Service", **Then** the service starts and the status updates to running.
 3. **Given** the dashboard is open, **When** user clicks "Run Doctor", **Then** a diagnostic report is generated and displayed (similar to `zeroclaw doctor`).
 
 ## Requirements
 
 ### Functional Requirements
 
 - **FR-012**: System MUST display the current status of the ZeroClaw daemon (running/stopped, uptime, memory usage).
 - **FR-013**: System MUST provide controls to Start, Stop, and Restart the ZeroClaw service.
 - **FR-014**: System MUST allow users to run `zeroclaw doctor` and view the diagnostic output.
 - **FR-015**: System MUST display logs or recent activity from the service.
 
 ### Key Entities
 
 - **ServiceStatus**: Represents the state of the ZeroClaw daemon (Running, Stopped, Error).
 - **DiagnosticReport**: The result of a `zeroclaw doctor` run.
 
 ## Edge Cases
 
 - **Service fails to start**: Display error message and suggest checking logs or running doctor.
 - **Permission denied**: If managing the service requires elevated privileges, prompt the user or explain the limitation.
 
 ## Out of Scope (MVP)
 
 - Advanced configuration editing (covered in other specs)
 
 ## Success Criteria
 
 ### Measurable Outcomes
 
 - **SC-010**: Users can successfully restart the service from the UI in 100% of attempts where permissions allow.
