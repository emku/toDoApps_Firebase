//
//  CVTableViewController.swift
//  
//
//  Created by Mohammad Kukuh on 7/27/16.
//
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CVTableViewController: UITableViewController {

    var ToDos = [toDo]()
    var dbRef : FIRDatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = FIRDatabase.database().reference().child("ToDo")
        ObservingDB()
    }
    
    func ObservingDB() {
        dbRef.observeEventType(.Value) { (snapshot:FIRDataSnapshot) in
            
            var newToDos = [toDo]()
            
            for t in snapshot.children{
                let toDoItem = toDo(snapshot: t as! FIRDataSnapshot)
                newToDos.append(toDoItem)
            }
            self.ToDos = newToDos
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func addToDoList(sender:AnyObject){
        let alert = UIAlertController(title: "Add ToDo", message: "Enter Your Plan", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textfield:UITextField) in
            textfield.placeholder = "Plan Title"
        }
        alert.addTextFieldWithConfigurationHandler { (textfield:UITextField) in
            textfield.placeholder = "Description"
        }
        alert.addAction(UIAlertAction(title: "Send", style: .Default, handler: { (action:UIAlertAction) in
            let planTitleText = alert.textFields!.first!
            let descripText = alert.textFields!.last!
            let date = NSDate()
            let dateFormat = NSDateFormatter()
            dateFormat.dateFormat = "dd-MM-yyyy"
            let dateStr = dateFormat.stringFromDate(date)
                
            //let plan = toDo(title: planTitle, description: "", addedIn: dateStr)
            let plan = toDo(title: planTitleText.text!, description: descripText.text! , addedIn: dateStr)
            let toDoRef = self.dbRef.child(planTitleText.text!.lowercaseString)
                toDoRef.setValue(plan.toAnyObject())
            }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel , handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let plan = ToDos[indexPath.row]
        cell.textLabel?.text = plan.title
        cell.detailTextLabel?.text = plan.addedIn
    
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            let plan = ToDos[indexPath.row]
            plan.itemRef?.removeValue()
        }
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPlanDetail" {
            if let indexpath = self.tableView.indexPathForSelectedRow{
                let destinationController = segue.destinationViewController as! DetailViewController
                destinationController.planTitle = ToDos[indexpath.row].title
                destinationController.date = ToDos[indexpath.row].addedIn
                destinationController.descrip = ToDos[indexpath.row].description
            }
        }
    }
}
