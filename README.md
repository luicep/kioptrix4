# Kioptrix 4 Vulnerability Assessment

**Authorized isolated-lab assessment demonstrating a verified attack path from network discovery to effective Linux root access.**

<p align="center">
  <a href="presentation/Kioptrix4-Public-Assessment.pdf">
    <img
      src="assets/previews/01-cover.png"
      alt="Kioptrix 4 Vulnerability Assessment presentation cover"
      width="100%"
    >
  </a>
</p>

<h2 align="center">
  <a href="presentation/Kioptrix4-Public-Assessment.pdf">
    View the Full Assessment Presentation
  </a>
</h2>

<p align="center">
  The primary project deliverable, documenting the assessment from initial
  discovery through effective Linux root access.
</p>

<p align="center">
  <a href="presentation/Kioptrix4-Public-Assessment.pdf">
    <img
      src="https://img.shields.io/badge/Open-Presentation_PDF-d93025?style=for-the-badge&logo=adobeacrobatreader&logoColor=white"
      alt="Open assessment presentation"
    >
  </a>
  <a href="findings/ASSESSMENT_REGISTER.md">
    <img
      src="https://img.shields.io/badge/View-Assessment_Register-0b2b4c?style=for-the-badge&logo=markdown&logoColor=white"
      alt="View complete assessment register"
    >
  </a>
  <a href="evidence/EVIDENCE_INDEX.md">
    <img
      src="https://img.shields.io/badge/Verify-Evidence_E01--E13-0b2b4c?style=for-the-badge&logo=checkmarx&logoColor=white"
      alt="Verify supporting evidence"
    >
  </a>
</p>

<br/>

<h2 align="center">Assessment Coverage</h2>

<p align="center">
  <img
    src="https://img.shields.io/badge/Assessment_Items-30-0b2b4c?style=for-the-badge"
    alt="Thirty assessment items"
  >
  <img
    src="https://img.shields.io/badge/Confirmed-17-238636?style=for-the-badge"
    alt="Seventeen confirmed findings and observations"
  >
  <img
    src="https://img.shields.io/badge/Potential_CVEs-13-6e7681?style=for-the-badge"
    alt="Thirteen potential CVE matches"
  >
</p>

<p align="center">
  <img
    src="https://img.shields.io/badge/Critical-11-d93025?style=flat-square"
    alt="Eleven critical assessment items"
  >
  <img
    src="https://img.shields.io/badge/High-5-f57c00?style=flat-square"
    alt="Five high severity assessment items"
  >
  <img
    src="https://img.shields.io/badge/Medium-11-c99700?style=flat-square"
    alt="Eleven medium severity assessment items"
  >
  <img
    src="https://img.shields.io/badge/Low_%2F_Observation-3-238636?style=flat-square"
    alt="Three low severity or observational items"
  >
</p>

<p align="center">
  <img
    src="https://img.shields.io/badge/Verified_Impact-Effective_Linux_Root-d93025?style=for-the-badge&logo=linux&logoColor=white"
    alt="Effective Linux root access verified"
  >
</p>

<p align="center">
  <sub>
    Severity totals combine confirmed items and potential CVE matches.
    Validation status is separated in the complete assessment register.
  </sub>
</p>

---

<p align="center">
  <a href="findings/ASSESSMENT_REGISTER.md">
    <strong>Review the Complete Assessment Register →</strong>
  </a>
</p>

---

## Presentation Preview

<p align="center">
  <a href="presentation/Kioptrix4-Public-Assessment.pdf">
    <img
      src="assets/previews/02-executive-summary.png"
      width="48%"
      alt="Executive summary and attack progression"
    >
  </a>
  <a href="presentation/Kioptrix4-Public-Assessment.pdf">
    <img
      src="assets/previews/03-sqli-confirmation.png"
      width="48%"
      alt="Blind SQL injection confirmation"
    >
  </a>
</p>

<p align="center">
  <a href="presentation/Kioptrix4-Public-Assessment.pdf">
    <img
      src="assets/previews/04-root-compromise.png"
      width="48%"
      alt="Root-level command execution and effective root access"
    >
  </a>
  <a href="presentation/Kioptrix4-Public-Assessment.pdf">
    <img
      src="assets/previews/05-remediation.png"
      width="48%"
      alt="Remediation and validation roadmap"
    >
  </a>
</p>

<p align="center">
  <em>Selected slides from the full assessment presentation.</em>
</p>

---

## Executive Summary

This portfolio project documents an authorized vulnerability assessment of **Kioptrix Level 4** conducted inside an isolated VirtualBox laboratory.

The assessment cataloged **30 security items**, including confirmed vulnerabilities, insecure configurations, hardening observations, and potential CVE matches.

The public presentation consolidates the primary compromise path into two critical deep-dive findings:

1. A blind SQL injection vulnerability in the login application exposed valid credentials, which were reused to obtain authenticated SSH access.
2. An insecure MySQL configuration allowed the low-privileged SSH session to execute Linux commands with root privileges and obtain an effective root shell.

These two findings were selected because they were directly validated, supported by traceable evidence, formed the primary compromise chain, and demonstrated the greatest impact.

The project demonstrates exploitation, evidence validation, negative controls, source-code root-cause analysis, business-risk communication, remediation planning, and post-remediation validation design.

---

## Assessment Workflow

<p align="center">
  <img
    src="https://img.shields.io/badge/Evidence-E01--E13-0b2b4c"
    alt="Evidence groups E01 through E13"
  >
  <img
    src="https://img.shields.io/badge/Final_Impact-Effective_Linux_Root-d93025"
    alt="Effective Linux root access verified"
  >
  <img
    src="https://img.shields.io/badge/Environment-Authorized_Isolated_Lab-0b2b4c"
    alt="Authorized isolated laboratory"
  >
</p>

| Assessment Phase | Evidence | Verified Result | Methods |
|---|:---:|---|---|
| **Reconnaissance & Enumeration** | **E01–E02** | Identified SSH, HTTP, NetBIOS, and SMB services and confirmed the exposed technology stack. | `Nmap` · `WhatWeb` · `Nikto` |
| **Web Application Testing** | **E03–E05** | Confirmed boolean-based and time-based blind SQL injection in `mypassword`. | HTTP analysis · `curl` · `sqlmap` · negative controls |
| **Credential Access** | **E06–E07** | Extracted valid credentials and authenticated to SSH as `john`. | Database enumeration · credential validation · SSH |
| **Root-Cause Analysis** | **E08–E10** | Escaped the restricted shell and identified unsafe SQL construction and excessive database privileges. | Linux enumeration · Python shell escape · source review |
| **Privilege Escalation** | **E11–E13** | Verified passwordless MySQL root access, root-owned `mysqld`, `sys_exec`, and `euid=0(root)`. | MySQL review · UDF execution · root verification |

> **Verification path:** Review the [Assessment Presentation](presentation/Kioptrix4-Public-Assessment.pdf), validate the technical claims through the [Evidence Directory](evidence/EVIDENCE_INDEX.md), and review the full inventory in the [Assessment Register](findings/ASSESSMENT_REGISTER.md).

---

## Primary Deep-Dive Findings

The presentation examines the following two validated findings in depth. They represent the primary compromise path but are not the only security items cataloged during the assessment.

| ID | Finding | Severity | Demonstrated Outcome |
|---|---|---:|---|
| [K4-001](findings/K4-001-sql-injection.md) | SQL Injection in Login Authentication | **Critical** | Credential extraction and authenticated SSH access |
| [K4-002](findings/K4-002-mysql-root-command-execution.md) | MySQL Misconfiguration Enabling Root-Level Command Execution | **Critical** | Root-level command execution and a shell with `euid=0(root)` |

For the complete inventory of confirmed findings, observations, and potential CVE matches, review the [Kioptrix 4 Assessment Register](findings/ASSESSMENT_REGISTER.md).

---

## Supporting Project Resources

| Resource | Purpose |
|---|---|
| [Assessment Register](findings/ASSESSMENT_REGISTER.md) | Complete inventory of 30 confirmed items, observations, and potential CVE matches |
| [Evidence Directory](evidence/EVIDENCE_INDEX.md) | Maps presentation claims E01–E13 to testing objectives, commands, sanitized screenshots, transcripts, results, limitations, and related findings |
| [K4-001 Detailed Finding](findings/K4-001-sql-injection.md) | Complete analysis of the SQL injection, credential disclosure, and authenticated SSH access path |
| [K4-002 Detailed Finding](findings/K4-002-mysql-root-command-execution.md) | Complete analysis of the MySQL misconfiguration and root-command-execution path |
| [Scope and Authorization](docs/SCOPE_AND_AUTHORIZATION.md) | Documents assessment ownership, boundaries, isolation, and safety controls |
| [Evidence Handling](docs/EVIDENCE_HANDLING.md) | Explains artifact preservation, sanitization, and public-release procedures |
| [Comparable Incidents](references/comparable-incidents.md) | Provides authoritative sources for the presentation’s documented business-impact comparisons |

---

## Evidence Handling

Original assessment artifacts are preserved privately.

The public repository contains sanitized copies with credentials, password values, and session identifiers redacted. Private RFC 1918 laboratory addresses are retained for technical traceability.

Presentation exhibits were reconstructed from the original terminal evidence for readability and visual consistency. They do not replace the screenshots and transcripts referenced in the [Evidence Directory](evidence/EVIDENCE_INDEX.md).

See [Evidence Handling](docs/EVIDENCE_HANDLING.md) for the complete policy.

---

## Scope and Authorization

All testing was performed against intentionally vulnerable systems owned and controlled by the assessor inside an isolated laboratory environment.

No testing was conducted against public, production, or third-party systems.

The techniques documented in this repository must not be used against systems without explicit authorization.

---

## Repository

**GitHub:** https://github.com/luicep/kioptrix4
