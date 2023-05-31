//
//  TrailerCollectionViewCell.swift
//  PotterLand
//
//  Created by Patka on 30/05/2023.
//

import UIKit
import SDWebImage

class TrailerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var trailerViewContainer: UIView!
    @IBOutlet weak var trailerImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    private let apiManager: APIManagerProtocol = APIManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with model: HomeScreenTrailerModel) {
        let posterImageUrl = URL(string: model.thumbnailUrl)
        posterImage.sd_setImage(with: posterImageUrl)
        titleLabel.text = model.title
        yearLabel.text = model.year
    }
}
