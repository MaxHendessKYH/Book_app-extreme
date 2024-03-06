//
//  NewBookItemView.swift
//  Book_App_extreme
//
//  Created by Mehdi on 2024-02-27.
//

import SwiftUI

struct BookItemView: View {
    @State var bookItem: BookItem
    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    Rectangle()
                        .frame(height: 300)
                        .background(.ultraThinMaterial)
                   RemoteImageView(imageUrl: convertBookUrltoString())
                }
                Text(bookItem.volumeInfo.title)
                    .font(.title)
                Text(bookItem.volumeInfo.authors?[0] ?? "")
                    Divider()
                Button("Add to Bookshelf") {
                }
            
                Divider()
                Text(bookItem.volumeInfo.description ?? "")
                    .padding()
                Spacer()
            }
            //.containerRelativeFrame([.horizontal, .vertical])
            //.background(Gradient(colors: [.teal,. cyan, .green]).opacity(0.6))
        }
    }
    func convertBookUrltoString() -> String{
        let bookURL:URL? =  bookItem.volumeInfo.imageLinks?.smallThumbnail
       if let url = bookURL
        {
           // make url into string
           let result:String = url.absoluteString
           return result
       }
        else{
            return ""
        }
    }
}

extension BookItemView {
    init() {
        let jsonString = """
        {
            \"title\": \"Harry Potter\",
            \"description\": \"About a wizard boy\",
            \"authors\": [\"Rowling\"]
        }
        """
        
        let jsonData = jsonString.data(using: .utf8)!
   
        var volumeInfo = try! JSONDecoder().decode(VolumeInfo.self, from: jsonData)
        
        let bookitem = BookItem(id: "1", volumeInfo: volumeInfo)
        
        self.init(bookItem: bookitem)
    }
}

#Preview {
    BookItemView()
}

