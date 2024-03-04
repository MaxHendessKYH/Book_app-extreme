//
//  BookListViewViewModel.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//

import Foundation

class BookListViewViewModel: ObservableObject{
    
    
  @Published  var bokHyllor : [(String, [Books])] = [("test", []), ("Test2", [Books(titel: "Mybook", author: "Ali Alhasan")] )]
    
     
    var listOfBooks = [Books(titel: "Ali", author: "husien"),
                       Books(titel: "tli", author: "husien"),
                       Books(titel: "AAAli", author: "husien"),
                       Books(titel: "CCCli", author: "husien"),
                       Books(titel: "BBBli", author: "husien"),]
    
    

    func addList(listTitel: String){
        
        bokHyllor.append((listTitel, []))
    }
    
    func removeList(listTitel: String){
        
        
        print(bokHyllor)
        
        for i in 0 ... bokHyllor.count - 1{
            
            if bokHyllor[i].0  == listTitel {
               
                bokHyllor.remove(at: i)
                print(bokHyllor)
           }
                
        }
        
    
        
        
        
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
}
