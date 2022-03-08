//
//  PopularVC + CollectionView.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 14.02.22.
//

import UIKit

extension PopularVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return viewModel.popularGifsArray.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularGifCell", for: indexPath) as? PopularGifCell else { return UICollectionViewCell() }
        cell.configure(imageUrl: viewModel.popularGifsArray.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onForwardFlow.accept(.details(string: viewModel.popularGifsArray.value[indexPath.row]))
    }
}

extension PopularVC : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.popularGifsArray.value.count - 1 {
            viewModel.fetchPopularGifs(offset: indexPath.row + 1)
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
