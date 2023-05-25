//
//  WelcomeScreen.swift
//  PotterLand
//
//  Created by Patka on 23/05/2023.
//

import UIKit

class WelcomeScreen: UIViewController {
    
    let apiManager = APIManager()
    let tabRouter: TabRouterProtocol
    
    init(tabRouter: TabRouterProtocol) {
        self.tabRouter = tabRouter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        fetchMoviesData()
        
    }
    
    // MARK: - Prepare Data to show
    
//    func fetchMoviesData() {
//        apiManager.fetchMoviesData { result in
//            switch result {
//            case .success(let models):
//                self.tabRouter.navigateToHomeScreen()
//                // show next screen with the data (use router)
//            case .failure(let error):
//                ()
//                // retry?
//            }
//        }
//    }

    }
