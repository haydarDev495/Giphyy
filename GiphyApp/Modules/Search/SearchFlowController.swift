//
//  SearchFlowController.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 22.02.22.
//

import UIKit
import SwinjectStoryboard


protocol SearchDelegate {
    func updateUI()
    func searchCVBeginRefreshing()
    func searchVCEndRefreshing() 
}

protocol NavigationSearchDelegate {
    func showGifDetailsVC(imageUrl: String)
}

final class SearchFlowController: FlowController, NavigationSearchDelegate {
    
    var presentableViewController: UIViewController { navigationController }
    private let rootWindow: UIWindow
    private let navigationController = BaseNC(rootViewController: UIViewController())
    
    required init(withRoot window: UIWindow) {
        self.rootWindow = window
    }
    
    func start() {
        let vc: SearchVC = SwinjectStoryboard.create(storyboard: .search).instantiateViewController()
        vc.viewModel = SearchViewModel(delegate: vc)
        vc.navigationSearchDelegate = self
        navigationController.tabBarItem = UITabBarItem(title: "Search", image: UIImage.init(systemName: "magnifyingglass"), selectedImage: nil)
        navigationController.viewControllers = [vc]
    }
    
    func showGifDetailsVC(imageUrl: String) {
        let vc : GifDetailsVC = SwinjectStoryboard.create(storyboard: .details).instantiateViewController()
        vc.setImageForGifDetailVC(imageUrl: imageUrl)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openDetails() {
        
    }
}
