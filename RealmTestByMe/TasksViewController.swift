//
//  TasksViewController.swift
//  RealmTestByMe
//
//  Created by iFARA💻 on 15.11.2022.
//

import Foundation
import UIKit
import RealmSwift

final class TasksViewController: UITableViewController {
    
    var delegate: TaskListViewController?
    var currentList: TaskList!
    var currentTasks: Results<Task>!
    var completedTasks: Results<Task>!
    
    //MARK: - Properties
    private let viewModelTasks: TasksViewModelProtocol
    
    //MARK: - LifeCycle
    init(viewModelTasks: TasksViewModelProtocol) {
        self.viewModelTasks = viewModelTasks
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TasksCell")
                
        currentTasks = currentList.tasks.filter("isComplete == false")
        completedTasks = currentList.tasks.filter("isComplete == true")
        
        setupUI()
        configureItems()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
     
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? currentTasks.count : completedTasks.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        section == 0 ? "CURRENT TASK" : "COMPLETED TASK"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksCell", for: indexPath)
        
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        cell.textLabel?.text = task.name
    
        return cell
    }
    
    private func setupUI() {
        title = currentList.name
        view.backgroundColor = .green
    }
    
    private func configureItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapButton)
        )
    }
    
    @objc private func didTapButton() {
        let alert = UIAlertController(title: "New Task", message: "Please insert new value", preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "Task Name"
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    let newTask = Task()
                    newTask.name = text
                    DispatchQueue.main.async {
                        StorageManager.shared.update(self.currentList, newTask)
                        self.tableView.reloadData()
                    }
                    print(text)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                                        
                                        present(alert, animated: true)
                                        }
    
}

