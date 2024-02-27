//
//  BookListViewViewModel.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//

import Foundation
import SwiftUI

struct BookListViewViewModel : View{
    
    @State var books: [Book] = []
    
    var body: some View{
        VStack{
            Button("Test API"){
                getBooks()
            }
        }
    }
    func getBooks(){
        let apiURL = URL(string:"https:://www.googleapis.com/books/v1/volumes?q=search+terms")!
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
    
}
#Preview {
    BookListViewViewModel(books: <#T##[Book]#>)
}
