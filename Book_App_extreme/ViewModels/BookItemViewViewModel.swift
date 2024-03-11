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
}
