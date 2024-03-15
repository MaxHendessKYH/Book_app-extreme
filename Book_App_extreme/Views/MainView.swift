//
//  MainView.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-03-06.
//

import SwiftUI

struct MainView: View {
    
    // ViewModel to manage the main screen logic
    @StateObject var viewModel = MainViewViewModel()
    
    var body: some View {
        // Check if user is signed in and has a valid user ID
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            // If signed in, show the account view
            accountView
        } else {
            // If not signed in, show the login view
            LoginView()
        }
    }
    // View for the account when user is signed in
    @ViewBuilder
    var accountView: some View {
        NavigationStack {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
            }
        }
        // TabView for the home, search, and profile views
        .toolbar(.visible, for: .tabBar)
    }
}

#Preview {
    MainView()
}
