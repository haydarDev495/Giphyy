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
    private var gifImageItemList = [CarModel]()
    
    var searching = false
    
    var searcedItem = [CarModel]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        fillData()
        
        
    }
    private func fillData() {
        let item1 = CarModel(nameImage: "audiBlue", nameCar: "Auid")
        gifImageItemList.append(item1)
        let item2 = CarModel(nameImage: "audiRed", nameCar: "Auid")
        gifImageItemList.append(item2)
        let item3 = CarModel(nameImage: "bbmwe39", nameCar: "BMW")
        gifImageItemList.append(item3)
        let item4 = CarModel(nameImage: "bmwM5", nameCar: "BMW")
        gifImageItemList.append(item4)
        let item5 = CarModel(nameImage: "bmwM5Black", nameCar: "BMW")
        gifImageItemList.append(item5)
        let item6 = CarModel(nameImage: "E63AMG", nameCar: "Mercedes")
        gifImageItemList.append(item6)
        let item7 = CarModel(nameImage: "e63Red", nameCar: "Mercedes")
        gifImageItemList.append(item7)
        let item8 = CarModel(nameImage: "ford", nameCar: "Ford")
        gifImageItemList.append(item8)
        let item9 = CarModel(nameImage: "mercedes", nameCar: "Mercedes")
        gifImageItemList.append(item9)
        let item10 = CarModel(nameImage: "mercedesBlack", nameCar: "Mercedes")
        gifImageItemList.append(item10)
        let item11 = CarModel(nameImage: "mercedesRed", nameCar: "Mercedes")
        gifImageItemList.append(item11)
        let item12 = CarModel(nameImage: "mercedesTwo", nameCar: "Mercedes")
        gifImageItemList.append(item12)
        let item13 = CarModel(nameImage: "mercedesWhite", nameCar: "Mercedes")
        gifImageItemList.append(item13)
        let item14 = CarModel(nameImage: "supra", nameCar: "Toyota supra")
        gifImageItemList.append(item14)
        let item15 = CarModel(nameImage: "tesla", nameCar: "Tesla")
        gifImageItemList.append(item15)
        
        
    }
}







// MARK:
// MARK: - UISearchResultsUpdating Delegate
extension CollectionViewController : UISearchResultsUpdating , UISearchBarDelegate , UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty {
            
            searching = true
            searcedItem.removeAll()
            for item in gifImageItemList {
                if item.nameCar.lowercased().contains(searchText.lowercased()) {
                    searcedItem.append(item)
                }
            }
            
        } else {
            searching = false
            searcedItem.removeAll()
            searcedItem = gifImageItemList
        }
        self.myCollectionView.reloadData()
        
        //        guard let text = searchController.searchBar.text else {
        //            return
        //        }
        //        print(text)
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searcedItem.removeAll()
        myCollectionView.reloadData()
    }
    
}



// MARK:
// MARK: - UICollectionViewDataSource
extension CollectionViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching {
            return searcedItem.count
        } else {
            return gifImageItemList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        
        if searching {
            cell.myImage.image = UIImage(named: searcedItem[indexPath.row].nameImage)
            cell.myLabel.text = searcedItem[indexPath.row].nameCar
            
            
        } else {
            cell.myImage.image = UIImage(named: gifImageItemList[indexPath.row].nameImage)
            cell.myLabel.text = gifImageItemList[indexPath.row].nameCar
        }
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.red.cgColor
        return cell
        
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
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        // Setup the Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.delegate = self
        navigationItem.searchController = searchController
        
        /*        searchController.loadViewIfNeeded()
         searchController.searchResultsUpdater = self
         searchController.searchBar.delegate = self
         searchController.obscuresBackgroundDuringPresentation = false
         searchController.searchBar.enablesReturnKeyAutomatically = false
         searchController.searchBar.returnKeyType = UIReturnKeyType.done
         navigationItem.hidesSearchBarWhenScrolling = false
         navigationItem.searchController = searchController
         definesPresentationContext = true*/
    }
}




















// MARK:
// MARK: - UICollectionViewDelegate
extension CollectionViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searching {
            print("you have clicked on car \(searcedItem[indexPath.row].nameCar)")
            
        }else {
            print("you have clicked on car \(gifImageItemList[indexPath.row].nameCar)")
        }
    }
}

