//
//  DataManager.swift
//  NotesAndToDoList
//
//  Created by Haris Madhavan on 01/10/24.
//

import Foundation
import UIKit
import CoreData

final class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    //Notes Data Manager
    func createNote(title: String, content: String, date: Date) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "Notes", in: managedContext) {
            
            let note = NSManagedObject(entity: entity, insertInto: managedContext)
            
            note.setValue(title, forKey: "title")
            note.setValue(content, forKey: "content")
            note.setValue(date, forKey: "date")
            
            do {
                try managedContext.save()
            } catch {
                print("Failed to save note: \(error.localizedDescription)")
            }
        } else {
            print("Entity not found")
        }
    }
    
    func retrieveNotes() -> [NSManagedObject] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Notes")
        
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes
        } catch {
            print("Failed to retrieve notes: \(error.localizedDescription)")
            return []
        }
    }
    
    func updateNotes(title: String, content: String, date: Date) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let note = try managedContext.fetch(fetchRequest)
            
            guard let noteToUpdate = note[0] as? NSManagedObject else { return }
            noteToUpdate.setValue(title, forKey: "title")
            noteToUpdate.setValue(content, forKey: "content")
            noteToUpdate.setValue(date, forKey: "date")
            
            do {
                try managedContext.save()
            } catch {
                print("Failed to save note after updated: \(error.localizedDescription)")
            }
        } catch {
            print("Failed to update note: \(error.localizedDescription)")
        }
    }
    
    func deleteNotes(_ title: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let note = try managedContext.fetch(fetchRequest)
            
            guard let noteToDelete = note[0] as? NSManagedObject else { return }
            managedContext.delete(noteToDelete)
            
            do {
                try managedContext.save()
            } catch {
                print("Failed to save note after delete: \(error.localizedDescription)")
            }
        } catch {
            print("Failed to delete note: \(error.localizedDescription)")
        }
    }
    
    //ToDoList Data Manager
    func createToDoList(title: String, status: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "ToDoList", in: managedContext) {
            
            let toDoList = NSManagedObject(entity: entity, insertInto: managedContext)
            
            toDoList.setValue(title, forKey: "title")
            toDoList.setValue(status, forKey: "status")
            
            do {
                try managedContext.save()
            } catch {
                print("Failed to save to do list: \(error.localizedDescription)")
            }
        } else {
            print("Entity not found")
        }
    }
    
    func retrieveToDoList() -> [NSManagedObject] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return []}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDoList")
        
        do {
            let toDoList = try managedContext.fetch(fetchRequest)
            return toDoList
        } catch {
            print("Failed to retrieve to do list: \(error.localizedDescription)")
            return []
        }
    }
    
    func updateToDoList(title: String, status: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: "ToDoList")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let toDoList = try managedContext.fetch(fetchRequest)
            
            guard let toDoListToUpdate = toDoList[0] as? NSManagedObject else { return }
            toDoListToUpdate.setValue(title, forKey: "title")
            toDoListToUpdate.setValue(status, forKey: "status")
            
            do {
                try managedContext.save()
            } catch {
                print("Failed to save ToDoList after updated: \(error.localizedDescription)")
            }
        } catch {
            print("Failed to update ToDoList")
        }
    }
    
    func deleteToDoList(_ title: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoList")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            let toDoList = try managedContext.fetch(fetchRequest)
            
            guard let toDoListToDelete = toDoList.first as? ToDoList else { return }
            managedContext.delete(toDoListToDelete)
            
            do {
                try managedContext.save()
            } catch {
                print("Failed to save ToDoList after delete: \(error.localizedDescription)")
            }
        } catch {
            print("Failed to delete ToDoList: \(error.localizedDescription)")
        }
    }
}
