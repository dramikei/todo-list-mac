//
//  ViewController.swift
//  Todo-list
//
//  Created by Raghav Vashisht on 23/07/18.
//  Copyright © 2018 Raghav Vashisht. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var checkBox: NSButton!
    
    var todoItems: [TodoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func addClicked(_ sender: NSButton) {
        if textField.stringValue != "" {
            guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            let todoItem = TodoItem(context: context)
            todoItem.name = textField.stringValue
            if checkBox.state == .off {
                todoItem.important = false
            } else if checkBox.state == .on {
                todoItem.important = true
            }
            appDelegate.saveAction(nil)
            textField.stringValue = ""
            checkBox.state = .off
            getData()
        }
    }
    
    func getData() {
        guard let appDelegate = NSApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            todoItems = try context.fetch(TodoItem.fetchRequest())
        } catch {
            
        }
        
    }
}

