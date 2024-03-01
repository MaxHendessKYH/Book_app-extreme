//
//  Books.swift
//  Book_App_extreme
//
//  Created by Ali Alhasan on 2024-02-29.
//

import Foundation


class Books: Identifiable ,Comparable{
    
    
    static func == (lhs: Books, rhs: Books) -> Bool {
        return lhs.titel == rhs.titel
    }
    
    static func < (lhs: Books, rhs: Books) -> Bool {
    
        return lhs.titel < rhs.titel
    }
    
    
    var titel: String
    var author: String

    var id: UUID = UUID()
    
    //var imgUrl: URL
    // Add more attributes if you feel it is needed. /Ali
    
    init(titel: String, author: String) {
        self.titel = titel
        self.author = author
        
      //  self.imgUrl = imgUrl
    }
    
}
