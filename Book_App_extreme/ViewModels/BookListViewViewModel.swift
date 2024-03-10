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

        print(userId ?? "No userId")

    }
    
    func removeList(shelfIndex: Int){
        
        if shelfIndex >= 0{
            
            bookshelves!.remove(at: shelfIndex)
            
        }
     //   bookshelves = bookshelves.filter { $0.0 != listTitel }
            
        uppdate()
    }
    
    func uppdateshelf(listToBeUppdated: [Books]){
        
        
        //Implementeras efter vi fixar med databasen då uppdateras databasen med den nya listan
    }
    
    func sortshelf(unSortedList: [Books]) -> [Books]{
        
        var sortedList = unSortedList

        sortedList.sort()
        
        /*print(unSortedList)
        print(sortedList)
         */
        
        
        return sortedList
    }
    
    
    
    
    func uppdate(){
                
        
        //"myLibrary"
        db.collection("library")
            .document(self.userId ?? "path")
            .setData(["userLibrary": bookshelves ?? [] ])
     
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
  }




/*
 func fetchLibrary(){
     
     let documentReference = db.collection("library").document("myLibrary")


     documentReference.getDocument { (document, error) in
         if let error = error {
             print("Error getting document: \(error)")
             
             
         } else {
             if let document = document, document.exists {


                 let data = document.data()

                 if let bookArray = data?["books"] as? [(String, [Books])] {
                     
                     for tuple in bookArray {
                         let title = tuple.0
                         let subArray = tuple.1
                         print("Title: \(title), Subarray: \(subArray)")
                         
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
 */
