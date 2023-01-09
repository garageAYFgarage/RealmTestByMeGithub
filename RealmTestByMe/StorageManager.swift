//
//  StorageManager.swift
//  RealmTestByMe
//
//  Created by iFARA💻 on 15.11.2022.
//

import Foundation
import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    func saveTaskList(_ taskLists: TaskList) {
        try! realm.write {
            realm.add(taskLists)
        }
    }
    
    func update(_ taskList: TaskList, _ task: Task) {
        try! realm.write {
            taskList.tasks.insert(task, at: 0)
        }
    }
    
    func deleteTaskList(_ taskLists: TaskList) {
        try! realm.write {
            realm.delete(taskLists)
        }
    }
    
    func deleteTask(_ taskList: TaskList, at indexPath: IndexPath) {
        try! realm.write {
            taskList.tasks.remove(at: indexPath.row)
        }
    }
    
    func editTask(_ taskList: TaskList, at indexPath: IndexPath, with name: String) {
        try! realm.write {
            taskList.tasks[indexPath.row].name = name
        }
    }
    
}

