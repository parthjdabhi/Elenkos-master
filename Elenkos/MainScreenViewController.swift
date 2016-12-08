//
//  MainScreenViewController.swift
//  Elenkos
//
//  Created by Dustin Allen on 10/16/16.
//  Copyright © 2016 Harloch. All rights reserved.
//

import UIKit
import Firebase

class MainScreenViewController: UIViewController {
    
    @IBOutlet var greetingLabel: UILabel!
    @IBOutlet var questionsCorrect: UILabel!
    @IBOutlet var questionsWrong: UILabel!
    @IBOutlet var averageCorrect: UILabel!
    @IBOutlet var averageWrong: UILabel!
    
    var ref:FIRDatabaseReference!
    var user: FIRUser!
    
    var nameString1 = ""
    var nameString2 = ""
    
    var mathChoice = "True"
    var scienceChoice = "True"
    var historyChoice = "True"
    
    var xArray = [Double]()
    
    var averageCorrectArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //averageCorrect.hidden = true
        averageWrong.hidden = true
        
        ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("users").child(userID!).observeEventType(FIRDataEventType.Value, withBlock: { snapshot in
                if let firstName = snapshot.value!["userFirstName"] {
                    self.nameString1 = firstName as! String
                }
                if let lastName = snapshot.value!["userLastName"] {
                    self.nameString2 = lastName as! String
                }
                if let questionsRight = snapshot.value!["numberCorrect"] {
                    let questions = "Questions Correct: \(questionsRight as! String)"
                    self.questionsCorrect.text = questions
                }
                if let questionsIncorrect = snapshot.value!["numberWrong"] {
                    let questions = "Questions Wrong: \(questionsIncorrect as! String)"
                    self.questionsWrong.text = questions
                }
                self.greetingLabel.text = "Welcome \(self.nameString1) \(self.nameString2)"
        })
        
        ref.child("users").child(userID!).child("difficultyCorrect").observeEventType(FIRDataEventType.Value, withBlock: { snapshot in
                for childSnap in snapshot.children.allObjects {
                    let snap = childSnap as! FIRDataSnapshot
                    if userID != snap.key {
                        let averageRight = snap.value!["difficulty"] as! String!
                        let averageRightInt = (averageRight as NSString).integerValue
                        var averageStuff = self.averageCorrectArray as Array
                        averageStuff.append(averageRightInt)
                        for x in averageStuff {
                            let xInt = x as! Double
                            self.xArray.append(xInt)
                        }
                        let xAverage = self.xArray.reduce(0, combine: +) / Double(self.xArray.count)
                        print("Average: \(xAverage)")
                        self.averageCorrect.text = "Average Difficulty Correct: \(xAverage)"
                    }
                }
            }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mathButton(sender: AnyObject) {
        Question1ViewController.mathOption = self.mathChoice
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("Question1ViewController") as! Question1ViewController!
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func scienceButton(sender: AnyObject) {
    }
    
    @IBAction func historyButton(sender: AnyObject) {
    }

    @IBAction func startTestButton(sender: AnyObject) {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("Question1ViewController") as! Question1ViewController!
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    @IBAction func logoutButton(sender: AnyObject) {
        try! FIRAuth.auth()?.signOut()
        AppState.sharedInstance.signedIn = false
        let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController!
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
}

protocol DoubleConvertible {
    init(_ double: Double)
    var double: Double { get }
}

extension Double : DoubleConvertible { var double: Double { return self         } }
extension Float  : DoubleConvertible { var double: Double { return Double(self) } }
extension CGFloat: DoubleConvertible { var double: Double { return Double(self) } }

extension Array where Element: DoubleConvertible {
    var total: Element {
        return  Element(reduce(0){ $0 + $1.double })
    }
    var average: Element {
        return  isEmpty ? Element(0) : Element(total.double / Double(count))
    }
}

extension Array where Element: IntegerType {
    /// Returns the sum of all elements in the array
    var total: Element {
        return reduce(0, combine: +)
    }
}
extension CollectionType where Generator.Element == Int, Index == Int {
    /// Returns the average of all elements in the array
    var average: Double {
        return isEmpty ? 0 : Double(reduce(0, combine: +)) / Double(endIndex-startIndex)
    }
}
