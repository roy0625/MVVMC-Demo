//
//  ChartViewController.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/8.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

class ChartViewController: UIViewController {

    let button = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }

    func setupViews() {
        view.addSubview(button)

        button.setTitle("Hello", for: .normal)

        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
