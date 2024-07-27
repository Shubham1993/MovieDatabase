//
//  MovieDetail.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 19/07/24.
//

import SwiftUI

struct MovieDetail: View {
    let movie: Movie
    @State private var selectedName = "Internet Movie Database"
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: movie.poster)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .clipShape(.rect(cornerRadius: 15))
                                .scaledToFit()
                                .frame(width: 220, height: 280)
                        case .failure(_):
                            EmptyView()
                        @unknown default:
                            fatalError()
                        }
                    }
                    Spacer()
                }
                .padding(.vertical, 8)
                Text("Title: ").bold() + Text(movie.title)
                HStack(spacing: 4) {
                    Text("Rating:").bold()
                    Text(movie.ratings.first { $0.source == selectedName }!.value)
                        .bold()
                    Spacer()
                    Picker("", selection: $selectedName) {
                        ForEach(movie.ratings, id: \.self.source) {
                            Text("(\($0.source))")
                        }
                    }
                }
                Text("Plot: ").bold() + Text(movie.plot)
                Text("Cast & Crew: ").bold() + Text(movie.actors)
                Text("Released: ").bold() + Text(movie.released)
                Text("Languages: ").bold() + Text(movie.language)
                Text("Genre: ").bold() + Text(movie.genre)
                Spacer()
            }
            .padding(.horizontal, 20)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(movie.title)
        }
        .scrollIndicators(.hidden)
    }
}
