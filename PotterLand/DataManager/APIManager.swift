//
//  APIManager.swift
//  PotterLand
//
//  Created by Patka on 22/05/2023.
//

import UIKit
import Foundation

protocol APIManagerProtocol: AnyObject {
    func fetchMoviesData(completion: @escaping (Result<[TitleModel], Error>) -> Void)
}

enum APIEndpoint: String {
    case title
}

enum APIManagerError: Error {
    case couldNotBuildURL
    case unknownError
    case notAllMoviesFetched
}

class APIManager: APIManagerProtocol {

    let baseURLString: String = "https://imdb-api.com/<language>/API/<endpoint>/k_n7hl962k/"

    let language: String
    
    var hpMoviesArray: [TitleModel] = []
    
    init(language: String = "en") {
        self.language = language
    }
    
    func buildURLForHP(for endpoint: APIEndpoint, id: String) -> URL? {
        let urlString = baseURLString
            .replacingOccurrences(of: "<language", with: language)
            .replacingOccurrences(of: "<endpoint>", with: endpoint.rawValue.capitalized)
            .appending(id)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let urlString = urlString else {
            return nil
        }
        return URL(string: urlString)
    }
    
    func fetchHPMovie(id: String, completion: @escaping (Result<TitleModel, Error>) -> Void) {
        guard let url = buildURLForHP(for: .title, id: id) else {
            completion(.failure(APIManagerError.couldNotBuildURL))
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(TitleModel.self, from: data)
                    completion(.success(decodedData))
                    return
                } catch {
                    completion(.failure(error))
                    return
                }
            }
            completion(.failure(APIManagerError.unknownError))
        }
        task.resume()
    }
    
    func fetchMoviesData(completion: @escaping (Result<[TitleModel], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        fetchHPMovieData(id: Constants.idHP1, dispatchGroup: dispatchGroup)
        fetchHPMovieData(id: Constants.idHP2, dispatchGroup: dispatchGroup)
        fetchHPMovieData(id: Constants.idHP3, dispatchGroup: dispatchGroup)
        fetchHPMovieData(id: Constants.idHP4, dispatchGroup: dispatchGroup)
        fetchHPMovieData(id: Constants.idHP5, dispatchGroup: dispatchGroup)
        fetchHPMovieData(id: Constants.idHP6, dispatchGroup: dispatchGroup)
        fetchHPMovieData(id: Constants.idHP7, dispatchGroup: dispatchGroup)
        fetchHPMovieData(id: Constants.idHP8, dispatchGroup: dispatchGroup)
        dispatchGroup.notify(queue: .main) {
            print("All finished", self.hpMoviesArray)
            let sortedArray = self.hpMoviesArray.sorted {
                (Int($0.year) ?? 0) < (Int($1.year) ?? 0)
            }
            for movie in sortedArray {
                print("Year: \(movie.year), title: \(movie.title)")
            }
            // add check if we have 8 movies
            if sortedArray.count == 8 {
                completion(.success(sortedArray))
            } else {
                completion(.failure(APIManagerError.notAllMoviesFetched))
            }
        }
     }
    
     func fetchHPMovieData(id: String, dispatchGroup: DispatchGroup) {
         dispatchGroup.enter()
         fetchHPMovie(id: id) { [weak self] result in
             switch result {
             case .success(let title):
                 let hp = title
                 self?.hpMoviesArray.append(hp)
             case .failure(let error):
                 print("error \(error)")
             }
             dispatchGroup.leave()
         }
     }
    
    }
    
