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
    
    @State var presentationText: String = ""
    @State var avatar: String = "person"
    
    @State var avatarColor: Color = Color.blue
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Your Profile")
                    .font(.largeTitle)
                    .bold()
                    Circle()
                        .frame(width: 100, height: 100, alignment: .top)
                        .foregroundStyle(avatarColor)
                        .overlay(
                            Image(systemName: getSytemImageString())
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                        )
                        .contextMenu {
                             Button {
                                 setSytemImageString(image: "person")
                                 setAvatarColor(color: Color.blue)
                             } label: {
                                 Label("Person", systemImage: "person")
                             }
                            
                            Button {
                                setSytemImageString(image: "heart")
                                setAvatarColor(color: Color.red)
                            } label: {
                                Label("Heart", systemImage: "heart")
                            }
                            
                            Button {
                                setSytemImageString(image: "star")
                                setAvatarColor(color: Color.yellow)
                            } label: {
                                Label("Star", systemImage: "star")
                            }
                            
                            Button {
                                setSytemImageString(image: "smiley")
                                setAvatarColor(color: Color.green)
                            } label: {
                                Label("Smiley", systemImage: "smiley")
                            }
                         }
                    
                    VStack {
                        Text("Welcome,  \(viewModel.getUserName())")
                            .bold()
                            .font(.title2)
                            .padding()
                        Text("Mail: \t\(viewModel.getUserMail())")
                            .bold()
                            .font(.title3)
                        Text("User since: \t \(viewModel.getUserRegistrationDate())")
                            .bold()
                            .font(.title3)
                        
                    }
                    .padding(20)
                
                Spacer()
                
                Text("About Jorgen")
                    .bold()
                
                TextEditor(text: $presentationText)
                              .border(.black, width: 1)
                              .frame(height: 200)
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
    func setSytemImageString(image: String){
        avatar = image
    }
    
    func getSytemImageString() -> String {
        return avatar
    }
    func setAvatarColor(color: Color){
        avatarColor = color
    }
    
    func getAvatarColor() -> Color {
        return avatarColor
    }
}

#Preview {
    ProfileView()
}
