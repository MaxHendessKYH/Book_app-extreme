//
//  RegisterViewViewModel.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class RegisterViewViewModel: ObservableObject {
    
    // Properties for user registration form
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var repeatPassword = ""
    @Published var errorMessage = ""
    
    init() {}
    
    // Function to handle user registration
    func register() {
        // Validate user input
        guard validate() else {
            return
        }
        
        // Create user account using Firebase Authentication
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            // Check if user creation was successful
            guard let userId = result?.user.uid else {
                return
            }
            
            // Insert user record into Firestore database
            self?.insertUserRecord(id: userId)
        }
    }
    
    // Function to insert user record into Firestore
    private func insertUserRecord(id: String) {
        // Create a new User object
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970)
        
        // Get a reference to Firestore database
        let db = Firestore.firestore()
        
        // Add the user record to 'users' collection in Firestore
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    // Function to validate user input
    private func validate() -> Bool {
        errorMessage = ""
        
        // Check if all fields are filled
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !repeatPassword.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        
        // Check if email is valid
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email address"
            return false
        }
        
        // Check if password is at least 8 characters long
        guard password.count >= 8 else {
            errorMessage = "Password must be at least 8 characters"
            return false
        }

        // Check if password and repeatPassword match
        guard password == repeatPassword else {
            errorMessage = "Passwords do not match"
            return false
        }

        return true
    }
    
}
