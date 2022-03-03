//
//  SearchViewModel.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 25.02.22.
//

import Foundation

final class SearchViewModel {
    
    private var delegate: SearchDelegate!
    var allGifsArray : [String] = []
    var propertyForSendSearchText = ""

    required init(delegate: SearchDelegate) {
        self.delegate = delegate
        fetchGifs(searchQuery: "", offset: 0)
    }
    
    func fetchGifs(searchQuery: String, offset: Int, refresh : Bool = false) {
        if refresh {
            self.delegate.searchCVBeginRefreshing()
        }
        
        guard let url = URL(string: "\(Constant.domain)\(Constant.apiVersion)/gifs/search?q=\(searchQuery)&api_key=\(Constant.apiKey)&limit=\(Constant.limit)&offset=\(offset)") else { return }
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
            DispatchQueue.main.async {
                if refresh {
                    self.delegate.searchVCEndRefreshing()
                }
                guard let data = data else { return }
                do {
                    let json = try JSONDecoder().decode(GIfModel.self, from: data)
                    for i in json.data {
                        allGifsArray.append(i.images.original.url)
                    }
                    self.delegate.updateUI()
                } catch {
                    return
                }
            }
        }.resume()
    }
}
