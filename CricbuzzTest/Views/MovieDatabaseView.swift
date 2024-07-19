//
//  ContentView.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 19/07/24.
//

import SwiftUI

struct MovieDatabaseView: View {
    @StateObject private var viewModelContainer = ViewModelContainer(viewModel: MovieListViewModelImpl())
    
    @State private var selectedSection: SectionType? = nil
    var body: some View {
        NavigationView {
            VStack {
                if !viewModelContainer.viewModel.searchText.isEmpty {
                    if viewModelContainer.viewModel.filteredMovies.count > 0 {
                        List(viewModelContainer.viewModel.filteredMovies, id: \.self.imdbID) { movie in
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
                        SectionCell(type: item, selectedSection: $selectedSection)
                            .listRowBackground(Color.white)
                            .padding(.vertical, 8)
                    }
                }
            }
            .contentMargins(0)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Movie Database")
            .searchable(text: $viewModelContainer.viewModel.searchText, prompt: "Search movies by title/actor/genre/director")
        }
        .onAppear(perform: {
            viewModelContainer.viewModel.loadMovies()
        })
        .environmentObject(viewModelContainer)
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
