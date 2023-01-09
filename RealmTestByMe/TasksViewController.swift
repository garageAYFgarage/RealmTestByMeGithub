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
    
    //MARK: - UIElements
    let button = UIButton()
    
    //MARK: - Properties
    var viewModelTasks: TasksViewModelProtocol
    
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
        
        setupTableView()
        setupTasks()
        setupUI()
        configureItems()
        
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TasksCell")
    }
    
    private func setupTasks() {
        currentTasks = currentList.tasks.filter("isComplete == false")
        completedTasks = currentList.tasks.filter("isComplete == true")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? currentTasks.count : completedTasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TasksCell", for: indexPath)
        
        let task = indexPath.section == 0 ? currentTasks[indexPath.row] : completedTasks[indexPath.row]
        cell.textLabel?.text = task.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rootViewController = EditingTaskViewController()
        rootViewController.viewModel.taskDescription = viewModelTasks.currentList?.tasks[indexPath.row].name ?? ""
        rootViewController.viewModel.indexPath = indexPath
        rootViewController.viewModel.taskList = viewModelTasks.currentList
        rootViewController.viewModel.reloadTable = { [weak self] in
            self?.tableView.reloadData()
        }
        
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.modalPresentationStyle = .fullScreen
        present(navigationViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModelTasks.deleteTask(currentList: currentList, indexPath: indexPath)
            tableView.reloadData()
        }
    }
    
    private func setupUI() {
        title = currentList.name
        view.backgroundColor = .secondarySystemBackground
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
                    DispatchQueue.main.async { [weak self] in
                        if let currentList = self?.currentList {
                            self?.viewModelTasks.updateTasks(currentList: currentList, newTask: newTask)
                            self?.tableView.reloadData()
                        }
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
}

