//
//  SettingsFlowController.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 22.02.22.
//

import UIKit
import SwinjectStoryboard


protocol SettingsDelegate {}

final class SettingsFlowController: FlowController, SettingsDelegate {

    var presentableViewController: UIViewController { navigationController }
    private let rootWindow: UIWindow
    private let navigationController = BaseNC(rootViewController: UIViewController())
    
    required init(withRoot window: UIWindow) {
        self.rootWindow = window
    }
    
    func start() {
        let vc: SettingsVC = SwinjectStoryboard.create(storyboard: .settings).instantiateViewController()
        vc.delegate = self
        navigationController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage.init(systemName: "gear"), selectedImage: nil)
        navigationController.viewControllers = [vc]
    }
}
