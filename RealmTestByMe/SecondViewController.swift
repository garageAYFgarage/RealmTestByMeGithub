//
//  SecondViewController.swift
//  RealmTestByMe
//
//  Created by iFARA💻 on 06.12.2022.
//

import UIKit

class SecondViewController: UIViewController {
    

    let tableView = UITableView()
    
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for x in 0...100 {
            data.append("Some data \(x)")
        }
        
        self.title = "SecondViewController"

        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellcell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellcell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("tapped cell.")
    }
    
}
