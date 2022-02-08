//
//  GetURL.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 31.01.22.
//

import UIKit

extension CollectionViewController {
    
    func getUrl(searchQuery: String, offset: Int, refresh : Bool = false) {
        
        if refresh {
            myCollectionView.refreshControl?.beginRefreshing()
        }
        
        guard let url = URL(string: "https://api.giphy.com/v1/gifs/search?q=\(searchQuery)&api_key=\(AppConstant.giphyApiKey)&limit=25&offset=\(offset)") else { return }
        
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
            
            DispatchQueue.main.async {
                
                if refresh {
                    self.myCollectionView.refreshControl?.endRefreshing()
                }
                
                guard let data = data else { return }
                
                do {
                    let json = try JSONDecoder().decode(GIfModel.self, from: data)
                    for i in json.data {
                        allGifsArray.append(i.images.original.url)
                    }
                    
                    self.myCollectionView.reloadData()
                } catch {
                    return
                }
            }
        }.resume()
    }
}

