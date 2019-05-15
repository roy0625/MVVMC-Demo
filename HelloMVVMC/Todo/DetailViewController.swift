//
//  DetailViewController.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/8.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit

protocol DetailViewControllerProtocol: class {
    func clickSave(viewController: UIViewController)
}

class DetailViewController: UIViewController {

    var viewModel: DetailViewModel

    weak var delegate: DetailViewControllerProtocol?

    let titleLabel = UILabel()
    let timeLabel = UILabel()
    let doneSwitch = UISwitch()
    let saveButton = UIButton(type: .custom)

    // MARK: - init
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Detail"
        addRightButton()
        setupViews()
    }

    // MARK: - setup views
    private func setupViews() {
        view.backgroundColor = .white

        view.addSubview(titleLabel)
        view.addSubview(timeLabel)
        view.addSubview(doneSwitch)
        view.addSubview(saveButton)

        let margin = 20.0
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(margin)
            make.top.equalToSuperview().offset(150)
        }

        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(margin)
        }

        doneSwitch.snp.makeConstraints { make in
            make.left.equalTo(titleLabel)
            make.top.equalTo(timeLabel.snp.bottom).offset(margin)
        }

        titleLabel.text = viewModel.name()
        timeLabel.text = viewModel.time()
        doneSwitch.isOn = viewModel.isDone()

        doneSwitch.addTarget(self, action: #selector(clickDoneSwitch(sender:)) , for: .valueChanged)
    }

    private func addRightButton() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(clickSave))
        navigationItem.rightBarButtonItem = rightButton
    }

    // MARK: click action
    @objc func clickSave() {
        viewModel.saveData()
        self.delegate?.clickSave(viewController: self)
    }

    @objc func clickDoneSwitch(sender: UISwitch) {
        viewModel.changeDoneStatus(sender.isOn)
    }
}
