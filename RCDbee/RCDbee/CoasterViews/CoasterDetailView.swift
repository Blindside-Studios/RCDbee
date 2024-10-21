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
            Text("\(coaster.id)")
            Text(coaster.name)
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
    
    CoasterDetailView(coaster: .constant(sampleCoaster))
}
