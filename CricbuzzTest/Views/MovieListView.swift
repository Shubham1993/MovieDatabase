//
//  MovieListView.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 19/07/24.
//

import SwiftUI

struct MovieListView: View {
    @Environment(\.colorScheme) var colorScheme
    var type: SectionType
    var name: String
    @EnvironmentObject var viewModelContainer: ViewModelContainer<MovieListViewModelImpl>
    let maxHeight: Int = 500
    let cellHeight: Int = 150
    var body: some View {
        List {
            ForEach(viewModelContainer.viewModel.filteredMovies, id: \.imdbID) { movie in
                MovieCell(movie: movie)
                    .listRowBackground(Color(UIColor.secondarySystemGroupedBackground))
            }
        }
        .onAppear(perform: {
            UIScrollView.appearance().bounces = false
        })
        .onDisappear(perform: {
            UIScrollView.appearance().bounces = true
        })
        .listStyle(PlainListStyle())
        .scrollIndicators(.hidden)
        .contentMargins(0)
        .frame(height: getHeight())
    }
    
    func getHeight() -> CGFloat {
        return CGFloat(min(viewModelContainer.viewModel.filteredMovies.count * cellHeight, maxHeight))
    }
}
