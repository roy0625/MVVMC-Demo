//
//  FileDataManager.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/9.
//  Copyright © 2019 roy. All rights reserved.
//

import Foundation

protocol FileDataManagerSyncActions {
    func writeDataToFile(todos: TodoListModel)
    func getDataFromFile() -> TodoListModel
    func removeFile()
}

open class FileDataManager: FileDataManagerSyncActions {

    private let filePath: String = {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/todo.txt"
    }()

    final func writeDataToFile(todos: TodoListModel) {

        do {
            let data = try JSONEncoder().encode(todos)
            try data.write(to: URL(fileURLWithPath: filePath), options: .atomic)
        } catch {
            print("wite file error: \(error)")
        }
    }

    func getDataFromFile() -> TodoListModel {

        guard FileManager.default.fileExists(atPath: self.filePath) else {
            return TodoListModel()
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath, isDirectory: false))
            let decoder = JSONDecoder()
            let list = try decoder.decode(TodoListModel.self, from: data)
            print(list)

            return list
        } catch {
            print("error: \(error)")
        }
        return TodoListModel()
    }

    func removeFile() {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: filePath)
        } catch {
            print("remove data fail: \(error)")
        }
    }
}
