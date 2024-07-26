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
                    .foregroundStyle(Color.black)
                HStack(spacing: 4) {
                    Text("Rating:").bold()
                        .foregroundStyle(Color.black)
                    Text(movie.ratings.first { $0.source == selectedName }!.value)
                        .bold()
                        .foregroundStyle(Color.black)
                    Spacer()
                    Picker("", selection: $selectedName) {
                        ForEach(movie.ratings, id: \.self.source) {
                            Text("(\($0.source))")
                                .foregroundStyle(Color.black)
                        }
                    }
                }
                Text("Plot: ").bold() + Text(movie.plot)
                    .foregroundStyle(Color.black)
                Text("Cast & Crew: ").bold() + Text(movie.actors)
                    .foregroundStyle(Color.black)
                Text("Released: ").bold() + Text(movie.released)
                    .foregroundStyle(Color.black)
                Text("Languages: ").bold() + Text(movie.language)
                    .foregroundStyle(Color.black)
                Text("Genre: ").bold() + Text(movie.genre)
                    .foregroundStyle(Color.black)
                Spacer()
            }
            .padding(.horizontal, 20)
            .background(Color.white)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(movie.title)
        }
        .background(Color.white)
    }
}
