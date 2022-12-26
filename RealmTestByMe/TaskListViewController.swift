//
//  ViewController.swift
//  RealmTestByMe
//
//  Created by iFARA💻 on 15.11.2022.
//

import UIKit
import SnapKit
import RealmSwift

class TaskListViewController: UIViewController {
    
    var taskLists: Results<TaskList>?
    
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
        
        
        //MARK: - REALM
//        taskLists = realm.objects(TaskList.self)
//
//        let shoppingList = TaskList()
//        shoppingList.name = "Shopping List 🥁"
//        let milk = Task()
//        milk.name = "Milk🥛"
//        milk.note = "2 litre"
//        let bread = Task()
//        bread.name = "Bread🍞"
//        bread.note = "5 unit"
//        let apples = Task()
//        apples.name = "Apple🍏"
//        apples.note = "15 unit"
//
//        let moviesList = TaskList(value: ["Movies List 🎬", Date(), [["Best Movie Ever1️⃣"], ["Best Of The Best Movie Ever0️⃣", "", Date(), false]]])
//
//        let carList = TaskList()
//        carList.name = "Car List 🚗"
//        let car = Task()
//        car.name = "ACURA🏎"
//        car.note = "RL"
//        carList.tasks.append(car)
//
//        shoppingList.tasks.append(milk)
//        shoppingList.tasks.insert(contentsOf: [bread, apples], at: 1)
//
//        DispatchQueue.main.async {
//            StorageManager.shared.saveTaskLists([carList, shoppingList, moviesList])
//        }


        
        setupUI()
        setupLayout()

        configureItems()
    }

    //MARK: -  Private Helpers
    //MARK: - Layout
    private func setupUI() {
        view.backgroundColor = .purple
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        navigationController?.navigationBar.backgroundColor = .blue
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Task List"
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
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
            field.placeholder = "List Name"
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    let shoppingList = TaskList()
                    shoppingList.name = text
                    DispatchQueue.main.async {
                        StorageManager.shared.saveTaskList(shoppingList)
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

//MARK: - Extensions
extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.getCellTitle(at: indexPath)
        cell.contentView.backgroundColor = .systemYellow
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let viewModelTasks = TasksViewModel()
        let tasksVC = TasksViewController(viewModelTasks: viewModelTasks)
        tasksVC.currentList = viewModel.dataSource?[indexPath.row]
        navigationController?.pushViewController(tasksVC, animated: true)
        
    }
}



