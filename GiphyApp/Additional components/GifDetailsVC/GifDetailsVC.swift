//
//  GifDetailsVC.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 21.02.22.
//

import UIKit
import Kingfisher

class GifDetailsVC: UIViewController {

    @IBOutlet weak var gifLabel: UILabel!
    @IBOutlet var fullScreeGifImage: UIImageView!
    
    var urlStringImage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func change(a:String) {
        urlStringImage = a
    }
    
    private func setupUI() {
        self.fullScreeGifImage.kf.setImage(with: URL(string: urlStringImage))
    }
    
}
