//
//  EditingTaskViewController.swift
//  RealmTestByMe
//
//  Created by iFARA💻 on 06.01.2023.
//

import UIKit

class EditingTaskViewController: UIViewController {
    
    let myTextField: UITextField = UITextField(frame: CGRect(x: 10, y: 100, width: 410, height: 780))
    let viewModel = EditingTaskViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupTextField()
        displayMyTextField()
        
    }
    
    private func setupViews() {
        view.backgroundColor = .secondarySystemBackground
        myTextField.backgroundColor = .systemBackground
    }
    
    private func setupTextField() {
        myTextField.text = viewModel.taskDescription
    }
    
    private func displayMyTextField() {
        
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
        if let indexPath = viewModel.indexPath, let text = myTextField.text{
            viewModel.saveEditedTask(indexPath: indexPath, text: text)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
