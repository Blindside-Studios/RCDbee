//
//  QuickFactCard.swift
//  RCDbee
//
//  Created by Blindside on 23.10.24.
//

import SwiftUI

struct QuickFactCard: View {
    @Binding var factIcon: Image
    @Binding var factHeader: String
    @Binding var factContent: String
    
    var body: some View {
        ZStack{
            Rectangle()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            VStack{
                HStack{
                    //factIcon
                    Text(factHeader)
                        .font(.subheadline)
                        .opacity(0.8)
                    Spacer()
                }
                Spacer()
                Text(factContent)
                    .font(.title3)
                    .frame(alignment: .center)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    QuickFactCard(factIcon: .constant(Image(systemName: "star")), factHeader: .constant("Fact Header"), factContent: .constant("Fact Value")).frame(width: 160, height: 110)
}
