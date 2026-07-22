# Publish This Portfolio to GitHub

The repository is prepared for this final URL:

`https://github.com/runeforged/kioptrix4`

## 1. Create the empty GitHub repository

1. Sign in to GitHub as **runeforged**.
2. Select **New repository**.
3. Repository name: **kioptrix4**
4. Description: `Authorized isolated-lab vulnerability assessment from SQL injection to root-level command execution.`
5. Set visibility to **Public**.
6. Do **not** initialize it with a README, `.gitignore`, or license because those files already exist in this package.
7. Create the repository.

## 2. Push this folder with Git

Open a terminal inside the extracted `kioptrix4` folder and run:

```bash
git init -b main
git add .
git commit -m "Initial public portfolio release"
git remote add origin https://github.com/runeforged/kioptrix4.git
git push -u origin main
```

GitHub will prompt you to authenticate if your computer is not already connected.

## 3. Configure the repository page

Recommended topics:

`cybersecurity`, `vulnerability-assessment`, `penetration-testing`, `sql-injection`, `mysql`, `linux`, `security-portfolio`

Recommended About text:

`Authorized Kioptrix 4 lab assessment with evidence-backed SQL injection, credential reuse, MySQL privilege escalation, and root-access verification.`

## 4. Verify before using the QR code

Open each of these URLs:

- `https://github.com/runeforged/kioptrix4`
- `https://github.com/runeforged/kioptrix4/blob/main/evidence/EVIDENCE_INDEX.md`
- `https://github.com/runeforged/kioptrix4/blob/main/presentation/Kioptrix4-Public-Assessment.pdf`

Then scan `assets/github-repository-qr.png` with a phone.

## 5. Final presentation replacement

After the repository is live, replace the PDF in `presentation/Kioptrix4-Public-Assessment.pdf` with the final version containing the working QR code and hyperlinks, then commit and push the replacement.
