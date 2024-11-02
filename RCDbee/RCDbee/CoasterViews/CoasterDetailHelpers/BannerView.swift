//
//  BannerView.swift
//  RCDbee
//
//  Created by Blindside on 21.10.24.
//

import SwiftUI

struct BannerView: View {
    @Binding var pictureURL: String?
    @Binding var pictureID: String?
    
    var body: some View {
        ImageViewer(pictureURL: $pictureURL, pictureID: $pictureID)
        .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .center, endPoint: .bottom))
        .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .center, endPoint: .bottom))
        .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .center, endPoint: .bottom))
    }
}

#Preview {
    BannerView(pictureURL: .constant("https://rcdb.com/aaebtta"), pictureID: .constant(""))
}
