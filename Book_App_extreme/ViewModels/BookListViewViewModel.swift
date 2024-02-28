//
//  BookListViewViewModel.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//

import Foundation
import SwiftUI

class BookListViewViewModel: ObservableObject{
    
    @State var books: [Book] = []
    
    func getBooks(){  
        // Call api serching for harry potter books
        let apiURL = URL(string:"https://www.googleapis.com/books/v1/volumes?q=harry+potter&key=AIzaSyC5sFbmsGJTzPu-F0Wkr7qcDnU_hz_VpcY")!
        let session = URLSession.shared
        
        let task = session.dataTask(with: apiURL) { data, response, error in
            
            if let error{
                print(error.localizedDescription)
                return
            }
            
            guard let jsonData = data else {
            print("no data found")
                return
            }
            
            do{
                let decodedData = try JSONDecoder().decode([Book].self, from: jsonData)
                
                DispatchQueue.main.async {
                    self.books = decodedData
                }
            }catch{
                print("Error decoding JSON")
            }
            }
        task.resume()
    }
    }


struct Book : Codable{
    let title: String
    let authors: [String]
    let description: String?
    let publishedDate: String?
    let categories: [String]
    let pageCount: Int?
    let isbn10: String?
    let isbn13: String?
    let thumbnailURL: URL?
    let fullImageURL: URL?
    let infoLink: URL?
    let previewLink: URL?
}
