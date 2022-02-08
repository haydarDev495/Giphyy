//
//  SearchController.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 31.01.22.
//
import UIKit


extension CollectionViewController : UISearchResultsUpdating , UISearchBarDelegate , UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else { return }
        
        propertyForSendSearchText = searchText
        
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [self] timer in
            
            self.getUrl(searchQuery: searchText, offset: 0)
            if searchText.isEmpty {allGifsArray.removeAll()}
        })
        self.myCollectionView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        allGifsArray.removeAll()
        myCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == allGifsArray.count - 1 {
            
            let indexPathRow = indexPath.row + 2
            getUrl(searchQuery: "\(propertyForSendSearchText)", offset: indexPathRow)
            
        }
    }
}
