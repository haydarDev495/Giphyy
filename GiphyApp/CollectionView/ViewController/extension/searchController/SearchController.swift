//
//  SearchController.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 31.01.22.
//
import UIKit

// MARK:
// MARK: - UISearchResultsUpdating Delegate
extension CollectionViewController : UISearchResultsUpdating , UISearchBarDelegate , UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
       guard let searchText = searchController.searchBar.text else { return }
        propertyForSendSearchText = searchText
        
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [self] timer in
            
            if searchText == "" {
                self.getUrl(searchQuery: searchText, offset: 1)
            } else {
                allGifsArray.removeAll()
                self.getUrl(searchQuery: searchText, offset: 1)
            }

        })
        self.myCollectionView.reloadData()
    }
    // cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        allGifsArray.removeAll()
        myCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        print("count allgifarray: \(allGifsArray.count)")
        if indexPath.row == allGifsArray.count - 1 {
            
            let indexPathRow = indexPath.row + 2
            getUrl(searchQuery: "\(propertyForSendSearchText)", offset: indexPathRow)
            

        }
    
}
}
