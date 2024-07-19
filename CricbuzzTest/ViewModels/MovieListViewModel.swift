//
//  MovieListViewModel.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 19/07/24.
//

import Foundation

protocol MovieListViewModel: ObservableObject {
    var movies: [Movie] { get set }
    var searchText: String { get set }
    var filteredMovies: [Movie] { get }
    var data: [String] { get set }
    func onExpand(type: SectionType, filter: String)
    func loadMovies()
}

enum SectionType: String, CaseIterable {
    case Year = "Year"
    case Genre = "Genre"
    case Directors = "Directors"
    case Actors = "Actors"
    case AllMovies = "AllMovies"
}

class MovieListViewModelImpl: MovieListViewModel {
    @Published var movies: [Movie] = []
    @Published var searchText: String = "" {
        didSet {
            search()
        }
    }
    @Published var data: [String] = [String]()
    @Published var filteredMovies: [Movie] = [Movie]()

    func search() {
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies.filter { movie in
                movie.title.localizedCaseInsensitiveContains(searchText) ||
                movie.actors.localizedCaseInsensitiveContains(searchText) ||
                movie.genre.localizedCaseInsensitiveContains(searchText) ||
                movie.director.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func onExpand(type: SectionType, filter: String = "") {
        switch type {
            case .Year:
                data = getAllUniqueData(for: .Year)
                filteredMovies = movies.filter { movie in movie.year.localizedStandardContains(filter) }
            case .Actors:
                data = getAllUniqueData(for: .Actors)
                filteredMovies = movies.filter { movie in movie.actors.localizedStandardContains(filter) }
            case .Directors:
                data = getAllUniqueData(for: .Directors)
                filteredMovies = movies.filter { movie in movie.director.localizedStandardContains(filter) }
            case .Genre:
                data = getAllUniqueData(for: .Genre)
                filteredMovies = movies.filter { movie in movie.genre.localizedStandardContains(filter) }
            case .AllMovies:
                data = [String]()
        }
    }
    
    private func getAllUniqueData(for type: SectionType) -> [String] {
        var substrings = [Substring]()
        
        switch type {
            case .Year:
                substrings = movies.flatMap { $0.year.split(separator: ",") }
            case .Genre:
                substrings = movies.flatMap { $0.genre.split(separator: ",") }
            case .Directors:
                substrings = movies.flatMap { $0.director.split(separator: ",") }
            case .Actors:
                substrings = movies.flatMap { $0.actors.split(separator: ",") }
            default:
                substrings = [Substring]()
        }
        
        let uniqueData = Set(substrings
            .map { $0.trimmingCharacters(in: CharacterSet([" ", "–"])) }
            .map { String($0) }
        )
        
        return Array(uniqueData).sorted()
    }
    
    func loadMovies() {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let movies = try? JSONDecoder().decode([Movie].self, from: data) else {
            return
        }
        self.movies = movies
    }
}
