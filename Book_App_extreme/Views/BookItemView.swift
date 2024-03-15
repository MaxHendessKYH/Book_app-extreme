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
    @State private var selectedOptionIndex = -1

    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .frame(height: 300)
                        .background(.ultraThinMaterial)
                    RemoteImageView(imageUrl: convertBookUrltoString())
                        .frame(maxWidth: 250, maxHeight: 300)
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
                

                Button("Add to Bookshelf") {   
                    isMenuVisible = true
                    

                }
                
                .frame(width: 500)
                .overlay(
                
                    MenuView(isVisible: $isMenuVisible, options: viewModel.bookshelves ?? [], selectedOptionIndex: $selectedOptionIndex) {
                           
                       }
                )
                .onChange(of: selectedOptionIndex, initial: false){ oldIndex, newIndex in
                    let title = viewModel.bookshelves?[newIndex]["titel"] as? String
                    viewModel.addBookToShelf(shelfTitel: title ?? "", book: bookItem)
                    isMenuVisible = false
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
        let volumeInfo = try! JSONDecoder().decode(VolumeInfo.self, from: jsonData)
        let bookitem = BookItem(id: "1", volumeInfo: volumeInfo)
        self.init(bookItem: bookitem,viewModelRatings:BookItemViewViewModel(bookItem: bookitem))
    }
}

#Preview {
    BookItemView()
}

struct MenuView<Content: View>: View {
    @Binding var isVisible: Bool
    var options: [[String: Any]]
    @Binding var selectedOptionIndex: Int
    
    var content: Content

    init(isVisible: Binding<Bool>, options: [[String: Any]], selectedOptionIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self._isVisible = isVisible
        self.options = options
        self._selectedOptionIndex = selectedOptionIndex
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
                    Picker(selection: $selectedOptionIndex, label: Text("")) {
                        ForEach(0..<options.count, id: \.self) { index in
                            Text(options[index]["titel"] as? String ?? "").tag(index)
                           // Text("hello Worldnnn").tag(index)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    
                    content
                        .padding()
                        .foregroundColor(.black)
                    
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}


