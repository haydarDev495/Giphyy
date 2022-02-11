//
//  SearchVC.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 31.01.22.
//
import UIKit


extension SearchVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        propertyForSendSearchText = searchText
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [self] timer in
            if searchText.isEmpty {allGifsArray.removeAll()}
            self.fetchGifs(searchQuery: searchText, offset: 0)
            print(searchText)
        })
        self.SearchGifsCollectionView.reloadData()
    }
}
