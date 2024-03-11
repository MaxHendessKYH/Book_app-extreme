//
//  AddBookShelfView.swift
//  Book_App_extreme
//
//  Created by Ali Alhasan on 2024-03-07.
//

import SwiftUI

struct AddBookShelfView: View {
    
    @ObservedObject var viewModel : BookListViewViewModel
    @State var isAlertpresented = false
    
    @State var newTitel: String = ""
    var body: some View {
        TextField("Type new shelf title", text: $newTitel)
            .padding()
            .frame(height: 50)
            .frame(maxWidth: 380)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.top, 20)
        
        Button("Add"){
            addShelf()
        }
        .foregroundStyle(.white)
        .padding(13)
        .bold()
        .background(.blue)
        .cornerRadius(10)
        .padding()
        .alert("Text is missing", isPresented: $isAlertpresented){
            Button("Ok", role: .cancel){}
        }
        Spacer()
            .navigationBarTitle("Add Bookshelf")
    }
    
    func addShelf() {
        
        if !newTitel.isEmpty{
            viewModel.addList(listTitel: newTitel)
        }
        else {
            isAlertpresented = true
        }
    }
}
/*
 #Preview {
 AddBookShelfView()
 }
 */
