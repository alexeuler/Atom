//
//  AddController.swift
//  Atom
//
//  Created by Алексей Карасев on 18/06/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class AddController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonClicked(sender: AnyObject) {
        Actions.instance.addTodo(titleTextField.text ?? "")
        navigationController?.popViewControllerAnimated(true)
    }
}
