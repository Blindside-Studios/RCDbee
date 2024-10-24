//
//  DetailsHeaderView.swift
//  RCDbee
//
//  Created by Nicolas Helbig on 24.10.24.
//

import SwiftUI

struct DetailsHeaderView: View {
    @Binding var coaster: RCDBCoasterDetail
    @Binding var spacing: CGFloat
    
    var body: some View {
        VStack{
            HStack{
                Text("\(coaster.name)")
                    .font(.system(size: 54))
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.leading)
                    .background(){
                        if (spacing > 50){
                            // If spacing is set to something larger than 50, we will assume the text is overlayed on the image and thus add a background to it for contast. The default spacing value for iPhone is 10, for iPad, it's several 100s.
                            Rectangle()
                                .fill(.thickMaterial)
                                .blur(radius: 10)
                                .padding(-35)
                        }
                    }
                Spacer()
            }
            .padding()
            Spacer()
                .frame(height: spacing)
            FactsView(coaster: .constant(coaster))
        }
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
    
    DetailsHeaderView(coaster: .constant(sampleCoaster!), spacing: .constant(0))
}