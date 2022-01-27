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
    private let searchController = UISearchController(searchResultsController: nil)
    
    // Data
    //    private var gifImageItemList = [CarModel]()
    var searching = false
//    var searcedItem : [String] = []
    var allGifsArray : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
    }
    
}


extension CollectionViewController {
    
    func getUrl(searchQuery: String) {
        
        print(searchQuery)
        guard let url = URL(string: "https://api.giphy.com/v1/gifs/search?q=\(searchQuery)&api_key=QqT3x9hCgbk6QTSQtoNeoNw3Y0gJvSyG&limit=30") else { return }
        
        let session = URLSession.shared.dataTask(with: url) { [self] data, response, error in
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
// MARK: - UICollectionViewDataSource
extension CollectionViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        if searching {
        //            return 3
        ////            return searcedItem.count + 15
        //        } else {
        //            return allGifsArray.count
        //        }
        return allGifsArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        
        if allGifsArray.isEmpty {
            print("g")
        } else {
            cell.myImage.kf.setImage(with: URL(string: allGifsArray[indexPath.row]))
            
        }
        
        if searching {
            //                        cell.myImage.image = UIImage(named: searcedItem[indexPath.row].nameImage)
            //            cell.myLabel.text = searcedItem[indexPath.row].nameCar
            
            
        } else {
            //            cell.myImage.image = UIImage(named: gifImageItemList[indexPath.row].nameImage)
            //            cell.myLabel.text = gifImageItemList[indexPath.row].nameCar
            
            
        }
        
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.red.cgColor
        return cell
        
    }
}


// MARK:
// MARK: - UISearchResultsUpdating Delegate
extension CollectionViewController : UISearchResultsUpdating , UISearchBarDelegate , UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            getUrl(searchQuery: searchText)
        }
        
        if !searchText.isEmpty {
            
            searching = true
//            searcedItem.removeAll()
//            for item in allGifsArray {
//                if item.lowercased().contains(searchText.lowercased()) {
//                    searcedItem.append(item)
//                }
//            }
            
        } else {
            searching = false
//            searcedItem.removeAll()
//            searcedItem = allGifsArray
        }
        self.myCollectionView.reloadData()
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
//        searcedItem.removeAll()
        allGifsArray.removeAll()
        myCollectionView.reloadData()


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
// MARK: - UICollectionViewDelegate
extension CollectionViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300 , height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        if searching {
        //            print("you have clicked on car \(searcedItem[indexPath.row].nameCar)")
        //
        //        }else {
        //            print("you have clicked on car \(gifImageItemList[indexPath.row].nameCar)")
        //        }
    }
}
