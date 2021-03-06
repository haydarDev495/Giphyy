//
//  GifDetailsVC.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 21.02.22.
//

import UIKit
import Kingfisher


class GifDetailsVC: UIViewController {


    @IBOutlet weak var fullScreeGifImage: UIImageView!
    private var urlImageString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setImageForGifDetailVC(imageUrl: String) {
        urlImageString = imageUrl
    }
    
    private func setupUI() {
        self.fullScreeGifImage.kf.setImage(with: URL(string: urlImageString))
        title = "GifDetailsVC"
    }
}
