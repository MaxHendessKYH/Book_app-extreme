import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel = ProfileViewViewModel()
    @State var name: String = ""
    @State var mail: String = ""
    
    @State var presentationText: String = ""
    @State var avatar: String = "person"
    
    @State var avatarColor: Color = Color.blue
    @State var showEdit = false
    @State var hasFetchedPresentation = false
    
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
                    Text("About me".uppercased())
                        .padding(5)
                        .font(.title3)
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                        
                        Text(fetchText(hasFetched: hasFetchedPresentation))
                            .font(.system(size: 16))
                            .bold()
                            .italic()
                            .foregroundStyle(.indigo)
                        
                        
                        
                    })
                    
                    
                }
                
                Button(showEdit ? "Hide edit" : "Show edit") {
                    showEdit.toggle()
                    hasFetchedPresentation = true
                    
                }
                .padding(5)
                
                if showEdit {
                    
                    Text("Name")
                        .bold()
                    TextField( "Your name: ", text: $name)
                        .frame(width: 150, height: 40)
                        .border(.gray, width: 1)
                    
                    Text("About You")
                        .bold()
                    
                    TextEditor(text: $presentationText)
                        .border(.gray, width: 1)
                        .frame(height: 70)
                        .onChange(of: presentationText, initial: false) { oldValue, newValue in
                            
                            presentationText = newValue
                            
                            
                        }
                }
                
            }
            .padding(20)
            
            if showEdit {
                Button(action: {
                    viewModel.changeDisplayName(newName: name)
                    viewModel.addPresentationText(presentationText: presentationText)
                    showEdit.toggle()
                    print("Button pressed!")
                }) {
                    Text("Save Changes")
                        .foregroundColor(.white)
                        .bold()
                        .padding(10)
                        .background(.green)
                        .cornerRadius(5)
                }
            }
            Button(action: {
                viewModel.userLogOut()
            }) {
                Text("Log out")
                    .foregroundColor(.white)
                    .bold()
                    .padding(10)
                    .background(.red)
                    .cornerRadius(5)
            }
        }
    }
    
    func fetchText(hasFetched: Bool) -> String {
        if(!hasFetched) {
            DispatchQueue.main.async {
                presentationText = viewModel.getPresentation()
            }
        }
        return presentationText
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
    //    func setPresentation(presentation: String) {
    //        presentationText = presentation
    //    }
    //
    //    func getPresentation() -> String {
    //        return presentationText
    //    }
}

#Preview {
    ProfileView()
}
