# Evidence Directory - E01 to E13

This directory is the central technical verification layer for the Kioptrix 4 assessment. Each entry connects a presentation claim to sanitized evidence, an interpretation, limitations, and the relevant detailed finding.

> **Evidence handling:** Untouched originals are retained privately. Public artifacts redact passwords and session identifiers while preserving private lab IP addresses for traceability.

## Quick Map

| Evidence | Phase | Primary Claim | Related Finding |
|---|---|---|---|
| E01-E02 | Reconnaissance | Reachable services and technology stack | Supporting |
| E03-E05 | Web testing | Login request mapped; `mypassword` SQL injection confirmed | K4-001 |
| E06-E07 | Exploitation | Credentials extracted and reused for SSH | K4-001 |
| E08-E10 | Post-exploitation | Restricted shell escaped; root cause identified | K4-001 / K4-002 |
| E11-E13 | Privilege escalation | MySQL conditions led to root execution and effective root shell | K4-002 |

---

## Supporting Lab Validation

### S01 - Network Confirmation

**Objective:** Confirm the attacker system's isolated-lab address and subnet.

**Evidence:** [S01-lab-network-confirmation.png](supporting/lab-validation/S01-lab-network-confirmation.png)

**Result:** Kali used `192.168.77.100/24` within the isolated `192.168.77.0/24` network.

### S02 - Host Discovery

**Evidence:** [S02-host-discovery-ping-sweep.png](supporting/lab-validation/S02-host-discovery-ping-sweep.png)

**Result:** The target was identified at `192.168.77.101`.

### S03 - Reachability Confirmation

**Evidence:** [S03-target-reachability-confirmed.png](supporting/lab-validation/S03-target-reachability-confirmed.png)

**Result:** The target responded to ICMP with 0% packet loss during verification.

---

## E01 - Full TCP Port Scan

**Presentation reference:** Attack Surface Discovery

**Objective:** Identify all reachable TCP services on the target.

**Method:** Full TCP SYN scan with service and operating-system detection.

**Hard evidence:** [E01.1-full-tcp-port-scan.png](E01-network-scan/E01.1-full-tcp-port-scan.png)

**Result:** Ports `22`, `80`, `139`, and `445` were open, exposing SSH, HTTP, NetBIOS, and SMB.

**Interpretation:** HTTP was selected as the primary application-testing path; SSH and SMB remained secondary access vectors.

**Limitation:** This artifact covers TCP only. UDP services were outside this evidence item.

---

## E02 - Focused Service Enumeration

**Presentation reference:** Focused Service Enumeration

**Objective:** Confirm software versions, configurations, and the web technology stack.

**Hard evidence:**

- [E02.1-targeted-service-enumeration.png](E02-service-enumeration/E02.1-targeted-service-enumeration.png)
- [E02.2-whatweb-technology-identification.png](E02-service-enumeration/E02.2-whatweb-technology-identification.png)
- [E02.3-nikto-web-enumeration.png](E02-service-enumeration/E02.3-nikto-web-enumeration.png)

**Result:** Enumeration identified OpenSSH `4.7p1`, Apache `2.2.8`, PHP `5.2.4`, Samba `3.0.28a`, disabled SMB signing, and a reachable PHP login application.

**Interpretation:** Automated scanner output was treated as a lead requiring manual validation, not as final proof.

**Limitation:** Potential CVEs inferred from version data were not treated as confirmed unless separately validated.

---

## E03 - Login Request Mapping and Baseline

**Presentation reference:** Login Request Mapping & Manual Bypass Test

**Objective:** Identify the authentication endpoint and establish normal invalid-login behavior.

**Hard evidence:**

- [E03.1-login-page-identified.png](E03-login-mapping/E03.1-login-page-identified.png)
- [E03.2-login-request-parameters.png](E03-login-mapping/E03.2-login-request-parameters.png)
- [E03.3a-invalid-login-terminal-control.png](E03-login-mapping/E03.3a-invalid-login-terminal-control.png)
- [E03.3b-invalid-login-browser-control.png](E03-login-mapping/E03.3b-invalid-login-browser-control.png)

**Result:** The form submitted `myusername` and `mypassword` through POST to `/checklogin.php`. A normal invalid credential attempt returned `Wrong Username or Password`.

**Interpretation:** The failed login provided a negative control for comparing later crafted-input behavior.

**Related finding:** [K4-001](../findings/K4-001-sql-injection.md)

---

## E04 - Manual Authentication-Bypass Behavior

**Presentation reference:** Login Request Mapping & Manual Bypass Test

**Objective:** Determine whether crafted input altered the application's authentication response.

**Hard evidence:**

- [E04.1-crafted-input-redirect-behavior.png](E04-manual-bypass/E04.1-crafted-input-redirect-behavior.png)

**Result:** Crafted input produced `HTTP/1.1 302 Found` and redirected to `login_success.php`, unlike the normal invalid-login response.

**Interpretation:** Authentication-bypass behavior was observed.

**Limitation:** This test did not isolate which input parameter was injectable or identify the exact injection technique. E05 performed parameter-level confirmation.

**Related finding:** [K4-001](../findings/K4-001-sql-injection.md)

---

## E05 - Blind SQL Injection Confirmation

**Presentation reference:** SQL Injection Confirmation and Validation Logic

**Objective:** Isolate the vulnerable parameter and identify confirmed SQL injection techniques.

**Hard evidence:**

- [E05.1-sqlmap-mypassword-confirmed.png](E05-sql-injection-confirmation/E05.1-sqlmap-mypassword-confirmed.png)
- [E05.2-sqlmap-myusername-negative-control.png](E05-sql-injection-confirmation/E05.2-sqlmap-myusername-negative-control.png)
- [E05.3-sqlmap-confirmation-transcript.txt](E05-sql-injection-confirmation/E05.3-sqlmap-confirmation-transcript.txt)

**Result:** `mypassword` was confirmed injectable through boolean-based blind and time-based blind testing. `myusername` was not confirmed injectable.

**Interpretation:** Application response differences and controlled delays showed that attacker-controlled password input influenced the backend MySQL query.

**Limitation:** The evidence confirms one SQL injection vulnerability with two blind-testing techniques, not two separate vulnerabilities.

**Related finding:** [K4-001](../findings/K4-001-sql-injection.md)

---

## E06 - Credential Extraction

**Presentation reference:** Credential Extraction & SSH Access

**Objective:** Determine whether the confirmed injection could enumerate and retrieve backend records.

**Hard evidence:**

- [E06.1-members-table-enumeration.png](E06-credential-extraction/E06.1-members-table-enumeration.png)
- [E06.2-members-column-enumeration.png](E06-credential-extraction/E06.2-members-column-enumeration.png)
- [E06.3-credential-dump-redacted.png](E06-credential-extraction/E06.3-credential-dump-redacted.png)

**Result:** The `members` database and table were enumerated, and two username/password records were retrieved. Password values are redacted publicly.

**Interpretation:** The injection exposed valid credential material and demonstrated loss of database confidentiality.

**Related finding:** [K4-001](../findings/K4-001-sql-injection.md)

---

## E07 - Credential Reuse and SSH Access

**Presentation reference:** Credential Extraction & SSH Access

**Objective:** Validate whether extracted credentials were reusable against an exposed system service.

**Hard evidence:**

- [E07.1-ssh-access-john.png](E07-ssh-access/E07.1-ssh-access-john.png)
- [E07.2-ssh-access-robert.png](E07-ssh-access/E07.2-ssh-access-robert.png)

**Result:** Extracted credentials authenticated successfully to SSH for both tested accounts. The compromise chain continued through the `john` session.

**Interpretation:** The web application compromise crossed into authenticated host access through credential reuse.

**Related finding:** [K4-001](../findings/K4-001-sql-injection.md)

---

## E08 - Restricted Shell Escape

**Presentation reference:** Restricted Shell Escape & Privilege Baseline

**Objective:** Determine whether the restricted LigGoat shell could launch a standard shell.

**Hard evidence:** [E08.1-restricted-shell-escape.png](E08-shell-escape/E08.1-restricted-shell-escape.png)

**Result:** Python `os.system()` functionality launched `/bin/bash`.

**Interpretation:** Command access expanded, but the identity remained `john`.

**Limitation:** Shell escape was not privilege escalation.

---

## E09 - Low-Privilege Baseline

**Presentation reference:** Restricted Shell Escape & Privilege Baseline

**Objective:** Establish the account identity and authorization level before privilege escalation.

**Hard evidence:**

- [E09.1-local-user-baseline.png](E09-privilege-baseline/E09.1-local-user-baseline.png)
- [E09.2-sudo-authorization-denied.png](E09-privilege-baseline/E09.2-sudo-authorization-denied.png)

**Result:** The shell remained `uid=1001(john)`, and `sudo -l` confirmed that no sudo commands were authorized.

**Interpretation:** Root access had not yet been achieved, providing a clear pre-escalation baseline.

**Related finding:** [K4-002](../findings/K4-002-mysql-root-command-execution.md)

---

## E10 - Application Source-Code Root Cause

**Presentation reference:** Application Source-Code Review

**Objective:** Explain why the password parameter was injectable and identify dangerous database configuration.

**Hard evidence:** [E10.1-checklogin-source-code-root-cause.png](E10-source-code-analysis/E10.1-checklogin-source-code-root-cause.png)

**Result:** The application connected as MySQL `root` with an empty password, password escaping was commented out, and user-controlled values were concatenated into a dynamic SQL query.

**Interpretation:** The source code directly explained the parameter-specific injection and exposed the next privilege-escalation lead.

**Related findings:** [K4-001](../findings/K4-001-sql-injection.md), [K4-002](../findings/K4-002-mysql-root-command-execution.md)

---

## E11 - MySQL Escalation Conditions

**Presentation reference:** MySQL Misconfiguration Chain

**Objective:** Verify whether the low-privileged session could access MySQL administratively and whether database operations could inherit Linux root privileges.

**Hard evidence:**

- [E11.1-passwordless-mysql-root-access.txt](E11-mysql-escalation-conditions/E11.1-passwordless-mysql-root-access.txt)
- [E11.2-mysqld-root-and-sys-exec-udf.png](E11-mysql-escalation-conditions/E11.2-mysqld-root-and-sys-exec-udf.png)

**Result:** The `john` session authenticated locally to MySQL as database `root` without a password prompt. `mysqld` ran as Linux `root`, and `sys_exec` was registered through `lib_mysqludf_sys.so`.

**Interpretation:** The three conditions established a credible path from low-privileged local access to Linux root command execution.

**Related finding:** [K4-002](../findings/K4-002-mysql-root-command-execution.md)

---

## E12 - Root Command-Execution Proof

**Presentation reference:** Root-Level Command Execution via MySQL UDF

**Objective:** Prove that a command invoked through MySQL executed with Linux root privileges.

**Hard evidence:** [E12.1-root-command-execution-proof.png](E12-root-command-execution/E12.1-root-command-execution-proof.png)

**Result:** `sys_exec` created a root-owned proof file containing `uid=0(root) gid=0(root)`.

**Interpretation:** Operating-system commands invoked through the database inherited the Linux root privileges of the MySQL service.

**Related finding:** [K4-002](../findings/K4-002-mysql-root-command-execution.md)

---

## E13 - Effective Root Shell

**Presentation reference:** Root-Level Command Execution via MySQL UDF

**Objective:** Determine whether the command-execution path could produce an interactive shell with effective root authority.

**Hard evidence:** [E13.1-effective-root-shell.png](E13-effective-root-shell/E13.1-effective-root-shell.png)

**Result:** `/bin/bash -p` returned `whoami: root` and `euid=0(root)` while the real user remained `uid=1001(john)`.

**Interpretation:** The low-privileged SSH session achieved effective Linux root authority, demonstrating complete host compromise.

**Cleanup:** Restore `/bin/bash` to `0755` and remove `/tmp/mysql_root_proof.txt`. Mark cleanup as completed only after verifying it in the lab.

**Related finding:** [K4-002](../findings/K4-002-mysql-root-command-execution.md)

---

## Supporting Finding SF01 - Exposed Database Backup

**Hard evidence:**

- [SF01.1-database-backup-manual-validation.png](supporting-findings/SF01-exposed-database-backup/SF01.1-database-backup-manual-validation.png)
- [SF01.2-database-backup-content-redacted.png](supporting-findings/SF01-exposed-database-backup/SF01.2-database-backup-content-redacted.png)

**Result:** `/database.sql` was publicly retrievable and disclosed database schema and a credential record. The disclosed password did not authenticate to the tested live login, as demonstrated by E03.

**Interpretation:** This was a separately confirmed information-disclosure weakness, not the source of the successful SSH compromise.

---

## Repository Verification

Repository: https://github.com/runeforged/kioptrix4
