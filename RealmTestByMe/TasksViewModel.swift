//
//  TasksViewModel.swift
//  RealmTestByMe
//
//  Created by iFARA💻 on 02.12.2022.
//

import Foundation
import RealmSwift

protocol TasksViewModelProtocol {
        
    func getCellTitle(at indexPath: IndexPath) -> String
    func selectedElement(at indexPath: IndexPath) -> String
    
}

final class TasksViewModel: TasksViewModelProtocol {
    
    var dataSource: Results<Task>?
    
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
}

