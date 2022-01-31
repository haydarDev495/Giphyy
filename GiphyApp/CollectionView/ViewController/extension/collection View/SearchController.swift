//
//  SearchController.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 31.01.22.
//

import Foundation
import UIKit


// MARK:
// MARK: - UISearchResultsUpdating Delegate
extension CollectionViewController : UISearchResultsUpdating , UISearchBarDelegate , UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else { return }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
//            getUrl(searchQuery: searchText)
//        }
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
