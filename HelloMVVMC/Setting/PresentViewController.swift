//
//  PresentViewController.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/9.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

protocol PresentViewControllerDelegate: class {
    func clickDismissButton(viewController: PresentViewController)
}

class PresentViewController: UIViewController {

    weak var delegate: PresentViewControllerDelegate?
    let dismissButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Present"
        setupViews()
    }

    func setupViews() {
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(clickDismiss), for: .touchUpInside)

        view.addSubview(dismissButton)

        dismissButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    @objc func clickDismiss() {
        self.delegate?.clickDismissButton(viewController: self)
    }
}
