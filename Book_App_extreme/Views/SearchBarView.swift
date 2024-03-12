//
//  SwiftUIView.swift
//  Book_App_extreme
//
//  Created by Jörgen Hård on 2024-02-28.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    @Binding var currentIndex: Int
    
    var onSearchClosure: () -> Void
    let searchFilters = ["Title", "ISBN", "Authors"]
    
    var body: some View {
        VStack {
            Picker("Category", selection: $currentIndex) {
                ForEach(0..<searchFilters.count, id: \.self) { index in
                    Text(searchFilters[index])
                }
            }
            .pickerStyle(.palette)
            .font(.title2)
            .foregroundColor(.brown)
            .bold()
            .padding()
            .background(.brown)
            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            .cornerRadius(10)
            
            HStack {
                TextField("Search", text: $searchText)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .foregroundStyle(.black)
                    .font(.title2)
                    .background(.white)
                    .cornerRadius(10)
                    .onChange(of: searchText, initial: false, { oldValue, newValue in
                        //Någon användning?
                })
                
                Button(action: {
                    onSearchClosure()
                    
                }) {
                    Image(systemName: "magnifyingglass")
                        .padding()
                        .background(.teal.secondary)
                        .foregroundStyle(.white)
                        .bold()
                        .cornerRadius(10)
                        .shadow(radius: 2)
                }
            }
            /* I think it dosen't need to be since Picker shows what we have chosen
             What do you think? :)
             
            Text("Category: \(searchFilters[currentIndex].uppercased())")
                .bold()
                .font(.title2)
                .foregroundStyle(.brown)
                .opacity(0.6)
            */
        }
        .padding()
    }
}
