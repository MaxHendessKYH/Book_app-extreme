//
//  PopUpMessageView.swift
//  Book_App_extreme
//
//  Created by Jörgen Hård on 2024-03-04.
//

import SwiftUI

struct MessageInfoView: View {
   var systemImageText: String
   var color: Color
   var message: String

       var body: some View {
           ZStack {
               
               RoundedRectangle(cornerRadius: 20)
                   .frame(width: 300, height: 50)
                   .foregroundStyle(color)
                   .opacity(0.5)
                   .padding()
               
               HStack {
                   Image(systemName: systemImageText)
                   Text(message)
                       .foregroundColor(.black)
                       .multilineTextAlignment(.center)
                   
               }
           }
       }
}

#Preview {
    MessageInfoView(systemImageText: "person", color: Color.blue, message: "Test")
}
