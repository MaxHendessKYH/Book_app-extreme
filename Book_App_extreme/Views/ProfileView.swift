import SwiftUI

struct ProfileView: View {
    
    @State var name: String = ""
    @State var mail: String = "NoMail"
    @State var date: String = "NoDate"
    @State var presentationText: String = ""
    @State var avatar: String = "hand.tap"
    @ObservedObject var viewModel = ProfileViewViewModel()
    
    @State var showEdit = false
    @State private var showWarning = false
    @State private var isSaved = false
    
    var body: some View {
        ScrollView {
            // Overall Vstack for profile except save- and delete-button
            VStack {
                // HStack for edit and log out
                HStack {
                    // Edit
                    Button(action: {
                        showEdit.toggle()
                    }) {
                        Image(systemName: showEdit ? "pencil.circle.fill" : "pencil.circle")
                            .foregroundStyle(showEdit ? .blue : .gray)
                            .font(.system(size: 30))
                        
                        Text("Edit")
                    }
                    Spacer()
                    
                    // Log out
                    Button(action: {
                        viewModel.userLogOut()
                    }) {
                        Text("Log out")
                            .foregroundColor(.white)
                            .bold()
                            .padding(5)
                            .background(.pink)
                            .cornerRadius(5)
                    }
                }
                
                // HStack for top info (image and info)
                HStack {
                    Circle()
                        .frame(width: 100, height: 100, alignment: .top)
                        .foregroundStyle(avatarColor(avatar: viewModel.avatarString ?? ""))
                        .overlay(
                            Image(systemName: viewModel.avatarString ?? avatar)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                        )
                    // Context-menu for image
                        .contextMenu {
                            Button {
                                avatar = "person"
                            } label: {
                                Label("Person", systemImage: "person")
                            }
                            Button {
                                avatar = "heart"
                            } label: {
                                Label("Heart", systemImage: "heart")
                            }
                            Button {
                                avatar = "star"
                            } label: {
                                Label("Star", systemImage: "star")
                            }
                            Button {
                                avatar = "smiley"
                            } label: {
                                Label("Smiley", systemImage: "smiley")
                            }
                            Button {
                                avatar = "book"
                            } label: {
                                Label("Book", systemImage: "book")
                            }
                        }
                        .onChange(of: avatar, initial: false) { oldValue, newValue in

                                viewModel.avatarString = newValue

                        }.onAppear {
                            viewModel.getUserAvatar()
                        }
                    Spacer()
                    
                    // Vstack for displaying top info
                    VStack {
                        if viewModel.hasFetchedName {
                            Text(viewModel.name ?? name)
                                .bold()
                                .font(.title2)
                        }
                        if viewModel.hasFetchedMail {
                            Text(viewModel.mail ?? mail)
                                .font(.title3)
                            
                        }
                        if viewModel.hasFetchedDate {
                            Text("Registered: \(viewModel.registrationDate ?? date)")
                                .font(.title3)
                        }
                    }
                }
                
                // Vstack for Displaying info about user
                VStack {
                    Text("About \(viewModel.name ?? name)")
                        .padding(30)
                        .font(.title3)
                        .bold()
                    
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                        if viewModel.hasFetchedPresentation {
                            Text(viewModel.presentation ?? "Could not fetch")
                                .font(.system(size: 16))
                                .bold()
                                .italic()
                                .foregroundStyle(.indigo)
                        } else {
                            Text(presentationText)
                                .font(.system(size: 20))
                                .bold()
                                .italic()
                                .foregroundStyle(.indigo)
                        }
                    })
                } .onAppear {
                    viewModel.getUserNameFromDictionary()
                    viewModel.getUserMail()
                    viewModel.getUserRegistrationDate()
                    viewModel.getUserPresentation()
                }
                
                // VStack on edit-fields
                VStack {
                    // Hidden edit-fields
                    if showEdit {
                        Text("Name")
                            .bold()
                        
                        TextField( "Your name... ", text: $name)
                            .frame(width: 150, height: 40)
                            .border(.gray, width: 1)
                            .onAppear {
                                name = viewModel.name ?? "NoName"
                            }
                            .onChange(of: name, initial: false) { oldValue, newValue in
                                viewModel.name = newValue
                            }
                        
                        Text("About You")
                            .bold()
                        
                        TextEditor(text: $presentationText)
                            .border(.gray, width: 1)
                            .frame(height: 70)
                            .onAppear {
                                presentationText = viewModel.presentation ?? "NoPresentation"
                            }
                            .onChange(of: presentationText, initial: false) { oldValue, newValue in
                                viewModel.presentation = newValue
                            }
                    }
                } .padding()
                
            }
            .padding(20)
            
            // Save data
            Button(action: {
                viewModel.overwriteName(nameString: name)
                viewModel.overwritePresentationText(presentationText: presentationText)

                if !avatar.isEmpty && avatar != "hand.tap" {
                    viewModel.overwriteAvatarString(avatar: avatar)
                }
                showEdit = false // Forgot to change this state
                isSaved = true
                // Let info dissappear and set to false
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isSaved = false
                }

            }) {
                Text("Save")
                    .foregroundColor(.white)
                    .bold()
                    .padding(5)
                    .background(.green)
                    .cornerRadius(5)
            }
            
            // Delete user
            if showEdit {
                Button(action: {
                    showWarning = true
                    
                }) {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundStyle(.red)
                        .font(.system(size: 30))
                    
                    Text("Delete account")
                        .foregroundColor(.white)
                        .bold()
                        .padding(5)
                        .background(.red)
                        .cornerRadius(5)
                        .padding()
                        .alert(isPresented: $showWarning) {
                            
                            // Alert-dialogue
                            Alert(
                                title: Text("Warning"),
                                message: Text("This will delete your account and all saved data. Are you sure you want to proceed?"),
                                primaryButton: .destructive(Text("Delete")) {
                                    viewModel.deleteDocumentsForUser()
                                    viewModel.deleteUser()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                }
            }
            // Added Saved-view to VStack
            VStack {
                if isSaved {
                    MessageInfoView(systemImageText: "externaldrive.badge.plus", color: Color.green, message: "Saved")
                }
            }
        }
    }
    
    // Change color-background on image
    func avatarColor(avatar: String) -> Color {
        switch avatar {
        case "person":
            return Color.blue
        case "heart":
            return Color.red
        case "star":
            return Color.green
        case "smiley":
            return Color.yellow
        case "book":
            return Color.orange
        default:
            return Color.gray
        }
    }
}

#Preview {
    ProfileView()
}
