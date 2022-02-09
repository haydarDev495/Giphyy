//
//  SearchController.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 31.01.22.
//
import UIKit


extension CollectionViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        propertyForSendSearchText = searchText
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [self] timer in
            if searchText.isEmpty {allGifsArray.removeAll()}
            self.getUrl(searchQuery: searchText, offset: 0)
            print(searchText)
        })
        self.myCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == allGifsArray.count - 1 {
            let indexPathRow = indexPath.row + 2
            getUrl(searchQuery: "\(propertyForSendSearchText)", offset: indexPathRow)
        }
    }
}
