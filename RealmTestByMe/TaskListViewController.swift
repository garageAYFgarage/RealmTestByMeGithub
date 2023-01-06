//
//  ViewController.swift
//  RealmTestByMe
//
//  Created by iFARA💻 on 15.11.2022.
//

import UIKit
import SnapKit
import RealmSwift

final class TaskListViewController: UIViewController {
    
    //MARK: - UIElements
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    //MARK: - Properties
    private let viewModel: TableViewModelProtocol
    
    //MARK: - LifeCycle
    init(viewModel: TableViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
        configureItems()
        
    }

    private func setupUI() {
        view.backgroundColor = .purple
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Task List"
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapButton)
        )
    }
    
    @objc private func didTapButton() {
        
        let alert = UIAlertController(title: "New List", message: "Please insert new value", preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "Create new item"
        }
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    let newList = TaskList()
                    newList.name = text
                    DispatchQueue.main.async { [weak self] in
                        StorageManager.shared.saveTaskList(newList)
                        self?.tableView.reloadData()
                    }
                    print(text)
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                                        present(alert, animated: true)
        
                                        }
    }


//MARK: - Extensions
extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.getCellTitle(at: indexPath)
        cell.contentView.backgroundColor = .systemBackground
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModelTasks = TasksViewModel()
        let tasksVC = TasksViewController(viewModelTasks: viewModelTasks)
        tasksVC.viewModelTasks.currentList = viewModel.dataSource?[indexPath.row]
        tasksVC.currentList = viewModel.dataSource?[indexPath.row]
        navigationController?.pushViewController(tasksVC, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let dataSource = viewModel.dataSource {
                StorageManager.shared.deleteTaskList(dataSource[indexPath.row])
            }
            
            tableView.reloadData()
            
        }
    }
}



