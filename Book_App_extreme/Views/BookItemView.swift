//
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
    @State private var isMenuVisible = false
    

    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    Rectangle()
                        .frame(height: 300)
                        .background(.ultraThinMaterial)
                   RemoteImageView(imageUrl: convertBookUrltoString())
                }
                Text(bookItem.volumeInfo.title)
                    .font(.title)
                Text(bookItem.volumeInfo.authors?[0] ?? "")
                    Divider()
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
            //.containerRelativeFrame([.horizontal, .vertical])
            //.background(Gradient(colors: [.teal,. cyan, .green]).opacity(0.6))
        }
    }
    func convertBookUrltoString() -> String{
        let bookURL:URL? =  bookItem.volumeInfo.imageLinks?.smallThumbnail
       if let url = bookURL
        {
           // make url into string
           let result:String = url.absoluteString
           return result
       }
        else{
            return ""
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
        
        self.init(bookItem: bookitem)
    }
}

#Preview {
    BookItemView()
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

