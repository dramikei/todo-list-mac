//
//  ViewController.swift
//  Todo-list
//
//  Created by Raghav Vashisht on 23/07/18.
//  Copyright © 2018 Raghav Vashisht. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var checkBox: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    
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
        tableView.reloadData()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return todoItems.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let todoItem = todoItems[row]
        if (tableColumn?.identifier)!.rawValue == "importantColumn" {
            
            guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "importantCell"), owner: self) as? NSTableCellView else { return nil }
            
            if todoItem.important{
                cell.textField?.stringValue = "❗️"
            } else {
                cell.textField?.stringValue = ""
            }
            
            return cell
            
        } else {
            guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "todoItems"), owner: self) as? NSTableCellView else { return nil }
            
            
            cell.textField?.stringValue = todoItem.name!
            return cell
        }
        
    }
    
    
    
}

