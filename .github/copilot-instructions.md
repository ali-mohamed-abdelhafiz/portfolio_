# Project Guidelines

## Scope
- This repository is a Flutter portfolio app.
- Prefer targeted changes in lib and web unless the task explicitly requires platform folders.

## Code Style
- Follow existing Dart style and structure already present in lib.
- Keep widgets readable and avoid large refactors in unrelated files.
- Prefer clear names and small, focused edits.

## Build And Validation
- Use flutter analyze for static checks when code changes are made.
- Use flutter test for unit and widget tests when relevant.
- Use flutter build web for web deployment checks.

## Deployment Conventions
- For Vercel deployment tasks, keep configuration explicit and reproducible.
- State expected Vercel build command and output directory in responses.
- Provide exact git commands for branch-based deployment workflows.

## Safety
- Avoid destructive git operations.
- Do not revert unrelated user changes.
