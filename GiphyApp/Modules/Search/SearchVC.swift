//
//  SearchVC.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 20.01.22.
//

import UIKit

class SearchVC: UIViewController, SearchDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchGifsCollectionView: UICollectionView!

    var viewModel: SearchViewModel!
    var timer = Timer()
    var navigationSearchDelegate: NavigationDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addHandlers()
    }
    
    private func setupUI() {
        self.searchGifsCollectionView.refreshControl = UIRefreshControl()
        viewModel.fetchGifs(searchQuery: "", offset: 0, refresh: false)
        hideKeyboardWhenTappedAround()
    }
    
    private func addHandlers() {
        self.searchGifsCollectionView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        viewModel.fetchGifs(searchQuery: "", offset: 0, refresh: true)
    }
    
    func updateUI() {
        self.searchGifsCollectionView?.reloadData()
    }
    
    func searchCVBeginRefreshing() {
        searchGifsCollectionView.refreshControl?.beginRefreshing()
    }
    
    func searchVCEndRefreshing() {
        self.searchGifsCollectionView.refreshControl?.endRefreshing()
    }
}
