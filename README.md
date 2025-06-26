# Fay iOS Project

An iOS app built in Swift and SwiftUI that demonstrates clean architecture, API integration, UI polish, and creativity based on a minimal spec. Designed as a coding exercise, this project shows judgment, attention to detail, and Swift best practices.

---

## Features

### Login
- Secure login screen using `username` and `password`
- Animated SF Symbol logo adds subtle UI delight
- Shake animation on login error
- Green check animation before transition on successful login
- Auto-focus on username field for improved UX

### Appointments Overview
- Fetches and displays real appointment data via REST API
- Current timezone used for accurate scheduling
- Custom horizontal tab picker with underline animation (Upcoming / Past)
- First upcoming appointment includes non-functional "Join Appointment" button
- Pull-to-refresh supported
- Responsive and styled per Figma design

### Chat Tab (Static UI)
- Realistic chat simulation with sent/received bubbles
- Scrollable history with timestamp section
- Disabled input field for UI demonstration

### Journal Tab (Static UI)
- Timeline of journal entries with icons, text, and clean layout
- Demonstrates potential future journaling UX

### Profile Tab (Static UI)
- Displays user info, upcoming session details, therapist info
- Clean and informative layout

---

## Architecture & Tech

- SwiftUI with MVVM-style state management
- `@Observable` and `@Bindable` (iOS 17+)
- Networking abstracted via `NetworkClient` protocol
- Animated logo and error handling
- Static previews for all views

---

## Auth Token Handling

- Token saved securely to `UserDefaults` upon login
- Automatically injected into API requests
- Future logout support can clear tokens

---

## Nice-to-Haves Implemented

- Animations (logo bounce, shake error, green check)
- Custom SF Symbol styling
- Scroll performance optimizations
- Modular and reusable components (`ChatBubble`, `ProfileRow`)
- Unit test-ready architecture (mockable network layer)
- Designed with light/dark mode support
