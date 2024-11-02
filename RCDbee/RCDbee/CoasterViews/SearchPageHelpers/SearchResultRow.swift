//
//  SearchResultRow.swift
//  RCDbee
//
//  Created by Blindside on 24.10.24.
//

import SwiftUI

struct SearchResultRow: View {
    @Binding var coaster: RCDBCoasterDetail?
    @Namespace var animationNamespace
    
    var body: some View {
        HStack{
            VStack{
                HStack{
                    Text(coaster?.name ?? "No name provided")
                        .font(.title)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.leading)
                        .matchedGeometryEffect(id: "name-\(coaster!.id)", in: animationNamespace)
                    Spacer()
                }
                Spacer()
                    .frame(height: 10)
                HStack{
                    Text("\(coaster?.park.name ?? "Park N/A"), \(coaster?.make ?? "Manufacturer N/A"), \(coaster?.country ?? "Country N/A")")
                        .multilineTextAlignment(.leading)
                        .opacity(0.7)
                        .lineLimit(3)
                        .minimumScaleFactor(1)
                        .matchedGeometryEffect(id: "details-\(coaster!.id)", in: animationNamespace)
                    Spacer()
                }
            }
            .padding(.bottom)
            .padding(.top)
            .padding(.leading, -80)
            .offset(x: 100)
            Spacer()
            
            ImageViewer(pictureURL: .constant(coaster?.mainPicture?.url), pictureID: .constant("\(coaster?.mainPicture?.id ?? 0)"))
                .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .trailing, endPoint: .leading))
                .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .trailing, endPoint: .leading))
                .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .trailing, endPoint: .leading))
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
