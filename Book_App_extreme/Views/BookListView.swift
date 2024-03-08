//
//  BookListView.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//

import SwiftUI

struct BookListView: View {
    
    
    @ObservedObject var bookViewModel: BookListViewViewModel = BookListViewViewModel()
    
    
    
    @State var bookList: [Books] = [Books(titel: "Harry Potter", author: "me"),
                                    
                                    Books(titel: "BAliBAli", author: "it is me"),
                                    
                                    Books(titel: "AliAliAli", author: "Ali Alhasan"),
                                    
                                    Books(titel: "AAAA", author: "me too")]
    
    var body: some View {
        ZStack{
            
            LinearGradient(colors: [Color.purple , Color.red], startPoint: .topLeading, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
               
                // kan ändras till var senare om det behövs vid bookViewn 
                let sortedList = bookViewModel.sortshelf(unSortedList: bookList)                 
                List(sortedList,id: \.id){ book in
                        
                        HStack{
                            Image(systemName: "trash")
                                .padding(.trailing, 20)
                            /*
                             AsyncImage(url: URL(string: viewModel.imageUrl))
                             */
                            
                            VStack{
                                Text(book.titel)
                                    .padding(5)
                                Text(book.author)
                                    .padding(5)
                            }
                        }
                        
                    }.scrollContentBackground(.hidden)
                
                
               
                
            }
            
            
                
             
            
        }
    }
   
}



#Preview {
    BookListView()
}
