//
//  SearchFlowController.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 22.02.22.
//

import UIKit
import SwinjectStoryboard
import RxSwift
import RxCocoa

enum SearchFlow {
    case search
    case details(imageUrl: String)
}

protocol SearchDelegate {
    func updateUI()
    func searchCVBeginRefreshing()
    func searchVCEndRefreshing() 
}

final class SearchFlowController: FlowController, GifDetailsVCDelegate {
    
    private let bag = DisposeBag()
    var presentableViewController: UIViewController { navigationController }
    private let rootWindow: UIWindow
    private let navigationController = BaseNC(rootViewController: UIViewController())
    
    required init(withRoot window: UIWindow) {
        self.rootWindow = window
    }
    
    func start() {
        let vc: SearchVC = SwinjectStoryboard.create(storyboard: .search).instantiateViewController()
        vc.delegate = self
        vc.viewModel = SearchViewModel(delegate: vc)
        vc.onForwardFlow.subscribe(onNext: {[weak self] flow in
            self?.handleFlowChanges(flow: flow)
        }).disposed(by: bag)
        navigationController.tabBarItem = UITabBarItem(title: "Search", image: UIImage.init(systemName: "magnifyingglass"), selectedImage: nil)
        navigationController.viewControllers = [vc]
    }
    
    func showGifDetailsVC(imageUrl: String) {
        let vc : GifDetailsVC = SwinjectStoryboard.create(storyboard: .details).instantiateViewController()
        vc.setImageForGifDetailVC(imageUrl: imageUrl)
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func handleFlowChanges(flow: SearchFlow) {
        switch flow {
        case .search:
            self.start()
        case .details(let imageUrl):
            self.showGifDetailsVC(imageUrl: imageUrl)
        }
    }
}
