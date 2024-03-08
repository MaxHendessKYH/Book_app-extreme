//
//  ListViewer.swift
//  Book_App_extreme
//
//  Created by Ali Alhasan on 2024-02-29.
//

import SwiftUI

struct ListViewer: View {
//    @State var bookList: [Books] = [Books(titel: "Harry Potter", author: "me", id: UUID(), imgUrl: URL(string: "mmm")!)]
//    
    
    @State var bookList: [Books] = [Books(titel: "Harry Potter", author: "J. K. Rowlling")]
    
    var body: some View {
        ZStack{
            
            LinearGradient(colors: [Color.purple , Color.red], startPoint: .topLeading, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
               
                
                
                List(bookList,id: \.id){ book in
                    
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
    ListViewer()
}

