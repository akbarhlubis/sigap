# SIGAP Project Rules & Agent Instructions

This document provides project-scoped rules and environment configurations for AI agents working on the **SIGAP** (first-aid assistant) project.

---

## Project Context
- **Name**: SIGAP (Sistem Informasi & Panduan Gawat Darurat)
- **Primary Language**: Default is **Bahasa Indonesia** (`id`), with support for **English** (`en`).
- **Localization**: Uses standard Flutter localization. Do NOT use synthetic packages. Generated files are written directly to `lib/l10n/app_localizations.dart`.
- **Target Platform**: Android & Responsive Mobile-first Web.
- **Design system**: Material 3, high-contrast, calm blue-green tones, with large touch targets suited for high-stress emergency environments.

---

## Environment & Path Configuration
- **Flutter SDK Location**: `D:\flutter\bin\flutter.bat` (Add to PATH for active sessions).
- **Node.js**: Installed (v22.12.0 is active).

---

## Local Development & Testing Strategy
Because the Android SDK toolchain and Developer Mode symlinks might not be fully configured, we utilize a **mobile web testing workflow**:

1. **Build the Web Target**:
   ```bash
   flutter build web
   ```
2. **Launch the Local Web Server** (using Node.js `npx`):
   ```bash
   npx http-server build/web -p 8080
   ```
3. **Mobile Browser Testing**:
   - Both PC and Android device must be on the same Wi-Fi network.
   - **Local Host IP**: `10.72.230.126`
   - Open this URL in the phone's browser (Chrome/Safari):
     👉 **`http://10.72.230.126:8080`**

---

## Codebase Architecture
Maintain the feature-first directory layout:
- `lib/core/constants/colors.dart` - Brand palette (Teal, Slate, warning colors).
- `lib/core/theme.dart` - Material 3 theme.
- `lib/models/emergency_models.dart` - Interactive decision-tree schemas.
- `lib/services/emergency_service.dart` - Local JSON loader.
- `assets/data/emergency_guides.json` - Unified localized guides database.
- `lib/shared/widgets/disclaimer_gate.dart` - Onboarding disclaimer.
- `lib/shared/widgets/navigation_shell.dart` - Main bottom navigation.
