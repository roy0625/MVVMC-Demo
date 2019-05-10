//
//  PresentCoordinator.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/9.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

class PresentCoordinator: Coordinator<UIViewController> {
    override func start() {
        if started { return }

        let vc = PresentViewController()
        vc.delegate = self
        vc.coordinator = self

        present(viewController: vc)

        super.start()
    }
}

extension PresentCoordinator : PresentViewControllerDelegate {
    func clickDismissButton(viewController: PresentViewController) {
        rootViewController.dismiss(animated: true) {
            self.parent?.stopChild(coordinator: self)
        }
    }
}
