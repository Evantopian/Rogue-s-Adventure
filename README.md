# Rogue's Adventure

Rogue's Adventure is a 2D deck-building RPG built in Flutter, incorporating Firebase for authentication, PostgreSQL for data persistence, and Flame for game rendering. It features turn-based battles, strategic card usage, and RPG-style progression through various stages and levels.

## 🧑‍💻 Team

* Evan Huang
* Ryan Jiang
* Wen Bin Lin

---

## 🚀 Features

* 🔒 **User Authentication** via Firebase
* 🗺️ **World Map & Stage Selector**: Players navigate a branching path of levels.
* ⚔️ **Battle System**: Card-based combat against AI enemies.
* 🏕️ **Camp Screen**: Recover and plan between battles.
* 🎴 **Deck Building**: Collect cards and build custom decks.
* 🎨 **Dynamic UI/UX**: Designed in Figma and implemented with Flutter.
* 🧪 **Full Testing Coverage**: Includes unit, widget, and integration tests.

---

## 📦 Dependencies

### Core Packages

* `firebase_auth` – User authentication
* `firebase_core` – Required to initialize Firebase
* `http` / `dio` – Networking and API calls
* `postgres` – Connects to PostgreSQL databases
* `test` – Dart testing framework

### Game & Utility

* `flame` – 2D game engine for rendering and input handling
* `flutter_dotenv` – Environment variable management

### Backend / Server

* `shelf` – Middleware-based server framework
* `shelf_router` – URL routing
* `shelf_test_handler` – Server testing utility

---

## 🧠 Architecture

### Frontend (Flutter)

* **Screens**:

  * Menu (Login / Signup)
  * Home (Play / Settings / Quit)
  * Stage Selector
  * Battle, Result, Camp
* **Assets**: Custom-designed player, enemy, card, and background graphics
* **Navigation**: Routed using Flutter Navigator

### Backend (Dart + Shelf)

* **Handlers**:

  * Player CRUD
* **Database**:

  * Local: PostgreSQL
  * Production: Google Cloud SQL (Postgres)
* **Sync**:

  * Local ↔ Cloud via Cloud Functions + Proxy

### Models

* Player
* Enemy
* Cards
* Decks
* Stages
* Levels
* Events

---

## 🧪 Testing & Deployment

* **Platform**: Tested on Android 11 (Pixel 5, API Level 30)
* **Distribution**: APK distributed to trusted beta users
* **Cloud Functions**: Used to process and synchronize user/game data

---

## 🗃️ Database Schema (SQL DBM)

Tables:

* `Player`
* `Card`
* `Deck`
* `Enemy`
* `Stage`
* `Level`

Each with relevant foreign key constraints to support scalable relational modeling.

---

## 🧩 Game Mechanics

* Experience-based level generation
* Card-based attack system: damage, energy, health cost
* AI-driven enemy combat
* Card rewards based on battle outcome
* Deck editing between battles

---

## 📁 Project Setup

1. Clone the repo.
2. Set up `.env` for Firebase & Postgres credentials.
3. Run local PostgreSQL and apply migrations (see `/db/migrations.sql`)
4. Build and run Flutter app:

   ```bash
   flutter pub get
   flutter run
   ```

---
