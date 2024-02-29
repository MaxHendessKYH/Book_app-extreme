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
 
    init() {
        
    }
    
}
