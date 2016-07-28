//
//  DetailViewController.swift
//  toDoApps_Firebase
//
//  Created by Mohammad Kukuh on 7/28/16.
//  Copyright © 2016 Mohammad Kukuh. All rights reserved.
//

import UIKit
import FirebaseDatabase
class DetailViewController: UIViewController {

    var dbRef : FIRDatabaseReference!
    var todo : toDo!
    
    @IBOutlet weak var planTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var planTitle : String!
    var date : String!
    var descrip : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.planTitleLabel.text = planTitle
        self.dateLabel.text = date
        self.descriptionTextView.text = descrip
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
