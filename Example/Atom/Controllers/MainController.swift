//
//  MainController.swift
//  Atom
//
//  Created by Алексей Карасев on 18/06/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class MainController: UITableViewController, AtomSubscriber {

    typealias AtomSubscriberEvent = Event
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Dispatcher.instance.addSubscriber(self)
    }
    
    func stateChanged(event: AtomSubscriberEvent) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return State.App.instance.todos.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MainCell") as! MainCell
        let todoState = State.Todo.select(State.App.instance, keys: indexPath.row)
        let props = MainCell.Props(key: indexPath.row, title: todoState.name, status: todoState.checked)
        cell.props = props
        return cell
    }
    
}
