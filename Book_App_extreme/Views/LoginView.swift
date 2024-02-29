//
//  LoginView.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-28.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                
                Form{
                    TextField("Email Adress", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    ZStack {
                            Color.blue // Background color
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            
                            Button(action: {
                                // Action
                            }, label: {
                                Text("Log In")
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding() // Add padding around the button text
                            })
                        
                        }
                        .cornerRadius(15)
                }
                .offset(y: 150)
                
                
                
                
                VStack{
                    Text("New around here?")
                        // Show Registeration
                    NavigationLink("Create An Account!", destination: RegisterView())
                }
                .padding(.bottom, 50)
                Spacer()
                
                // Login Form
//                Form{
//
//                        
//                    TextField("Email Adress", text: $viewModel.email)
//                        .textFieldStyle(DefaultTextFieldStyle())
//                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
//                    
//                    SecureField("Password", text: $viewModel.password)
//                        .textFieldStyle(DefaultTextFieldStyle())
//                    
//                    Button(title: "Log In", background: .blue){
//                        // Attempt Log in
//                        viewModel.login()
//                    }
//                    .padding()
//                }
//                .offset(y: -50)
//                
//                // Create Acount
//                VStack{
//                    Text("New around here?")
//                        // Show Registeration
//                    NavigationLink("Create An Account!", destination: RegisterView())
//                }
//                .padding(.bottom, 50)
//                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
