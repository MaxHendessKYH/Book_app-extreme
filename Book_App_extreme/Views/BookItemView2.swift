//
//  BookItemView2.swift
//  Book_App_extreme
//
//  Created by Ali Alhasan on 2024-03-14.
//

import SwiftUI

struct BookItemView2: View {
    
    @ObservedObject var viewModel = BookListViewViewModel.shared
    @State var bookItem: BookItem
    @State private var isRatingMode = false
    @State private var rating: Int = 0
    @State private var reviewText: String = ""
    @State var text: String = ""
    @StateObject var viewModelRatings : BookItemViewViewModel
    @State private var isMenuVisible = false
    
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
                    RatingView2(rating: $rating)
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
                        viewModelRatings.addReviewAndSave(review: reviewText, star: rating)
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
                        viewModelRatings.fetchReviews { reviews in
                           if let reviews = reviews {
                               
                               print(reviews)
                                /*for review in reviews {
                                    print("Review ID: \(review.id), Star: \(review.star), Comment: \(review.comment)")
                                }
                            } else {
                                print("Failed to fetch reviews.")*/
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .foregroundColor(Color.brown)
                    .cornerRadius(5)
                }
                
               
                Divider()
                ScrollView {
                    Text(bookItem.volumeInfo.description ?? "")
                        .padding()
                }
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

struct RatingView2: View {
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

extension BookItemView2 {
    init(){
    
        let jsonString = """
        {
            \"title\": \"Harry Potter\",
            \"description\": \"About a wizard boy\",
            \"authors\": [\"Rowling\"]
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
        let volumeInfo = try! JSONDecoder().decode(VolumeInfo.self, from: jsonData)
        let bookitem = BookItem(id: "1", volumeInfo: volumeInfo)
        self.init(bookItem: bookitem,viewModelRatings:BookItemViewViewModel(bookItem: bookitem))
    }
}

/*#Preview {
    BookItemView2()
}
*/
