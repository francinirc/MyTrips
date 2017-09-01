//
//  ChecklistViewController.swift
//  Class2-TableView
//
//  Created by Francini Roberta de Carvalho on 06/07/17.
//  Copyright © 2017 Francini Roberta de Carvalho. All rights reserved.
//

import UIKit

class ChecklistViewController: UIViewController {

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemQuantityTextField: UITextField!

    @IBOutlet weak var itemsLabel: UILabel!
    
    
    @IBAction func saveItem(_ sender: Any) {
        if !itemNameTextField.text!.isEmpty && !itemQuantityTextField.text!.isEmpty {
            let checklistItem = Checklist(item: itemNameTextField.text!, quantity: Int(itemQuantityTextField.text!)!)
            ChecklistDAO.addRegister(with: checklistItem)
        }
    }
    
    @IBAction func searchItems(_ sender: Any) {
        ChecklistDAO.searchAll()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addAllNotifications()
        ChecklistDAO.searchAll()
    }

    
    private func addAllNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(ChecklistViewController.actOnNotificationSuccessRegister), name: NSNotification.Name(rawValue: "notificationSuccessRegister"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChecklistViewController.actOnNotificationErrorRegister), name: NSNotification.Name(rawValue: "notificationErrorRegister"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChecklistViewController.actOnNotificationSuccessFetch), name: NSNotification.Name(rawValue: "notificationSuccessFetch"), object: nil)
    }
    
    
    func actOnNotificationSuccessRegister() {
        print("Register successfully created!")
    }
    
    func actOnNotificationErrorRegister() {
        print("Something went wrong!")
    }
    
    func actOnNotificationSuccessFetch() {
        print("Success!")
        
        if checklistItems.count > 0 {
            var text = String()
            
            for item in checklistItems {
                text += "\(item.quantity!) - \(item.item!)\n"
            }
            print(text)
            //itemsTextView.text = text
            itemsLabel.text = text
        }
        
    }
    

}
