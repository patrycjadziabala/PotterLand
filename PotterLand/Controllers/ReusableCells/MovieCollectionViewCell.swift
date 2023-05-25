//
//  MovieCollectionViewCell.swift
//  PotterLand
//
//  Created by Patka on 23/05/2023.
//

import UIKit
import SDWebImage

protocol SwipeableInformationTilePresentable {
    var id: String { get }
    var titleLabel: String { get }
    var imageUrlString: String { get }
    var year: String { get }
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        configureCellView()
        
    }
    
    // MARK: - Cell configuration
    
    func configureCellView() {
        imageContainerView.makeRound(radius: 20)
    }
    
    func configureCollectionCellData(with model: SwipeableInformationTilePresentable) {
        image.sd_setImage(with: URL(string: model.imageUrlString))
        yearLabel.text = model.year
        titleLabel.text = model.titleLabel
    }
}
