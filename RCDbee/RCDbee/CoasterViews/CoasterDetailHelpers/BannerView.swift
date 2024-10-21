//
//  BannerView.swift
//  RCDbee
//
//  Created by Blindside on 21.10.24.
//

import SwiftUI

struct BannerView: View {
    @Binding var pictureURL: String?
    
    var body: some View {
        if ((pictureURL) != nil){
            GeometryReader { geometry in
                AsyncImage(url: URL(string: pictureURL!)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: 400)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
            }
            .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .center, endPoint: .bottom))
            .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .center, endPoint: .bottom))
            .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .center, endPoint: .bottom))
            .frame(height: 400)
        }
        else { Image(systemName: "xmark.bin") }
    }
}

#Preview {
    BannerView(pictureURL: .constant("https://rcdb.com/aaebtta"))
}
