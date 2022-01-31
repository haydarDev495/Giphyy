//
//  ViewController.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 20.01.22.
//

import UIKit
import SwiftGifOrigin
import Kingfisher

class CollectionViewController: UIViewController {
    
    // CollectionView
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    // searchController
     let searchController = UISearchController(searchResultsController: nil)
    
    // Data
    var allGifsArray : [String] = []
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
    }
    
}

















