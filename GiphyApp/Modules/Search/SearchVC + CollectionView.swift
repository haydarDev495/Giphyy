//
//  SearchVC + CollectionView.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 28.01.22.
//

import UIKit


extension SearchVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.allGifsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCell", for: indexPath) as? GifCell else { return UICollectionViewCell() }
        cell.configure(imageUrl: viewModel.allGifsArray[indexPath.row])
        return cell
    }
}

extension SearchVC : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationSearchDelegate.showGifDetailsVC(imageUrl: viewModel.allGifsArray[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.allGifsArray.count - 1 {
            let indexPathRow = indexPath.row + 1
            viewModel.fetchGifs(searchQuery: "\(viewModel.propertyForSendSearchText)", offset: indexPathRow)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2
        return CGSize(width: width - 2, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
