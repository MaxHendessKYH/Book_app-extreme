//
//  ProfileView.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel = ProfileViewViewModel()
    @State var name: String = ""
    @State var mail: String = ""
    @State var dateOfRegistration: TimeInterval? = nil
    
    @State var presentationText: String = ""
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Your Profile")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                    Circle()
                        .frame(width: 100, height: 100, alignment: .top)
                        .foregroundStyle(.brown)
                        .padding()
                        .overlay(
                            Button(action: {
                                // Sätt en avatar eller liknande?
                                print("Button pressed!")
                            }) {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                            }
                        )
                    
                    Spacer()
                    
                    VStack {
                        Text("Name: \t Test")
                            .bold()
                        Text("Mail: \t\(viewModel.getUserMail())")
                            .bold()
                        Text("User since: \t \(viewModel.getUserRegistrationDate())")
                            .bold()
                        
                    }
                    .padding(20)
                
                Spacer()
                
                Text("Short presentation")
                    .bold()
                
                TextEditor(text: $presentationText)
                             .padding(80)
                             .border(.black, width: 1)
                             .cornerRadius(5)
                     }
            .padding(20)
                        Button(action: {
                            // Spara ändringar
                            print("Button pressed!")
                        }) {
                            Text("Save Changes")
                                .foregroundColor(.white)
                                .bold()
                                .padding(10)
                                .background(.green)
                                .cornerRadius(5)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Logga ut
                           
                        }) {
                            Text("Log out")
                                .foregroundColor(.white)
                                .bold()
                                .padding(10)
                                .background(.red)
                                .cornerRadius(5)
                        }
                        
                    .padding(20)
                
            }
        }
    }

#Preview {
    ProfileView()
}
