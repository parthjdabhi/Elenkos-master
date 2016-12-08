//
//  RegisterViewController.swift
//  Elenkos
//
//  Created by Dustin Allen on 10/16/16.
//  Copyright © 2016 Harloch. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var emailAddress: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var gradeLevel: UITextField!
    
    var ref:FIRDatabaseReference!
    var user: FIRUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        user = FIRAuth.auth()?.currentUser
        
        self.firstName.delegate = self
        self.lastName.delegate = self
        self.emailAddress.delegate = self
        self.passwordField.delegate = self
        self.gradeLevel.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButton(sender: AnyObject) {
        
        let email = self.emailAddress.text!
        let password = self.passwordField.text!
        
        if firstName.text != "" && lastName.text != "" && emailAddress.text != "" && passwordField.text != "" && gradeLevel.text != "" {
        
        CommonUtils.sharedUtils.showProgress(self.view, label: "Registering...")
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion:  { (user, error) in
            if error == nil {
                FIREmailPasswordAuthProvider.credentialWithEmail(email, password: password)
                self.ref.child("users").child(user!.uid).setValue(["userFirstName": self.firstName.text!, "userLastName": self.lastName.text!, "email": email, "educationLevel": self.gradeLevel.text!, "numberCorrect": "\(0)", "numberWrong": "\(0)"])
                trackResults = true
                CommonUtils.sharedUtils.hideProgress()
                let photoViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainScreenViewController") as! MainScreenViewController!
                self.navigationController?.pushViewController(photoViewController, animated: true)
            } else {
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    CommonUtils.sharedUtils.hideProgress()
                    CommonUtils.sharedUtils.showAlert(self, title: "Error", message: (error?.localizedDescription)!)
                })
            }
        })
            } else {
                let alert = UIAlertController(title: "Error", message: "Enter email & password!",   preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alert.addAction(action)
        }
    
    }

}
