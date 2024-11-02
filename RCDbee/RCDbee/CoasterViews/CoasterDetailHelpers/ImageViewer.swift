//
//  ImageViewer.swift
//  RCDbee
//
//  Created by Blindside on 02.11.24.
//

import SwiftUI

struct ImageViewer: View {
    @Binding var pictureURL: String?
    @Binding var pictureID: String?
    
    @State private var uiImage: UIImage? = nil
    @State private var isLoading = true
    
    var body: some View {
        GeometryReader { geometry in
            if let image = uiImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width)
                    .clipped()
            } else if isLoading {
                Group{
                    ProgressView()
                        .frame(alignment: .center)
                }
                .onAppear {
                    loadImage()
                }
            } else {
                Image(systemName: "xmark.bin")
                    .resizable()
                    .opacity(0.3)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width)
            }
        }
    }
    
    private func loadImage() {
        guard let pictureID = pictureID else { return }
        
        // Check if image is already cached
        if let cachedImage = ImageCache.shared.getImage(forKey: pictureID) {
            self.uiImage = cachedImage
            return
        }
        
        // If not cached, proceed with download
        guard let urlString = pictureURL, let url = URL(string: urlString) else { return }
        
        isLoading = true
        URLSession.shared.dataTask(with: url) { data, response, error in
            isLoading = false
            if let data = data, let downloadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.uiImage = downloadedImage
                    ImageCache.shared.saveImage(downloadedImage, forKey: pictureID)
                }
            } else {
                debugPrint("Failed to download image: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
}

#Preview {
    ImageViewer(pictureURL: .constant("https://rcdb.com/aaebtta"), pictureID: .constant("xdfgchvjbkn"))
}
