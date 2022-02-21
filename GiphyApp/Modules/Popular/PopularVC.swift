//
//  PopularVC.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 12.02.22.
//

import UIKit

class PopularVC: UIViewController {

    @IBOutlet weak var PopularGifsCollectionView: UICollectionView!
    var popularGifsArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGifsPopularVC(offset: 0)
    }
    
    func fetchGifsPopularVC (offset: Int) {
        guard let url = URL(string: "\(Constant.domain)\(Constant.apiVersion)/gifs/trending?api_key=\(Constant.apiKey)&q=keyword&offset=\(offset)&limit=25") else { return }
                                                                                    
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
            
            DispatchQueue.main.async {
    
                guard let data = data else { return }
                
                do {
                    let json = try JSONDecoder().decode(GIfModel.self, from: data)
                    for i in json.data {
                        popularGifsArray.append(i.images.original.url)
                    }
                    self.PopularGifsCollectionView.reloadData()
                } catch {
                    return
                }
            }
        }.resume()


    }
}
