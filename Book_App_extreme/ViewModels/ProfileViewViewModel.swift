import Foundation
import Firebase

class ProfileViewViewModel: ObservableObject {
    
    @Published var registrationDate: String?
    @Published var presentation: String?
    @Published var hasFetchedPresentation = false
    
    @Published var avatarString: String?
    
    func getUserMail() -> String {
        if let user = Auth.auth().currentUser {
            guard let mail = user.email else { return "nomail@empty.com" }
              return mail
          }
        return "No mail to display"
      }
    
    func getUserName() -> String {
        if let user = Auth.auth().currentUser {
            guard let name = user.displayName else { return "User" }
              return name
          }
        return "User"
      }
    
    func getPresentation() -> String {
        if let user = Auth.auth().currentUser {
            let firestore = Firestore.firestore()
            let presentationTextReference = firestore.collection("userPresentation").document(user.uid)
            
            presentationTextReference.getDocument { (document, error) in
                if let document = document, document.exists {
                        if let presentationText = document.data()?["text"] as? String {
                            self.presentation = presentationText
                        } else {
                            print("No text found for user with ID: \(user.uid).")
                        }
                } else {
                    print("Error fetching presentation: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
        
        return presentation ?? "NOTHING"
    }
    
    func changeDisplayName(newName: String) {
        if let user = Auth.auth().currentUser {
            let request = user.createProfileChangeRequest()
            
            if !newName.isEmpty {
                request.displayName = newName
                request.commitChanges { (error) in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    } else {
                        print("Name has successfully changed")
                    }
                }
            } else {
                print("Name cannot be empty")
            }
        } else {
            print("User is not not logged in")
        }
    }
    
    func addPresentationText(presentationText: String) {
        if let user = Auth.auth().currentUser {
            let firestore = Firestore.firestore()
            let presentationTextReference = firestore.collection("userPresentation").document(user.uid)
            presentationTextReference.setData(["text": presentationText]) { (error) in
                if let error = error {
                    print("Error \(user.uid): \(error.localizedDescription)")
                } else {
                    print("Presentationtext added for user: \(user.uid)")
                }
            }
        }
    }

    func getUserRegistrationDate() -> String {
         if let user = Auth.auth().currentUser {
             let registrationDate = formatDateToString(from: user.metadata.creationDate!)
             return registrationDate
             
         } else {
             return "No date"
         }
     }
    
    func userLogOut() {
        do {
            try Auth.auth().signOut()
            print("User has successfully logged out")
        } catch let signOutError as NSError {
            print("Error: \(signOutError.localizedDescription)")
        }
    }
    
   private func formatDateToString(from date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .medium
        return df.string(from: date)
    }
    
    private func changeAvatar() -> String {
        return avatarString ?? ""
    }
}
