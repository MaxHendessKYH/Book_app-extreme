//
//  HomeView.swift
//  Book_App_extreme
//
//  Created by Juhee Kang Johansson on 2024-03-05.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = BookListViewViewModel()
    
    @State var newTitel: String = ""
    
    var body: some View {
        NavigationView{
           
            
            VStack{
                NavigationLink{
                    
                    AddBookShelfView(viewModel: viewModel)
                    
                }label :{
                    
                    Image(systemName: "plus")
                }
                
                
                List{
                    
                    
                    ForEach(viewModel.bookshelves!.indices, id: \.self){ index in
                        
                        
                        if let shelfData = viewModel.bookshelves?[index],
                           let titel = shelfData["titel"] as? String,
                           let books = shelfData["bookshelf"] as? [Books]
                           {
                            
                            
                           // print(books)
                            
                            NavigationLink{
                                
                                BookListView(bookViewModel: viewModel, bookList: books)
                                
                            }label :{
                                
                                
                                HStack{
                                    Image(systemName: "books.vertical") 
                                    Text(titel)
                                    
                                }
                            }
                            
                            
                            
                            
                        }
                        
                        
                    }.onDelete(perform: { indexSet in
                        let shelfIndex = indexSet.first
                        
                        viewModel.removeList(shelfIndex: shelfIndex ??  -1) 
                    })
                    
                    
                }
                
                
                
                
                
                
                
                Text("Hello it is me")
                    .onTapGesture {
                        print(viewModel.bookshelves!)
                    }
            }
        }
    }
    
}

#Preview {
    HomeView()
}

/*
 List{
     
     
     ForEach(viewModel.bookshelves!.indices, id: \.self){ index in
         
         let (titel, _books) = viewModel.bookshelves![index]
         
         HStack{
             Image(systemName: "books.vertical")
             Text(titel)
             
         }
         
         
     }.onDelete(perform: { indexSet in
         let shelfIndex = indexSet.first
         
         viewModel.removeList(shelfIndex: shelfIndex ??  -1)
     })
     
     
 }

 */
