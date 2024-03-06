//
//  BookListViewViewModel.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//
import SwiftUI
import Foundation
import Firebase
class BookListViewViewModel: ObservableObject{
    
    
  @Published  var bokHyllor : [(String, [Books])] = [("test", []), ("Test2", [Books(titel: "Mybook", author: "Ali Alhasan")] )]
    
    
    let db =  Firestore.firestore()
    
    
    
    
    
    
    
    
    
    
    
    
     
    // Behövs inte, bara för testning
    var listOfBooks = [Books(titel: "Ali", author: "husien"),
                       Books(titel: "tli", author: "husien"),
                       Books(titel: "AAAli", author: "husien"),
                       Books(titel: "CCCli", author: "husien"),
                       Books(titel: "BBBli", author: "husien"),]
    
 
    func addList(listTitel: String){
        
        bokHyllor.append((listTitel, []))
    }
    
    func removeList(listTitel: String){
        
        
        bokHyllor = bokHyllor.filter { $0.0 != listTitel }
            
        
    }
    
    func uppdateList(listToBeUppdated: [Books]){
        
        
        //Implementeras efter vi fixar med databasen då uppdateras databasen med den nya listan
    }
    
    func sortList(unSortedList: [Books]) -> [Books]{
        
        var sortedList = unSortedList

        sortedList.sort()
        
        print(unSortedList)
        print(sortedList)
        
        
        return sortedList
    }
    
    
    
    func save(){
        
        db.collection("library")
            .document("myLibrary")
            .setData(["userLibrary": self.bokHyllor])
        
     
    }
    
    func fetchLibrary(){
        
        let documentReference = db.collection("library").document("myLibrary")


        documentReference.getDocument { (document, error) in
            if let error = error {
                print("Error getting document: \(error)")
                return
                
            } else {
                if let document = document, document.exists {


                    let data = document.data()

                    if let bookArray = data?["books"] as? [(String, [Books])] {
                        
                        for tuple in bookArray {
                            let title = tuple.0
                            let subArray = tuple.1
                            print("Title: \(title), Subarray: \(subArray)")
                            
                        }
                        
                        self.bokHyllor = bookArray

                    } else {
                        print("Error: Unable to retrieve the 'books' field or it's not an array of tuples.")
                        return
                    }
                } else {
                    print("Document does not exist")
                    return
                }
            }
        }
        

    }
  }
