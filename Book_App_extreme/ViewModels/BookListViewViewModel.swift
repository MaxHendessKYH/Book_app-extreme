//
//  BookListViewViewModel.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//

import Foundation

class BookListViewViewModel: ObservableObject{
    
    
    var lists: [(String, [Books])] = [("test", []), ("Test2", [Books(titel: "Mybook", author: "Ali Alhasan")] )]
    
     
    var listOfBooks = [Books(titel: "Ali", author: "husien"),
                       Books(titel: "tli", author: "husien"),
                       Books(titel: "AAAli", author: "husien"),
                       Books(titel: "CCCli", author: "husien"),
                       Books(titel: "BBBli", author: "husien"),]
    
    

    func addList(listTitel: String){
        
        lists.append((listTitel, []))
    }
    
    func removeList(listTitel: String){
        
        //lists.remove complete !!!
        
       /* for i in lists{
            
            if lists[i] == listTitel
                
        }*/
        
        // I was going to test some methods and print list items
    }
    
    func uppdateList(listToBeUppdated: [Books]){
        
        sortList(unSortedList: listToBeUppdated)
        
        
    }
    
    func sortList(unSortedList: [Books]) -> [Books]{
        
        var sortedList = unSortedList

        sortedList.sort()
        
        print(unSortedList)
        print(sortedList)
        
        
        return sortedList
    }
}
