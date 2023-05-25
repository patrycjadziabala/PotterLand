//
//  Routing.swift
//  PotterLand
//
//  Created by Patka on 25/05/2023.
//

import UIKit

protocol TabRouterProtocol {
    func navigateToHomeScreen()
    func navigateToMovieDetails(id: String)
    func navitageToPersonDetails(id: String)
}

class TabRouter: TabRouterProtocol {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToHomeScreen() {
        DispatchQueue.main.async {
            let viewModel = HomeScreenViewModel()
            let homeScreenViewController = HomeScreenViewController(tabRouter: self, viewModel: viewModel)
            self.navigationController.pushViewController(homeScreenViewController, animated: true)
        }
    }
    
    func navigateToMovieDetails(id: String) {
        DispatchQueue.main.async {
        }
    }
    
    func navitageToPersonDetails(id: String) {
        
    }
    

    


}
