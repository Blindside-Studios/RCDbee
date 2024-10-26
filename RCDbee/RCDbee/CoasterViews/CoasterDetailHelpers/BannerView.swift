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
        Group{
            GeometryReader { geometry in
                if ((pictureURL) != nil){
                    AsyncImage(url: URL(string: pictureURL!)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(width: geometry.size.width)
                    }
                }
                else { Image(systemName: "xmark.bin")
                        .resizable()
                        .opacity(0.3)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width)
                }
            }
        }
        .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .center, endPoint: .bottom))
        .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .center, endPoint: .bottom))
        .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .center, endPoint: .bottom))
    }
}

#Preview {
    BannerView(pictureURL: .constant("https://rcdb.com/aaebtta"))
}
