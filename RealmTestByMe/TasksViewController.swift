//
//  TasksViewController.swift
//  RealmTestByMe
//
//  Created by iFARA💻 on 15.11.2022.
//

import Foundation
import UIKit
import RealmSwift

class TasksViewController: UITableViewController {
    
    var currentList: TaskList!
    
    var currentTasks: Results<Task>!
    var completedTasks: Results<Task>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = currentList?.name
        view.backgroundColor = .green
        
//        currentTasks = currentList.tasks.filter("isCompleted == false")
//        completedTasks = currentList.tasks.filter("isCompleted == true")
    }
    
}

