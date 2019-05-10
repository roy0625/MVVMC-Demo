//
//  AppCoordinator.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/8.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator<UITabBarController> {

    private let dependency = AppDependency()

    required init(viewController: UITabBarController) {
        super.init(viewController: viewController)
    }

    override func start() {
        let rootTabBarCoordinator = RootTabBarCoordinator(viewController: rootViewController)
        rootTabBarCoordinator.dependency = dependency
        startChild(coordinator: rootTabBarCoordinator)
        super.start()
    }
}
