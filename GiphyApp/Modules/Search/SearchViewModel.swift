//
//  SearchViewModel.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 25.02.22.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    private var newAndOldGifs: [String] = []
    var searchGifsArray = BehaviorRelay<[String]>(value: [])
    var propertyForSendSearchText = ""
    private var delegate: SearchDelegate!
    
    required init(delegate: SearchDelegate) {
        self.delegate = delegate
        fetchGifs(searchQuery: "", offset: 0)
    }
    
    func cleanApp() {
        searchGifsArray.accept([])
        newAndOldGifs.removeAll()
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
                    var newGifs: [String] = []
                    for i in json.data {
                        newGifs.append(i.images.original.url)
                    }
                    newAndOldGifs.append(contentsOf: newGifs)
                    searchGifsArray.accept(newAndOldGifs)
                } catch {
                    return
                }
            }
        }.resume()
    }
}

