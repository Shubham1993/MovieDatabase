//
//  MovieListView.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 19/07/24.
//

import SwiftUI

struct MovieListView: View {
    var name: String
    var viewModel: MovieListViewModel
    let maxHeight: CGFloat = 300
    var body: some View {
        List {
            ForEach(viewModel.getFilteredMovies(filter: name), id: \.imdbID) { movie in
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
        return CGFloat(min(viewModel.getFilteredMovies(filter: name).count * 150, 500))
    }
}
