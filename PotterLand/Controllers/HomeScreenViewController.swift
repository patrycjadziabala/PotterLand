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
    @IBOutlet weak var moviesCollectionView: UIView!
    @IBOutlet weak var trailersCollectionView: UIView!
    
    let tabRouter: TabRouterProtocol
    let hpMoviesController: SwipeableInformationTilesController
    let hpTrailersController: TrailerViewController
    let viewModel: HomeScreenViewModelProtocol
    
    init(tabRouter: TabRouterProtocol, viewModel: HomeScreenViewModelProtocol) {
        self.tabRouter = tabRouter
        self.viewModel = viewModel
        self.hpMoviesController = SwipeableInformationTilesController(tabRouter: tabRouter, dataSource: [])
        self.hpTrailersController = TrailerViewController(tabRouter: tabRouter)
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHomeScreenView()
    }
    
    // MARK: - Home Screen View Configuration
    
    func configureHomeScreenView() {
        configureCollectionViews()
        prepareForShowingMoviesInformation()
    } 
    
    func configureCollectionViews() {
        configureCollectionViewHPMovies()
        configureCollectionViewHPTrailers()
    }
    
    func prepareForShowingMoviesInformation() {
        viewModel.fetchMoviesData()
        viewModel.fetchTrailers()
    }
    
    // MARK: - Home Screen View Configuration - Movies Collection View
    func configureCollectionViewHPMovies() {
        addChild(hpMoviesController)
        view.addSubview(hpMoviesController.view)
        hpMoviesController.didMove(toParent: self)
        hpMoviesController.view.constraint(to: moviesCollectionView)
    }
    
    func handleSuccessForMoviesData(model: [TitleModel]) {
        DispatchQueue.main.async {
            self.hpMoviesController.set(dataSource: model)
        }
    }
    
    // MARK: - Home Screen View Configuration - Trailers Collection View
    
    func configureCollectionViewHPTrailers() {
        addChild(hpTrailersController)
        view.addSubview(hpTrailersController.view)
        hpTrailersController.didMove(toParent: self)
        hpTrailersController.view.constraint(to: trailersCollectionView)
    }
    
    func handleSuccessForTrailers(model: [HomeScreenTrailerModel]) {
        DispatchQueue.main.async {
            self.hpTrailersController.set(dataSource: model)
        }
    }
}

//MARK: - HomeScreenViewController - extension

extension HomeScreenViewController: HomeScreenViewModelDelegate {
    func onFetchMoviesDataSuccess(model: [TitleModel]) {
        handleSuccessForMoviesData(model: model)
    }
    func onFetchTrailersSuccess(model: [HomeScreenTrailerModel]) {
        handleSuccessForTrailers(model: model)
    }
}
