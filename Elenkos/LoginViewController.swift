//
//  LoginViewController.swift
//  Elenkos
//
//  Created by Dustin Allen on 10/16/16.
//  Copyright © 2016 Harloch. All rights reserved.
//

import UIKit
import Firebase

var trackResults = false

class LoginViewController: UIViewController {
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    var ref:FIRDatabaseReference!
    var user: FIRUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        user = FIRAuth.auth()?.currentUser
        
        if let user = FIRAuth.auth()?.currentUser {
            self.signedIn(user)
            trackResults = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(sender: AnyObject) {
        let email = emailField.text!
        let password = passwordField.text!
        if email.isEmpty || password.isEmpty {
            CommonUtils.sharedUtils.showAlert(self, title: "Error", message: "Email or password is missing.")
        }
        else{
            CommonUtils.sharedUtils.showProgress(self.view, label: "Signing in...")
            FIRAuth.auth()?.signInWithEmail(email, password: password) { (user, error) in
                dispatch_async(dispatch_get_main_queue(), {
                    CommonUtils.sharedUtils.hideProgress()
                })
                if let error = error {
                    CommonUtils.sharedUtils.showAlert(self, title: "Error", message: error.localizedDescription)
                    print(error.localizedDescription)
                }
                else{
                    let next = self.storyboard?.instantiateViewControllerWithIdentifier("MainScreenViewController") as! MainScreenViewController!
                    self.navigationController?.pushViewController(next, animated: true)
                    
                    trackResults = true
                }
            }
        }
    }
    
    @IBAction func registerButton(sender: AnyObject) {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterViewController") as! RegisterViewController!
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func startTesting(sender: AnyObject) {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("Question1ViewController") as! Question1ViewController!
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func forgotPasswordButton(sender: AnyObject) {
        let prompt = UIAlertController.init(title: nil, message: "Email:", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            FIRAuth.auth()?.sendPasswordResetWithEmail(userInput!) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        }
        prompt.addTextFieldWithConfigurationHandler(nil)
        prompt.addAction(okAction)
        presentViewController(prompt, animated: true, completion: nil);
    }

    func signedIn(user: FIRUser?) {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("MainScreenViewController") as! MainScreenViewController!
        self.navigationController?.pushViewController(next, animated: true)
    }
}
