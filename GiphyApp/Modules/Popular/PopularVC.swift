//
//  PopularVC.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 12.02.22.
//

import UIKit

class PopularVC: UIViewController, PopularDelegate {

    @IBOutlet weak var popularGifsCollectionView: UICollectionView!
    
    let viewModel = PopularViewModel()
    var navigationPopularDelegate: NavigationDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addHandlers()
    }
    
    func updateUI() {
        self.popularGifsCollectionView.reloadData()
    }
    
    private func setupUI() {
        viewModel.delegate = self
    }
    
    private func addHandlers() {
        
    }
}
