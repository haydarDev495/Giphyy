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
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var allGifsArray : [String] = []
    var propertyForSendSearchText = ""
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    @objc func refreshData() {
        getUrl(searchQuery: "", offset: 0, refresh: true)
        
    }
}
