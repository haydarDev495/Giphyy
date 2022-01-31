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
    
    // Timer
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.myCollectionView.refreshControl = UIRefreshControl()
        self.myCollectionView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        configure()
        getUrl(searchQuery: "", refresh: false)
        
    }
    @objc private func refreshData() {
        print("refreshData")
        getUrl(searchQuery: "", refresh: true)
    }

}


// MARK:
// MARK: - UISearchResultsUpdating Delegate
extension CollectionViewController : UISearchResultsUpdating , UISearchBarDelegate , UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else { return }
        
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [self] timer in
            
            if searchText == "" {
                self.getUrl(searchQuery: searchText)
            } else {
                allGifsArray.removeAll()
                self.getUrl(searchQuery: searchText)
            }

        })
        self.myCollectionView.reloadData()
    }
    // cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        myCollectionView.reloadData()
    }
    
}


// MARK:
// MARK: - URL request
extension CollectionViewController {
    
    func getUrl(searchQuery: String, refresh : Bool = false) {
        
        print(searchQuery)
        
        if refresh {
            myCollectionView.refreshControl?.beginRefreshing()
        }
        guard let url = URL(string: "https://api.giphy.com/v1/gifs/search?q=\(searchQuery)&api_key=QqT3x9hCgbk6QTSQtoNeoNw3Y0gJvSyG&limit=30") else { return }
        
        let session = URLSession.shared.dataTask(with: url) { [self] data, response, error in
            
            DispatchQueue.main.async {
                if refresh {
                    self.myCollectionView.refreshControl?.endRefreshing()
                }
            }

            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(GIf.self, from: data)
                for i in json.data {
                    allGifsArray.append(i.images.original.url)
                }
                
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                }
                
            } catch {
                debugPrint("catch -- - - - --  \(error)")
            }
        }.resume()

            
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
    func configureTitle() {
        title = "Search"
    }
    func configureCollectionView() {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }

    func configureSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        // Setup the Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
    }
}


// MARK:
// MARK: - UICollectionViewDataSource
extension CollectionViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return allGifsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        
        if allGifsArray.isEmpty {
            print("allGifsArray is empty,in collection view cell : \(allGifsArray.count)")
        } else {
            cell.myImage.kf.setImage(with: URL(string: allGifsArray[indexPath.row]))
            
        }
        
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.red.cgColor
        return cell
        
    }
}
// MARK:
// MARK: - UICollectionViewDelegate
extension CollectionViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300 , height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

}

