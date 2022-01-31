//
//  GetURL.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 31.01.22.
//

import UIKit

// MARK:
// MARK: - URL request
extension CollectionViewController {
    
    func getUrl(searchQuery: String) {
        
        print(searchQuery)
        
        guard let url = URL(string: "https://api.giphy.com/v1/gifs/search?q=\(searchQuery)&api_key=QqT3x9hCgbk6QTSQtoNeoNw3Y0gJvSyG&limit=30") else { return }
        
        let session = URLSession.shared.dataTask(with: url) { [self] data, response, error in
            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(GIf.self, from: data)
                for i in json.data {
                    allGifsArray.append(i.images.original.url)
                }
                
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                }
                
            } catch {
                debugPrint("catch -- - - - --  \(error)")
            }
        }.resume()

            
        }
    }
