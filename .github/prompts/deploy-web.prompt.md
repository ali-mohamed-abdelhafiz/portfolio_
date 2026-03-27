---
description: "Prepare Flutter web deployment to GitHub and Vercel with exact commands and config changes"
name: "Deploy Flutter Web"
argument-hint: "Include target branch, folder strategy (web or build/web), and whether to auto-deploy on push"
agent: "Flutter Web GitHub Vercel Deployer"
---
Prepare this repository for Flutter web deployment to GitHub and Vercel.

Inputs:
- Target branch: ${input:branch|main}
- Folder strategy: ${input:folder|build/web}
- Auto deploy from GitHub: ${input:auto|yes}

Required output:
1. Selected strategy with one-line reason.
2. Exact file edits needed (for example vercel.json or ignore rules).
3. Exact git commands to add, commit, and push.
4. Vercel settings:
   - Framework preset
   - Build command
   - Output directory
5. Post-deploy validation checklist.

Constraints:
- Keep edits minimal and deployment-focused.
- Do not change app features.
- If information is missing, state assumptions explicitly.
