//
//  RandomCoasterView.swift
//  RCDbee
//
//  Created by Blindside on 20.10.24.
//

import SwiftUI

struct RandomCoasterView: View {
    @StateObject private var viewModel = RandomCoasterViewModel()

    var body: some View {
        VStack {
            if let coaster = viewModel.coaster {
                CoasterDetailView(coaster: .constant(coaster))
            } else {
                Text("Loading....")
            }
        }
        .refreshable {
            viewModel.fetchRandomCoaster()
        }
        .onAppear {
            viewModel.fetchRandomCoaster()
        }
    }
}

#Preview {
    RandomCoasterView()
}
