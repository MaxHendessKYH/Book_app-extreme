//
//  BookViewViewModel.swift
//  Book_App_extreme
//
//  Created by Max.Hendess on 2024-02-28.
//

import Foundation
class BookViewViewModel: ObservableObject{
    
    @Published var books = [BookItem]()
    
    @Published var searchText: String = ""
    @Published var categoryIndex: Int = 0
    let baseUrl = "https://www.googleapis.com/books/v1/volumes?q="
    
    // todo add searchterm instead of hardcoded value, inparameter and in apiURL (after volumes?q=)
    func getBooks( compleation: @escaping ([BookItem])-> Void){
        // Call api with searchword. Looking for harry potter books
        let apiURL = URL(string:combinedUrl())!
        // Here are the apis endpoints ( not implemented )
        //GET Specific info about a volume https://www.googleapis.com/books/v1/volumes/volumeID?
        //Get bookshelves https://www.googleapis.com/books/v1/myLibrary/bookshelves
        // Get MyLibrary https://www.googleapis.com/books/v1/myLibrary/bookshelves/bookshelfID?
        //api key, think its useless &key=AIzaSyC5sFbmsGJTzPu-F0Wkr7qcDnU_hz_VpcY
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: apiURL){ data , response , error in
        
            if let error{
                    print(error.localizedDescription)
                    return
                }
                
                guard let jsonData = data else {
                    print("no data found")
                    return
                }
             
            // check status code (you get 200 on a succesfull call )
                guard let httpRespons = response as? HTTPURLResponse else {
                    print("Error: no HTTPURL Response")
                    return
                }
                print("Your call got this Status Code:\(httpRespons.statusCode)")
            
                // Successfull api call start decoding process
                    do{
                        let decodedData = try JSONDecoder().decode(Book.self, from: jsonData)
                        DispatchQueue.main.async {
                            self.books = decodedData.items
                        }
                        compleation(decodedData.items)
                        
                    }catch{
                        print("Error decoding JSON \(error)")
                    }
        }
        
        task.resume()
    }
    
    func combinedUrl() -> String {
        let newUrl = "\(baseUrl)\(getCategoryString())\(searchText)"
        return newUrl
    }
    
    func getCategoryString() -> String {
        switch categoryIndex {
            case 0:
                return "intitle:"
            case 1:
                return "isbn:"
            case 2:
                return "inauthor:"
        default:
            return ""
        }
    }
}
