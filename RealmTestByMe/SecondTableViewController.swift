//
//  SecondTableViewController.swift
//  RealmTestByMe
//
//  Created by iFARA💻 on 06.12.2022.
//

import UIKit

class SecondTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SecondTableViewController"

        tableView.delegate = self
        tableView.dataSource = self
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = ("Row \(indexPath.row + 1)")
        
        return cell
    }

}
