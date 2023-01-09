//
//  EditingTaskModel.swift
//  RealmTestByMe
//
//  Created by iFARA💻 on 09.01.2023.
//

import Foundation

class EditingTaskViewModel {
    
    var taskDescription = ""
    var indexPath: IndexPath?
    var taskList: TaskList?
    var reloadTable: (()->Void)?

    func saveEditedTask(indexPath: IndexPath, text: String) {
        StorageManager.shared.editTask(taskList!, at: indexPath, with: text)
        reloadTable?()
    }
}

