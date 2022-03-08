//
//  AppDelegate.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 20.01.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appFlowContoller: AppFlowController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.appFlowContoller = AppFlowController(withWindow: window)
        self.appFlowContoller?.start()
        return true
    }
}

