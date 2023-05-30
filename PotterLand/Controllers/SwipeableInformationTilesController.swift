//
//  SwipeableInformationTilesController.swift
//  PotterLand
//
//  Created by Patka on 25/05/2023.
//

import UIKit

class SwipeableInformationTilesController: UIViewController {
    
    private let tabRouter: TabRouterProtocol
    
    var dataSource: [SwipeableInformationTilePresentable]
    
    private let collectionView: UICollectionView
    
    init(tabRouter: TabRouterProtocol, dataSource: [SwipeableInformationTilePresentable]) {
        self.tabRouter = tabRouter
        self.dataSource = dataSource
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        
    }
    
    // MARK: - View configuration
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(UINib(nibName: Constants.collectionViewCell, bundle: nil), forCellWithReuseIdentifier: Constants.collectionViewCell)
        collectionView.backgroundColor = UIColor(named: Constants.customGold)
        collectionView.constraint(to: view)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    //MARK: - Set data source
    
    func set(dataSource: [SwipeableInformationTilePresentable]) {
        self.dataSource = dataSource
        self.collectionView.reloadData()
    }
}
//MARK: - SwipeableInformationTilesController - Extensions

extension SwipeableInformationTilesController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        CGSize(width: 100, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataSource[indexPath.item]
        
    }
}

extension SwipeableInformationTilesController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
    }
}

//MARK: - SwipeableInformationTilesController - Data Source

extension SwipeableInformationTilesController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCell, for: indexPath) as? MovieCollectionViewCell {
            cell.configureCollectionCellData(with: dataSource[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
}


