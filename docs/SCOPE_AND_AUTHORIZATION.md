# Scope and Authorization

## Assessment Type

Independent vulnerability assessment conducted in an authorized, isolated cybersecurity laboratory.

## In-Scope Systems

- Kioptrix Level 4 target virtual machine
- Kali Linux assessment virtual machine
- Isolated VirtualBox network in the `192.168.77.0/24` RFC 1918 address space

## Out-of-Scope Systems

- Public internet systems
- Home-network devices
- Third-party infrastructure
- Any system not intentionally placed in the lab

## Safety Controls

- Target and attacker were isolated from the public internet during testing.
- Testing was limited to systems controlled by the assessor.
- Public artifacts redact credentials and session identifiers.
- Private IP addresses are retained because they identify only the isolated lab topology.

## Testing Objective

Identify, validate, document, and remediate vulnerabilities while preserving sufficient evidence for independent technical review.
