import FirebaseFirestore
import FirebaseFirestoreSwift

class BookItemViewViewModel: ObservableObject {
    @Published var bookItem: BookItem

    init(bookItem: BookItem) {
        self.bookItem = bookItem
    }

    func addReviewAndSave(review: String, star: Int) {
        // Create a new review or update the existing one
        let newReview = Review(id: UUID().uuidString, star: star, comment: review)
        bookItem.reviews = newReview

        // Save the updated bookItem to Firestore
        let db = Firestore.firestore()
        do {
            let bookRef = db.collection("books").document(bookItem.id)
            try bookRef.setData(from: bookItem)
        } catch {
            print("Error saving bookItem: \(error.localizedDescription)")
        }
    }
    
    func fetchReviews(completion: @escaping (Review?) -> Void) {
        print("fetching reviews")
           let db = Firestore.firestore()
           let reviewsCollection = db.collection("books")
           reviewsCollection.whereField("id", isEqualTo: bookItem.id).getDocuments { (querySnapshot, error) in
               print("done fetch reviews")
               if let error = error {
                   print("Error fetching reviews: \(error.localizedDescription)")
                   completion(nil)
               } else {
                   let book = querySnapshot?.documents.compactMap { document in
                       try? document.data(as: BookItem.self)
                   }

                   print("done fetch reviews: \((book?.first)?.reviews)")
                   completion((book?.first)?.reviews)
               }
           }
       }
}
