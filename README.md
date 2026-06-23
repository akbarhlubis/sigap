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
- **Mesh Network SOS (BLE Mesh)**: Broadcast distress beacon alerts locally when cellular grids fail, using native platform bridges.
- **Voice-Guided Resuscitation**: Text-to-speech integration to read step-by-step actions aloud during rescue maneuvers.
- **Symptom Triage AI**: Offline lightweight classification model to suggest potential matching categories based on user inputs.

---

## 🔗 Key References & Sources

To ensure maximum safety, technical compliance, and reliability, **SIGAP** references the following sources:

### 🚑 Emergency & Medical Guidelines
- **First Aid Guidelines**: Based on the [American Heart Association (AHA) CPR & ECC Guidelines](https://eccguidelines.heart.org/) and the [International Federation of Red Cross (IFRC) First Aid Reference](https://www.referencecentrefirstaid.org/).
- **Kemenkes RI**: Localized emergency procedures aligned with guidelines from the [Kementerian Kesehatan Republik Indonesia (Kemenkes)](https://sehatnegeriku.kemkes.go.id/).
- **Palang Merah Indonesia (PMI)**: Standardized training pathways and competencies based on the [PMI Emergency Response Certification Area](https://www.pmi.or.id/training-certification/certification-area/emergency-response).

### 📶 Bluetooth Mesh Research & Offline P2P
For our offline mesh roadmap, we studied the open-source BLE mesh implementation by **PermissionlessTech**:
- **iOS/macOS Swift Implementation**: [permissionlesstech/bitchat](https://github.com/permissionlesstech/bitchat) - Native `CoreBluetooth` mesh with multi-hop flood routing, Noise XX handshake encryption, and MTU fragmentation.
- **Android Kotlin Implementation**: [permissionlesstech/bitchat-android](https://github.com/permissionlesstech/bitchat-android) - Native Kotlin BLE stack utilizing Nordic Semiconductor's `Android-BLE-Library` for robust background mesh services.

### 💙 Flutter & Material 3 Best Practices
- **Flutter Internationalization (l10n)**: Follows the official [Flutter Localization Guide](https://docs.flutter.dev/accessibility-and-localization/internationalization) utilizing native ARB catalog generation.
- **Material 3 Specifications**: High-contrast layout principles based on [Material 3 Accessibility Specs](https://m3.material.io/).
- **Flutter Performance Guide**: Guidelines followed to optimize painter redraws during CPR visuals [Flutter Performance Best Practices](https://docs.flutter.dev/perf/best-practices).

---

## ❤️ Acknowledgments & Appreciation
- **PermissionlessTech (BitChat Contributors)**: Deep appreciation to the developers of BitChat for open-sourcing their dual-transport mesh architecture. Their native CoreBluetooth and Nordic BLE implementations provided critical insights for our offline mesh engineering path.
- **Palang Merah Indonesia (PMI)**: Sincere thanks for their public education resources, community training modules (MTDB, SATGANA), and national competency certification standards.
- **Medical Professionals & First Responders**: Sincere gratitude to all doctors, nurses, and emergency dispatchers who dedicate their lives to emergency response.


