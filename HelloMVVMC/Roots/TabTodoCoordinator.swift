//
//  TabTodoCoordinator.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/8.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

class TabTodoCoordinator: Coordinator<UINavigationController>, CoordinatingDependency {

    var dependency: AppDependency?

    override func start() {
        guard !started,
            let fileDataManager = dependency?.fileDataManager
        else { return }

        let todoViewModel = TodoViewModel(fileDataManager: fileDataManager)
        let vc = TodoViewController(viewModel: todoViewModel)
        vc.coordinator = self
        vc.delegate = self
        rootViewController.viewControllers = [vc]

        super.start()
    }
}

extension TabTodoCoordinator: TodoViewControllerDelegate {
    func todoClickTableViewCell(viewController: TodoViewController, item: TodoModel, indexPath: IndexPath) {
        let detailCoordinator = DetailCoordinator(viewController: rootViewController)
        detailCoordinator.todoModel = item
        detailCoordinator.indexPath = indexPath
        detailCoordinator.dependency = dependency
        startChild(coordinator: detailCoordinator)
    }
}
