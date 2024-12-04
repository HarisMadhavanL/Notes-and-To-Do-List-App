//
//  AddToDoListViewController.swift
//  NotesAndToDoList
//
//  Created by Haris Madhavan on 10/10/24.
//

import UIKit

protocol ToDoListDelegate: AnyObject {
    func reloadData()
}

class AddToDoListViewController: UIViewController {
    
    @IBOutlet weak var addToDoView: UIView!
    @IBOutlet weak var toDoTextField: UITextField!
    
    weak var delegate: ToDoListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.alpha = 0
        
        addToDoView.applyCornerRadiusAndShadow()
        toDoTextField.applyTextFieldStyle(placeholderText: "To-Do List")
        
        makeBlur()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 1
        })
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 0
        }) { _ in
            self.dismiss(animated: false)
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        guard let title = toDoTextField.text else { return }
        
        DataManager.shared.createToDoList(title: title, status: false)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 0
        }) { _ in
            self.delegate?.reloadData()
            self.dismiss(animated: false)
        }
    }
    
    func makeBlur() {
        let blurView = UIVisualEffectView()
        blurView.frame = view.frame
        blurView.effect = UIBlurEffect(style: .regular)
        view.addSubview(blurView)
        view.bringSubviewToFront(addToDoView)
    }
}
