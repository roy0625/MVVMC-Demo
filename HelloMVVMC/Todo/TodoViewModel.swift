//
//  TodoViewModel.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/8.
//  Copyright © 2019 roy. All rights reserved.
//

import Foundation

protocol TodoViewModelDelegate: class {
    func todoListUpdate()
}

class TodoViewModel {

    var fileDataManager: FileDataManagerSyncActions
    var data: TodoListModel = TodoListModel()

    weak var delegate: TodoViewModelDelegate?
    
    init(fileDataManager: FileDataManagerSyncActions) {
        self.fileDataManager = fileDataManager
        updateData()
    }

    private func saveData() {
        fileDataManager.writeDataToFile(todos: data)
        updateData()
    }

    // MARK: - public function
    func updateData() {
        data = fileDataManager.getDataFromFile()

        self.delegate?.todoListUpdate()
    }

    func addItem(name: String) {
        let item = TodoModel(name: name, isDone: false, time: 0)
        data.todo.append(item)
        saveData()
    }

    func removeData(indexPath: IndexPath) {
        if indexPath.section == TodoSection.done.rawValue {
            data.done.remove(at: indexPath.row)
        } else {
            data.todo.remove(at: indexPath.row)
        }
        saveData()
    }

    func deleteFile() {
        fileDataManager.removeFile()
        updateData()
    }
}

