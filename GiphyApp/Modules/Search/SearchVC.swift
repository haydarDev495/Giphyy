//
//  SearchVC.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 20.01.22.
//

import UIKit
import RxSwift
import RxCocoa

class SearchVC: UIViewController, SearchDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchGifsCollectionView: UICollectionView!
    
    var delegate: GifDetailsVCDelegate!
    var viewModel: SearchViewModel!
    private let bag = DisposeBag()
    var timer = Timer()
    let onForwardFlow = PublishRelay<SearchFlow>()

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
        viewModel.searchGifsArray.subscribe(onNext: { [weak self] value in
            self?.searchGifsCollectionView.reloadData()
        }).disposed(by: bag)
        
        self.searchGifsCollectionView.refreshControl?.rx.controlEvent(UIControl.Event.valueChanged).subscribe(onNext: { [weak self] in
            self?.viewModel.fetchGifs(searchQuery: "", offset: 0, refresh: true)
        }).disposed(by: bag)
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
