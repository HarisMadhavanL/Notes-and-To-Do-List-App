//
//  NotesViewController.swift
//  NotesAndToDoList
//
//  Created by Haris Madhavan on 01/10/24.
//

import UIKit
import CoreData

class NotesViewController: UIViewController, NotesDelegate {
    
    @IBOutlet weak var notesTableView: UITableView! {
        didSet {
            notesTableView.delegate = self
            notesTableView.dataSource = self
            notesTableView.register(UINib(nibName: "NotesTableViewCell", bundle: nil), forCellReuseIdentifier: "NotesTableViewCell")
        }
    }
    @IBOutlet weak var emptyView: UIView!
    
    
    var notes = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
                    
        notes = DataManager.shared.retrieveNotes()
        notesTableView.reloadData()
        noNotes()
    }

    @IBAction func addAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddNotesViewController") as! AddNotesViewController
        controller.delegate = self
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: false)
    }
    
    func reloadData() {
        notes = DataManager.shared.retrieveNotes()
        notesTableView.reloadData()
        noNotes()
    }
    
    func noNotes() {
        if notes.isEmpty {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
        }
    }
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as! NotesTableViewCell
        
        let notes = notes[indexPath.row]
        cell.titleLabel.text = notes.value(forKey: "title") as? String
        cell.contentLabel.text = notes.value(forKey: "content") as? String
        if let date = notes.value(forKey: "date") as? Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            cell.dateLabel.text = "Created at \(dateFormatter.string(from: date))"
        } else {
            cell.dateLabel.text = "No date"
        }
        
        if indexPath.row == 0 {
            cell.layer.cornerRadius = 20
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            cell.layer.masksToBounds = true
            cell.backgroundColor = .white
        }
        
        if indexPath.row == self.notes.count - 1 {
            cell.layer.cornerRadius = 20
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.layer.masksToBounds = true
            cell.backgroundColor = .white
        }
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { action, view, completion in
            
            let title = self.notes[indexPath.row].value(forKey: "title") as? String
            DataManager.shared.deleteNotes(title ?? "")
            self.notes = DataManager.shared.retrieveNotes()
            self.notesTableView.reloadData()
            self.noNotes()
            
            completion(true)
        }
        delete.backgroundColor = .systemRed
    
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AddNotesViewController") as! AddNotesViewController
        controller.isDidSelect = true
        controller.noteTitle = self.notes[indexPath.row].value(forKey: "title") as? String ?? ""
        controller.noteContent = self.notes[indexPath.row].value(forKey: "content") as? String ?? ""
        controller.delegate = self
        controller.modalPresentationStyle = .overCurrentContext
        self.present(controller, animated: false)
    }
    
}
