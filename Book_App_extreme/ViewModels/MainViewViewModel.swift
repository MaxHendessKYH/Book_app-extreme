//
//  MainViewViewModel.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-03-06.
//

import FirebaseAuth
import Foundation

class MainViewViewModel: ObservableObject {

    @Published var currentUserId: String = ""
    
    // Listener handle for authentication state changes
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        // Add listener to observe authentication state changes
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                // Update currentUserId with the user's UID if user is not nil
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    // Bool property to check if user is signed in
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
