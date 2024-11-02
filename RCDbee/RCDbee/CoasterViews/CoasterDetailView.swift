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
            LinearGradient(gradient: Gradient(colors: [.cyan, .blue, .purple]), startPoint: .top, endPoint: .bottom)
                .contrast(5)
                .opacity(0.3)
            
            ScrollView{
                Group {
                    if horizontalSizeClass == .compact {
                        // iPhone layout
                        // image at the top
                        BannerView(pictureURL: .constant(coaster.mainPicture?.url), pictureID: .constant("\(String(describing: coaster.mainPicture!.id))"))
                            .frame(height: 400)
                        // fact cards
                        DetailsHeaderView(coaster: .constant(coaster), spacing: .constant(10))
                            .offset(y: -95)
                    } else {
                        // iPad header layout
                        ZStack{
                            // image at the top
                            VStack{
                                BannerView(pictureURL: .constant(coaster.mainPicture?.url), pictureID: .constant("\(coaster.mainPicture!.id)"))
                                    .frame(height: 600)
                                Spacer()
                            }
                            // fact cards
                            VStack{
                                Spacer()
                                    .frame(height: 50)
                                DetailsHeaderView(coaster: .constant(coaster), spacing: .constant(220))
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
            guard let url = Bundle.main.url(forResource: "Alpengeist", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let coaster = try? JSONDecoder().decode(RCDBCoasterDetail.self, from: data) else {
                return nil
            }
            return coaster
        }()
    
    CoasterDetailView(coaster: .constant(sampleCoaster))
}
