//
//  AppFlowController.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 22.02.22.
//

import UIKit

final class AppFlowController: FlowController {
    
    private var mainFlow: MainFlowController?
    let window: UIWindow

    required init(withWindow window: UIWindow) {
        self.window = window
    }
    
    func start() {
        self.showMainMenu()
    }
    
    private func showMainMenu() {
        mainFlow = MainFlowController(withRoot: window)
        mainFlow?.start()
    }
}
