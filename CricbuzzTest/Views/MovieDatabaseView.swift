//
//  ContentView.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 19/07/24.
//

import SwiftUI

struct MovieDatabaseView: View {
    @StateObject private var viewModel = MovieListViewModelImpl()
    @State private var selectedSection: SectionType? = nil
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.searchText.isEmpty {
                    if viewModel.filteredMovies.count > 0 {
                        List(viewModel.filteredMovies, id: \.self.imdbID) { movie in
                            MovieCell(movie: movie)
                                .listRowBackground(Color.white)
                        }
                        .background(Color.white)
                        .padding(.top, 8)
                    } else {
                        Text("No result found")
                    }
                } else {
                    List(SectionType.allCases, id: \.self.rawValue) { item in
                        SectionCell(type: item, viewModel: viewModel, selectedSection: $selectedSection)
                            .listRowBackground(Color.white)
                            .padding(.vertical, 8)
                    }
                }
            }
            .contentMargins(0)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Movie Database")
            .searchable(text: $viewModel.searchText, prompt: "Search movies by title/actor/genre/director")
        }
        .onAppear(perform: {
            viewModel.loadMovies()
        })
        .tint(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDatabaseView()
    }
}

#Preview {
    MovieDatabaseView()
}
