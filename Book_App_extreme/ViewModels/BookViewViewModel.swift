//
//  BookViewViewModel.swift
//  Book_App_extreme
//
//  Created by Max.Hendess on 2024-02-28.
//

import Foundation
class BookViewViewModel: ObservableObject{
    
    @Published var books = [BookItem]()
    // todo add searchterm instead of hardcoded value, inparameter and in apiURL (after volumes?q=)
    func getBooks( compleation: @escaping ([BookItem])-> Void){
        // Call api serching for harry potter books
        let apiURL = URL(string:"https://www.googleapis.com/books/v1/volumes?q=harry+potter")!
        // &key=AIzaSyC5sFbmsGJTzPu-F0Wkr7qcDnU_hz_VpcY
        
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
             
            // check status code ( you want 200 )
                guard let httpRespons = response as? HTTPURLResponse else {
                    print("Error: no HTTPURL Response")
                    return
                }
                print("Your call got this Status Code:\(httpRespons.statusCode)")
            
            
                //  print("Data: \(String(data: jsonData , encoding: .utf8))" ?? "Decoding error")
                // Successfull api call start teh decoding process
               
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
}
