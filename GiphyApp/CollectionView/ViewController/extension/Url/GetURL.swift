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
    
    func getUrl(searchQuery: String, offset: Int, refresh : Bool = false) {
        
        print(searchQuery)
        
        
        if refresh {
            myCollectionView.refreshControl?.beginRefreshing()
        }
        guard let url = URL(string: "https://api.giphy.com/v1/gifs/search?q=\(searchQuery)&api_key=QqT3x9hCgbk6QTSQtoNeoNw3Y0gJvSyG&limit=25&offset=\(offset)") else { return }
        
        let session = URLSession.shared.dataTask(with: url) { [self] data, response, error in
            
            DispatchQueue.main.async {
                if refresh {
                    self.myCollectionView.refreshControl?.endRefreshing()
                }
            }

            guard let data = data else { return }
            
            do {
                let json = try JSONDecoder().decode(GIfModel.self, from: data)
                print("pagination count:\(json.pagination.count)")
                print("pagination totalCount:\(json.pagination.totalCount)")
                print("pagination offset:\(json.pagination.offset)")
                
                for i in json.data {
                    allGifsArray.append(i.images.original.url)
                }
                print("allGifsArray.count:\(allGifsArray.count)")
                
                DispatchQueue.main.async {
                    self.myCollectionView.reloadData()
                }
                
            } catch {
                debugPrint("catch -- - - - --  \(error)")
            }
        }.resume()

            
        }
    }

