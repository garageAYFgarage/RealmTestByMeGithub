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
//    var newTaskList = RealmSwift.List<TaskList>()
    
    let tableViewControllerButton = UIButton()
    let viewControllerButton = UIButton()
    
//    var selectedIndex = IndexPath(row: -1, section: 0)

    //MARK: - UIElements
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.backgroundColor = .systemPink
//        TableViewCell.contentView.backgroundColor = .systemPink
        
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
////
//        let shoppingList = TaskList()
//        shoppingList.name = "Shopping List 🥁"
//
//        let moviesList = TaskList(value: ["Movies List 🎬", Date(), [["Best Movie Ever1️⃣"], ["Best Of The Best Movie Ever0️⃣", "", Date(), false]]])
//
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
//        shoppingList.tasks.append(milk)
//        shoppingList.tasks.insert(contentsOf: [bread, apples], at: 1)
//
//        DispatchQueue.main.async {
//            StorageManager.shared.saveTaskLists([shoppingList, moviesList])
//        }

        
        
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dissmis", style: .plain, target: self, action: #selector(dismissSelf))
        

        // first button
        tableViewControllerButton.setTitle("Go to STVC", for: .normal)
        tableViewControllerButton.backgroundColor = .green
        tableViewControllerButton.setTitleColor(.yellow, for: .normal)
        tableViewControllerButton.layer.borderWidth = 1.5
        
        // second button
        viewControllerButton.setTitle("Go to SVC", for: .normal)
        viewControllerButton.backgroundColor = .orange
        viewControllerButton.setTitleColor(.systemPink, for: .normal)
        viewControllerButton.layer.borderWidth = 1.5
        
        setupUI()
        setupLayout()

        

        configureItems()
    }

    //MARK: -  Private Helpers
    //MARK: - Layout
    private func setupUI() {
            navigationController?.navigationBar
        .prefersLargeTitles = true
        view.backgroundColor = .purple
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        navigationController?.navigationBar.backgroundColor = .blue
        title = "Task Lists"
//        cell.backgroundColor = UIColor.blue
//        tableView.cell.backgroundColor = .systemPink
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        view.addSubview(tableViewControllerButton)
        tableViewControllerButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(250)
            make.bottom.equalToSuperview().offset(-558)
            make.trailing.equalToSuperview().offset(-100)
            make.leading.equalToSuperview().offset(100)
            tableViewControllerButton.addTarget(self, action: #selector(didTapTableViewControllerButton), for: .touchUpInside)
        }
        view.addSubview(viewControllerButton)
        viewControllerButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(570)
            make.bottom.equalToSuperview().offset(-235)
            make.trailing.equalToSuperview().offset(-100)
            make.leading.equalToSuperview().offset(100)
            viewControllerButton.addTarget(self, action: #selector(didTapViewControllerButton), for: .touchUpInside)
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
                    
                    //Enter new to do list item
                    print(text)
                    
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                                        
                                        present(alert, animated: true)
                                        }
    
    //MARK: - Add setupUI button to STVC
    @objc private func didTapTableViewControllerButton() {
        let vc = SecondTableViewController()
        vc.view.backgroundColor = .systemCyan
        navigationController?.pushViewController(vc, animated: true)

    }
//    @objc private func dismissSelf() {
//        dismiss(animated: true, completion: nil)
//    }
    
    @objc private func didTapViewControllerButton() {
        let secondVC = SecondViewController()
        secondVC.view.backgroundColor = .orange
        navigationController?.pushViewController(secondVC, animated: true)
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
//        if selectedIndex == indexPath { cell.backgroundColor = UIColor.black }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let indexesToRedraw = [indexPath]
//                selectedIndex = indexPath
//
        
        let viewModelTasks = TasksViewModel()
        let tasksVC = TasksViewController(viewModelTasks: viewModelTasks)
        tasksVC.currentList = viewModel.dataSource?[indexPath.row]
        navigationController?.pushViewController(tasksVC, animated: true)
        
//        tableView.reloadRows(at: indexesToRedraw, with: .fade)
    
    }
}



