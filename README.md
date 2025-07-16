# 🚀 SwiftUI Navigation Demo App

A comprehensive SwiftUI demo showcasing modern navigation patterns — all designed to be **iOS 15+ compatible**. This project blends **root-level routing**, **tab navigation**, and **traditional `NavigationView` flows** into a cohesive and production-ready architecture.

---

## ✅ Features

### 1. Root-Level Navigation (App-Wide Routing)
- `ViewRouter` to manage global navigation state
- Supports `Splash → Sign In/Sign Up → Main App`
- Persistent authentication via `@AppStorage`
- Smooth route transitions (e.g. slide in/out)

### 2. Tab Navigation (Multi-Stack)
- Bottom `TabView` with 4 sections: **Home**, **Search**, **Favorites**, **Profile**
- Each tab maintains its **independent navigation stack**

### 3. Traditional Navigation (iOS 15 Compatible)
- Uses `NavigationView` and `NavigationLink`
- Push/pop navigation for:
  - Detail views
  - Settings screens
  - Form flows

### 4. Complete Screen Flows

#### 🔐 Authentication
- Splash screen with loading state
- Sign In (demo credentials included)
- Sign Up with basic validation

#### 📱 Main App Tabs
- **Home**: Grid layout with categories & featured items
- **Search**: Search bar with result navigation
- **Favorites**: Swipe-to-delete favorites list
- **Profile**: Access settings and user options

#### 🧩 Detail & Settings Views
- `DetailView`, `CategoryView`, `SearchResultView`, `FavoriteDetailView`
- Profile Settings: Edit Profile, Notifications, Privacy, Help, About

---

## 📦 Architecture Overview

### 🔁 ViewRouter-Based Routing

```swift
enum Roots {
    case initial, signIn, signUp, bottomTab
}

Switch root view with:

router.currentRoot = .signIn

🧭 Traditional NavigationView

Used for standard view transitions (iOS 15+ compatible):

NavigationLink(destination: DetailView(itemId: 1)) {
    Text("Go to Details")
}

🔄 Programmatic Navigation Extension

extension View {
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        ZStack {
            self
            NavigationLink(destination: view, isActive: binding) {
                EmptyView()
            }
        }
    }
}

✅ TabView Integration

Each tab uses .tag() and @State to maintain navigation independently.


📱 Compatibility

Feature	Supported
iOS Version	✅ iOS 15+
SwiftUI Version	✅ SwiftUI 3.0
NavigationView	✅ Used
@AppStorage	✅ Supported
@StateObject / @Binding	✅ Fully supported
SwiftUI Previews	✅ #Preview used

🧪 How to Use

1. Clone & Open in Xcode

git clone https://github.com/yourname/SwiftUI-Navigation-Demo.git
cd SwiftUI-Navigation-Demo
open SwiftUI-Navigation-Demo.xcodeproj

2. Use Demo Credentials
	•	Email: demo@example.com
	•	Password: demo123

3. Explore the App
	•	Sign in → Navigate tabs → Open details
	•	Edit profile, adjust settings, or sign out


📘 Learning Resources
	•	SwiftUI Navigation Best Practices
	•	WWDC: Advanced Navigation in SwiftUI
	•	Swift Forums

🛠 Troubleshooting

Issue	Suggested Fix
App stuck on splash screen	Check @AppStorage("isLoggedIn") value
Navigation not working	Ensure .environmentObject(ViewRouter()) is set
Preview not loading	Add required environment values to #Preview block


🤝 Contribution

Getting Started
	1.	Fork this repository
	2.	Create a new branch: git checkout -b feature/your-feature
	3.	Commit your changes
	4.	Submit a pull request 🚀

Guidelines
	•	Follow SwiftLint rules
	•	Use #Preview instead of deprecated PreviewProvider
	•	Ensure all views remain compatible with iOS 15+

🔖 License

This project is licensed under the MIT License — you are free to use, modify, and distribute it.



Let me know if you'd like this version exported as a file or need a `CONTRIBUTING.md` or `LICENSE` file as well.
