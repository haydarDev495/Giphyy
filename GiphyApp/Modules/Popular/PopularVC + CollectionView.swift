//
//  PopularVC + CollectionView.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 14.02.22.
//

import UIKit
import Kingfisher

extension PopularVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularGifsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularGifCell", for: indexPath) as? PopularGifCell else { return UICollectionViewCell() }
        cell.configure(imageUrl: popularGifsArray[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard.init(name: "GifDetails", bundle: nil).instantiateViewController(withIdentifier: "GifDetailsVC") as? GifDetailsVC else { return }
        vc.getImageForGifDetailVC(imageUrl: popularGifsArray[indexPath.row])
        present(vc, animated: true)
    }
}

extension PopularVC : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == popularGifsArray.count - 1 {
            let indexPathRow = indexPath.row + 1 
            fetchGifsPopularVC(offset: indexPathRow)
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
