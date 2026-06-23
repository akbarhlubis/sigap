# SIGAP 🚑
**Sistem Informasi & Panduan Gawat Darurat**  
*An interactive, offline-first first-aid assistant designed to help ordinary people respond correctly during emergency situations.*

---

## 🌟 Core Product Vision
During high-stress medical emergencies, reading long articles is counter-productive. **SIGAP** addresses this by providing a clean, **decision-tree based interactive flow** that walks users through emergency procedures one step at a time with minimal text, large touch targets, and procedural animations.

---

## 🛠️ Tech Stack & Features

- **Framework**: Flutter (Dart 3.x, Null-Safety)
- **Design Language**: Material 3 (Calming Teal/Slate palette, high-contrast, optimized for accessibility and quick touch interactions)
- **Architecture**: Clean Architecture / Feature-First Directory Layout
- **Offline-First**: All emergency guidelines and contact information are stored locally in a unified multi-language JSON database (`assets/data/emergency_guides.json`).
- **Standard Localization (`l10n`)**: Fully supports **Bahasa Indonesia** (Default) and **English** via native translation catalogs.

### MVP Features Implemented:
1. **Safety Disclaimer Gate**: Full-screen modal on first launch requiring users to accept the medical disclaimer before entering. Status is stored locally in `SharedPreferences`.
2. **Interactive Emergency Flows**: 10 distinct emergency guides (Choking, Fainting, Bleeding, Burns, Electric Shock, Seizures, Heart Attack, Stroke, Animal Bites, Fractures). Features a step-by-step decision-tree player with large stacked buttons.
3. **Procedural Illustrations**: Flat-vector schematic animations custom-painted on the canvas (using Flutter `CustomPainter`) to illustrate CPR, Heimlich maneuver, recovery position, direct pressure, and leg elevation offline without heavy assets.
4. **Emergency Calls (SOS Center)**: Direct dialing for Ambulance, Police, and Fire services. Supports country presets (ID, US, UK) and a one-tap GPS coordinates copier to easily share your location with dispatchers.
5. **CPR Assistant**: Standalone tool providing a visual pulsing compression circle and system-level rhythmic metronome beep set at **110 BPM** (the target CPR compression rate). Includes a session timer and compression counter.
6. **Educational Library (Learn)**: Curated guides on Disaster Preparedness, Kit Packing lists, Injury Prevention, and First Aid Principles.
7. **Profile & Settings**: Dynamic theme switcher (Dark/Light mode), dynamic language selector, database size statistics, and a debug reset for the onboarding disclaimer.

---

## 📂 Project Directory Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── colors.dart           # Palette (Teal, Slate, Crimson)
│   └── theme.dart                # Material 3 Light/Dark Theme configurations
├── models/
│   └── emergency_models.dart     # Category and decision-tree node data structures
├── services/
│   └── emergency_service.dart    # Caching Local JSON asset loader
├── shared/
│   └── widgets/
│       ├── disclaimer_gate.dart  # Acceptance onboarding screen
│       └── navigation_shell.dart # Bottom Navigation bar controller
├── features/
│   ├── emergency_flows/
│   │   └── screens/
│   │       ├── home_screen.dart  # Emergency categories grid and search
│   │       └── flow_screen.dart  # Step-by-step guidance player & visual painters
│   ├── emergency_calls/
│   │   └── screens/
│   │       └── calls_screen.dart # One-tap dials and clipboard GPS share
│   ├── cpr_assistant/
│   │   └── screens/
│   │       └── cpr_screen.dart   # Audio-visual metronome pulsing at 110 BPM
│   ├── learning/
│   │   └── screens/
│   │       └── learning_screen.dart # Expandable first aid checklist articles
│   └── profile/
│       └── screens/
│           └── profile_screen.dart  # Language, theme, and diagnostic settings
└── main.dart                     # App entry point, locale, and theme states
```

---

## 🚀 Running the App Locally

### 1. Prerequisites
Ensure you have the Flutter SDK installed. If you are using the pre-configured local SDK, add the binary path to your system:
- **Flutter path**: `D:\flutter\bin`

### 2. Fetch Dependencies & Generate Platform Wrappers
Initialize configuration files, fetch packages, and generate code-binding assets:
```bash
# Generate native wrappers (Android, iOS, Web)
flutter create --org com.sigap .

# Fetch package dependencies
flutter pub get

# Generate localized translation catalogs
flutter gen-l10n
```

### 3. Local Web Server Testing
Since Android Emulator or Developer Mode symlinks might require administrative access on Windows, we utilize a **mobile web testing workflow**:

1. Compile the production web assets:
   ```bash
   flutter build web
   ```
2. Serve the build directory locally using Node.js:
   ```bash
   npx http-server build/web -p 8080
   ```
3. Test on your mobile phone:
   - Ensure your PC and phone are connected to the **same Wi-Fi network**.
   - Open your mobile phone browser (Chrome/Safari) and go to:
     👉 **`http://10.72.230.126:8080`** *(using your PC's local Wi-Fi IP address)*

---

## 🔮 Future Roadmap (Non-MVP)
- **Offline Hospital Locator**: Search and navigate to nearby ER stations without an internet connection using cached coordinates.
- **Mesh Network SOS**: Utilize Bluetooth Mesh or Wi-Fi Direct to broadcast local distress beacon alerts when cellular grids fail.
- **Voice-Guided Resuscitation**: Text-to-speech integration to read step-by-step actions aloud during rescue maneuvers.
- **Symptom Triage AI**: Offline lightweight classification model to suggest potential matching categories based on user inputs.
