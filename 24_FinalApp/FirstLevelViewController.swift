//
//  FirstLevelViewController.swift
//  24_FinalApp
//
//  Created by Devanshi Chakrabarti on 6/29/17.
//  Copyright © 2017 Devanshi Chakrabarti. All rights reserved.
//

import UIKit
import AVFoundation

class FirstLevelViewController: UIViewController
{
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var topNumber: GridLabel!
    @IBOutlet weak var leftNumber: GridLabel!
    @IBOutlet weak var rightNumber: GridLabel!
    @IBOutlet weak var bottomNumber: GridLabel!
    @IBOutlet weak var totalDisplay: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var twentyFour = MyCustomClass()
    var operation = ""
    var valuesArray: ([Int]) = [13, 1, 12, 2, 22, 20, 1, 21, 10, 15, 8, 7, 78, 49, 4, 9, 108, 90, 50, 44]
    var total = 0
    var i = 0
    var lastButtonClicked = ""
    var alreadyClicked = 0
    var topClicked = false
    var leftClicked = false
    var rightClicked = false
    var bottomClicked = false
    var resetTimes = 0
    var score = 0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "LEVEL 1"
        topNumber.text = "\(valuesArray[i])"
        leftNumber.text = "\(valuesArray[i+1])"
        rightNumber.text = "\(valuesArray[i+2])"
        bottomNumber.text = "\(valuesArray[i+3])"
        
        topNumber.isUserInteractionEnabled = true
        leftNumber.isUserInteractionEnabled = true
        rightNumber.isUserInteractionEnabled = true
        bottomNumber.isUserInteractionEnabled = true
        
        var topTapGesture = UITapGestureRecognizer(target: self, action: #selector(FirstLevelViewController.TopLabelTapped))
        var leftTapGesture = UITapGestureRecognizer(target: self, action: "LeftLabelTapped")
        var rightTapGesture = UITapGestureRecognizer(target: self, action: "RightLabelTapped")
        var bottomTapGesture = UITapGestureRecognizer(target: self, action: "BottomLabelTapped")
        self.topNumber.addGestureRecognizer(topTapGesture)
        self.leftNumber.addGestureRecognizer(leftTapGesture)
        self.rightNumber.addGestureRecognizer(rightTapGesture)
        self.bottomNumber.addGestureRecognizer(bottomTapGesture)
        
        
    }
    
    
    func TopLabelTapped()
    {
        if topClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == ""
            {
                print("Top Label clicked")
                twentyFour.playSound()
                lastButtonClicked = "\(topNumber.text!)"
                topNumber.backgroundColor = UIColor.red
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(topNumber.text!)!)
                topClicked = true
            }
            else
            {
                selectOperator()
            }
        }
        else
        {
            selectDifferentNumber()
        }
        
    }
    
    func LeftLabelTapped()
    {
        if leftClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == ""
            {
                print("Left Label clicked")
                twentyFour.playSound()
                lastButtonClicked = leftNumber.text!
                leftNumber.backgroundColor = UIColor.red
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                //checkGameOver()
                calculateTotal(value: Int(leftNumber.text!)!)
                leftClicked = true
            }
            else
            {
                selectOperator()
            }
        }
        else
        {
            selectDifferentNumber()
        }
        
    }
    
    func RightLabelTapped()
    {
      print("Right Label clicked is" + " \(rightClicked)")
        if rightClicked == false
        {
            print("")
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == ""
            {
                print("Right Label clicked")
                twentyFour.playSound()
                lastButtonClicked = rightNumber.text!
                rightNumber.backgroundColor = UIColor.red
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(rightNumber.text!)!)
                rightClicked = true
            }
            else
            {
                selectOperator()
            }
        }
        else
        {
            selectDifferentNumber()
        }
        
    }
    
    func BottomLabelTapped()
    {
        if bottomClicked == false
            
        {
            print("Bottom level clicked is \(bottomClicked)")
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == ""
            {
                print("Bottom Label clicked")
                twentyFour.playSound()
                lastButtonClicked = bottomNumber.text!
                bottomNumber.backgroundColor = UIColor.red
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(bottomNumber.text!)!)
                bottomClicked = true
            }
            else
            {
                selectOperator()
            }
        }
        else
        {
            selectDifferentNumber()
        }
        
    }
    
    @IBAction func additionButton(_ sender: Any)
    {
        print("ADD Bottom Clicked is \(bottomClicked)")
        print("ADD Right Label clicked is" + " \(rightClicked)")

        if lastButtonClicked == "-" || lastButtonClicked == "+"
        {
            selectOperand()
        }
        else if lastButtonClicked == ""
        {
            selectOperandFirst()
        }
        else
        {
            operation = "+"
            print("+ clicked")
            twentyFour.playSoundOperator()
            lastButtonClicked = "+"
            displayLabel.text = displayLabel.text! + " " + "+"
        }
        
    }

    
    @IBAction func subrtractionButton(_ sender: Any)
    {
         print("SUBTRACT Bottom Clicked is \(bottomClicked)")
        print(" SUBTRACT Right Label clicked is" + " \(rightClicked)")

        if lastButtonClicked == "+" || lastButtonClicked == "-"
        {
            selectOperand()
        }
        else if lastButtonClicked == ""
        {
            selectOperandFirst()
        }
        else
        {
            operation = "-"
            print("- clicked")
            twentyFour.playSoundOperator()
            lastButtonClicked = "-"
            displayLabel.text = displayLabel.text! + " " + "-"
        }
    }
    
    func resetScreen()
    {
        displayLabel.text = ""
        totalDisplay.text = ""
        operation = ""
        lastButtonClicked = ""
        total = 0
        topNumber.backgroundColor = UIColor.lightGray
        leftNumber.backgroundColor = UIColor.lightGray
        rightNumber.backgroundColor = UIColor.lightGray
        bottomNumber.backgroundColor = UIColor.lightGray
        alreadyClicked = 0
        topClicked = false
        leftClicked = false
        rightClicked = false
        bottomClicked = false
    }
    
    @IBAction func resetGame(_ sender: Any)
    {
        resetScreen()
        resetTimes += 1
        if resetTimes > 1
        {
            score -= 40
            scoreLabel.text = "\(score)"
        }
    }
    func checkGameOver()
    {
        if alreadyClicked == 4
        {
            if total == 24
            {
                resetScreen()
                topClicked = false
                leftClicked = false
                rightClicked = false
                bottomClicked = false
                if i <= 13
                {
                
                print("YAY YOU WON! GO ON TO THE NEXT ROUND!")
                twentyFour.winningSound()
                let alert = UIAlertController(title: "Congratulations! You have found the correct sequence!", message: "On to the next set!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                    resetTimes = 0
                    score += 50
                    scoreLabel.text = "\(score)"
                    i += 4
                    resetScreen()
                    topNumber.text = "\(valuesArray[i])"
                    leftNumber.text = "\(valuesArray[i+1])"
                    rightNumber.text = "\(valuesArray[i+2])"
                    bottomNumber.text = "\(valuesArray[i+3])"
                    
                
                }
                 else if i > 13
                {
                    let alertController = UIAlertController(title: "Congratulations! You have finished the first level!", message: "On to the next level!", preferredStyle: UIAlertControllerStyle.alert)
                    let levelTwo = UIAlertAction(title: "Level 2", style: UIAlertActionStyle.default, handler:
                    {
                        (action) -> Void in self.performSegue(withIdentifier: "Level2", sender: self)
                    })
                    
                    alertController.addAction(levelTwo)
                    self.present(alertController, animated: true)
                    twentyFour.winningSound()
                    score += 100
                    scoreLabel.text = "\(score)"
                    topNumber.text = "\(valuesArray[i])"
                    leftNumber.text = "\(valuesArray[i+1])"
                    rightNumber.text = "\(valuesArray[i+2])"
                    bottomNumber.text = "\(valuesArray[i+3])"
                }
                
            }
    
            else
            {
                topClicked = false
                leftClicked = false
                rightClicked = false
                bottomClicked = false
                print("SORRY YOUR ANSWER IS INCORRECT! PLEASE TRY AGAIN!")
                let alert = UIAlertController(title: "Sorry! Your answer doesn't equal 24!", message: "Better luck next time!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true)
                resetScreen()
                
            }
        }
    }
    
    func calculateTotal(value: Int)
    {
        switch operation
        {
        case "":
        total = value
        totalDisplay.text = "\(total)"
        case "+":
            total += value
            totalDisplay.text = "\(total)"
        case "-":
            total -= value
            totalDisplay.text = "\(total)"
        default:
        break
        }
        
        checkGameOver()
        
    }
   
    
    func selectDifferentNumber()
    {
        let alert = UIAlertController(title: "Please select a different number!", message: "You can select each number only once.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func selectOperator()
    {
        let alert = UIAlertController(title: "Please select an operator", message: "You cannot select two operands in a row!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func selectOperand()
    {
        let alert = UIAlertController(title: "Please select a number!", message: "You cannot select two operators in a row!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func selectOperandFirst()
    {
        let alert = UIAlertController(title: "Please select a number!", message: "You cannot start off with an operator!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        twentyFour.topClicked = false
        twentyFour.leftClicked = false
        twentyFour.rightClicked = false
        twentyFour.bottomClicked = false
        twentyFour.i = 0
        twentyFour.score = Int(scoreLabel.text!)!
        var nextView = segue.destination  as! SecondViewController
        nextView.svc = twentyFour
    }
    // 13 + 1 + 12 - 2
    // 21 + 22 - 20 + 1
    // 10 + 15 - 8 + 7
    // 78 - 49 + 4 - 9
    // 108 - 90 + 50 - 44
    
    
}
