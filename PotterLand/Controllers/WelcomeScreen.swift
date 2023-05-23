//
//  WelcomeScreen.swift
//  PotterLand
//
//  Created by Patka on 23/05/2023.
//

import UIKit

class WelcomeScreen: UIViewController {
    
    let apiManager = APIManager()
    let hpMoviesArray: [TitleModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMoviesData()
        
    }
    
    // MARK: - Fetch Movies Data
    
   func fetchMoviesData() {
       
       apiManager.fetchHPMovie(id: Constants.idHP1) { [weak self] result in
           switch result {
           case .success(let title):
               print("success \(title)")
           case .failure(let error):
               print("error \(error)")
           }
       }
    }
    
}
