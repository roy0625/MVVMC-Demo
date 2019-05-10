//
//  DetailViewModel.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/8.
//  Copyright © 2019 roy. All rights reserved.
//

import Foundation

struct DetailViewModel {

    var fileDataManager: FileDataManagerSyncActions

    var todoModel: TodoModel
    var indexPath: IndexPath

    init(todoModel: TodoModel, indexPath: IndexPath, fileDataManager: FileDataManagerSyncActions) {
        self.todoModel = todoModel
        self.indexPath = indexPath
        self.fileDataManager = fileDataManager
    }

    func saveData() {
        var data = fileDataManager.getDataFromFile()

        if indexPath.section == TodoSection.done.rawValue {
            if todoModel.isDone == true {
                data.done[indexPath.row] = todoModel
            } else {
                data.done.remove(at: indexPath.row)
                data.todo.append(todoModel)
            }
        } else {
            if todoModel.isDone == false {
                data.todo[indexPath.row] = todoModel
            } else {
                data.todo.remove(at: indexPath.row)
                data.done.append(todoModel)
            }
        }
        fileDataManager.writeDataToFile(todos: data)
    }
}
