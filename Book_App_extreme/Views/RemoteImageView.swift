//
//  RemoteImageView.swift
//  Book_App_extreme
//
//  Created by Max.Hendess on 2024-03-06.
// used to convert URLS Into Images

import SwiftUI

struct RemoteImageView: View {
    let imageUrl: String
    @State private var image: UIImage?

    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onAppear(perform: loadImage)
        } else {
            ProgressView() // Placeholder while loading
                .onAppear(perform: loadImage)
        }
    }

    private func loadImage() {
        // make sure urlstring uses https
        let fixedUrl = convertToHttps(urlString: imageUrl)
        guard let url = URL(string: fixedUrl) else {
            print("Invalid URL \(imageUrl)")
            return
        }
        //Get image
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // check status code (you get 200 on a succesfull call )
                guard let httpRespons = response as? HTTPURLResponse else {
                    print("Error: \(response)")
                    return
                }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }else{
                print("no data recived")
            }
        }.resume()
    }
}
/*
 testing stuff
struct ContentView: View {
    var body: some View {
        RemoteImageView(imageUrl: "https://books.google.com/books/content?id=8zN_CgAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api")
            .frame(width: 200, height: 200)
            .clipped()
    }
}
 
 #Preview {
     ContentView()
 }
 */
func convertToHttps(urlString: String) -> String {
    // Check if the URL already starts with "https://"
    if urlString.lowercased().hasPrefix("https://") {
        return urlString // Already HTTPS, no need to convert
    } else if urlString.lowercased().hasPrefix("http://") {
        // Replace "http://" with "https://"
        return "https://" + urlString.dropFirst("http://".count)
    } else {
        // Unsupported scheme, return the original URL
        return urlString
    }
}
