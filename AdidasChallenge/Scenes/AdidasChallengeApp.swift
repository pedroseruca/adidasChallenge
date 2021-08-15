//
//  AdidasChallengeApp.swift
//  AdidasChallenge
//
//  Created by Pedro Seruca on 09/08/2021.
//

import SwiftUI

@main
struct AdidasChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            let serviceManager = ServiceManager()
            let factory = AdidasFactory(serviceManager: serviceManager)
            let viewModel = factory.makeProductListViewModel()
            ProductListView(viewModel: viewModel)
        }
    }
}
