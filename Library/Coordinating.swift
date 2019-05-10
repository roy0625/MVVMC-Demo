//
//  Coordinating.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/7.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

protocol Coordinating : class {
    var identifier: String { get }
    var started: Bool { get }
    var parent: Coordinating? { get set }
    var childCoordinators: [Coordinating] { get }
    func start() -> Void
    func startChild( coordinator : Coordinating ) -> Void
    func stop() -> Void
    func stopChild(coordinator: Coordinating) -> Void
    func stopChildren() -> Void

    @available(*, deprecated)
    func didReceiveDestoried(  viewController: UIViewController) -> Void
    func active() -> Void
    func deactive() -> Void
}

protocol CoordinatingVisibleViewController {
    var visibleViewController: UIViewController { get }
}

extension Coordinating {
    func printCoordinatorHierarchy() {
        #if DEBUG
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
            print("------ DebugInfo start ------")
            print("\(self.hierarchy())")
        })
        #endif
    }

    private func hierarchy(_ indent: String = "") -> String {
        var string = identifier
        childCoordinators.forEach {
            string += "\n" + indent + "|-\($0.hierarchy( indent + "\t" ))"
        }
        return string
    }
}

private struct CoordinatingAssociatedKeys {
    static var ownerKey: UInt = 0
}

// Extensions must not contain stored properties
// -> use objc_setAssociatedObject / objc_getAssociatedObject
extension UIViewController {
    weak var coordinator: Coordinating? {
        set {
            objc_setAssociatedObject(self, &CoordinatingAssociatedKeys.ownerKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return objc_getAssociatedObject(self, &CoordinatingAssociatedKeys.ownerKey) as? Coordinating
        }
    }
}
