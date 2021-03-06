//
//  SearchVC.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 31.01.22.
//
import UIKit
import RxSwift
import RxCocoa

extension SearchVC : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.propertyForSendSearchText = searchText
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [self] timer in
            if searchText.isEmpty {
                viewModel.cleanUp()
            } else {
                viewModel.fetchGifs(searchQuery: searchText, offset: 0)
            }
        })
        self.searchGifsCollectionView.reloadData()
    }
}
