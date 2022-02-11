//
//  SearchVC.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 20.01.22.
//

import UIKit
import Kingfisher

class SearchVC: UIViewController {
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var SearchGifsCollectionView: UICollectionView!
    
    var allGifsArray : [String] = []
    var propertyForSendSearchText = ""
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addHandlers()
    }
    
    private func setupUI() {
        self.SearchGifsCollectionView.refreshControl = UIRefreshControl()
        fetchGifs(searchQuery: "", offset: 0, refresh: false)
    }
    
    private func addHandlers() {
        self.SearchGifsCollectionView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

    func prepaerRefreshControl() {
        
    }
    
    func fetchGifs(searchQuery: String, offset: Int, refresh : Bool = false) {
        if refresh {
            SearchGifsCollectionView.refreshControl?.beginRefreshing()
        }
        
        guard let url = URL(string: "\(Constant.domain)\(Constant.apiVersion)/gifs/search?q=\(searchQuery)&api_key=\(Constant.apiKey)&limit=\(Constant.limit)&offset=\(offset)") else { return }
        
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
            DispatchQueue.main.async {
                if refresh {
                    self.SearchGifsCollectionView.refreshControl?.endRefreshing()
                }
                
                guard let data = data else { return }
                
                do {
                    let json = try JSONDecoder().decode(GIfModel.self, from: data)
                    for i in json.data {
                        allGifsArray.append(i.images.original.url)
                    }
                    self.SearchGifsCollectionView.reloadData()
                } catch {
                    return
                }
            }
        }.resume()
    }
    
    @objc func refreshData() {
        fetchGifs(searchQuery: "", offset: 0, refresh: true)
    }
}
