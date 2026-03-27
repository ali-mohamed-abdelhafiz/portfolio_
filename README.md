# Portfolio (Flutter Web)

Personal portfolio built with Flutter and deployed to Vercel.

## Local Development

Run locally:

```bash
flutter pub get
flutter run -d chrome
```

Run quality checks:

```bash
flutter analyze
flutter test
```

Build web release:

```bash
flutter build web --release
```

## Deployment (GitHub + Vercel)

This repository supports deployment from branch main.

### Vercel settings

- Framework Preset: Other
- Install Command: use value from vercel.json
- Build Command: use value from vercel.json
- Output Directory: build/web

### Git workflow

```bash
git checkout main
git pull origin main
flutter build web --release
git add vercel.json README.md test/widget_test.dart build/web
git commit -m "chore: prepare vercel web deployment"
git push origin main
```

### Post-deploy checks

- Confirm homepage loads successfully.
- Confirm deep-link refresh works (rewrite to index.html).
- Confirm static assets load without 404 errors.
