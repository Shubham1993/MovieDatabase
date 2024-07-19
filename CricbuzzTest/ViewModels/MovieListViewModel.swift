//
//  MovieListViewModel.swift
//  CricbuzzTest
//
//  Created by shubham gupta on 19/07/24.
//

import Foundation

protocol MovieListViewModel {
    var movies: [Movie] { get set }
    var searchText: String { get set }
    var filteredMovies: [Movie] { get }
    var years: [String] { get }
    var genres: [String] { get }
    var directors: [String] { get }
    var actors: [String] { get }
    func getFilteredMovies(filter: String) -> [Movie]
}

enum SectionType: String, CaseIterable {
    case Year = "Year"
    case Genre = "Genre"
    case Directors = "Directors"
    case Actors = "Actors"
    case AllMovies = "AllMovies"
}

class MovieListViewModelImpl: ObservableObject, MovieListViewModel {
    var movies: [Movie] = []
    var searchText: String
    
    private lazy var allYears: [String] = {
        return getAllUniqueData(for: .Year)
    }()
    
    private lazy var allGenres: [String] = {
        return getAllUniqueData(for: .Genre)
    }()
    
    private lazy var allDirectors: [String] = {
        return getAllUniqueData(for: .Directors)
    }()
    
    private lazy var allActors: [String] = {
        return getAllUniqueData(for: .Actors)
    }()
    
    var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { movie in
                movie.title.localizedCaseInsensitiveContains(searchText) ||
                movie.actors.localizedCaseInsensitiveContains(searchText) ||
                movie.genre.localizedCaseInsensitiveContains(searchText) ||
                movie.director.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var years: [String] {
        return allYears
    }
    
    var genres: [String] {
        return allGenres
    }
    
    var directors: [String] {
        return allDirectors
    }
    
    var actors: [String] {
        return allActors
    }
    
    init() {
        self.searchText = ""
        self.movies = loadMovies()
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
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .map { String($0) }
        )
        
        return Array(uniqueData).sorted()
    }
    
    private func loadMovies() -> [Movie] {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let movies = try? JSONDecoder().decode([Movie].self, from: data) else {
            return []
        }
        return movies
    }
    
    func getFilteredMovies(filter: String) -> [Movie] {
        if filter.isEmpty {
            return []
        } else {
            return movies.filter { movie in
                movie.title.localizedCaseInsensitiveContains(filter) ||
                movie.year.localizedStandardContains(filter) ||
                movie.actors.localizedCaseInsensitiveContains(filter) ||
                movie.genre.localizedCaseInsensitiveContains(filter) ||
                movie.director.localizedCaseInsensitiveContains(filter)
            }
        }
    }
}
