# doctor_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

flutter build web

# crear rama 
git checkout -b gh-pages
# si ya existe
git checkout gh-pages

# Elimina todo (excepto .git) en la carpeta del repo
Get-ChildItem -Exclude .git, .github, .gitignore -Recurse | Remove-Item -Recurse -Force


# rama principal
git branch
flutter build web
Remove-Item docs -Recurse -Force
xcopy .\build\web .\docs /E /H /C /I
git add docs
git commit -m "Add web build to docs"
git push origin main
