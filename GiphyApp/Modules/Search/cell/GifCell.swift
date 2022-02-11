//
//  GifCell.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 20.01.22.
//

import UIKit
import Kingfisher

class GifCell: UICollectionViewCell {
    
    @IBOutlet weak var gifImage: UIImageView!
    
    func configure(imageUrl: String ) {
        self.gifImage.kf.setImage(with: URL(string: imageUrl))
    }
}
