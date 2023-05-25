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
}

class HomeScreenViewModel: HomeScreenViewModelProtocol {

   var delegate: HomeScreenViewModelDelegate?
    let apiManager: APIManagerProtocol = APIManager()
   
    func fetchMoviesData() {
            apiManager.fetchMoviesData { result in
                switch result {
                case .success(let models):
                    self.delegate?.onFetchMoviesDataSuccess(model: models)
                case .failure(let error):
                    print(error)
                    // retry?
                }
            }
        }
    
}

//MARK: - HomeScreenViewModelDelegate

protocol HomeScreenViewModelDelegate {
    
    func onFetchMoviesDataSuccess(model: [TitleModel])
}
