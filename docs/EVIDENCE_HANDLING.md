# Evidence Handling and Public Release

## Authoritative Evidence

The untouched screenshots and raw notes captured during testing are retained privately. They are the authoritative source artifacts.

## Public Evidence

The GitHub repository contains sanitized copies of selected screenshots and transcripts. Public copies preserve the commands, results, timestamps, application behavior, and technical context needed to validate the findings.

## Redactions

The following values are removed from public artifacts:

- Password values
- Session identifiers
- Any secret that could be reused outside the lab

The following values are retained:

- RFC 1918 private lab addresses
- Lab usernames such as `john` and `robert`
- Target hostnames
- Commands and outputs required to understand the findings

## Presentation Exhibits

Some presentation terminal panels were reconstructed from the source evidence for readability and consistent formatting. Reconstructed exhibits do not replace the corresponding screenshots and transcripts in the Evidence Directory.

## Integrity

`evidence/manifest.csv` maps evidence IDs to public files and supported claims. `evidence/checksums/SHA256SUMS.txt` contains hashes for the public evidence artifacts included in this release.
