//
//  AllMovies.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 26/07/24.
//

import SwiftUI

struct AllMovies: View {
    @EnvironmentObject var viewModelContainer: ViewModelContainer<MovieListViewModelImpl>
    var body: some View {
        VStack {
            List(viewModelContainer.viewModel.movies, id: \.self.imdbID) { movie in
                MovieCell(movie: movie)
                    .listRowBackground(Color.white)
            }
            .contentMargins(0)
            .background(Color.white)
            .padding(.top, 8)
        }
        .navigationTitle("All Movies")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AllMovies()
}
