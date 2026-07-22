# Kioptrix 4 Vulnerability Assessment

**Authorized isolated-lab security assessment demonstrating a complete attack path from network discovery to effective Linux root access.**

[![Public Report](https://img.shields.io/badge/Public_Report-PDF-0b2b4c)](presentation/Kioptrix4-Public-Assessment.pdf)
[![Evidence Index](https://img.shields.io/badge/Evidence-E01--E13-d93025)](evidence/EVIDENCE_INDEX.md)
[![Findings](https://img.shields.io/badge/Findings-K4--001_%7C_K4--002-0b2b4c)](findings/)

## Project Overview

This portfolio project documents a vulnerability assessment performed against **Kioptrix Level 4** in an isolated VirtualBox lab. Testing identified a remotely reachable SQL injection flaw, credential disclosure and reuse, restricted-shell access, unsafe application database configuration, and a MySQL privilege-escalation path that produced effective root access.

The project is organized for two audiences:

- **Recruiters and hiring managers:** start with the public report and README.
- **Technical reviewers:** use the Evidence Index to trace every major claim to sanitized screenshots, transcripts, and detailed findings.

## Verified Attack Path

`Discovery -> Web Enumeration -> SQL Injection -> Credential Extraction -> SSH Access -> Shell Escape -> MySQL Misconfiguration -> Root Command Execution -> Effective Root Shell`

## Primary Findings

| ID | Finding | Severity | Demonstrated Outcome |
|---|---|---:|---|
| [K4-001](findings/K4-001-sql-injection.md) | SQL Injection in Login Authentication | Critical | Credential extraction and authenticated SSH access |
| [K4-002](findings/K4-002-mysql-root-command-execution.md) | MySQL Misconfiguration Enabling Root-Level Command Execution | Critical | Root command execution and `euid=0(root)` shell |

## Repository Navigation

| Resource | Purpose |
|---|---|
| [Public Assessment Report](presentation/Kioptrix4-Public-Assessment.pdf) | Polished presentation covering scope, evidence, impact, comparable incidents, and remediation |
| [Evidence Directory](evidence/EVIDENCE_INDEX.md) | Central verification layer mapping E01-E13 to objectives, commands, screenshots, transcripts, results, limitations, and findings |
| [Detailed Findings](findings/) | Professional finding writeups with root cause, impact, remediation, and validation requirements |
| [Scope & Authorization](docs/SCOPE_AND_AUTHORIZATION.md) | Lab boundaries, authorization, and safety controls |
| [Evidence Handling](docs/EVIDENCE_HANDLING.md) | Redaction, preservation, and public-release rules |
| [Comparable Incidents](references/comparable-incidents.md) | Authoritative sources supporting the executive business-impact slide |

## Evidence Traceability

`Presentation Claim -> Evidence ID -> GitHub Evidence Entry -> Sanitized Screenshot or Transcript -> Detailed Finding`

Evidence ranges:

- **E01-E02:** Reconnaissance and service enumeration
- **E03-E05:** Login mapping and SQL injection validation
- **E06-E07:** Credential extraction and SSH access
- **E08-E10:** Shell escape, privilege baseline, and root-cause analysis
- **E11-E13:** MySQL escalation and root-access verification

## Skills Demonstrated

- Network and service enumeration
- Web application testing
- SQL injection validation with positive and negative controls
- Database enumeration and credential analysis
- SSH authentication testing
- Linux post-exploitation and privilege baselining
- Source-code root-cause analysis
- MySQL security configuration review
- Evidence handling and technical reporting
- Executive risk communication and remediation planning

## Evidence Handling

Original artifacts are preserved privately. The public repository contains sanitized copies with credentials and session identifiers redacted. Private RFC 1918 lab addresses are retained for technical traceability. See [Evidence Handling](docs/EVIDENCE_HANDLING.md).

## Authorization

All testing was performed against intentionally vulnerable systems owned and controlled by the assessor in an isolated laboratory. Do not use these techniques against systems without explicit authorization.

## Repository URL

https://github.com/runeforged/kioptrix4
