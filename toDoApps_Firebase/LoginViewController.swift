//
//  ViewController.swift
//  toDoApps_Firebase
//
//  Created by Mohammad Kukuh on 7/27/16.
//  Copyright © 2016 Mohammad Kukuh. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Login(sender: AnyObject) {
        let email = emailText.text!
        let pass = passText.text!
        
        FIRAuth.auth()?.signInWithEmail(email, password: pass, completion: { (user:FIRUser?, error:NSError?) in
            if error == nil{
                let storyboard : UIStoryboard = UIStoryboard(name:"Main", bundle:nil)
                let m : UINavigationController = storyboard.instantiateViewControllerWithIdentifier("ToDoAppsID") as! UINavigationController
                self.presentViewController(m, animated: true, completion: nil)
            }else{
                if let errorCode : FIRAuthErrorCode = FIRAuthErrorCode(rawValue: error!.code){
                    switch(errorCode){
                    case .ErrorCodeWrongPassword:
                        let alert = UIAlertView(title: "Alert", message: "Wrong Password", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                        print("wrong password")
                    case .ErrorCodeUserNotFound:
                        let alert = UIAlertView(title: "Alert", message: "User's Not Found", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                        print("user's not exist")
                    default:
                        print("handler")
                    }
                }
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
