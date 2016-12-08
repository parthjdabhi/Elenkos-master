//
//  Question1ViewController.swift
//  Pods
//
//  Created by Dustin Allen on 10/16/16.
//
//

import UIKit
import Firebase
import SpriteKit
import JSSAlertView

class Question1ViewController: UIViewController, SKSceneDelegate {
    
    @IBOutlet var animationView: UIView!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    @IBOutlet var aLabel: UIButton!
    @IBOutlet var bLabel: UIButton!
    @IBOutlet var cLabel: UIButton!
    @IBOutlet var dLabel: UIButton!
    @IBOutlet var eLabel: UIButton!
    @IBOutlet var explain: UIButton!

    var choice1 = ""
    var choice2 = ""
    var choice3 = ""
    var choice4 = ""
    var choice5 = ""
    
    var answer1 = ""
    var answer2 = ""
    var answer3 = ""
    var answer4 = ""
    var answer5 = ""
    
    var corrrectChoice = ""
    
    var x1 = 0
    var x2 = 0
    var x3 = 0
    var x4 = 0
    var x5 = 0
    
    var limit = 6
    var count = 30
    
    var timer = NSTimer()
    var helloWorldTimer = NSTimer()
    var loopingTimer = NSTimer()
    var previousNumber: UInt32?
    var images: [UIImage] = []
    
    var ref:FIRDatabaseReference!
    var user: FIRUser!
    
    var getRandomString = ""
    var correctBool = false
    var falseBool = false
    var difficultyRating = ""
    var difficultyCorrect = ""
    var difficultyWrong = ""
    
    var alertWrong = ""
    var fullExplanation = ""
    
    var correctInt = 0
    var falseInt = 0
    
    var textureAtlas = SKTextureAtlas()
    var textureArray = [SKTexture]()
    var mainGuy = SKSpriteNode()
    
    var switchAnimations = false
    
    static var mathOption:String = ""
    static var scienceOption:String = ""
    static var historyButton:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationsForBoyWorking()
        
        explain.hidden = true
        
        difficultyCorrect = ""
        difficultyWrong = ""
        
        for _ in 1...10 {
            
            randomizeQuestions()
            
            let getRandom = String(randomQuestion())
            getRandomString = "\(getRandom)"
            
            ref = FIRDatabase.database().reference()
            //let userID = FIRAuth.auth()?.currentUser?.uid
            
            ref.child("tests").child("mathTests").child(getRandom).observeEventType(FIRDataEventType.Value, withBlock: { snapshot in
                
                self.corrrectChoice = snapshot.value?.objectForKey("FIELD3") as! String!
                print("Correct Answer: \(self.corrrectChoice)")
                
                let testQuestion = snapshot.value?.objectForKey("FIELD7") as! String
                self.questionLabel.text = testQuestion
                
                let answerA = snapshot.value?.objectForKey("FIELD\(self.x1)") as! String
                let answerB = snapshot.value?.objectForKey("FIELD\(self.x2)") as! String
                let answerC = snapshot.value?.objectForKey("FIELD\(self.x3)") as! String
                let answerD = snapshot.value?.objectForKey("FIELD\(self.x4)") as! String
                let answerE = snapshot.value?.objectForKey("FIELD\(self.x5)") as! String
                
                self.difficultyRating = snapshot.value?.objectForKey("FIELD14") as! String
                self.alertWrong = snapshot.value?.objectForKey("FIELD8") as! String
                self.fullExplanation = snapshot.value?.objectForKey("FIELD9") as! String
                    
                self.aLabel.setTitle("\(answerA)", forState: UIControlState.Normal)
                self.bLabel.setTitle("\(answerB)", forState: UIControlState.Normal)
                self.cLabel.setTitle("\(answerC)", forState: UIControlState.Normal)
                self.dLabel.setTitle("\(answerD)", forState: UIControlState.Normal)
                self.eLabel.setTitle("\(answerE)", forState: UIControlState.Normal)
                    
                self.answer1 = answerA
                self.answer2 = answerB
                self.answer3 = answerC
                self.answer4 = answerD
                self.answer5 = answerE
                
                })
            }
        timer.invalidate()
        helloWorldTimer.invalidate()
        startTimer()
        animateTimer()
    }
    
    override func viewDidAppear(animated: Bool) {
        viewDidLoad()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func aButton(sender: AnyObject) {
        helloWorldTimer.invalidate()
        if trackResults == false {
            ref = FIRDatabase.database().reference()
            ref.child("tests").child("mathTests").child(getRandomString).observeEventType(FIRDataEventType.Value, withBlock: { snapshot in
                
                if self.answer1 == self.corrrectChoice {
                    self.correctBool = true
                    
                    _ = UIImage(named: "Elenkos1")
                    JSSAlertView().success(self, title: "Correct!", text: "Great Job! Try Out The Next Question...")
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyCorrectAnswer()
                    } else {
                        self.animationsForBoyCorrectAnswer1()
                    }
                } else {
                    self.falseBool = true
                    self.explain.hidden = false
                    
                    let customIcon = UIImage(named: "Enkos4")
                    let alertview = JSSAlertView().show(self, title: "Try Again", text: "\(self.alertWrong)", buttonText: "Okay!", color: UIColorFromHex(0xE0107A, alpha: 1), iconImage: customIcon)
                    alertview.addAction(self.closeCallback)
                    alertview.setTitleFont("ClearSans-Bold")
                    alertview.setTextFont("ClearSans")
                    alertview.setButtonFont("ClearSans-Light")
                    alertview.setTextTheme(.Light)
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyWrongAnswer()
                    } else {
                        self.animationsForBoyWrongAnswer1()
                    }
                }
            })
        } else {
            ref = FIRDatabase.database().reference()
            ref.child("tests").child("mathTests").child(getRandomString).observeEventType(FIRDataEventType.Value, withBlock: { snapshot in
                
                if self.answer1 == self.corrrectChoice {
                    self.correctBool = true
                    self.correctAdder()
                    self.difficultyCorrect = "\(self.difficultyRating)"
                    
                    _ = UIImage(named: "Elenkos1")
                    JSSAlertView().success(self, title: "Correct!", text: "Great Job! Try Out The Next Question...")
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyCorrectAnswer()
                    } else {
                        self.animationsForBoyCorrectAnswer1()
                    }
                } else {
                    self.falseBool = true
                    self.wrongAdder()
                    self.difficultyWrong = "\(self.difficultyRating)"
                    self.explain.hidden = false
                    
                    let customIcon = UIImage(named: "Enkos4")
                    let alertview = JSSAlertView().show(self, title: "Try Again", text: "\(self.alertWrong)", buttonText: "Okay!", color: UIColorFromHex(0xE0107A, alpha: 1), iconImage: customIcon)
                    alertview.addAction(self.closeCallback)
                    alertview.setTitleFont("ClearSans-Bold")
                    alertview.setTextFont("ClearSans")
                    alertview.setButtonFont("ClearSans-Light")
                    alertview.setTextTheme(.Light)
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyWrongAnswer()
                    } else {
                        self.animationsForBoyWrongAnswer1()
                    }
                }
            })
        }
    }
    
    @IBAction func bButton(sender: AnyObject) {
        helloWorldTimer.invalidate()
        if trackResults == false {
            ref = FIRDatabase.database().reference()
            ref.child("tests").child("mathTests").child(getRandomString).observeEventType(FIRDataEventType.Value, withBlock: { snapshot in
                
                if self.answer2 == self.corrrectChoice {
                    self.correctBool = true
                    
                    _ = UIImage(named: "Elenkos1")
                    JSSAlertView().success(self, title: "Correct!", text: "Great Job! Try Out The Next Question...")
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyCorrectAnswer()
                    } else {
                        self.animationsForBoyCorrectAnswer1()
                    }
                } else {
                    self.falseBool = true
                    self.explain.hidden = false
                    
                    let customIcon = UIImage(named: "Enkos4")
                    let alertview = JSSAlertView().show(self, title: "Try Again", text: "\(self.alertWrong)", buttonText: "Okay!", color: UIColorFromHex(0xE0107A, alpha: 1), iconImage: customIcon)
                    alertview.addAction(self.closeCallback)
                    alertview.setTitleFont("ClearSans-Bold")
                    alertview.setTextFont("ClearSans")
                    alertview.setButtonFont("ClearSans-Light")
                    alertview.setTextTheme(.Light)
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyWrongAnswer()
                    } else {
                        self.animationsForBoyWrongAnswer1()
                    }
                }
            })
        } else {
            ref = FIRDatabase.database().reference()
            ref.child("tests").child("mathTests").child(getRandomString).observeEventType(FIRDataEventType.Value, withBlock: { snapshot in
                
                if self.answer2 == self.corrrectChoice {
                    self.correctBool = true
                    self.correctAdder()
                    self.difficultyCorrect = "\(self.difficultyRating)"
                    
                    _ = UIImage(named: "Elenkos1")
                    JSSAlertView().success(self, title: "Correct!", text: "Great Job! Try Out The Next Question...")
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyCorrectAnswer()
                    } else {
                        self.animationsForBoyCorrectAnswer1()
                    }
                } else {
                    self.falseBool = true
                    self.wrongAdder()
                    self.difficultyWrong = "\(self.difficultyRating)"
                    self.explain.hidden = false
                    
                    let customIcon = UIImage(named: "Enkos4")
                    let alertview = JSSAlertView().show(self, title: "Try Again", text: "\(self.alertWrong)", buttonText: "Okay!", color: UIColorFromHex(0xE0107A, alpha: 1), iconImage: customIcon)
                    alertview.addAction(self.closeCallback)
                    alertview.setTitleFont("ClearSans-Bold")
                    alertview.setTextFont("ClearSans")
                    alertview.setButtonFont("ClearSans-Light")
                    alertview.setTextTheme(.Light)
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyWrongAnswer()
                    } else {
                        self.animationsForBoyWrongAnswer1()
                    }
                }
            })
        }
    }

    @IBAction func cButton(sender: AnyObject) {
        helloWorldTimer.invalidate()
        if trackResults == false {
            ref = FIRDatabase.database().reference()
            ref.child("tests").child("mathTests").child(getRandomString).observeEventType(FIRDataEventType.Value, withBlock: { snapshot in
                
                if self.answer3 == self.corrrectChoice {
                    self.correctBool = true
                    
                    _ = UIImage(named: "Elenkos1")
                    JSSAlertView().success(self, title: "Correct!", text: "Great Job! Try Out The Next Question...")
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyCorrectAnswer()
                    } else {
                        self.animationsForBoyCorrectAnswer1()
                    }
                } else {
                    self.falseBool = true
                    self.explain.hidden = false
                    
                    let customIcon = UIImage(named: "Enkos4")
                    let alertview = JSSAlertView().show(self, title: "Try Again", text: "\(self.alertWrong)", buttonText: "Okay!", color: UIColorFromHex(0xE0107A, alpha: 1), iconImage: customIcon)
                    alertview.addAction(self.closeCallback)
                    alertview.setTitleFont("ClearSans-Bold")
                    alertview.setTextFont("ClearSans")
                    alertview.setButtonFont("ClearSans-Light")
                    alertview.setTextTheme(.Light)
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyWrongAnswer()
                    } else {
                        self.animationsForBoyWrongAnswer1()
                    }
                }
            })
        } else {
            ref = FIRDatabase.database().reference()
            ref.child("tests").child("mathTests").child(getRandomString).observeEventType(FIRDataEventType.Value, withBlock: { snapshot in
                
                if self.answer3 == self.corrrectChoice {
                    self.correctBool = true
                    self.correctAdder()
                    self.difficultyCorrect = "\(self.difficultyRating)"
                    
                    _ = UIImage(named: "Elenkos1")
                    JSSAlertView().success(self, title: "Correct!", text: "Great Job! Try Out The Next Question...")
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyCorrectAnswer()
                    } else {
                        self.animationsForBoyCorrectAnswer1()
                    }
                } else {
                    self.falseBool = true
                    self.wrongAdder()
                    self.difficultyWrong = "\(self.difficultyRating)"
                    self.explain.hidden = false
                    
                    let customIcon = UIImage(named: "Enkos4")
                    let alertview = JSSAlertView().show(self, title: "Try Again", text: "\(self.alertWrong)", buttonText: "Okay!", color: UIColorFromHex(0xE0107A, alpha: 1), iconImage: customIcon)
                    alertview.addAction(self.closeCallback)
                    alertview.setTitleFont("ClearSans-Bold")
                    alertview.setTextFont("ClearSans")
                    alertview.setButtonFont("ClearSans-Light")
                    alertview.setTextTheme(.Light)
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyWrongAnswer()
                    } else {
                        self.animationsForBoyWrongAnswer1()
                    }
                }
            })
        }
    }
    
    @IBAction func dButton(sender: AnyObject) {
        helloWorldTimer.invalidate()
        if trackResults == false {
            ref = FIRDatabase.database().reference()
            ref.child("tests").child("mathTests").child(getRandomString).observeEventType(FIRDataEventType.Value, withBlock: { snapshot in
                
                if self.answer4 == self.corrrectChoice {
                    self.correctBool = true
                    
                    _ = UIImage(named: "Elenkos1")
                    JSSAlertView().success(self, title: "Correct!", text: "Great Job! Try Out The Next Question...")
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyCorrectAnswer()
                    } else {
                        self.animationsForBoyCorrectAnswer1()
                    }
                } else {
                    self.falseBool = true
                    self.explain.hidden = false
                    
                    let customIcon = UIImage(named: "Enkos4")
                    let alertview = JSSAlertView().show(self, title: "Try Again", text: "\(self.alertWrong)", buttonText: "Okay!", color: UIColorFromHex(0xE0107A, alpha: 1), iconImage: customIcon)
                    alertview.addAction(self.closeCallback)
                    alertview.setTitleFont("ClearSans-Bold")
                    alertview.setTextFont("ClearSans")
                    alertview.setButtonFont("ClearSans-Light")
                    alertview.setTextTheme(.Light)
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyWrongAnswer()
                    } else {
                        self.animationsForBoyWrongAnswer1()
                    }
                }
            })
        } else {
            ref = FIRDatabase.database().reference()
            ref.child("tests").child("mathTests").child(getRandomString).observeEventType(FIRDataEventType.Value, withBlock: { snapshot in
                
                if self.answer4 == self.corrrectChoice {
                    self.correctBool = true
                    self.correctAdder()
                    self.difficultyCorrect = "\(self.difficultyRating)"
                    
                    _ = UIImage(named: "Elenkos1")
                    JSSAlertView().success(self, title: "Correct!", text: "Great Job! Try Out The Next Question...")
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyCorrectAnswer()
                    } else {
                        self.animationsForBoyCorrectAnswer1()
                    }
                } else {
                    self.falseBool = true
                    self.wrongAdder()
                    self.difficultyWrong = "\(self.difficultyRating)"
                    self.explain.hidden = false
                    
                    let customIcon = UIImage(named: "Enkos4")
                    let alertview = JSSAlertView().show(self, title: "Try Again", text: "\(self.alertWrong)", buttonText: "Okay!", color: UIColorFromHex(0xE0107A, alpha: 1), iconImage: customIcon)
                    alertview.addAction(self.closeCallback)
                    alertview.setTitleFont("ClearSans-Bold")
                    alertview.setTextFont("ClearSans")
                    alertview.setButtonFont("ClearSans-Light")
                    alertview.setTextTheme(.Light)
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyWrongAnswer()
                    } else {
                        self.animationsForBoyWrongAnswer1()
                    }
                }
            })
        }
    }
    
    @IBAction func eButton(sender: AnyObject) {
        helloWorldTimer.invalidate()
        if trackResults == false {
            ref = FIRDatabase.database().reference()
            ref.child("tests").child("mathTests").child(getRandomString).observeEventType(FIRDataEventType.Value, withBlock: { snapshot in
                
                if self.answer5 == self.corrrectChoice {
                    self.correctBool = true
                    
                    _ = UIImage(named: "Elenkos1")
                    JSSAlertView().success(self, title: "Correct!", text: "Great Job! Try Out The Next Question...")
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyCorrectAnswer()
                    } else {
                        self.animationsForBoyCorrectAnswer1()
                    }
                } else {
                    self.falseBool = true
                    self.explain.hidden = false
                    
                    let customIcon = UIImage(named: "Enkos4")
                    let alertview = JSSAlertView().show(self, title: "Try Again", text: "\(self.alertWrong)", buttonText: "Okay!", color: UIColorFromHex(0xE0107A, alpha: 1), iconImage: customIcon)
                    alertview.addAction(self.closeCallback)
                    alertview.setTitleFont("ClearSans-Bold")
                    alertview.setTextFont("ClearSans")
                    alertview.setButtonFont("ClearSans-Light")
                    alertview.setTextTheme(.Light)
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyWrongAnswer()
                    } else {
                        self.animationsForBoyWrongAnswer1()
                    }
                }
            })
        } else {
            ref = FIRDatabase.database().reference()
            ref.child("tests").child("mathTests").child(getRandomString).observeEventType(FIRDataEventType.Value, withBlock: { snapshot in
                
                if self.answer5 == self.corrrectChoice {
                    self.correctBool = true
                    self.correctAdder()
                    self.difficultyCorrect = "\(self.difficultyRating)"
                    
                    _ = UIImage(named: "Elenkos1")
                    JSSAlertView().success(self, title: "Correct!", text: "Great Job! Try Out The Next Question...")
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyCorrectAnswer()
                    } else {
                        self.animationsForBoyCorrectAnswer1()
                    }
                } else {
                    self.falseBool = true
                    self.wrongAdder()
                    self.difficultyWrong = "\(self.difficultyRating)"
                    self.explain.hidden = false
                    
                    let customIcon = UIImage(named: "Enkos4")
                    let alertview = JSSAlertView().show(self, title: "Try Again", text: "\(self.alertWrong)", buttonText: "Okay!", color: UIColorFromHex(0xE0107A, alpha: 1), iconImage: customIcon)
                    alertview.addAction(self.closeCallback)
                    alertview.setTitleFont("ClearSans-Bold")
                    alertview.setTextFont("ClearSans")
                    alertview.setButtonFont("ClearSans-Light")
                    alertview.setTextTheme(.Light)
                    
                    if self.switchAnimations == false {
                        self.animationsForBoyWrongAnswer()
                    } else {
                        self.animationsForBoyWrongAnswer1()
                    }
                }
            })
        }
    }
    
    @IBAction func explainButton(sender: AnyObject) {
        
        JSSAlertView().info(self, title: "Here's The Explanation!", text: "\(self.fullExplanation)", buttonText: "Okay!")
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        
        if trackResults == false {
            
            timer.invalidate()
            timerLabel.text = "30"
            count = 30
            startTimer()
            timer.invalidate()
            viewDidLoad()
        } else {
            
            timer.invalidate()
            timerLabel.text = "30"
            count = 30
            startTimer()
            timer.invalidate()
            
            ref = FIRDatabase.database().reference()
            let userID = FIRAuth.auth()?.currentUser?.uid
            
            if switchAnimations == false {
                switchAnimations = true
            } else {
                switchAnimations = false
            }
            
            if difficultyCorrect != "" {
                ref.child("users").child(userID!).child("difficultyCorrect").childByAutoId().updateChildValues(["difficulty":"\(difficultyCorrect)"])
            }
            if difficultyWrong != "" {
                ref.child("users").child(userID!).child("difficultyWrong").childByAutoId().updateChildValues(["difficulty":"\(difficultyWrong)"])
            }
            
            if correctBool == true {
                ref.child("users").child(userID!).updateChildValues(["numberCorrect": "\(correctInt)"])
            }
            if falseBool == true {
                ref.child("users").child(userID!).updateChildValues(["numberWrong": "\(falseInt)"])
            }
            viewDidLoad()
        }
    }
    
    func randomQuestion() -> UInt32 {
        var randomNumber = arc4random_uniform(19) + 1
        while previousNumber == randomNumber {
            randomNumber = arc4random_uniform(19) + 1
        }
        previousNumber = randomNumber
        return randomNumber
    }
    
    func update() {
        if(count >= 0) {
            var countUpdate = count
            countUpdate -= -1
            timerLabel.text = String(count--)
        }
    }
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(Question1ViewController.update), userInfo: nil, repeats: true)
    }
    
    func animateTimer() {
        helloWorldTimer = NSTimer.scheduledTimerWithTimeInterval(6.0, target: self, selector: #selector(Question1ViewController.animationForBoyDistracted), userInfo: nil, repeats: false)
        //let helloWorldTimer1 = NSTimer.scheduledTimerWithTimeInterval(15.0, target: self, selector: #selector(Question1ViewController.girlDistractedAnimate), userInfo: nil, repeats: true)
        //let helloWorldTimer2 = NSTimer.scheduledTimerWithTimeInterval(15.0, target: self, selector: #selector(Question1ViewController.grandpaDistractedAnimate), userInfo: nil, repeats: true)
        print(helloWorldTimer)
        //print(helloWorldTimer1)
        //print(helloWorldTimer2)
    }
    
    func loopingTheTimer() {
        loopingTimer = NSTimer.scheduledTimerWithTimeInterval(6.0, target: self, selector: #selector(Question1ViewController.animationForLooping), userInfo: nil, repeats: false)
    }
    
    func updateTimer(timer: NSTimer) {
        //timerLabel.text = String(timerArray++)
        timerLabel.text = "30"
    }
    
    func correctAdder() {
        
        var x = 0
        ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("users").child(userID!).observeEventType(FIRDataEventType.Value, withBlock: { snapshot in
            
            let yString = snapshot.value?.objectForKey("numberCorrect") as! String!
            x = (yString as NSString).integerValue
            
        x += 1
        self.correctInt = x
        })
    }
    
    func wrongAdder() {
        var x = 0
        ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("users").child(userID!).observeEventType(FIRDataEventType.Value, withBlock: { snapshot in
            
            let yString = snapshot.value?.objectForKey("numberWrong") as! String!
            x = (yString as NSString).integerValue
            
            x += 1
            self.falseInt = x
        })
    }
    
    func randomizeQuestions() {
        var arraySet = [1, 2, 3, 4, 5]
        let a = Int(arc4random_uniform(5))
        x1 = arraySet[a]
        arraySet.removeAtIndex(a)
        let b = Int(arc4random_uniform(4))
        x2 = arraySet[b]
        arraySet.removeAtIndex(b)
        let c = Int(arc4random_uniform(3))
        x3 = arraySet[c]
        arraySet.removeAtIndex(c)
        let d = Int(arc4random_uniform(2))
        x4 = arraySet[d]
        arraySet.removeAtIndex(d)
        x5 = arraySet[0]
    }
    
    func animationsForBoyWorking() {
        let scene = BoyIsWorking(size: animationView.bounds.size)
        let skView = animationView as! SKView
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        skView.showsFPS = false
        skView.showsNodeCount = false
    }
    
    func animationsForBoyCorrectAnswer() {
        let scene = BoyIsCorrect(size: animationView.bounds.size)
        let skView = animationView as! SKView
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        skView.showsFPS = false
        skView.showsNodeCount = false
    }
    
    func animationsForBoyWrongAnswer() {
        let scene = BoyIsWrong(size: animationView.bounds.size)
        let skView = animationView as! SKView
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        skView.showsFPS = false
        skView.showsNodeCount = false
    }
    
    func animationsForBoyWrongAnswer1() {
        let scene = BoyIsWrong2(size: animationView.bounds.size)
        let skView = animationView as! SKView
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        skView.showsFPS = false
        skView.showsNodeCount = false
    }
    
    func animationsForBoyCorrectAnswer1() {
        let scene = BoyIsCorrect2(size: animationView.bounds.size)
        let skView = animationView as! SKView
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        skView.showsFPS = false
        skView.showsNodeCount = false
    }
    
    func animationForBoyDistracted() {
        let scene = BoyIsDistracted(size: animationView.bounds.size)
        let skView = animationView as! SKView
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        skView.showsFPS = false
        skView.showsNodeCount = false
        
        let _ = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(Question1ViewController.animationForLooping), userInfo: nil, repeats: false)
    }
    
    func animationForLooping() {
        let scene = BoyIsWorkingContinuous(size: animationView.bounds.size)
        let skView = animationView as! SKView
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        skView.showsFPS = false
        skView.showsNodeCount = false
    }
    
    func firstTask(completion: (success: Bool) -> Void) {
        
        animationForBoyDistracted()
        
        // Call completion, when finished, success or faliure
        completion(success: true)
    }
    
    func closeCallback() {
        print("Close callback called")
    }
    
    func cancelCallback() {
        print("Cancel callback called")
    }
}
