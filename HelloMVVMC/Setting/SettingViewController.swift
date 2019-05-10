//
//  SettingViewController.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/8.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    weak var delegate: SettingViewControllerDelegate?
    let presentButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Settings"
        setupViews()
    }

    func setupViews() {
        presentButton.setTitle("Present", for: .normal)
        presentButton.addTarget(self, action: #selector(clickPresent), for: .touchUpInside)

        view.addSubview(presentButton)

        presentButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    @objc func clickPresent() {
        print("click present")
        self.delegate?.clickPresent(viewController: self)
    }
}

protocol SettingViewControllerDelegate : class {
    func clickPresent(viewController: UIViewController)
}
