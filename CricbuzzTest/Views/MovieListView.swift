//
//  MovieListView.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 19/07/24.
//

import SwiftUI

struct MovieListView: View {
    var type: SectionType
    var name: String
    @EnvironmentObject var viewModelContainer: ViewModelContainer<MovieListViewModelImpl>
    let maxHeight: CGFloat = 300
    var body: some View {
        List {
            ForEach(viewModelContainer.viewModel.filteredMovies, id: \.imdbID) { movie in
                MovieCell(movie: movie)
                    .listRowBackground(Color.white)
            }
        }
        .padding(.horizontal, -16)
        .padding(.vertical, -13)
        .contentMargins(0)
        .scrollBounceBehavior(.basedOnSize)
        .frame(height: getHeight())
    }
    
    func getHeight() -> CGFloat {
        return CGFloat(min(viewModelContainer.viewModel.filteredMovies.count * 150, 500))
    }
}
