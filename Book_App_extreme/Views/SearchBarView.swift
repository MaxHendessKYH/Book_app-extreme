//
//  SwiftUIView.swift
//  Book_App_extreme
//
//  Created by Jörgen Hård on 2024-02-28.
//

import SwiftUI

struct SearchBarView: View {
    
    @State private var searchText = ""
    @State private var currentIndex = 0
    
    let searchFilters = ["ISBN", "Titel", "Författare", "Genre"]
    
    var body: some View {
        VStack {
            Picker("Category", selection: $currentIndex) {
                ForEach(0..<searchFilters.count, id: \.self) { index in
                    Text(searchFilters[index])
                }
            }
            .pickerStyle(.palette)
            .font(.title2)
            .bold()
            .padding()
            .background(.brown)
            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            .cornerRadius(10)
            
            HStack {
                TextField("Sök...", text: $searchText)
                    .padding()
                    .foregroundStyle(.black)
                    .font(.title2)
                    .background(.white)
                    .textFieldStyle(.roundedBorder)
                    .cornerRadius(10)
                    .onChange(of: searchText, initial: false, { oldValue, newValue in
                        // API-anrop..
                        // Baserat på nuvarande index i filtret så
                        // vill vi hämta från specifik key.
                        
                        //print("Söker.. \(newValue) med filter \(searchFilters[currentIndex])")
                })
                
                Button(action: {
                    // Behövs knapp?
                    
                }) {
                    Image(systemName: "magnifyingglass")
                        .padding(10)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .bold()
                        .cornerRadius(10)
                        .shadow(radius: 2)
                }
            }
            
            Text("Kategori: \(searchFilters[currentIndex].uppercased())")
                .bold()
                .font(.title2)
                .foregroundStyle(.brown)
                .opacity(0.6)
            
            
            // Visa resultaten i en lista.
            
            
            Text("Resultat")
                .padding()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SearchBarView()
}
