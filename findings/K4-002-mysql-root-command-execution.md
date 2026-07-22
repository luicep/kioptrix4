# K4-002 - MySQL Misconfiguration Enabling Root-Level Command Execution

| Field | Value |
|---|---|
| Severity | Critical |
| Status | Confirmed and exploited in the authorized lab |
| Affected component | Local MySQL service and `sys_exec` UDF |
| Initial account | `john`, `uid=1001` |
| Evidence | E09-E13 |

## Description

A low-privileged local account could authenticate to MySQL as database `root` without a password. The MySQL daemon ran under Linux `root`, and the `sys_exec` function from `lib_mysqludf_sys.so` was installed and available. Together, these conditions allowed database queries to execute operating-system commands with Linux root privileges.

## Demonstrated Impact

- Executed the Linux `id` command through MySQL `sys_exec`.
- Created a root-owned proof file containing `uid=0(root)`.
- Applied SUID permissions to `/bin/bash` through `sys_exec`.
- Launched `/bin/bash -p`, producing a shell with `euid=0(root)` while the real user remained `john`.
- Demonstrated complete administrative control of the host.

## Root Cause

The compromise required three interacting security failures:

1. Passwordless local MySQL administrative access.
2. MySQL service execution under Linux `root`.
3. An enabled operating-system command-execution UDF.

## Evidence

- [E09 - Low-privilege baseline](../evidence/EVIDENCE_INDEX.md#e09---low-privilege-baseline)
- [E10 - Application database configuration](../evidence/EVIDENCE_INDEX.md#e10---application-source-code-root-cause)
- [E11 - Escalation conditions](../evidence/EVIDENCE_INDEX.md#e11---mysql-escalation-conditions)
- [E12 - Root command proof](../evidence/EVIDENCE_INDEX.md#e12---root-command-execution-proof)
- [E13 - Effective root shell](../evidence/EVIDENCE_INDEX.md#e13---effective-root-shell)

## Remediation

1. Require strong authentication for every MySQL administrative account.
2. Run MySQL under a dedicated, non-root service account.
3. Remove `sys_exec`, `lib_mysqludf_sys.so`, and other unsafe UDFs.
4. Restrict MySQL plugin and library directories.
5. Review the host for unauthorized SUID changes and persistence.
6. Rebuild from a trusted image if system integrity cannot be established.
7. Restore `/bin/bash` to mode `0755` and remove temporary proof artifacts.

## Validation Requirements

- Confirm `mysql -u root` cannot authenticate without a password.
- Verify `mysqld` does not run as Linux `root`.
- Confirm `sys_exec` is absent from `mysql.func` and its shared library is removed.
- Test that the database service cannot create root-owned files or execute Linux commands.
- Verify `/bin/bash` and other critical binaries have expected ownership and permissions.
