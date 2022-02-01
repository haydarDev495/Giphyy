//
//  Configure.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 31.01.22.
//

import UIKit


// MARK:
// MARK: - configure
extension CollectionViewController {
    func configure() {
        getUrl(searchQuery: "", offset: 1, refresh: false)
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
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = .black
        searchController.searchBar.backgroundColor = .white
        searchController.searchBar.barTintColor = .black
        // Setup the Search Controller
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
    }
}
