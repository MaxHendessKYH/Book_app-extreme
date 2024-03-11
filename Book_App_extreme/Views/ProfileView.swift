import SwiftUI

struct ProfileView: View {
    
    @State var name: String = ""
    @State var mail: String = "NoMail"
    @State var date: String = "NoDate"
    @State var presentationText: String = ""
    @State var avatar: String = ""
    @ObservedObject var viewModel = ProfileViewViewModel()
    
    @State var showEdit = false
    @State private var showWarning = false
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Your Profile")
                    .font(.largeTitle)
                    .bold()
                VStack {
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
                        }
                } .onAppear {
                    viewModel.getUserAvatar()
                }
                
                // Displaying info
                VStack {
                    if viewModel.hasFetchedName {
                        Text("Welcome,  \(viewModel.name ?? name)")
                            .bold()
                            .font(.title2)
                            .padding()
                    } else {
                        Text("Welcome, \(name)")
                            .bold()
                            .font(.title2)
                            .padding()
                    }
                    if viewModel.hasFetchedMail {
                        Text("Mail: \t\(viewModel.mail ?? mail)")
                            .bold()
                            .font(.title3)
                    }
                    if viewModel.hasFetchedDate {
                        Text("User since: \t \(viewModel.registrationDate ?? date)")
                            .bold()
                            .font(.title3)
                    }
                    Text("About me".uppercased())
                        .padding(5)
                        .font(.title3)
                    
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                        if viewModel.hasFetchedPresentation {
                            Text(viewModel.presentation ?? "Could not fetch")
                                .font(.system(size: 16))
                                .bold()
                                .italic()
                                .foregroundStyle(.indigo)
                        } else {
                            Text(presentationText)
                                .font(.system(size: 16))
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
                
                Button(showEdit ? "Hide edit" : "Show edit") {
                    showEdit.toggle()
                }
                .padding(5)
                
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
            }
            .padding(20)
            
            // Saving
            Button(action: {
                viewModel.overwriteName(nameString: name)
                viewModel.overwritePresentationText(presentationText: presentationText)
                viewModel.overwriteAvatarString(avatar: avatar)
                showEdit.toggle()
            }) {
                Text("Save Changes")
                    .foregroundColor(.white)
                    .bold()
                    .padding(5)
                    .background(.green)
                    .cornerRadius(5)
            }
            
            // Log out
            Button(action: {
                viewModel.userLogOut()
            }) {
                Text("Log out")
                    .foregroundColor(.white)
                    .bold()
                    .padding(5)
                    .background(.orange)
                    .cornerRadius(5)
            }
            
            // Delete user
            if showEdit {
                Button(action: {
                    showWarning = true
                    
                }) {
                    Text("Delete account")
                        .foregroundColor(.white)
                        .bold()
                        .padding(5)
                        .background(.red)
                        .cornerRadius(5)
                        .padding()
                        .alert(isPresented: $showWarning) {
                            // Bekräftelsedialogruta
                            Alert(
                                title: Text("Warning"),
                                message: Text("Delete account?"),
                                primaryButton: .destructive(Text("Delete")) {
                                    viewModel.deleteDocumentsForUser()
                                    viewModel.deleteUser()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundStyle(.red)
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
