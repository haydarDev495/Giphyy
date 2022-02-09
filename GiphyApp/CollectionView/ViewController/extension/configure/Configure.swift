//
//  Configure.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 31.01.22.
//

import UIKit


extension CollectionViewController {
    
    func configure() {
        getUrl(searchQuery: "", offset: 0, refresh: false)
        configureTitle()
        configureCollectionView()
        configureRefreshControl()
        configureSearchController()
    }
    
    func configureTitle() {
        title = "Search"
    }
    
    func configureCollectionView() {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }
    
    func configureRefreshControl() {
        self.myCollectionView.refreshControl = UIRefreshControl()
        self.myCollectionView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    func configureSearchController() {
        searchController.delegate = self
    }
}
