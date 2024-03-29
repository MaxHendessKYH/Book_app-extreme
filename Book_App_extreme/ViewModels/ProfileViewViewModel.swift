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
        getUserName()
        getUserMail()
        getUserRegistrationDate()
        getUserPresentation()
        getUserAvatar()
    }
    
    /// Fetches the current users mail-address from Firebase as String.
    func getUserMail() {
        guard !hasFetchedMail else { return }
        if let user = Auth.auth().currentUser {
            guard let mail = user.email else { return}
            self.mail = mail
            self.hasFetchedMail = true
        }
    }
    
    /// Fetches the current users name from Firebase as String.
    func getUserName() {
        guard !hasFetchedName else { return }
        if let user = Auth.auth().currentUser {
            guard let name = user.displayName else { return }
            self.name = name
            self.hasFetchedName = true
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
    
    /// Changes the current users name.
    /// - Parameters:
    ///      - newName: The replacement-name as String.
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
}
