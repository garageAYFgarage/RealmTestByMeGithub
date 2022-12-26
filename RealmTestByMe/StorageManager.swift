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
    
    func saveTaskLists(_ taskLists: [TaskList]) {
        try! realm.write {
            realm.add(taskLists)
        }
    }
    
    func saveTaskList(_ taskLists: TaskList) {
        try! realm.write {
            realm.add(taskLists)
        }
    }
    
    func saveTask(_ task: Task) {
        try! realm.write {
            realm.add(task)
        }
    }
    
    func update(_ taskList: TaskList, _ task: Task) {
        try! realm.write {
            taskList.tasks.insert(task, at: 0)
            //taskList.tasks.append(task)
        }
    }
    
}

