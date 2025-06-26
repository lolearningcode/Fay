# Fay iOS Project
https://www.loom.com/share/b989f9bbc71f48a280f7e1f73c1b6806?sid=edfa7dd3-d765-4a90-b0ae-92dc809415c6
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

---

## Implementation Notes

-	All networking is abstracted to allow easy mocking or swapping clients
-	Used @Observable and @Bindable to align with latest SwiftUI standards
-	The login token is securely stored in UserDefaults for session persistence
-	Static tabs (Chat, Journal, Profile) were designed to feel like functional features
-	On login success, a green check icon overlays to confirm success before transitioning
-	Error messaging is animated and accessible
-	Tabs use SF Symbols where possible, with fallback images for design consistency

⸻
## Time Breakdown
- Login screen: 2 hours
- Appointments screen: 2 hours
- Nice-to-haves: 2 hours
- Any additional time spent: 2-3 hours
