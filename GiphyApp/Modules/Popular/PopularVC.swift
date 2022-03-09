//
//  PopularVC.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 12.02.22.
//

import UIKit
import RxSwift
import RxCocoa

class PopularVC: UIViewController {

    @IBOutlet weak var popularGifsCollectionView: UICollectionView!
    private let bag = DisposeBag()
    let onForwardFlow = PublishRelay<PopularFlow>()
    
    var delegate: GifDetailsVCDelegate!
    let viewModel = PopularViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        addHandlers()
    }
        
    private func addHandlers() {
        viewModel.popularGifsArray
            .subscribe(onNext: { [weak self] value in
                self?.popularGifsCollectionView.reloadData()
            }).disposed(by: bag)
        
        self.popularGifsCollectionView.rx.itemSelected.subscribe(onNext:{ indexPath in
            self.onForwardFlow.accept(.details(imageUrl: self.viewModel.popularGifsArray.value[indexPath.row]))
        }).disposed(by: bag)
    }
}
