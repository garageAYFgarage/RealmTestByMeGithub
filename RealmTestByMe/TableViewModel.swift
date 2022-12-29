//
//  TableViewModel.swift
//  RealmTestByMe
//
//  Created by iFARA💻 on 15.11.2022.
//

import Foundation
import RealmSwift

protocol TableViewModelProtocol {
    
    var numberOfRows: Int { get }
    var dataSource: Results<TaskList>? { get set }
    
    func getCellTitle(at indexPath: IndexPath) -> String
    func selectedElement(at indexPath: IndexPath) -> String
    
}

final class TableViewModel: TableViewModelProtocol {
    
    var taskLists: Results<TaskList>?
    var dataSource: Results<TaskList>? 
    
    init() {
        self.dataSource = realm.objects(TaskList.self)
    }
    
    var numberOfRows: Int {
        dataSource?.count ?? 0
    }
    
    func getCellTitle(at indexPath: IndexPath) -> String {
        "\(dataSource?[indexPath.row].name ?? "")"    }
    
    func selectedElement(at indexPath: IndexPath) -> String {
        "\(dataSource?[indexPath.row].name ?? "")"
    }

}


