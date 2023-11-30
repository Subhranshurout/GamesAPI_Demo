//
//  screenShotCell.swift
//  GamesAPI
//
//  Created by Yudiz-subhranshu on 26/05/23.
//

import UIKit
import Kingfisher
class screenShotCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    func prepareUI (game : String) {
        imageView.kf.setImage(with: URL(string: game))
    }
    
}
