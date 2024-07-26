//
//  MovieCell.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 19/07/24.
//

import SwiftUI

struct MovieCell: View {
    @State var isTapped = false
    let movie: Movie
    var body: some View {
            NavigationLink(destination: MovieDetail(movie: movie), isActive: $isTapped) {
                VStack {
                    HStack(alignment: .top, spacing: 12) {
                        AsyncImage(url: URL(string: movie.poster)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 120)
                                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            case .failure(_):
                                Image("image_not_found")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 120)
                                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            @unknown default:
                                fatalError()
                            }
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text(movie.title)
                                .foregroundStyle(Color.black)
                                .fontWeight(.medium)
                            Text("Language: \(movie.language)")
                                .foregroundStyle(Color.black)
                            Text("Year: \(movie.year)")
                                .foregroundStyle(Color.black)
                        }
                    }
                }
                .contentShape(Rectangle())
                .padding(.horizontal, 8)
                .background(Color.clear)
                .frame(height: 150)
                .onTapGesture {
                    isTapped.toggle()
                }
        }
    }
}
