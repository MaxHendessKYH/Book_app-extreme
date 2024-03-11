//
//  RegisterView.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//

import SwiftUI


struct RegisterView: View {
    
    @StateObject var viewModel = RegisterViewViewModel()
       
        var body: some View {
            VStack {
                
                ZStack{
                    RoundedRectangle(cornerRadius: 0)
                        .foregroundColor(Color.gray)
                        .frame(width: UIScreen.main.bounds.width,height: 300)
                    
                        
                    
                    VStack{
                        Text("Create account")
                            .foregroundColor(Color.white)
                            .bold()
                            .font(.system(size: 50))
                            .padding(.bottom)
                    
                        
                        Text("“If you don’t like to read, you haven’t found the right book.”")
                            .foregroundColor(Color.white)
                            .bold()
                            .font(.system(size: 28))
                            .padding(5)
                        
                        
                        Text("J.K. Rowling")
                            .foregroundColor(Color.white)
                            .font(.system(size: 20))
                    }
                    .padding(.bottom)
                }
                .padding(.bottom)
                
                Form{
                    
                    TextField("Full Name", text: $viewModel.name)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                    
                    TextField("Email Adress", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    
                    TextField("Password (at least 8 character)", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    TextField("Re-enter Password", text: $viewModel.repeatPassword)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    ZStack {
                            Color.blue
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .cornerRadius(15)
                            
                            Button(action: {
                                viewModel.register()
                            }, label: {
                                Text("Create Account")
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding()
                            })
                        
                        }
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                }
            }
        }
}

#Preview {
    RegisterView()
}
