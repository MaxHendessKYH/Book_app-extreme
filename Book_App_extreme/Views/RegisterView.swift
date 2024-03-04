//
//  RegisterView.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//

import SwiftUI
import Firebase


struct RegisterView: View {
    
    @State private var mail = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    
    @State var showMessage = false
    @State var isPasswordTooShort = false
    @State var passwordInfo = "Password needs to be at least 8 characters"
    
        var body: some View {
            VStack {
                Text("Create account")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.brown)
                    .padding()
                
                TextField("E-mail", text: $mail)
                    .padding()
                    .autocapitalization(.none)
                    .textContentType(.emailAddress)
                    .foregroundStyle(.black)
                    .font(.title2)
                    .background(.white)
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(10)

                SecureField("Password", text: $password)
                    .padding()
                    .foregroundStyle(.black)
                    .font(.title2)
                    .background(.white)
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(10)
                    .onChange(of: password, initial: false, { previous, newTypedPassword in
                        if newTypedPassword.count < 8 {
                            isPasswordTooShort = true
                            
                        } else {
                            isPasswordTooShort = false
                        }
                    })
                  
                SecureField("Re-enter password", text: $repeatPassword)
                    .padding()
                    .foregroundStyle(.black)
                    .font(.title2)
                    .background(.white)
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(10)
                
                if isPasswordTooShort {
                    displayShortPasswordText(text: passwordInfo)
                }

                Button(action: {
                    if !mail.isEmpty && !password.isEmpty && password == repeatPassword && checkMailFormat(mail: mail) {
                        showMessage = true
                        //createUser()
                        //logga in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showMessage = false
                        }
                        
                    }
                
                }) {
                    Text("Register")
                        .imageScale(.large)
                        .padding(20)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .bold()
                        .cornerRadius(10)
                        .shadow(radius: 2)
                }
                
                .padding()
                buildMessage()

                Spacer()
            }
            .padding()
        }
    
    private func createUser() {
        // Skapa användare i Firebase
       }
    
    func displayShortPasswordText(text: String) -> Text {
        return Text(text)
    }
    
    
    private func buildMessage() -> some View {
         if showMessage {
             PopUpMessageView(systemImageText: "person.fill.checkmark", color: Color.green, message: "User registered")
         } else {
             PopUpMessageView(systemImageText: "person.fill.xmark", color: Color.red, message: "Fill out the form correctly...")
         }
     }
    private func checkMailFormat(mail: String) -> Bool {
           let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
           let mailFilter = NSPredicate(format:"SELF MATCHES %@", regex)
           return mailFilter.evaluate(with: mail)
       }
}

#Preview {
    RegisterView()
}
