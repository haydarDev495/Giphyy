//
//  FlowController.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 22.02.22.
//

import UIKit
import SwinjectStoryboard

enum FlowError: Error {
    case notFound(String)
}

protocol FlowController {
    func start()
    var rootWindow: UIWindow? { get }
}

extension FlowController {
    var rootWindow: UIWindow? {
        return UIApplication.shared.delegate?.window ?? nil
    }
    
    var iPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
