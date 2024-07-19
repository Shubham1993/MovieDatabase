//
//  SectionView.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 19/07/24.
//

import SwiftUI

struct SectionView: View {
    
    @State private var selectedSection: String? = nil
    var type: SectionType
    @EnvironmentObject var viewModelContainer: ViewModelContainer<MovieListViewModelImpl>
    
    init(type: SectionType) {
        self.type = type
    }
    
    var body: some View {
        if type == .AllMovies {
            List(viewModelContainer.viewModel.movies, id: \.self.imdbID) { movie in
                MovieCell(movie: movie)
                    .listRowBackground(Color.white)
            }
            .contentShape(Rectangle())
            .contentMargins(0)
            .frame(height: CGFloat(min(viewModelContainer.viewModel.movies.count * 150, 500)))
            .background(Color.white)
            .padding(.top, 8)
        } else {
            List(viewModelContainer.viewModel.data, id: \.self) { name in
                HStack {
                    Text(name)
                    Spacer()
                    if selectedSection == name {
                        Image(systemName: "chevron.up")
                    } else {
                        Image(systemName: "chevron.right")
                    }
                }
                .contentShape(Rectangle())
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.white)
                .onTapGesture {
                    if selectedSection == name {
                        selectedSection = nil
                    } else {
                        selectedSection = name
                        viewModelContainer.viewModel.onExpand(type: type, filter: name)
                    }
                }
                
                if selectedSection == name {
                    MovieListView(type: type, name: name)
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .frame(height: CGFloat(min(viewModelContainer.viewModel.data.count * 50, 300)))
            .contentMargins(0)
        }
    }
}

