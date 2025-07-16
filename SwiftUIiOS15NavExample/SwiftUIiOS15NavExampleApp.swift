//
//  ContentView.swift
//  DemoApp
//
//  Created by Developer on 2024-09-08.
//

import SwiftUI

// MARK: - App Entry Point
@main
struct DemoApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .applyViewRoutes()
        }
    }
}

// MARK: - Root Types
enum Roots: CaseIterable {
    case initial
    case signIn
    case signUp
    case bottomTab
}

// MARK: - Root View
struct RootView: View {
    @EnvironmentObject var router: ViewRouter
    @State private var isAnimated = false

    var body: some View {
        NavigationView {
            containedView(root: router.currentRoot)
                .id(UUID().uuidString)
                .transition(.slide)
                .animation(.linear(duration: 0.2), value: isAnimated)
                .onAppear {
                    isAnimated = true
                }
        }
        .navigationViewStyle(.stack)
    }

    @ViewBuilder
    func containedView(root: Roots) -> some View {
        switch root {
        case .initial:
            InitialScreen()
        case .signIn:
            SignInScreen()
        case .signUp:
            SignUpScreen()
        case .bottomTab:
            BottomTabView()
        }
    }
}

// MARK: - View Router
class ViewRouter: ObservableObject {
    @Published var currentRoot: Roots = .initial
    @AppStorage("IsAuthenticated") var IsAuthenticated = false {
        didSet {
            checkUserLoginOrNot()
        }
    }
    
    static let shared = ViewRouter()
    
    fileprivate init() {
        // Show initial screen first, then check authentication
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.checkUserLoginOrNot()
        }
    }
    
    func checkUserLoginOrNot() {
        if IsAuthenticated {
            currentRoot = .bottomTab
        } else {
            currentRoot = .signIn
        }
    }
    
    func signOut() {
        IsAuthenticated = false
        currentRoot = .signIn
    }
}

// MARK: - Route Modifier
struct RouteModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .environmentObject(ViewRouter.shared)
    }
}

extension View {
    func applyViewRoutes() -> some View {
        modifier(RouteModifier())
    }
    
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Active binding
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        ZStack {
            self
            NavigationLink(
                destination: view,
                isActive: binding
            ) {
                EmptyView()
            }
        }
    }
}

// MARK: - Extensions
extension Roots: Hashable {}

// MARK: - Initial Screen
struct InitialScreen: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "app.badge")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                
                Text("Demo App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Welcome to our amazing app!")
                    .font(.title2)
                    .foregroundColor(.white.opacity(0.8))
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                    .padding(.top, 40)
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Sign In Screen
struct SignInScreen: View {
    @EnvironmentObject var router: ViewRouter
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Logo
            Image(systemName: "person.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("Sign In")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Email Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }
            
            // Password Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                SecureField("Enter your password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // Sign In Button
            Button(action: signIn) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(email.isEmpty || password.isEmpty)
            
            // Demo Credentials
            VStack(spacing: 5) {
                Text("Demo Credentials:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("Email: demo@example.com")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("Password: demo123")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 10)
            
            // Sign Up Link
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.secondary)
                
                Button("Sign Up") {
                    router.currentRoot = .signUp
                }
                .foregroundColor(.blue)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
        .alert("Sign In", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func signIn() {
        // Demo authentication logic
        if email == "demo@example.com" && password == "demo123" {
            router.IsAuthenticated = true
        } else {
            alertMessage = "Invalid credentials. Please use demo@example.com and demo123"
            showingAlert = true
        }
    }
}

// MARK: - Sign Up Screen
struct SignUpScreen: View {
    @EnvironmentObject var router: ViewRouter
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Logo
            Image(systemName: "person.badge.plus")
                .font(.system(size: 80))
                .foregroundColor(.green)
            
            Text("Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // First Name Field
            VStack(alignment: .leading, spacing: 8) {
                Text("First Name")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                TextField("Enter your first name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // Last Name Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Last Name")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                TextField("Enter your last name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // Email Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Email")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }
            
            // Password Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                SecureField("Enter your password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // Confirm Password Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Confirm Password")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                SecureField("Confirm your password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            // Sign Up Button
            Button(action: signUp) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .disabled(!isFormValid)
            
            // Sign In Link
            HStack {
                Text("Already have an account?")
                    .foregroundColor(.secondary)
                
                Button("Sign In") {
                    router.currentRoot = .signIn
                }
                .foregroundColor(.blue)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
        .alert("Sign Up", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private var isFormValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty &&
        !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword
    }
    
    private func signUp() {
        // Demo sign up logic
        if password != confirmPassword {
            alertMessage = "Passwords do not match"
            showingAlert = true
            return
        }
        
        // Simulate successful sign up
        alertMessage = "Account created successfully! Please sign in."
        showingAlert = true
        
        // Navigate to sign in after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            router.currentRoot = .signIn
        }
    }
}

// MARK: - Bottom Tab View
struct BottomTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(3)
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Home View
struct HomeView: View {
    @State private var showNotifications = false
    @State private var selectedItemId: Int? = nil
    @State private var showItemDetail = false
    @State private var selectedCategory: String? = nil
    @State private var showCategoryDetail = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("Welcome back!")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("Here's what's new today")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showNotifications = true
                    }) {
                        Image(systemName: "bell")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal)
                
                // Featured Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Featured")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(1...5, id: \.self) { index in
                                Button(action: {
                                    selectedItemId = index
                                    showItemDetail = true
                                }) {
                                    FeaturedCard(title: "Item \(index)", imageName: "photo")
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Categories Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Categories")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 15) {
                        ForEach(["Sports", "Music", "Travel", "Food"], id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                                showCategoryDetail = true
                            }) {
                                CategoryCard(title: category)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigate(to: NotificationsView(), when: $showNotifications)
            .navigate(to: DetailView(itemId: selectedItemId ?? 0), when: $showItemDetail)
            .navigate(to: CategoryView(category: selectedCategory ?? ""), when: $showCategoryDetail)
        }
    }
}

// MARK: - Search View
struct SearchView: View {
    @State private var searchText = ""
    @State private var searchResults: [String] = []
    @State private var selectedResult: String? = nil
    @State private var showResultDetail = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search...", text: $searchText)
                            .onSubmit {
                                performSearch()
                            }
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                                searchResults = []
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    
                    Button("Search", action: performSearch)
                        .foregroundColor(.blue)
                }
                .padding(.horizontal)
                
                // Search Results
                if searchResults.isEmpty && !searchText.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        
                        Text("No results found")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 50)
                } else if !searchResults.isEmpty {
                    List(searchResults, id: \.self) { result in
                        Button(action: {
                            selectedResult = result
                            showResultDetail = true
                        }) {
                            HStack {
                                Image(systemName: "doc.text")
                                    .foregroundColor(.blue)
                                
                                VStack(alignment: .leading) {
                                    Text(result)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Text("Search result description")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                } else {
                    VStack(spacing: 20) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        
                        Text("Search for items")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text("Enter a keyword to find what you're looking for")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 50)
                }
                
                Spacer()
            }
            .navigationTitle("Search")
            .navigate(to: SearchResultView(result: selectedResult ?? ""), when: $showResultDetail)
        }
    }
    
    private func performSearch() {
        // Simulate search results
        if !searchText.isEmpty {
            searchResults = (1...10).map { "Result \($0) for '\(searchText)'" }
        } else {
            searchResults = []
        }
    }
}

// MARK: - Favorites View
struct FavoritesView: View {
    @State private var favorites = [
        "Favorite Item 1",
        "Favorite Item 2",
        "Favorite Item 3",
        "Favorite Item 4",
        "Favorite Item 5"
    ]
    @State private var selectedFavorite: String? = nil
    @State private var showFavoriteDetail = false
    
    var body: some View {
        NavigationView {
            VStack {
                if favorites.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "heart.slash")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        
                        Text("No favorites yet")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text("Items you favorite will appear here")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 50)
                } else {
                    List {
                        ForEach(favorites, id: \.self) { favorite in
                            Button(action: {
                                selectedFavorite = favorite
                                showFavoriteDetail = true
                            }) {
                                HStack {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                    
                                    VStack(alignment: .leading) {
                                        Text(favorite)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        
                                        Text("Added to favorites")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 4)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .onDelete(perform: deleteFavorite)
                    }
                }
                
                Spacer()
            }
            .navigationTitle("Favorites")
            .toolbar {
                EditButton()
            }
            .navigate(to: FavoriteDetailView(item: selectedFavorite ?? ""), when: $showFavoriteDetail)
        }
    }
    
    private func deleteFavorite(at offsets: IndexSet) {
        favorites.remove(atOffsets: offsets)
    }
}

// MARK: - Profile View
struct ProfileView: View {
    @EnvironmentObject var router: ViewRouter
    @State private var showEditProfile = false
    @State private var showNotifications = false
    @State private var showPrivacy = false
    @State private var showHelp = false
    @State private var showAbout = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Profile Header
                VStack(spacing: 15) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    Text("John Doe")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("demo@example.com")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 20)
                
                // Profile Options
                VStack(spacing: 0) {
                    Button(action: { showEditProfile = true }) {
                        ProfileRow(icon: "person.crop.circle", title: "Edit Profile")
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: { showNotifications = true }) {
                        ProfileRow(icon: "bell", title: "Notifications")
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: { showPrivacy = true }) {
                        ProfileRow(icon: "lock", title: "Privacy")
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: { showHelp = true }) {
                        ProfileRow(icon: "questionmark.circle", title: "Help & Support")
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: { showAbout = true }) {
                        ProfileRow(icon: "info.circle", title: "About")
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .background(Color(.systemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Sign Out Button
                Button(action: {
                    router.signOut()
                }) {
                    Text("Sign Out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                Spacer()
            }
            .navigationTitle("Profile")
            .background(Color(.systemGray6))
            .navigate(to: EditProfileView(), when: $showEditProfile)
            .navigate(to: NotificationsView(), when: $showNotifications)
            .navigate(to: PrivacyView(), when: $showPrivacy)
            .navigate(to: HelpView(), when: $showHelp)
            .navigate(to: AboutView(), when: $showAbout)
        }
    }
}

// MARK: - Supporting Views

struct FeaturedCard: View {
    let title: String
    let imageName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: imageName)
                .font(.system(size: 40))
                .foregroundColor(.blue)
                .frame(width: 150, height: 80)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(width: 150)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct CategoryCard: View {
    let title: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "square.grid.2x2")
                .font(.system(size: 30))
                .foregroundColor(.white)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(LinearGradient(
            gradient: Gradient(colors: [.blue, .purple]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ))
        .cornerRadius(12)
    }
}

struct ProfileRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 30)
            
            Text(title)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

// MARK: - Detail Views

struct DetailView: View {
    let itemId: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "photo")
                .font(.system(size: 100))
                .foregroundColor(.blue)
            
            Text("Item \(itemId)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("This is a detailed view for item \(itemId). You can add more content here.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Add to Favorites") {
                // Add to favorites logic
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Item \(itemId)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CategoryView: View {
    let category: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "square.grid.2x2")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text(category)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Explore items in the \(category) category.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            List(1...20, id: \.self) { index in
                NavigationLink(destination: DetailView(itemId: index)) {
                    Text("\(category) Item \(index)")
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(category)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SearchResultView: View {
    let result: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.text")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text(result)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("This is the detailed view for this search result. You can display relevant information here.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Search Result")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FavoriteDetailView: View {
    let item: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart.fill")
                .font(.system(size: 60))
                .foregroundColor(.red)
            
            Text(item)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text("This is one of your favorite items. You can view details and manage your favorites here.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Remove from Favorites") {
                // Remove from favorites logic
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Favorite Item")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EditProfileView: View {
    @State private var firstName = "John"
    @State private var lastName = "Doe"
    @State private var email = "demo@example.com"
    @State private var phone = "+1 (555) 123-4567"
    
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                TextField("Phone", text: $phone)
                    .keyboardType(.phonePad)
            }
            
            Section(header: Text("Profile Picture")) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                    
                    VStack(alignment: .leading) {
                        Text("Profile Picture")
                            .font(.headline)
                        
                        Button("Change Picture") {
                            // Change picture logic
                        }
                        .foregroundColor(.blue)
                    }
                    
                    Spacer()
                }
                .padding(.vertical, 8)
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    // Save profile logic
                }
            }
        }
    }
}

struct NotificationsView: View {
    @State private var pushNotifications = true
    @State private var emailNotifications = false
    @State private var soundEnabled = true
    
    var body: some View {
        Form {
            Section(header: Text("Notification Settings")) {
                Toggle("Push Notifications", isOn: $pushNotifications)
                Toggle("Email Notifications", isOn: $emailNotifications)
                Toggle("Sound", isOn: $soundEnabled)
            }
            
            Section(header: Text("Notification Types")) {
                NavigationLink("News Updates", destination: SimpleTextView(title: "News Updates", content: "Configure your news update notification preferences here."))
                NavigationLink("Messages", destination: SimpleTextView(title: "Messages", content: "Configure your message notification preferences here."))
                NavigationLink("Reminders", destination: SimpleTextView(title: "Reminders", content: "Configure your reminder notification preferences here."))
            }
        }
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PrivacyView: View {
    var body: some View {
        Form {
            Section(header: Text("Privacy Settings")) {
                NavigationLink("Data & Privacy", destination: SimpleTextView(title: "Data & Privacy", content: "Manage your data and privacy settings here."))
                NavigationLink("Location Services", destination: SimpleTextView(title: "Location Services", content: "Control location access for the app."))
                NavigationLink("Camera & Microphone", destination: SimpleTextView(title: "Camera & Microphone", content: "Manage camera and microphone permissions."))
            }
            
            Section(header: Text("Account")) {
                NavigationLink("Delete Account", destination: SimpleTextView(title: "Delete Account", content: "Warning: This action cannot be undone."))
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Privacy")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HelpView: View {
    var body: some View {
        List {
            Section(header: Text("Support")) {
                NavigationLink("FAQ", destination: SimpleTextView(title: "FAQ", content: "Frequently asked questions and answers."))
                NavigationLink("Contact Us", destination: SimpleTextView(title: "Contact Us", content: "Get in touch with our support team."))
                NavigationLink("Report a Bug", destination: SimpleTextView(title: "Report a Bug", content: "Report issues you've encountered."))
            }
            
            Section(header: Text("Resources")) {
                NavigationLink("User Guide", destination: SimpleTextView(title: "User Guide", content: "Complete guide on how to use the app."))
                NavigationLink("Video Tutorials", destination: SimpleTextView(title: "Video Tutorials", content: "Watch video tutorials to learn more."))
                NavigationLink("Community Forum", destination: SimpleTextView(title: "Community Forum", content: "Join our community discussions."))
            }
        }
        .navigationTitle("Help & Support")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "app.badge")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("Demo App")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Version 1.0.0")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("A comprehensive demo app showcasing SwiftUI navigation patterns, including root-level routing, tab navigation, and traditional NavigationView navigation.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            VStack(spacing: 10) {
                Text("Features:")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("• Authentication flow with sign in/sign up")
                    Text("• Tab-based navigation")
                    Text("• Detail view navigation")
                    Text("• Search functionality")
                    Text("• Favorites management")
                    Text("• Profile settings")
                }
                .font(.body)
                .foregroundColor(.secondary)
            }
            .padding()
            
            Spacer()
            
            VStack(spacing: 10) {
                Text("© 2024 Demo App")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("Made with SwiftUI")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SimpleTextView: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(content)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
#Preview {
    RootView()
        .applyViewRoutes()
}
