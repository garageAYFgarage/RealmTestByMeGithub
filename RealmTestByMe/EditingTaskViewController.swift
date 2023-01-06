//
//  EditingTaskViewController.swift
//  RealmTestByMe
//
//  Created by iFARA💻 on 06.01.2023.
//

import UIKit

class EditingTaskViewController: UIViewController {
    
    let myTextField: UITextField = UITextField(frame: CGRect(x: 10, y: 100, width: 410, height: 780))
    var taskDescription = ""
    var indexPath: IndexPath?
    var taskList: TaskList?
    var reloadTable: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .secondarySystemBackground
        myTextField.backgroundColor = .systemBackground
        setupTextField()
        displayMyTextField()
        
    }
    
    func displayMyTextField() {
        
        myTextField.placeholder = "Edit task"
        myTextField.textAlignment = .center
        self.view.addSubview(myTextField)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissSelf))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveEditedTask))
    }

    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveEditedTask() {
        StorageManager.shared.editTask(taskList!, at: indexPath!, with: myTextField.text ?? "")
        reloadTable?()
        dismiss(animated: true, completion: nil)
    }
    
    func setupTextField() {
        myTextField.text = taskDescription
    }
    
}
