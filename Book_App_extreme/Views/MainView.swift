//
//  ContentView.swift
//  Book_App_extreme
//
//  Created by Max.Hendess on 2024-02-26.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var  librarian = BookViewViewModel()
    @State var apiBooks = [BookItem]()
    @State var myBookshelf = [BookItem]()
    
    var body: some View {
        VStack {
            // Title test - Harry Potter and the Philosopher's Stone
            // ISBN test - 1781100217 eller 9781781100219
            // Authors test - J.K. Rowling
            SearchBarView(searchText: $librarian.searchText, currentIndex: $librarian.categoryIndex, onSearchClosure: {
                apiBooks.removeAll()
//                // Get books from api
                librarian.getBooks{ books in
                    for book in books {
                        apiBooks.append(book)
                    }
                }
            })
            List{
                // show books from api
                ForEach(apiBooks, id: \.id){book in
                    NavigationLink{
                        NewBookItemView()
                    } label: {
                        Text(book.volumeInfo.title)
                    }
                    
                    Button("Add to Bookshelf"){
                        //Add book to bookshelf todo: save in database
                        myBookshelf.append(book)
                        print(myBookshelf)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    MainView()
}
