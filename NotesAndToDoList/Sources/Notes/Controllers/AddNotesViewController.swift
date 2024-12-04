//
//  AddNotesViewController.swift
//  NotesAndToDoList
//
//  Created by Haris Madhavan on 02/10/24.
//

import UIKit

protocol NotesDelegate: AnyObject {
    func reloadData()
}

class AddNotesViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView! {
        didSet {
            contentTextView.delegate = self
        }
    }
    @IBOutlet weak var addNotesView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    weak var delegate: NotesDelegate?
    
    var noteTitle = String()
    var noteContent = String()
    var isDidSelect = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.view.alpha = 0
        
        addNotesView.applyCornerRadiusAndShadow()
        titleTextField.applyTextFieldStyle(placeholderText: "Title")
        contentTextView.applyTextViewStyle()
        
        if isDidSelect {
            titleTextField.text = noteTitle
            contentTextView.text = noteContent
            contentTextView.textColor = .black
            headingLabel.text = "Edit Note"
        } else {
            contentTextView.text = "Content"
            contentTextView.textColor = .lightGray
            headingLabel.text = "Add Note"
        }
        
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
        guard let title = titleTextField.text else { return }
        guard let content = contentTextView.text else { return }
        let date = Date()
        
        if isDidSelect {
            DataManager.shared.updateNotes(title: title, content: content, date: date)
        } else {
            DataManager.shared.createNote(title: title, content: content, date: date)
        }
        
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
        view.bringSubviewToFront(addNotesView)
    }
    
}

extension AddNotesViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Content"
            textView.textColor = .lightGray
        }
    }
}
