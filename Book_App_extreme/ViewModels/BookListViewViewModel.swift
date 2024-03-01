//
//  BookListViewViewModel.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//

import Foundation

class BookListViewViewModel: ObservableObject{
    
    
    var list: [(String, [Books])] = [("test", []), ("Test2", [Books(titel: "Mybook", author: "Ali Alhasan")] )]
    
     
    var listOfBooks = [Books(titel: "Ali", author: "husien"),
                       Books(titel: "tli", author: "husien"),
                       Books(titel: "AAAli", author: "husien"),
                       Books(titel: "CCCli", author: "husien"),
                       Books(titel: "BBBli", author: "husien"),]
    
    

    func addList(){
        
    }
    
    func removeList(){
        
    }
    
    func uppdateList(){
        
    }
    
    func sortList(unSortedList: [Books]) -> [Books]{
        
        var sortedList = unSortedList

        sortedList.sort()
        
        print(unSortedList)
        print(sortedList)
        
        
        return sortedList
    }
}
