//
//  CollectionView.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 28.01.22.
//

import UIKit

// MARK:
// MARK: - UICollectionViewDataSource
extension CollectionViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allGifsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        
        if allGifsArray.isEmpty {
            print("allGifsArray is empty,in collection view cell : \(allGifsArray.count)")
        } else {
            cell.myImage.kf.setImage(with: URL(string: allGifsArray[indexPath.row]))
            
        }
        
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.red.cgColor
        return cell
        
    }
}
// MARK:
// MARK: - UICollectionViewDelegate
extension CollectionViewController : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350 , height: 350)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

}
