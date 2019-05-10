//
//  TabChartCoordinator.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/8.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

class TabChartCoordinator: Coordinator<UIViewController> {
    override func start() {
        if started { return }

        let vc = ChartViewController()
        vc.coordinator = self

        super.start()
    }
}
