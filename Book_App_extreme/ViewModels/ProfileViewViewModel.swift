//
//  File.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//

import Foundation
import Firebase

class ProfileViewViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var registrationDate: String?
    
    
    func getUserMail() -> String {
        if let user = Auth.auth().currentUser {
            guard let mail = user.email else { return "nomail@empty.com" }
              return mail
          }
        return "No mail to display"
      }
    
    func getUserRegistrationDate() -> String {
         if let user = Auth.auth().currentUser {
             let registrationDate = formatDateToString(from: user.metadata.creationDate!)
             return registrationDate
             
         } else {
             return "No date"
         }
       
     }
    func formatDateToString(from date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .medium
        return df.string(from: date)
    }
}
