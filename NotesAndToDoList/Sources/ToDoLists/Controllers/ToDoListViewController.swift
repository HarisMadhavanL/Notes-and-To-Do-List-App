//
//  ToDoListViewController.swift
//  NotesAndToDoList
//
//  Created by Haris Madhavan on 01/10/24.
//

import UIKit
import CoreData

class ToDoListViewController: UIViewController, ToDoListDelegate {
    
    @IBOutlet weak var toDoListTableView: UITableView! {
        didSet {
            toDoListTableView.delegate = self
            toDoListTableView.dataSource = self
            toDoListTableView.register(UINib(nibName: "ToDoListTableViewCell", bundle: nil), forCellReuseIdentifier: "ToDoListTableViewCell")
        }
    }
    @IBOutlet weak var emptyView: UIView!
    
    var toDoList = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        toDoList = DataManager.shared.retrieveToDoList()
        toDoListTableView.reloadData()
        
        noToDoList()
    }
    
    @IBAction func addAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "AddToDoListViewController") as! AddToDoListViewController
        controller.delegate = self
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: true)
        //        DataManager.shared.createToDoList(title: "Test 1", status: false)
    }
    
    func reloadData() {
        toDoList = DataManager.shared.retrieveToDoList()
        toDoListTableView.reloadData()
        noToDoList()
    }
    
    func noToDoList() {
        if toDoList.isEmpty {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
        }
    }
}

extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCell", for: indexPath) as! ToDoListTableViewCell
        
        let title = toDoList[indexPath.row].value(forKey: "title") as? String ?? ""
        let status = toDoList[indexPath.row].value(forKey: "status") as? Bool ?? false
        
        cell.toDoLabel.text = title
        cell.selectionImageView.image = status ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
        
        if status {
            cell.toDoLabel.strikethroughText(title)
        } else {
            cell.toDoLabel.removeStrikethroughText(title)
        }
        
        if indexPath.row == 0 {
            cell.layer.cornerRadius = 18
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.layer.masksToBounds = true
            cell.backgroundColor = .white
        }
        
        if indexPath.row == self.toDoList.count - 1 {
            cell.layer.cornerRadius = 18
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.layer.masksToBounds = true
            cell.backgroundColor = .white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { action, view, completion in
            
            let title = self.toDoList[indexPath.row].value(forKey: "title") as? String
            DataManager.shared.deleteToDoList(title ?? "")
            self.toDoList = DataManager.shared.retrieveToDoList()
            self.toDoListTableView.reloadData()
            self.noToDoList()
            
            completion(true)
        }
        delete.backgroundColor = .systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? ToDoListTableViewCell else { return }
        if cell.toDoLabel.isStrikethrough {
            cell.toDoLabel.removeStrikethroughText(cell.toDoLabel.text ?? "")
            cell.selectionImageView.image = UIImage(systemName: "circle")
            DataManager.shared.updateToDoList(title: cell.toDoLabel.text ?? "", status: false)
        } else {
            cell.toDoLabel.strikethroughText(cell.toDoLabel.text ?? "")
            cell.selectionImageView.image = UIImage(systemName: "checkmark.circle.fill")
            DataManager.shared.updateToDoList(title: cell.toDoLabel.text ?? "", status: true)
        }
        
        UIView.transition(with: cell.toDoLabel, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
    }
    
}
