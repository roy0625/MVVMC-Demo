//
//  DetailCoordinator.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/8.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

class DetailCoordinator: Coordinator<UINavigationController> {

    var dependency: AppDependency?
    var todoModel: TodoModel?
    var indexPath: IndexPath?

    override func start() {
        guard !started,
            let fileDataManager = dependency?.fileDataManager
        else { return }

        let detailViewModel = DetailViewModel(todoModel: todoModel!, indexPath: indexPath!, fileDataManager: fileDataManager)
        let vc = DetailViewController(viewModel: detailViewModel)
        vc.coordinator = self
        vc.delegate = self

        show(viewController: vc, animated: true)

        super.start()
    }
}

extension DetailCoordinator: DetailViewControllerProtocol {
    func clickSave(viewController: UIViewController) {
        pop()
    }
}
