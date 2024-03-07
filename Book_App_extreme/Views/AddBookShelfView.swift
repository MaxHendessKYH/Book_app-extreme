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
        
        Button("Add Shelf"){
            
            addShelf()
        }
        .foregroundStyle(.white)
        .padding(13)
        .background(.red)
        .cornerRadius(30)
        .padding()
        .alert("Text is missing", isPresented: $isAlertpresented){
            Button("Ok", role: .cancel){}
            
            Spacer()
            
        }
        Spacer()

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
