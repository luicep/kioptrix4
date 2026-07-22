# Kioptrix 4 Assessment Register

This register documents all **30 security items** cataloged during the authorized Kioptrix 4 laboratory assessment, including confirmed vulnerabilities, insecure configurations, security observations, and potential CVE matches.

## Assessment Summary

The public presentation examines **two critical findings in depth** because they were directly validated, supported by traceable evidence, formed the primary compromise path, and demonstrated the greatest impact.

The remaining items are retained here to provide complete assessment coverage. Potential CVE matches were identified through component-version research but were not treated as confirmed vulnerabilities.

| Assessment Category | Critical | High | Medium | Low / Observation | Total |
|---|---:|---:|---:|---:|---:|
| **Confirmed findings and observations** | **9** | **1** | **5** | **2** | **17** |
| **Potential CVE matches** | **2** | **4** | **6** | **1** | **13** |
| **Total assessment items** | **11** | **5** | **11** | **3** | **30** |

| Key Result | Outcome |
|---|---|
| Detailed findings presented | **2** |
| Verified final impact | **Effective Linux root access** |

## Project Resources

| Resource | Purpose |
|---|---|
| [**Assessment Presentation**](../presentation/Kioptrix4-Public-Assessment.pdf) | Evidence-backed findings, business impact, and remediation priorities |
| [**Evidence Directory**](../evidence/EVIDENCE_INDEX.md) | Supporting screenshots, commands, transcripts, and evidence references |
| [**K4-001: SQL Injection**](K4-001-sql-injection.md) | SQL injection, credential disclosure, and authenticated SSH access |
| [**K4-002: MySQL Root Command Execution**](K4-002-mysql-root-command-execution.md) | MySQL misconfiguration chain resulting in effective Linux root access |

> **Validation note:** **Confirmed / Exploited** items were directly used in the demonstrated compromise, while **Confirmed** items were independently observed or tested. **Potential** and **Conditional** entries remain unverified version- or configuration-based matches. **Observation** identifies exposure or hardening risk rather than demonstrated exploitability.

---

## Complete Assessment Register

| ID | Type | Finding | Affected Component / Location | Score / Mapping | Severity | Status in Lab | Reference |
|---:|---|---|---|---|---|---|---|
| **001** | Non-CVE | Root-level command execution through MySQL `sys_exec` | MySQL UDF `sys_exec` | Misconfiguration | **Critical** | Confirmed / Exploited | N/A |
| **002** | Non-CVE | MySQL service running as Linux root | `mysqld --user=root` | CWE-250 | **Critical** | Confirmed / Exploited | N/A |
| **003** | Non-CVE | MySQL root account with blank password | Local MySQL service | CWE-521 / CWE-798 | **Critical** | Confirmed / Exploited | N/A |
| **004** | Non-CVE | SQL injection in login form | `/checklogin.php`, parameter `mypassword` | CWE-89 | **Critical** | Confirmed / Exploited | N/A |
| **005** | Non-CVE | Authentication bypass through SQL injection | Login form | CWE-89 / CWE-287 | **Critical** | Confirmed / Exploited | N/A |
| **006** | Non-CVE | Web application uses MySQL root account | `/var/www/checklogin.php` | CWE-250 / CWE-798 | **Critical** | Confirmed | N/A |
| **007** | Non-CVE | Hardcoded database credentials | `/var/www/checklogin.php` | CWE-798 | **Critical** | Confirmed | N/A |
| **008** | Non-CVE | Plaintext passwords stored in database | `members.members` table | CWE-256 / CWE-522 | **Critical** | Confirmed | N/A |
| **009** | Non-CVE | Exposed database backup file | `/database.sql` | CWE-200 / CWE-538 | **Critical** | Confirmed | N/A |
| **010** | CVE | CVE-2012-1182: Samba RPC remote code execution | Samba 3.0.28a | CVSS v2: 10.0 / CVSS v3: 9.8 | **Critical** | Potential; not exploited | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2012-1182) |
| **011** | CVE | CVE-2012-1823: PHP-CGI remote code execution | PHP 5.2.4 | CVSS v3: 9.8 / CVSS v2: 7.5 | **Critical** | Conditional on PHP-CGI usage | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2012-1823) |
| **012** | Non-CVE | Outdated and unsupported software stack | Ubuntu 8.04, Apache, PHP, MySQL, and Samba | Unsupported software risk | **High** | Confirmed | N/A |
| **013** | CVE | CVE-2011-3192: Apache Range header denial of service | Apache 2.2.8 | CVSS v2: 7.8 | **High** | Potential; not exploited | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2011-3192) |
| **014** | CVE | CVE-2009-2692: Linux kernel local privilege escalation | Linux kernel 2.6.24 | CVSS v3: 7.8 / CVSS v2: 7.2 | **High** | Potential; not exploited | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2009-2692) |
| **015** | CVE | CVE-2010-3904: Linux kernel RDS local privilege escalation | Linux kernel 2.6.24 | CVSS v3: 7.8 / CVSS v2: 7.2 | **High** | Potential; not exploited | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2010-3904) |
| **016** | CVE | CVE-2009-1185: `udev` local privilege escalation | `udev` / Ubuntu 8.04-era component | CVSS v2: 7.2 | **High** | Potential; not exploited | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2009-1185) |
| **017** | CVE | CVE-2008-2364: Apache `mod_proxy` denial of service | Apache 2.2.8 | CVSS v2: 5.0 | **Medium** | Conditional on `mod_proxy` being enabled | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2008-2364) |
| **018** | CVE | CVE-2011-0719: Samba denial of service | Samba 3.0.28a | CVSS v2: 5.0 | **Medium** | Potential; not exploited | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2011-0719) |
| **019** | CVE | CVE-2010-1635: Samba `smbd` denial of service | Samba 3.0.28a | CVSS v2: 5.0 | **Medium** | Potential; not exploited | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2010-1635) |
| **020** | CVE | CVE-2008-4097: MySQL privilege-check bypass | MySQL 5.0.51a | CVSS v2: 4.6 | **Medium** | Potential; not exploited | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2008-4097) |
| **021** | CVE | CVE-2011-3607: Apache `mod_setenvif` local privilege issue | Apache 2.2.x | CVSS v2: 4.4 | **Medium** | Potential; not exploited | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2011-3607) |
| **022** | CVE | CVE-2007-4887: PHP `dl()` denial of service | PHP 5.2.4 | CVSS v2: 4.3 | **Medium** | Potential; not exploited | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2007-4887) |
| **023** | Non-CVE | SMB signing disabled | SMB on ports `139/tcp` and `445/tcp` | Weak SMB configuration | **Medium** | Confirmed | N/A |
| **024** | Non-CVE | HTTP TRACE enabled | Apache web server | CWE-16 | **Medium** | Confirmed | N/A |
| **025** | Non-CVE | Directory indexing enabled | `/icons/`, `/images/` | CWE-548 | **Medium** | Confirmed | N/A |
| **026** | Non-CVE | Missing `X-Frame-Options` header | HTTP response headers | CWE-1021 | **Medium** | Confirmed | N/A |
| **027** | Non-CVE | Session cookie missing `HttpOnly` flag | `PHPSESSID` cookie | CWE-1004 | **Medium** | Confirmed | N/A |
| **028** | Non-CVE | PHP version disclosure | `X-Powered-By: PHP/5.2.4` | CWE-200 | **Low / Medium** | Confirmed | N/A |
| **029** | CVE | CVE-2008-5161: OpenSSH CBC plaintext-recovery weakness | OpenSSH 4.7p1 | CVSS v3: 3.7 / CVSS v2: 2.6 | **Low** | Potential; not exploited | [NVD](https://nvd.nist.gov/vuln/detail/CVE-2008-5161) |
| **030** | Non-CVE | SSH exposed to network | Port `22/tcp` | Attack-surface exposure | **Low** | Confirmed observation | N/A |

---

## Authorization Notice

All testing was performed against intentionally vulnerable systems owned and controlled by the assessor inside an isolated laboratory environment.

No testing was conducted against public, production, or third-party systems.
