//
//  PopularFlowController.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 22.02.22.
//

import UIKit
import SwinjectStoryboard
import RxSwift
import RxCocoa

enum PopularFlow {
    case popular
    case details(string: String)
}

final class PopularFlowController: FlowController, GifDetailsVCDelegate {
    
    private let bag = DisposeBag()
    var presentableViewController: UIViewController { navigationController }
    private let rootWindow: UIWindow
    private let navigationController = BaseNC(rootViewController: UIViewController())
    
    required init(withRoot window: UIWindow) {
        self.rootWindow = window
    }
    
    func start() {
        let vc: PopularVC = SwinjectStoryboard.create(storyboard: .popular).instantiateViewController()
        vc.delegate = self
        vc.onForwardFlow.subscribe(onNext: {[weak self] flow in
            self?.handleFlowChanges(flow: flow)
        }).disposed(by: bag)
        navigationController.tabBarItem = UITabBarItem(title: "Popular", image: UIImage.init(systemName: "heart"), selectedImage: nil)
        navigationController.viewControllers = [vc]
    }
    
    private func showGifDetailsVC(imageUrl: String) {
        let vc: GifDetailsVC = SwinjectStoryboard.create(storyboard: .details).instantiateViewController()
        vc.setImageForGifDetailVC(imageUrl: imageUrl)
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func handleFlowChanges(flow: PopularFlow) {
        switch flow {
        case .popular:
            self.start()
        case .details(let string):
            self.showGifDetailsVC(imageUrl: string)
        }
    }
}

