//
//  APIManager.swift
//  PotterLand
//
//  Created by Patka on 22/05/2023.
//

import UIKit
import Foundation

protocol APIManagerProtocol: AnyObject {
    
}

enum APIEndpoint: String {
    case title
}

enum APIManagerError: Error {
    case couldNotBuildURL
    case unknownError
}

class APIManager: APIManagerProtocol {

    let baseURLString: String = "https://imdb-api.com/<language>/API/<endpoint>/k_bdv8grxf/"
    
    let language: String
    
    var currentTasks: [URLSessionDataTask] = []
    
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
        var currentTask: URLSessionDataTask?
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            self?.currentTasks.removeAll { storedTask in
                storedTask === currentTask
            }
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
        currentTask = task
        task.resume()
        currentTasks.append(task)
    }
    
    }
    
