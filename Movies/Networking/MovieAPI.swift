//
//  MovieAPI.swift
//  Movies
//
//  Created by Parul Vats on 23/05/2018.
//  Copyright © 2018 Parul Vats. All rights reserved.
//

import Foundation

protocol MovieAPIProtocol {
    // Option 1: Block implementation
    func fetch(completionHandler: @escaping ([Movie]) -> Void)
    
    // Option 2: Delegate implementation
    func fetch()
    var delegate: MovieAPIDelegate? { get set }
}

protocol MovieAPIDelegate {
    func movieAPI(_ movieAPI: MovieAPIProtocol, didFetchMovies movies: [Movie])
}

enum JSONError : Error {
    case noJSONFileWasFound
}

class MovieAPI: MovieAPIProtocol {
    
    // MARK: - Block implementation
    
    func fetch(completionHandler: @escaping ([Movie]) -> Void) {
        getMovies(completionHandler: completionHandler)
    }
    
    // MARK: - Delegate implementation
    
    var delegate: MovieAPIDelegate?
    
    func fetch() {
        getMovies { [weak self] movies in
            guard let strongSelf = self else {
                return
            }
            strongSelf.delegate?.movieAPI(strongSelf, didFetchMovies: movies)
        }
    }
    
    // MARK: - Movies JSON
    
    private func getMovies(completionHandler: @escaping ([Movie]) -> Void) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            
            var movies = [Movie]()
            if let moviesJSON = try? strongSelf.getMoviesJson() {
                movies = strongSelf.parseJSONToMovies(json: moviesJSON)
            }
            
            DispatchQueue.main.async {
                completionHandler(movies)
            }
        }
    }
    
    private func getMoviesJson() throws -> Data {
        guard let fileUrl = Bundle.main.url(forResource: "Movies", withExtension: "json") else {
            throw JSONError.noJSONFileWasFound
        }
        
        return try Data(contentsOf: fileUrl)
    }
    
    // MARK: - Parsing Movie JSON
    
    private func parseJSONToMovies(json: Data) -> [Movie] {
        let decoder = JSONDecoder()
        guard let movies = try? decoder.decode([Movie].self, from: json) else {
            return [Movie]()
        }
        return movies
    }
}
