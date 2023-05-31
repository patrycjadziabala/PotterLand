//
//  HomeScreenViewModel.swift
//  PotterLand
//
//  Created by Patka on 25/05/2023.
//

import UIKit

protocol HomeScreenViewModelProtocol: AnyObject {
    var delegate: HomeScreenViewModelDelegate? { get set }
    func fetchMoviesData()
    func fetchTrailers()
}

class HomeScreenViewModel: HomeScreenViewModelProtocol {

   var delegate: HomeScreenViewModelDelegate?
    let apiManager: APIManagerProtocol = APIManager()
   
    func fetchMoviesData() {
            apiManager.fetchHPMoviesData { result in
                switch result {
                case .success(let models):
                    self.delegate?.onFetchMoviesDataSuccess(model: models)
                case .failure(let error):
                    print(error)
                    // retry?
                }
            }
        }
    
    func fetchTrailers() {
        apiManager.fetchHPTrailersLinks { result in
            switch result {
            case .success(let models):
                self.delegate?.onFetchTrailersSuccess(model: models)
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - HomeScreenViewModelDelegate

protocol HomeScreenViewModelDelegate {
    
    func onFetchMoviesDataSuccess(model: [TitleModel])
    func onFetchTrailersSuccess(model: [HomeScreenTrailerModel])
}
