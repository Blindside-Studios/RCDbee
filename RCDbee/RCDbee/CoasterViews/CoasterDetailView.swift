//
//  CoasterDetailView.swift
//  RCDbee
//
//  Created by Blindside on 20.10.24.
//

import SwiftUI

struct CoasterDetailView: View {
    @Binding var coaster: RCDBCoasterDetail!
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ZStack{
            Rectangle().fill(.blue).opacity(0.4)
            ScrollView{
                Group {
                    if horizontalSizeClass == .compact {
                        // iPhone layout
                        // image at the top
                        BannerView(pictureURL: .constant(coaster.mainPicture?.url))
                            .frame(height: 400)
                        // fact cards
                        DetailsHeaderView(coaster: .constant(coaster), spacing: .constant(10))
                            .offset(y: -95)
                    } else {
                        // iPad header layout
                        ZStack{
                            // image at the top
                            VStack{
                                BannerView(pictureURL: .constant(coaster.mainPicture?.url))
                                    .frame(height: 600)
                                Spacer()
                            }
                            // fact cards
                            VStack{
                                Spacer()
                                    .frame(height: 50)
                                DetailsHeaderView(coaster: .constant(coaster), spacing: .constant(300))
                            }
                        }
                    }
                }
                
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
