//
//  TodoViewController.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/8.
//  Copyright © 2019 roy. All rights reserved.
//

import UIKit
import SnapKit

enum TodoSection: Int {
    case todo = 0
    case done = 1
}

protocol TodoViewControllerDelegate: class {
    func todoClickTableViewCell(viewController: TodoViewController, item: TodoModel, indexPath: IndexPath)
}

class TodoViewController: UIViewController {

    let viewModel: TodoViewModel

    let tableView = UITableView()
    let deleteButton = UIButton(type: .custom)

    weak var delegate: TodoViewControllerDelegate?

    // MARK: - init
    init(viewModel: TodoViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self

        title = "To Do List"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        addRightButton()

        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.updateData()
    }

    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(deleteButton)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self

        deleteButton.backgroundColor = .gray
        deleteButton.setTitle("Delete All", for: .normal)
        deleteButton.layer.cornerRadius = 25
        deleteButton.layer.masksToBounds = true
        deleteButton.addTarget(self, action: #selector(clickDelete), for: .touchUpInside)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        deleteButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.right.equalToSuperview().offset(-30)
            make.size.equalTo(CGSize(width: 110, height: 50))
        }
    }

    private func addRightButton() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showTodoAlert))
        navigationItem.rightBarButtonItem = rightButton
    }

    // MARK: - Actions
    @objc func showTodoAlert() {
        let alert = UIAlertController(title: "Enter", message: "What do you want to do?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            if let name = alert.textFields?.first?.text {
                self.viewModel.addItem(name: name)
            }
            print("click OK")
        })
        alert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("click cancel")
        }
        alert.addAction(cancelAction)

        alert.addTextField { textField in
            textField.placeholder = "to do"
        }

        present(alert, animated: true, completion: {
            print("alert complete")
        })
    }

    @objc func clickDelete() {
        viewModel.deleteFile()
    }
}

extension TodoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == TodoSection.todo.rawValue {
            return viewModel.data.todo.count
        } else {
            return viewModel.data.done.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if indexPath.section == TodoSection.todo.rawValue {
            let item = viewModel.data.todo[indexPath.row]
            cell.textLabel?.text = item.name
        } else {
            let item = viewModel.data.done[indexPath.row]
            cell.textLabel?.text = item.name
        }

        return cell
    }
}

extension TodoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == TodoSection.todo.rawValue {
            self.delegate?.todoClickTableViewCell(viewController: self, item: viewModel.data.todo[indexPath.row], indexPath: indexPath)
        } else {
            self.delegate?.todoClickTableViewCell(viewController: self, item: viewModel.data.done[indexPath.row], indexPath: indexPath)
        }
    }

    // for edit
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeData(indexPath: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    // section header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == TodoSection.todo.rawValue {
            return "To Do"
        } else {
            return "Done"
        }
    }
}

extension TodoViewController: TodoViewModelDelegate {
    func todoListUpdate() {
        tableView.reloadData()
    }
}
