//
//  CoasterDetailView.swift
//  RCDbee
//
//  Created by Blindside on 20.10.24.
//

import SwiftUI

struct CoasterDetailView: View {
    @Binding var coaster: RCDBCoasterDetail!
    
    var adaptiveFactColumns: [GridItem] {
            [GridItem(.adaptive(minimum: 120, maximum: 200))]
        }
    
    var body: some View {
        ZStack{
            Rectangle().fill(.blue).opacity(0.4)
            ScrollView{
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
                    .padding()
                    Spacer()
                        .frame(height: 10)
                    ScrollView(.horizontal){
                        LazyHGrid(rows: adaptiveFactColumns, spacing: 10){
                            ForEach(coaster.statItems, id: \.statName) { item in
                                QuickFactCard(factIcon: .constant(Image(systemName: item.statIcon)), factHeader: .constant(item.statName), factContent: .constant(item.statValue!))
                                    .frame(width: 138, height: 140)
                            }
                        }
                        .padding()
                    }
                    .offset(y: -35)
                    .frame(height: 320)
                }
                .offset(y: -95)
                //.padding()
                Spacer()
            }
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
