//
//  PopularFlowController.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 22.02.22.
//

import UIKit
import SwinjectStoryboard

protocol PopularDelegate {
    func updateUI()
}

protocol NavigationPopularDelegate {
    func showGifDetailsVC(imageUrl: String)
}

final class PopularFlowController: FlowController, NavigationPopularDelegate {

    var presentableViewController: UIViewController { navigationController }
    private let rootWindow: UIWindow
    private let navigationController = BaseNC(rootViewController: UIViewController())
    
    required init(withRoot window: UIWindow) {
        self.rootWindow = window
    }
    
    func start() {
        let vc: PopularVC = SwinjectStoryboard.create(storyboard: .popular).instantiateViewController()
        vc.navigationPopularDelegate = self
        navigationController.tabBarItem = UITabBarItem(title: "Popular", image: UIImage.init(systemName: "heart"), selectedImage: nil)
        navigationController.viewControllers = [vc]
    }
    
    func showGifDetailsVC(imageUrl: String) {
        let vc: GifDetailsVC = SwinjectStoryboard.create(storyboard: .details).instantiateViewController()
        vc.setImageForGifDetailVC(imageUrl: imageUrl)
        navigationController.pushViewController(vc, animated: true)
    }
}

