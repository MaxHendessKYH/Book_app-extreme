//
//  BookListViewViewModel.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//
import SwiftUI
import Foundation
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth

class BookListViewViewModel: ObservableObject{
 
    static var shared = BookListViewViewModel()
    
    
  
    var userId: String?
    //@Published var bookshelves : [(String, [Books])]? = []
    
    @Published var bookshelves : [[String: Any]]? = []
    

    let db =  Firestore.firestore()

    
    init(){
        
        getUserId()
        fetchLibrary()
    
    }
    
   
        
        
    
    
    
 
    func addList(listTitel: String){
        
        bookshelves!.append(["titel": listTitel, "bookshelf": []])

            uppdate()


    }
    
    func removeList(shelfIndex: Int){
        
        if shelfIndex >= 0{
            
            bookshelves!.remove(at: shelfIndex)
        }
            
        uppdate()
    }
    
    
    
    
   
    
    
    
   
     

    func uppdate() {
        

        var bookshelvesJson : [[String: Any]]? = []
        
        let encoder = JSONEncoder()
        
        for bookshelf in self.bookshelves!{
            
            let titel = bookshelf["titel"]
            
            let bookArray = bookshelf["bookshelf"] as? [BookItem]
            do {
                let jsonData = try encoder.encode(bookArray)
                let jsonString = String(data: jsonData, encoding: .utf8)
                
                
                bookshelvesJson!.append(["titel": titel!  ,"bookshelf": jsonString! ])
                
            } catch  {
                
                
                print("Error encoding [BookItem] to JSON")
            }
            
            
            
        }
        
        
        
        
        
        db.collection("library")
            .document(self.userId ?? "path")
            .setData(["userLibrary": bookshelvesJson ?? []])
    }


        
        
     
    
    
    
    func fetchLibrary(){
        
        let documentReference = db.collection("library").document(self.userId ?? "path")

           documentReference.getDocument { (document, error) in
               if let error = error {
                   print("Error getting document: \(error)")
               } else {
                   if let document = document, document.exists {
                       let data = document.data()

                       if let bookArray = data?["userLibrary"] as? [[String: Any]] {
                           var fetchedBookshelves: [[String: Any]] = []

                           for shelf in bookArray {
                               do {
                                   guard
                                       let titel = shelf["titel"] as? String,
                                       let jsonString = shelf["bookshelf"] as? String,
                                       let jsonData = jsonString.data(using: .utf8)
                                   else {return}
                                   
                                   
                                   let bookArray2 = try JSONDecoder().decode([BookItem].self, from: jsonData)
                                   fetchedBookshelves.append(["titel": titel, "bookshelf": bookArray2])
                               } catch {
                                   print("Error decoding bookshelf data: \(error)")
                               }
                           }

                           self.bookshelves = fetchedBookshelves
                       } else {
                           print("Error: Unable to retrieve the 'userLibrary' field or it's not an array of dictionaries.")
                       }
                   } else {
                       print("Document does not exist")
                   }
               }
           }
       }

    
    
    func getUserId(){
        
        
        let user = Auth.auth().currentUser
      
        self.userId = user?.uid
        
    }
    
    
    func addBookToShelf(shelfTitel: String, book: BookItem){
        

        
        let length = self.bookshelves?.count ?? 100 // vad kan står istället för 100?
        for i in 0 ... (length - 1) {
            
            if self.bookshelves?[i]["titel"] as? String == shelfTitel{
                
             var bookArray = self.bookshelves?[i]["bookshelf"] as? [BookItem] ?? []
                
                bookArray.append(book)
                
                self.bookshelves?[i]["bookshelf"] = bookArray as Any
                uppdate()
                
                

            }
        }
    }
    
    func removeBookFromShelf(shelfTitel: String, index: Int){
        
        if index >= 0{
            
            
            let length = self.bookshelves?.count ?? 100 // vad kan står istället för 100?
            for i in 0 ... (length - 1) {
                
                if self.bookshelves?[i]["titel"] as? String == shelfTitel{
                    
                    var bookArray = self.bookshelves?[i]["bookshelf"] as? [BookItem] ?? []
                    
                    bookArray.remove(at: index)
                    
                    self.bookshelves?[i]["bookshelf"] = bookArray as Any

                                        
                    
                }
            }
        }
        uppdate()

    }
    
    
  }






// these are last modified on 10 mars 2024

/*
 
 func fetchLibrary(){
     
     let documentReference = db.collection("library").document(self.userId ?? "path")


     documentReference.getDocument { (document, error) in
         if let error = error {
             print("Error getting document: \(error)")
             
             
         } else {
             if let document = document, document.exists {


                 let data = document.data()

                 if let bookArray = data?["userLibrary"] as? [[String: Any]] {
                     
                     
                     
                     
                     for shelf in bookArray{
                         
                         let titel = shelf["titel"]
                         self.bookshelfTitels.append(titel ?? "")
                     }
                     
                     
                     
                     
                 
                     self.bookshelves = bookArray

                 } else {
                     print("Error: Unable to retrieve the 'books' field or it's not an array of tuples.")
                     
                 }
             } else {
                 print("Document does not exist")
                 
             }
         }
     }
 }
 func getUserId(){
     
     
     let user = Auth.auth().currentUser
   
     self.userId = user?.uid
     
 }
 
 
 func addBookToShelf(shelfTitel: String, book: BookItem){
     
     let length = self.bookshelves?.count ?? 2 // vad kan står istället för 2?
     for i in 0 ... (length - 1) {
         
         if self.bookshelves?[i]["titel"] as? String == shelfTitel{
             
          var bookArray = self.bookshelves?[i]["bookshelf"] as? [BookItem] ?? []
             
             bookArray.append(book)
             self.bookshelves?[i]["bookshelf"] = bookArray as Any
             

            uppdate()
             //

         }
     }
 }
 
 
}
 
 
 
 
 
 // Fetch 2
 
 func fetchLibrary(){
     
     let documentReference = db.collection("library").document(self.userId ?? "path")


     documentReference.getDocument { (document, error) in
         if let error = error {
             print("Error getting document: \(error)")
             
             
         } else {
             if let document = document, document.exists {


                 let data = document.data()

                 if let bookArray = data?["userLibrary"] as? [[String: Any]] {
                     
                     
                     
                    var  bookArrayFromJson : [[String: Any]]? = []
                     
                     guard !bookArray.isEmpty else {return}
                     
                     for shelf in bookArray{
                         
                         let titel = shelf["title"]
                         self.bookshelfTitels.append(titel ?? "")
                         
                         let decoder = JSONDecoder()
                         let jsonString = shelf["bookshelf"] as? String
                         print(jsonString ?? "No JsonString found")
                         print(titel)
                         print(shelf)
                         let jsonData = jsonString?.data(using: .utf8)
                         let bookItemArray =  try! decoder.decode( [BookItem].self , from: jsonData!)
                         bookArrayFromJson?.append(["title": titel!, "bookshelf": bookItemArray])
                         
                     }
                     
                     
                     
                     
                 
                     self.bookshelves = bookArrayFromJson

                 } else {
                     print("Error: Unable to retrieve the 'books' field or it's not an array of tuples.")
                     
                 }
             } else {
                 print("Document does not exist")
                 
             }
         }
     }
 }
 
 
 
 func countNumberOfBooks(){
     
     for shelf in self.bookshelves!{
         
         
         let books = shelf["bookshelf"] as? [BookItem]
         let count = books!.count
         print(count)
     }
 }
 
 
 
 
 
 */
