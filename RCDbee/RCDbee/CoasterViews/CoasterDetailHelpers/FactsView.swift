//
//  FactsView.swift
//  RCDbee
//
//  Created by Blindside on 24.10.24.
//

import SwiftUI

struct FactsView: View {
    @Binding var coaster: RCDBCoasterDetail
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var adaptiveFactColumns: [GridItem] {
        [GridItem(.adaptive(minimum: 120, maximum: 300))]
    }
    
    var body: some View {
        ScrollView(.horizontal){
            if (horizontalSizeClass == .compact){
                LazyHGrid(rows: adaptiveFactColumns, spacing: 10){
                    ForEach(coaster.statItems, id: \.statName) { item in
                        QuickFactCard(factIcon: .constant(Image(systemName: item.statIcon)), factHeader: .constant(item.statName), factContent: .constant(item.statValue ?? "No Data"))
                            .frame(width: 138, height: 140)
                    }
                }
                .frame(height: 290)
                .padding()
            } else {
                LazyHGrid(rows: adaptiveFactColumns, spacing: 10){
                    ForEach(coaster.statItems, id: \.statName) { item in
                        QuickFactCard(factIcon: .constant(Image(systemName: item.statIcon)), factHeader: .constant(item.statName), factContent: .constant(item.statValue ?? "No Data"))
                            .frame(width: 200, height: 120)
                    }
                }
                .padding()
                .frame(height:282)
            }
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
    
    FactsView(coaster: .constant(sampleCoaster!))
}
