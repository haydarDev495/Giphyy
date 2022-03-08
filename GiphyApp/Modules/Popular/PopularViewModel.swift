//
//  PopularViewModel.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 25.02.22.
//

import Foundation
import RxSwift
import RxCocoa

class PopularViewModel {
    
    var popularGifsArray = BehaviorRelay<[String]>(value: [])
    private var newAndOldGifs: [String] = []
        
    init() {
        fetchPopularGifs(offset: 0)
    }
    
    func fetchPopularGifs(offset: Int) {
        guard let url = URL(string: "\(Constant.domain)\(Constant.apiVersion)/gifs/trending?api_key=\(Constant.apiKey)&q=keyword&offset=\(offset)&limit=25") else { return }
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
            DispatchQueue.main.async {
                guard let data = data else { return }
                do {
                    let json = try JSONDecoder().decode(GIfModel.self, from: data)
                    var newGifs: [String] = []
                    for i in json.data {
                        newGifs.append(i.images.original.url)
                    }
                    newAndOldGifs.append(contentsOf: newGifs)
                    popularGifsArray.accept(newAndOldGifs)
                } catch {
                    return
                }
            }
        }.resume()
    }
}

