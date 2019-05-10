//
//  RootTabBarCoordinator.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/8.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

class RootTabBarCoordinator: Coordinator<UITabBarController>, CoordinatingDependency {

    let tabBarViewcontroller = UITabBarController()

    var dependency: AppDependency?

    private var tabBarDelegateProxy = TabBarDelegateProxy()
    private var selectedCoordinator: Coordinating?

    override func start() {
        // add child coordinator

        if started { return }

        setupChildCoordinator()
        selectedCoordinator?.start()

        super.start()
    }

    private func setupChildCoordinator() {

        rootViewController.delegate = tabBarDelegateProxy
        tabBarDelegateProxy.delegate = self

        let todoVC = generateNavigationController(tabBarItem: UITabBarItem())
        todoVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        let todoCoordinator = TabTodoCoordinator(viewController: todoVC)
        todoCoordinator.dependency = dependency

        let chartVC = ChartViewController()
        chartVC.tabBarItem = UITabBarItem(title: "Chart", image: UIImage(named: "chart")?.withRenderingMode(.alwaysOriginal), tag: 1)
        let chartCoordinator = TabChartCoordinator(viewController: chartVC)

        let settingVC = generateNavigationController(tabBarItem: UITabBarItem())
        settingVC.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        let settingCoordinator = TabSettingCoordinator(viewController: settingVC)

        rootViewController.viewControllers = [todoVC, chartVC, settingVC]
        childCoordinators = [todoCoordinator, chartCoordinator, settingCoordinator]

        selectedCoordinator = todoCoordinator
    }

    private final func generateNavigationController(tabBarItem: UITabBarItem) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = tabBarItem

        return navigationController
    }
}

extension RootTabBarCoordinator : TabBarDelegateProxyDelegate {
    func tabBarDelegateProxy(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        selectedCoordinator = childCoordinators[tabBarController.selectedIndex]
        selectedCoordinator?.start()
    }
}

// Because Coordinator is not a subclass of NSObject, it can not sign UITabBarControllerDelegate directly
protocol TabBarDelegateProxyDelegate : class {
    func tabBarDelegateProxy(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
}

class TabBarDelegateProxy: NSObject, UITabBarControllerDelegate {
    weak var delegate: TabBarDelegateProxyDelegate?

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {        delegate?.tabBarDelegateProxy(tabBarController, didSelect: viewController)
    }
}
