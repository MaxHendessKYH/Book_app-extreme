//
//  BookListView.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//

import SwiftUI

struct BookListView: View {
    
    
    @ObservedObject var bookViewModel: BookListViewViewModel = BookListViewViewModel()
    
    
    
    @State var bookList = [BookItem]()
    
    
    
    var body: some View {
        ZStack{
            
            LinearGradient(colors: [Color.purple , Color.red], startPoint: .topLeading, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
               
                //kan ändras till var senare om det behövs vid bookViewn
                
                
               List(bookList,id: \.id){ book in
                        
                        HStack{
                            let urlString = book.volumeInfo.imageLinks?.smallThumbnail.absoluteString
                            
                           RemoteImageView(imageUrl: urlString!)
                                .padding(.trailing, 20)
                            //Image(systemName: "trash")

                            
                            
                            VStack{
                                Text(book.volumeInfo.title)
                                    .padding(5)
                                Text(book.volumeInfo.authors?[0] ?? "No author found ")
                                    .padding(5)
                            }
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
