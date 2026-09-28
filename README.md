📝 To-Do App

A modern and clean To-Do mobile application built with Flutter & Dart, designed to provide a simple task-management experience while applying structured architecture, state management, and Firebase integration.

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?logo=firebase&logoColor=black" />
  <img src="https://img.shields.io/badge/BLoC-Cubit-blueviolet" />
  <img src="https://img.shields.io/badge/Architecture-Layered-success" />
</p>---

📱 Preview

<p align="center">
  <img src="screenshots/login.png" width="220"/>
  <img src="screenshots/home.png" width="220"/>
  <img src="screenshots/add_task.png" width="220"/>
  <img src="screenshots/task_details.png" width="220"/>
</p>---

✨ Features

🔐 Authentication

- User registration
- User login
- Authentication state handling
- Secure user-specific data access

📋 Task Management

- Create new tasks
- Edit existing tasks
- Delete tasks
- Organize tasks by date
- Manage task status

🎨 User Interface

- Clean and modern UI
- Responsive layouts
- Reusable Flutter widgets
- Smooth user interactions
- Consistent design system

☁️ Cloud Integration

- Firebase Authentication
- Cloud Firestore
- Real-time data synchronization
- User-specific task data

---

🛠️ Tech Stack

Technology| Usage
Flutter| Mobile application development
Dart| Programming language
Firebase Authentication| User authentication
Cloud Firestore| Cloud database
Cubit / BLoC| State management
Layered Architecture| Code organization

---

🏗️ Architecture

The project follows a Layered Architecture to separate responsibilities and keep the code organized, maintainable, and easier to extend.

┌──────────────────────────────┐
│        Presentation         │
│                              │
│  Screens • Widgets • Cubit  │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│        Business Logic        │
│                              │
│     Application Logic        │
│     State Management         │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│            Data              │
│                              │
│ Firebase Auth • Firestore    │
│ Models • Data Sources        │
└──────────────────────────────┘
---
Application Flow

User
 │
 ▼
Flutter UI
 │
 ▼
Cubit / BLoC
 │
 ▼
Application Logic
 │
 ▼
Data Layer
 │
 ├── Firebase Authentication
 │
 └── Cloud Firestore

---

🎥 Demo

<p align="center">
  <img src="assets/demo.gif" width="300"/>
</p>«A short demonstration of the main application flow and task-management features.»

---

📸 Screenshots

🔐 Authentication

<p align="center">
  <img src="screenshots/login.png" width="250"/>
  <img src="screenshots/signup.png" width="250"/>
</p>🏠 Home

<p align="center">
  <img src="screenshots/home.png" width="250"/>
</p>➕ Add Task

<p align="center">
  <img src="screenshots/add_task.png" width="250"/>
  <img src="screenshots/task_details.png" width="250"/>
</p>---

🎯 What I Practiced

This project helped me strengthen my understanding of:

- Flutter UI development
- State management with Cubit
- Firebase integration
- Authentication
- CRUD operations
- Cloud Firestore
- Layered Architecture
- Reusable widgets
- Managing application states
- Connecting UI with business logic and data

---

🚀 Getting Started

1. Clone the repository

git clone <repository-url>

2. Navigate to the project

cd todo_app

3. Install dependencies

flutter pub get

4. Configure Firebase

Connect the project to your Firebase project and add the required Firebase configuration files.

5. Run the application

flutter run

---

📌 Future Improvements

- 🔔 Local notifications for task reminders
- 🌙 Dark mode
- 🔎 Task search and filtering
- 📊 Task statistics
- 🔄 Offline support

---

👨‍💻 Author

Ahmed

Flutter Developer | Mobile Application Development

---

<p align="center">
  Built with 💙 using Flutter
</p>
