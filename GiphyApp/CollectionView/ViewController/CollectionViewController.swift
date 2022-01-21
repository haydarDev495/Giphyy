//
//  ViewController.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 20.01.22.
//

import UIKit

class CollectionViewController: UIViewController {
    
    // CollectionView
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    // searchController
    private let searchController = UISearchController(searchResultsController: nil)
    
    // Data
    var data = ""
    
    private let gif =  [
        Gif(nameGif: "Hello"),
        Gif(nameGif: "Mem"),
        Gif(nameGif: "Smile"),
        Gif(nameGif: "Fun"),
        Gif(nameGif: "MisterBin"),
        Gif(nameGif: "Jog"),
        Gif(nameGif: "Run"),
        Gif(nameGif: "Video"),
        Gif(nameGif: "Sport"),
        Gif(nameGif: "Magic"),
        Gif(nameGif: "Comedy"),
        Gif(nameGif: "Joker")]
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
    }
}

// MARK:
// MARK: - configure
extension CollectionViewController {
    func configure() {
        configureTitle()
        configureCollectionView()
        configureSearchController()
        
    }
    func configureCollectionView() {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }
    func configureTitle() {
        title = "Search"
    }
    func configureSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        // Setup the Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        
        
    }
    
}
// MARK:
// MARK: - UISearchResultsUpdating Delegate
extension CollectionViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        print(text)
    }

    
}

// MARK:
// MARK: - UICollectionViewDataSource
extension CollectionViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gif.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.myLabel.text = gif[indexPath.row].nameGif
        cell.myLabel.layer.cornerRadius = 50
        
        return cell
    }
    
    
}

// MARK:
// MARK: - UICollectionViewDelegate
extension CollectionViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}

