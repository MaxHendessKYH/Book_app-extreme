//  NewBookItemView.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//
// ToDO = Solve the issue with the revealing buttons 

import SwiftUI

struct BookItemView: View {
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
                        viewModelRatings.addReviewAndSave(review: text, star: rating)
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
                        viewModelRatings.fetchReviews { review in
                            if let unwrappedReview = review {
                                text = unwrappedReview.comment
                                rating=unwrappedReview.star
                            } else {
                                print("fail to fetch data")
                            }
                        
                            
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .foregroundColor(Color.brown)
                    .cornerRadius(5)
                }
                
                Button("Add to Bookshelf") {   
                    isMenuVisible.toggle()
                }
                .frame(width: 500)
                .overlay(
                
                    MenuView(isVisible: $isMenuVisible) {
                        //ForEach(viewModel.bookshelfTitels as? [String] ?? ["not found", "Not Found"], id: \.self) { shelf in
                            
                        ForEach( viewModel.bookshelves!.indices, id: \.self) { index in
                            
                            if let shelfData = viewModel.bookshelves?[index],
                               let titel = shelfData["titel"] as? String{
                                
                                Button(action: {
                                    
                                    isMenuVisible.toggle()
                                    viewModel.addBookToShelf(shelfTitel: titel , book: bookItem)
                                    
                                    
                                    
                                }) {
                                    Text(titel)
                                }
                                
                                //.zIndex(1.0)
                                
                            }
                        }
                       }
                
                
                
                    //alignment: .bottom
                
                )
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
        self.init(bookItem: bookitem,viewModelRatings:BookItemViewViewModel(bookItem: bookitem))
    }
}

struct BookItemView_Previews: PreviewProvider {
    static var previews: some View {
        BookItemView()
    }
}
struct MenuView<Content: View>: View {
    @Binding var isVisible: Bool
    var content: Content

    init(isVisible: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isVisible = isVisible
        self.content = content()
    }

    var body: some View {
        if isVisible {
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                    .onTapGesture {
                        isVisible = false
                    }
                VStack {
                    content
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
