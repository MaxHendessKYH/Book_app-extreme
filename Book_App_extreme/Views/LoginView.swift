//
//  LoginView.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-28.
//

import SwiftUI

struct LoginView: View {
    // ViewModel to handle login logic
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                // Form for login input fields and login button
                Form{
                    // Display error message if any
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                    TextField("Email Adress", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    ZStack {
                            Color.blue
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            
                            Button(action: {
                                viewModel.login()
                            }, label: {
                                Text("Log In")
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding()
                            })
                        
                        }
                        .cornerRadius(15)
                    
                }
                .offset(y: 150)
                
                
                
                // Navigation link to register view
                VStack{
                    Text("New around here?")
                        // Show Registeration
                    NavigationLink("Create An Account!", destination: RegisterView())
                }
                .padding(.bottom, 50)
                Spacer()
                
                
            }
        }
    }
}

#Preview {
    LoginView()
}
