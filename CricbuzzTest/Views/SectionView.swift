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
    var viewModel: MovieListViewModel
    var data: [String]
    
    init(type: SectionType, viewModel: MovieListViewModel) {
        self.type = type
        self.viewModel = viewModel
        switch type {
            case .Year:
                data = viewModel.years
            case .Actors:
                data = viewModel.actors
            case .Directors:
                data = viewModel.directors
            case .Genre:
                data = viewModel.genres
            case .AllMovies:
                data = [String]()
        }
    }
    
    var body: some View {
        if type == .AllMovies {
            List(viewModel.movies, id: \.self.imdbID) { movie in
                MovieCell(movie: movie)
                    .listRowBackground(Color.white)
            }
            .contentShape(Rectangle())
            .contentMargins(0)
            .frame(height: CGFloat(min(viewModel.movies.count * 150, 500)))
            .background(Color.white)
            .padding(.top, 8)
        } else {
            List(data, id: \.self) { name in
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
                    }
                }
                
                if selectedSection == name {
                    MovieListView(name: name, viewModel: viewModel)
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .frame(height: CGFloat(min(data.count * 50, 300)))
            .contentMargins(0)
        }
    }
}

