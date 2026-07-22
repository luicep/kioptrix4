#!/usr/bin/env bash
set -euo pipefail

git init -b main
git add .
git commit -m "Initial public portfolio release"
git remote add origin https://github.com/runeforged/kioptrix4.git
git push -u origin main
