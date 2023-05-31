//
//  APIManager.swift
//  PotterLand
//
//  Created by Patka on 22/05/2023.
//

import UIKit
import Foundation

protocol APIManagerProtocol: AnyObject {
    func fetchHPMoviesData(completion: @escaping (Result<[TitleModel], Error>) -> Void)
    func fetchHPTrailersLinks(completion: @escaping (Result<[HomeScreenTrailerModel], Error>) -> Void)
}

enum APIEndpoint: String {
    case title
    case trailer
}

enum APIManagerError: Error {
    case couldNotBuildURL
    case unknownError
    case notAllMoviesFetched
    case notAllTrailersFetched
}

class APIManager: APIManagerProtocol {

    let baseURLString: String = "https://imdb-api.com/<language>/API/<endpoint>/k_hd74d58q/"

    let language: String
    
    var hpMoviesArray: [TitleModel] = []
    var hpTrailersArray: [HomeScreenTrailerModel] = []
    
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
    
    //MARK: - Fetch Harry Potter Movies Data
    
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
    
    func fetchHPMoviesData(completion: @escaping (Result<[TitleModel], Error>) -> Void) {
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
            let sortedMoviesArray = self.hpMoviesArray.sorted {
                (Int($0.year) ?? 0) < (Int($1.year) ?? 0)
            }
            for movie in sortedMoviesArray {
            }
            // check if we have 8 movies in the array
            if sortedMoviesArray.count == 8 {
                completion(.success(sortedMoviesArray))
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
    
    //MARK: - Fetch Harry Potter Trailers Data

    func fetchHPTrailer(id: String, completion: @escaping (Result<HomeScreenTrailerModel, Error>) -> Void) {
        guard let url = buildURLForHP(for: .trailer, id: id) else {
            completion(.failure(APIManagerError.couldNotBuildURL))
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {
            [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try
                    decoder.decode(HomeScreenTrailerModel.self, from: data)
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
    
    func fetchHPTrailersLinks(completion: @escaping (Result<[HomeScreenTrailerModel], Error>) -> Void) {
        let dispachGroup = DispatchGroup()
        fetchHPTrailerLink(id: Constants.idHP1, dispachGroup: dispachGroup)
        fetchHPTrailerLink(id: Constants.idHP2, dispachGroup: dispachGroup)
        fetchHPTrailerLink(id: Constants.idHP3, dispachGroup: dispachGroup)
        fetchHPTrailerLink(id: Constants.idHP4, dispachGroup: dispachGroup)
        fetchHPTrailerLink(id: Constants.idHP5, dispachGroup: dispachGroup)
        fetchHPTrailerLink(id: Constants.idHP6, dispachGroup: dispachGroup)
        fetchHPTrailerLink(id: Constants.idHP7, dispachGroup: dispachGroup)
        fetchHPTrailerLink(id: Constants.idHP8, dispachGroup: dispachGroup)
        dispachGroup.notify(queue: .main) {
            let sortedTrailerArray = self.hpTrailersArray.sorted {
                (Int($0.year) ?? 0) < (Int($1.year) ?? 0)
            }
            for movie in sortedTrailerArray {
            }
            // check if we have 8 trailers in the array
            if sortedTrailerArray.count == 8 {
                completion(.success(sortedTrailerArray))
            } else {
                completion(.failure(APIManagerError.notAllTrailersFetched))
            }
        }
    }
    
    func fetchHPTrailerLink(id: String, dispachGroup: DispatchGroup) {
        dispachGroup.enter()
        fetchHPTrailer(id: id) { [weak self] result in
            switch result {
            case .success(let title):
                let hp = title
                self?.hpTrailersArray.append(hp)
            case .failure(let error):
                print("error \(error)")
            }
            dispachGroup.leave()
        }
    }
    
    }
    
