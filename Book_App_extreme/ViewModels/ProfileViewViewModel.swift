import Foundation
import Firebase

class ProfileViewViewModel: ObservableObject {
    @Published var registrationDate: String?
    @Published var presentation: String?
    @Published var mail: String?
    @Published var name: String?
    @Published var avatarString: String?
    
    @Published var hasFetchedName = false
    @Published var hasFetchedPresentation = false
    @Published var hasFetchedMail = false
    @Published var hasFetchedDate = false
    @Published var hasFetchedAvatar = false
    
    init() {
        getUserNameFromDictionary()
        getUserMail()
        getUserRegistrationDate()
        getUserPresentation()
        getUserAvatar()
    }
    
    /// Fetches the current users mail-address from authentication from Firebase as String.
    func getUserMail() {
        guard !hasFetchedMail else { return }
        if let user = Auth.auth().currentUser {
            guard let mail = user.email else { return}
            self.mail = mail
            self.hasFetchedMail = true
        }
    }
    
    /// Fetches the current users name from Firebase as String.
    func getUserNameFromDictionary() {
        guard !hasFetchedName else { return }
        if let user = Auth.auth().currentUser {
            let firestore = Firestore.firestore()
            let userName = firestore.collection("users").document(user.uid)
            userName.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let newName = document.data()?["name"] as? String {
                        self.name = newName
                        self.hasFetchedName = true
                    } else {
                        print("No text found for user with ID: \(user.uid).")
                    }
                } else {
                    print("Error fetching presentation: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
    }
    
    /// Fetches the current users system-image from Firebase as String.
    func getUserAvatar() {
        if !hasFetchedAvatar {
            if let user = Auth.auth().currentUser {
                let firestore = Firestore.firestore()
                let avatarStringReference = firestore.collection("userAvatar").document(user.uid)
                avatarStringReference.getDocument { (document, error) in
                    if let document = document, document.exists {
                        if let avatar = document.data()?["avatarString"] as? String {
                            self.avatarString = avatar
                            self.hasFetchedAvatar = true
                        } else {
                            print("No avatar found for user with ID: \(user.uid).")
                        }
                    } else {
                        print("Error fetching avatar: \(error?.localizedDescription ?? "Unknown error")")
                    }
                }
            }
        }
    }
    
    /// Fetches the current users presentation-text from Firebase as String.
    func getUserPresentation() {
        guard !hasFetchedPresentation else { return }
        if let user = Auth.auth().currentUser {
            let firestore = Firestore.firestore()
            let presentationTextReference = firestore.collection("userPresentation").document(user.uid)
            
            presentationTextReference.getDocument { (document, error) in
                if let document = document, document.exists {
                    if let presentationText = document.data()?["text"] as? String {
                        self.presentation = presentationText
                        self.hasFetchedPresentation = true
                    } else {
                        print("No text found for user with ID: \(user.uid).")
                    }
                } else {
                    print("Error fetching presentation: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }
    }
    
    /// Formatting a Date to a String, without the time.
    /// - Parameters:
    ///      - date: The Date-struct to format.
    /// - Returns:
    ///     A String of the Date.
    private func formatDateToString(from date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        return df.string(from: date)
    }
    
    /// Fetches the current users date of registration from Firebase as String.
    func getUserRegistrationDate() {
        guard !hasFetchedDate else { return }
        if let user = Auth.auth().currentUser {
            let registrationDate = formatDateToString(from: user.metadata.creationDate!)
            self.registrationDate = registrationDate
            self.hasFetchedDate = true
        }
    }
    
    /// Overwrites the current users name.
    /// - Parameters:
    ///      - nameString: The replacement-name as String.
    func overwriteName(nameString: String) {
        if let user = Auth.auth().currentUser {
            let firestore = Firestore.firestore()
            let userReference = firestore.collection("users").document(user.uid)
            if !nameString.isEmpty {
                userReference.updateData(["name": nameString]) { (error) in
                    if let error = error {
                        print("Error \(user.uid): \(error.localizedDescription)")
                    } else {
                        print("Name is updated: \(user.uid)")
                    }
                }
            } else {
                print("Name is empty")
            }
        }
    }
    
    /// Overwrites the current users presentation-text.
    /// - Parameters:
    ///      - presentationText: The replacement-text as String.
    func overwritePresentationText(presentationText: String) {
        if let user = Auth.auth().currentUser {
            let firestore = Firestore.firestore()
            let presentationTextReference = firestore.collection("userPresentation").document(user.uid)
            if !presentationText.isEmpty {
                presentationTextReference.setData(["text": presentationText]) { (error) in
                    if let error = error {
                        print("Error \(user.uid): \(error.localizedDescription)")
                    } else {
                        print("Presentationtext updated for user: \(user.uid)")
                    }
                }
            } else {
                print("Presentationtext empty")
            }
        }
    }
    
    /// Overwrites the current users image-string from system-images.
    /// - Parameters:
    ///      - avatar: The replacement image-string.
    func overwriteAvatarString(avatar: String) {
        if let user = Auth.auth().currentUser {
            let firestore = Firestore.firestore()
            let avatarStringReference = firestore.collection("userAvatar").document(user.uid)
            avatarStringReference.setData(["avatarString": avatar]) { (error) in
                if let error = error {
                    print("Error \(user.uid): \(error.localizedDescription)")
                } else {
                    print("Image updated for user: \(user.uid)")
                }
            }
        }
    }
    
    /// Logging out the current user.
    func userLogOut() {
        do {
            try Auth.auth().signOut()
            print("User has successfully logged out")
        } catch let signOutError as NSError {
            print("Error: \(signOutError.localizedDescription)")
        }
    }
    
    /// Deleting the current users stored documents.
    func deleteDocumentsForUser() {
        if let user = Auth.auth().currentUser {
            let firestore = Firestore.firestore()
            let userBooks = firestore.collection("books").document(user.uid)
            let userLibrary = firestore.collection("library").document(user.uid)
            let presentationDocument = firestore.collection("userPresentation").document(user.uid)
            let imageDocument = firestore.collection("userAvatar").document(user.uid)
            let userData = firestore.collection("users").document(user.uid)
            userBooks.delete()
            userLibrary.delete()
            presentationDocument.delete()
            imageDocument.delete()
            userData.delete()
            { error in
                if let error = error {
                    print("Error deleting documents: \(error.localizedDescription)")
                } else {
                    print("Documents deleted.")
                }
            }
        }
    }
    
    /// Deleting the current authentication user.
    func deleteUser() {
        guard let user = Auth.auth().currentUser else {return}
        user.delete() { error in
            if let error = error {
                print("Error when trying to delete user: \(error.localizedDescription)")
            } else {
                print("User deleted.")
            }
        }
    }
}
