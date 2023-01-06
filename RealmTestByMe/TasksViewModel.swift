//
//  TasksViewModel.swift
//  RealmTestByMe
//
//  Created by iFARA💻 on 02.12.2022.
//

import Foundation
import RealmSwift

protocol TasksViewModelProtocol {
    
    var currentList: TaskList? {get set}
    var dataSource: Results<Task>? {get set}
    func getCellTitle(at indexPath: IndexPath) -> String
    func selectedElement(at indexPath: IndexPath) -> String
    
}

final class TasksViewModel: TasksViewModelProtocol {
    
    var dataSource: Results<Task>?
    var currentList: TaskList?
    
    init() {
        self.dataSource = realm.objects(Task.self)
    }
    
    var numberOfRows: Int {
        dataSource?.count ?? 0
    }
    
    func getCellTitle(at indexPath: IndexPath) -> String {
        "\(dataSource?[indexPath.row].name ?? "")"
    }
    
    func selectedElement(at indexPath: IndexPath) -> String {
        "\(dataSource?[indexPath.row].name ?? "")"
    }
    
    func deletedElement(at indexPath: IndexPath) -> String {
        "\(dataSource?[indexPath.row].name ?? "")"
    }
}

