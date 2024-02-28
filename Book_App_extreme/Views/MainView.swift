//
//  ContentView.swift
//  Book_App_extreme
//
//  Created by Max.Hendess on 2024-02-26.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var  bookListVM = BookListViewViewModel()
    var body: some View {
        VStack {
            Button("Test API"){
            bookListVM.getBooks{ books in
                for book in books {
                    print(book.volumeInfo.title)
                }
            }
            }
            .padding()
        }
    }
}

#Preview {
    MainView()
}
