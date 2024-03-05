import SwiftUI


struct ContentView: View {
    @State private var isShowingDialog = false

    var body: some View {
        Button("Show Dialog") {
            isShowingDialog.toggle()
        }
        .sheet(isPresented: $isShowingDialog) {
            BookRatingView(isPresented: $isShowingDialog)
        }
    }
}

struct BookRatingView: View {
    @Binding var isPresented: Bool
    @State private var rating: Int = 5
    @State private var comment: String = "Write your comments here..."

    var body: some View {
        VStack(spacing: 20) {
            Text("Rate This Book")
                .font(.title)
                .foregroundColor(.blue)
            
            HStack(spacing: 20) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= rating ? "star.fill" : "star")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(index <= rating ? Color.yellow : Color.gray.opacity(0.5))
                        .onTapGesture {
                            withAnimation {
                                // Set the rating to the tapped star
                                rating = index
                            }
                        }
                }
            }
            
            TextEditor(text: $comment)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                )
                .foregroundColor(.black)
                .frame(height: 100) // Adjust the height based on your preference
            
            Button(action: {
                // Handle the submission of the rating and comments
                print("Rating: \(rating), Comment: \(comment)")
                isPresented = false // Close the dialog
            }) {
                Text("Submit")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
