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
    
    let button = UIButton()

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
        
//        taskLists = realm.objects(TaskList.self)
//
//        let shoppingList = TaskList()
//        shoppingList.name = "Shopping List"
//
//        let moviesList = TaskList(value: ["Movies List", Date(), [["Best Movie Ever"], ["Best Of The Best Movie Ever", "", Date(), true]]])
//
//        let milk = Task()
//        milk.name = "Milk"
//        milk.note = "2 litre"
//        let bread = Task()
//        bread.name = "Bread"
//        bread.note = "5 unit"
//        let apples = Task()
//        apples.name = "Apple"
//        apples.note = "15 unit"
//
//        shoppingList.tasks.append(milk)
//        shoppingList.tasks.insert(contentsOf: [bread, apples], at: 1)
//
//        DispatchQueue.main.async {
//            StorageManager.shared.saveTaskLists([shoppingList, moviesList])
//        }
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dissmis", style: .plain, target: self, action: #selector(dismissSelf))
        
        button.setTitle("Go to second VC", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.yellow, for: .normal)
        button.layer.borderWidth = 1.5
        
        setupUI()
        setupLayout()
        
    }

    //MARK: -  Private Helpers
    private func setupUI() {
            navigationController?.navigationBar
        .prefersLargeTitles = true
        view.backgroundColor = .purple
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        navigationController?.navigationBar.backgroundColor = .clear
        title = "Task Lists"
    }
    
    //MARK: - Layout
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(350)
            make.bottom.equalToSuperview().offset(-350)
            make.trailing.equalToSuperview().offset(-100)
            make.leading.equalToSuperview().offset(100)
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        }
    }
    //MARK: - Actions
    @objc private func didTapButton() {
        let vc = TasksViewController()
        vc.view.backgroundColor = .systemCyan
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
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
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let taskList = taskLists?[indexPath.row]
        let tasksVC = TasksViewController()
        tasksVC.currentList = taskList
        self.present(tasksVC, animated: true)
    }
}



