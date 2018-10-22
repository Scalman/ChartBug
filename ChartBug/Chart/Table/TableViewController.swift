//
//  TableViewController.swift
//  Dashboard
//
//  Created by Gustaf Holmström on 2018-10-10.
//  Copyright © 2018 Waleed Hassan. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    
        
    @IBOutlet weak var textField: UITextField!
    
    
    var datePicker = UIDatePicker()
    
    
    private var startDateShow = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = UIColor.lightGray
        
        createDatePicker()
        
    }

    func createDatePicker(){
        datePicker.datePickerMode = .dateAndTime
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPress))
        toolbar.setItems(([doneButton]), animated: true)
        
        textField.inputAccessoryView = toolbar
        
        textField.inputView = datePicker
        
    }
    
    @objc func doneButtonPress(){
        textField.text = "\(datePicker.date)"
        self.view.endEditing(true)
        
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
 
}
