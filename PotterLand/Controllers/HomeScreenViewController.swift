//
//  HomeScreenViewController.swift
//  PotterLand
//
//  Created by Patka on 22/05/2023.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var potterLabel: UILabel!
    @IBOutlet weak var moviesContainerView: UIView!
    @IBOutlet weak var trailersContainerView: UIView!
    @IBOutlet weak var charactersContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHomeScreenView()
        
    }
    
// MARK: - Home Screen View Configuration

    func configureHomeScreenView() {
        
    }
    
}
