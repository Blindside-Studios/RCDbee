//
//  CoasterDetailView.swift
//  RCDbee
//
//  Created by Blindside on 20.10.24.
//

import SwiftUI

struct CoasterDetailView: View {
    @Binding var coaster: RCDBCoasterDetail!
    
    var body: some View {
        VStack{
            // image at the top
            BannerView(pictureURL: .constant(coaster.mainPicture?.url))
            
            // fact card
            VStack{
                HStack{
                    Text("\(coaster.name)")
                        .font(.system(size: 54))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer()
                    .frame(height: 20)
                HStack{
                    Text(coaster.make ?? "Unknown Manufacturer")
                    Spacer()
                }
                HStack{
                    Text(coaster.type ?? "Unknown Type")
                    Divider()
                    Text(coaster.design ?? "Unknown Design")
                    Spacer()
                }
                .frame(height:30)
            }
            .offset(y: -95)
            .padding()
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    @Previewable @State var sampleCoaster: RCDBCoasterDetail? = {
            guard let url = Bundle.main.url(forResource: "Taron", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let coaster = try? JSONDecoder().decode(RCDBCoasterDetail.self, from: data) else {
                return nil
            }
            return coaster
        }()
    
    CoasterDetailView(coaster: .constant(sampleCoaster))
}
