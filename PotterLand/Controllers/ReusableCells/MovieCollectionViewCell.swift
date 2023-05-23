//
//  MovieCollectionViewCell.swift
//  PotterLand
//
//  Created by Patka on 23/05/2023.
//

import UIKit


class MovieCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        configureCellView()
        
    }

    func configureCellView() {
        
    }
    
    // MARK: - Cell configuration
    
    func configure(with model: TitleModel) {
        
    }
    
}
