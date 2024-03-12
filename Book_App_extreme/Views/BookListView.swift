//
//  BookListView.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//

import SwiftUI

struct BookListView: View {
    
    
    @ObservedObject var bookViewModel = BookListViewViewModel.shared
    
    @State var bookShelfIndex: Int
        
    
    var body: some View {
        
        ZStack{
            
            LinearGradient(colors: [Color.purple , Color.red], startPoint: .topLeading, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
               
                
                
                List{
                    
                    
                    if let shelfData = bookViewModel.bookshelves?[bookShelfIndex],
                       let titel = shelfData["titel"] as? String,
                       let books = shelfData["bookshelf"] as? [BookItem]
                    {
                        
                        ForEach(books,id: \.id){ book in
                            
                            HStack{
                                let urlString = book.volumeInfo.imageLinks?.smallThumbnail.absoluteString
                                
                                RemoteImageView(imageUrl: urlString!)
                                    .padding(.trailing, 20)
                                
                                
                                
                                VStack{
                                    Text(book.volumeInfo.title)
                                        .padding(5)
                                    Text(book.volumeInfo.authors?[0] ?? "No author found ")
                                        .padding(5)
                                }
                            }
                            
                        }.onDelete(perform: { indexSet in
                            
                            let bookIndex = indexSet.first
                            bookViewModel.removeBookFromShelf(shelfTitel: titel, index: bookIndex ?? -1)
                        })
                        
                        
                        
                    }
                }.scrollContentBackground(.hidden)
            }
            
            
                
             
            
        }
    }
   
}



/*
 #Preview {
 BookListView()
 }
 */
