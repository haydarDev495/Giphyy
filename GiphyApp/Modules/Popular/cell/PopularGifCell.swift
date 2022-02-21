//
//  PopularGifCell.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 14.02.22.
//

import UIKit
import Kingfisher

class PopularGifCell: UICollectionViewCell {
    
    @IBOutlet weak var gifImagePopularVC: UIImageView!
    
    func configure(imageUrl: String ) {
        self.gifImagePopularVC.kf.setImage(with: URL(string: imageUrl))

    }
}
