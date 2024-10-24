//
//  SearchResultRow.swift
//  RCDbee
//
//  Created by Blindside on 24.10.24.
//

import SwiftUI

struct SearchResultRow: View {
    @Binding var coaster: RCDBCoasterDetail?
    
    var body: some View {
        HStack{
            VStack{
                HStack{
                    Text(coaster?.name ?? "No name provided")
                        .font(.title)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
                    .frame(height: 10)
                HStack{
                    Text("\(coaster?.park.name ?? "Park N/A"), \(coaster?.make ?? "Manufacturer N/A"), \(coaster?.country ?? "Country N/A")")
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                    Spacer()
                }
            }
            .padding(.bottom)
            .padding(.top)
            .padding(.leading, -80)
            .offset(x: 100)
            Spacer()
            if ((coaster?.mainPicture?.url) != nil){
                let pictureURL = coaster?.mainPicture?.url
                GeometryReader { geometry in
                    AsyncImage(url: URL(string: pictureURL!)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                }
                .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .trailing, endPoint: .leading))
                .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .trailing, endPoint: .leading))
                .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .trailing, endPoint: .leading))
            }
            else { Image(systemName: "xmark.bin")
                    .resizable()
                    .opacity(0.3)
                    .aspectRatio(contentMode: .fill)
                    .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .trailing, endPoint: .leading))
                    .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .trailing, endPoint: .leading))
                    .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .trailing, endPoint: .leading))
            }
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}

#Preview {
    @Previewable @State var sampleCoaster: RCDBCoasterDetail? = {
            guard let url = Bundle.main.url(forResource: "Alpengeist", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let coaster = try? JSONDecoder().decode(RCDBCoasterDetail.self, from: data) else {
                return nil
            }
            return coaster
        }()
    
    SearchResultRow(coaster: .constant(sampleCoaster))
        .frame(height: 150)
}
