import SwiftUI

struct BookItemView: View {
    @State var bookItem: BookItem
    @State private var isRatingMode = false
    @State private var rating: Int = 0
    @State private var reviewText: String = ""
    @State var text: String = ""
    @StateObject var viewModel : BookItemViewViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .frame(height: 300)
                        .background(.ultraThinMaterial)
                    RemoteImageView(imageUrl: convertBookUrltoString())
                }
                Text(bookItem.volumeInfo.title)
                    .font(.title)
                Text(bookItem.volumeInfo.authors?[0] ?? "")
                Divider()
                
                if isRatingMode {
                    RatingView(rating: $rating)
                        .padding()
                    VStack {
                        // Input
                        TextEditor(text: $text)
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.brown, lineWidth: 1)
                            )
                    }
                
                
                    Button("Done") {
                        viewModel.addReviewAndSave(review: reviewText, star: rating)
                        isRatingMode.toggle()
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .padding()
                    .background(Color.white)
                    .foregroundColor(Color.brown)
                    .cornerRadius(5)
                } else {
                    Button("Rate/Review") {
                        isRatingMode.toggle()
                    }
                    .padding()
                    .background(Color.white)
                    .foregroundColor(Color.brown)
                    .cornerRadius(5)
                }
                
                Button("Add to Bookshelf") {
                    // Handle add to bookshelf action
                }
                
                Divider()
                Text(bookItem.volumeInfo.description ?? "")
                    .padding()
                Spacer()
            }
        }
    }
    
    func convertBookUrltoString() -> String {
        let bookURL: URL? =  bookItem.volumeInfo.imageLinks?.smallThumbnail
        if let url = bookURL {
            let result: String = url.absoluteString
            return result
        } else {
            return ""
        }
    }
}

struct RatingView: View {
    @Binding var rating: Int

    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
}

extension BookItemView {
    init() {
        let jsonString = """
        {
            \"title\": \"Harry Potter\",
            \"description\": \"About a wizard boy\",
            \"authors\": [\"Rowling\"]
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        var volumeInfo = try! JSONDecoder().decode(VolumeInfo.self, from: jsonData)
        let bookitem = BookItem(id: "1", volumeInfo: volumeInfo)
        self.init(bookItem: bookitem,viewModel:BookItemViewViewModel(bookItem: bookitem))
    }
}

struct BookItemView_Previews: PreviewProvider {
    static var previews: some View {
        BookItemView()
    }
}
