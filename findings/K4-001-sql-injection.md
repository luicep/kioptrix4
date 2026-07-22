# K4-001 - SQL Injection in Login Authentication

| Field | Value |
|---|---|
| Severity | Critical |
| Status | Confirmed and exploited in the authorized lab |
| Affected endpoint | `/checklogin.php` |
| Affected parameter | `mypassword` (POST) |
| Classification | CWE-89: Improper Neutralization of Special Elements used in an SQL Command |
| Evidence | E03-E07 and E10 |

## Description

The login application constructed an SQL authentication query using attacker-controlled POST input. Testing confirmed boolean-based blind and time-based blind SQL injection in the `mypassword` parameter. A separate control test did not confirm `myusername` as injectable.

## Root Cause

Source-code review showed that `mypassword` escaping was commented out and the value was concatenated directly into a dynamically constructed query. The application also used an excessively privileged MySQL `root` connection configured with an empty password.

## Demonstrated Impact

- Enumerated the `members` database and table structure.
- Extracted valid user credentials.
- Reused an extracted credential to authenticate to SSH as `john`.
- Crossed the trust boundary from the web application into authenticated operating-system access.

## Business Impact

An attacker could bypass intended authentication controls, access or modify backend data, disclose credentials, and use credential reuse to obtain access to connected systems. In a production environment, this could lead to account takeover, data exposure, incident-response costs, customer harm, and regulatory consequences.

## Evidence

- [E03 - Login mapping and invalid-login control](../evidence/EVIDENCE_INDEX.md#e03---login-request-mapping-and-baseline)
- [E04 - Crafted-input redirect behavior](../evidence/EVIDENCE_INDEX.md#e04---manual-authentication-bypass-behavior)
- [E05 - Blind SQL injection confirmation](../evidence/EVIDENCE_INDEX.md#e05---blind-sql-injection-confirmation)
- [E06 - Credential extraction](../evidence/EVIDENCE_INDEX.md#e06---credential-extraction)
- [E07 - SSH access](../evidence/EVIDENCE_INDEX.md#e07---credential-reuse-and-ssh-access)
- [E10 - Source-code root cause](../evidence/EVIDENCE_INDEX.md#e10---application-source-code-root-cause)

## Remediation

1. Replace dynamic query construction with prepared statements and parameter binding.
2. Remove database-administrator credentials from application code.
3. Run the application with a dedicated, least-privileged database account.
4. Enforce modern password hashing and prevent credential reuse between application and system accounts.
5. Rotate all credentials exposed during testing.
6. Upgrade the unsupported application and operating-system stack.

## Validation Requirements

- Re-run targeted SQL injection testing against both login parameters.
- Confirm malicious input is treated strictly as data.
- Verify the application database account cannot access administrative schemas or execute privileged operations.
- Confirm extracted or rotated application passwords cannot authenticate to SSH.
