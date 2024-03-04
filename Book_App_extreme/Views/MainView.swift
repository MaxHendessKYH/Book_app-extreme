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
            Button("Test API"){
                // Get books from api
                librarian.getBooks{ books in
                    for book in books {
                        apiBooks.append(book)
                    }
                }
            }
            List{
                // show books from api
                ForEach(apiBooks, id: \.id){book in
                    NavigationLink(
                        destination: BookItemView(bookItem: book),
                    label: {
                        Text(book.volumeInfo.title ?? " no name ")
                    })
                    
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
    NavigationView {
        MainView()
    }
}
