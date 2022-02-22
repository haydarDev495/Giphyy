//
//  SearchFlowController.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 22.02.22.
//

import UIKit
import SwinjectStoryboard


protocol SearchDelegate {}

final class SearchFlowController: FlowController, SearchDelegate {

    var presentableViewController: UIViewController { navigationController }
    
    private let rootWindow: UIWindow
    private let navigationController = BaseNC(rootViewController: UIViewController())
    
    required init(withRoot window: UIWindow) {
        self.rootWindow = window
    }
    
    func start() {
        let vc: SearchVC = SwinjectStoryboard.create(storyboard: .search).instantiateViewController()
        vc.delegate = self
        navigationController.tabBarItem = UITabBarItem(title: "Search", image: UIImage.init(systemName: "magnifyingglass"), selectedImage: nil)
        navigationController.viewControllers = [vc]
    }
}
