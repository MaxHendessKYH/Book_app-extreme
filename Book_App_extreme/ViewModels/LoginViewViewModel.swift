//
//  LoginViewViewModel.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-28.
//

import Foundation
import FirebaseAuth

class LoginViewViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {
        
    }
    
    // Function to handle user login
    func login() {
        guard validate() else {
            return
        }
        
        // Attempt login with provided credentials
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    // Function to validate user input
    private func validate() -> Bool {
        errorMessage = ""
        // Check if email and password fields are not empty
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            
            errorMessage = "Please fill in all fields"
            return false
        }
        
        // email validation
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email"
            return false
        }
        return true
    }
}

