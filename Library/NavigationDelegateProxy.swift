//
//  NavigationDelegateProxy.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/7.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

class NavigationDelegateProxy: NSObject, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard
            let previousViewController = navigationController.transitionCoordinator?.viewController(forKey: .from), !navigationController.viewControllers.contains(previousViewController) else {
                return
        }
        viewController.coordinator?.stopChildren()
    }
}
