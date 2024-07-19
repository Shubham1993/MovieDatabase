//
//  CricbuzzTestApp.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 19/07/24.
//

import SwiftUI

@main
struct CricbuzzTestApp: App {
    @StateObject private var viewModelContainer = ViewModelContainer(viewModel: MovieListViewModelImpl())

    var body: some Scene {
        WindowGroup {
            MovieDatabaseView()
                .environmentObject(viewModelContainer)
        }
    }
}
