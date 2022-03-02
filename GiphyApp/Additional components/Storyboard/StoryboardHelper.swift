//
//  StoryboardHelper.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 22.02.22.
//

import UIKit
import SwinjectStoryboard

public protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

public protocol PStoryBoard {
    func name() -> String
}

public extension UIStoryboard {
    convenience init(storyboard: PStoryBoard, bundle: Bundle? = nil) {
        self.init(name: storyboard.name(), bundle: bundle)
    }

    func instantiateViewController<T: UIViewController>() -> T {
        let storyBoardId = String(describing: T.self)
        let optionalViewController = self.instantiateViewController(withIdentifier: storyBoardId)
        guard let viewController = optionalViewController as? T  else {
            fatalError("Couldn’t instantiate view controller with identifier \(storyBoardId) ")
        }
        return viewController
    }

    func instantiateInitialViewController<T: UIViewController>() -> T {
        let optionalViewController = self.instantiateInitialViewController()
        guard let viewController = optionalViewController as? T  else {
            fatalError("Couldn’t instantiate initial view controller")
        }
        return viewController
    }
}

enum Storyboard: String, PStoryBoard {

    case popular
    case search
    case settings
    case details
    
    func name() -> String {
        return self.rawValue.capitalized
    }
}

extension UIStoryboard {
    class func create(storyboard: Storyboard, bundle: Bundle? = nil, iPad: Bool = false) -> SwinjectStoryboard {
        let name = iPad ? "\(storyboard.name())_iPad" : storyboard.name()
        return SwinjectStoryboard.create(name: name, bundle: bundle)
    }
}
