//
//  TabSettingCoordinator.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/8.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

class TabSettingCoordinator: Coordinator<UINavigationController> {
    override func start() {
        if started { return }

        let vc = SettingViewController()
        vc.coordinator = self
        vc.delegate = self
        rootViewController.viewControllers = [vc]

        super.start()
    }
}

extension TabSettingCoordinator: SettingViewControllerDelegate {
    func clickPresent(viewController: UIViewController) {
        startChild(coordinator: PresentCoordinator(viewController: viewController))
    }
}
