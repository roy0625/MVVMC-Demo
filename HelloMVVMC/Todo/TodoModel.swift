//
//  TodoModel.swift
//  HelloMVVMC
//
//  Created by roy on 2019/5/9.
//  Copyright © 2019 roy. All rights reserved.
//

import Foundation

struct TodoListModel: Codable {
    var todo: [TodoModel]
    var done: [TodoModel]

    init() {
        self.todo = []
        self.done = []
    }
}

struct TodoModel : Codable {
    var name: String
    var isDone: Bool
    var time: Int
}
