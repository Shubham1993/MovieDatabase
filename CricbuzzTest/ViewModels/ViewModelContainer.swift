//
//  ViewModelContainer.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 20/07/24.
//

import Foundation

class ViewModelContainer<VM: MovieListViewModel>: ObservableObject {
    @Published var viewModel: VM
    
    init(viewModel: VM) {
        self.viewModel = viewModel
    }
}
