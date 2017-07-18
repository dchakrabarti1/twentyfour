//
//  ThirdViewController.swift
//  24_FinalApp
//
//  Created by Devanshi Chakrabarti on 7/11/17.
//  Copyright © 2017 Devanshi Chakrabarti. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController
{
    @IBOutlet weak var topNumber: UILabel!
    @IBOutlet weak var leftNumber: UILabel!
    @IBOutlet weak var rightNumber: UILabel!
    @IBOutlet weak var bottomNumber: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var totalDisplay: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var tvc = MyCustomClass()
    var resetTimes = 0
    var operation = ""
    var lastButtonClicked = ""
    var total = 0
    var alreadyClicked = 0
    var valuesArray: ([Int]) = [17, 2, 9, 25, 3, 10, 21, 2, 8, 4, 2, 64, 52, 6, 13, 12, 3, 3, 8, 2]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "LEVEL 3"
        topNumber.text = "\(valuesArray[tvc.i])"
        leftNumber.text = "\(valuesArray[tvc.i+1])"
        rightNumber.text = "\(valuesArray[tvc.i+2])"
        bottomNumber.text = "\(valuesArray[tvc.i+3])"
        
        topNumber.isUserInteractionEnabled = true
        leftNumber.isUserInteractionEnabled = true
        rightNumber.isUserInteractionEnabled = true
        bottomNumber.isUserInteractionEnabled = true
        
        var topTapGesture = UITapGestureRecognizer(target: self, action: #selector(ThirdViewController.TopLabelTapped))
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
        if tvc.topClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x" || lastButtonClicked == "/"
            {
                print("Valid Move")
                tvc.playSound()
                lastButtonClicked = "\(topNumber.text!)"
                topNumber.textColor = UIColor.clear
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(topNumber.text!)!)
                tvc.topClicked = true
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
        if tvc.leftClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x" || lastButtonClicked == "/"
            {
                print("Valid Move")
                tvc.playSound()
                lastButtonClicked = "\(leftNumber.text!)"
                leftNumber.textColor = UIColor.clear
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(leftNumber.text!)!)
                tvc.leftClicked = true
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
        if tvc.rightClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x" || lastButtonClicked == "/"
            {
                print("Valid Move")
                tvc.playSound()
                lastButtonClicked = "\(rightNumber.text!)"
                rightNumber.textColor = UIColor.clear
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(rightNumber.text!)!)
                tvc.rightClicked = true
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
        if tvc.bottomClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x" || lastButtonClicked == "/"
            {
                print("Valid Move")
                tvc.playSound()
                lastButtonClicked = "\(bottomNumber.text!)"
                bottomNumber.textColor = UIColor.clear
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(bottomNumber.text!)!)
                tvc.bottomClicked = true
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
    
    @IBAction func additionButtton(_ sender: Any)
    {
        
        if lastButtonClicked == "-" || lastButtonClicked == "+" || lastButtonClicked == "x" || lastButtonClicked == "/"
        {
            selectOperand()
        }
        else if lastButtonClicked == ""
        {
            selectOperandFirst()
        }
        else
        {
            tvc.playSoundOperator()
            operation = "+"
            lastButtonClicked = "+"
            displayLabel.text = displayLabel.text! + " " + "+"
        }
    }
    
    @IBAction func subtractionButton(_ sender: Any)
    {
        if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "x" || lastButtonClicked == "/"

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
            lastButtonClicked = "-"
            displayLabel.text = displayLabel.text! + " " + "-"
        }
    }

    @IBAction func multiplicationButton(_ sender: Any)
    {
        if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "x" || lastButtonClicked == "/"
        {
            selectOperand()
        }
        else if lastButtonClicked == ""
        {
            selectOperandFirst()
        }
        else
        {
            tvc.playSoundOperator()
            operation = "x"
            lastButtonClicked = "x"
            displayLabel.text = displayLabel.text! + " " + "x"
        }
    }
    
    @IBAction func divisionButton(_ sender: Any)
    {
        if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "x" || lastButtonClicked == "/"
        {
            selectOperand()
        }
        else if lastButtonClicked == ""
        {
            selectOperandFirst()
        }
        else
        {
            tvc.playSoundOperator()
            operation = "/"
            lastButtonClicked = "/"
            displayLabel.text = displayLabel.text! + " " + "/"
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
        case "x":
            total *= value
           totalDisplay.text = "\(total)"
        case "/":
            total /= value
            totalDisplay.text = "\(total)"
        default:
            break
        }
        
        checkGameOver()
        
    }
    
    func resetScreen()
    {
        displayLabel.text = ""
        totalDisplay.text = ""
        operation = ""
        lastButtonClicked = ""
        total = 0
        topNumber.textColor = UIColor.black
        leftNumber.textColor = UIColor.black
        rightNumber.textColor = UIColor.black
        bottomNumber.textColor = UIColor.black
        alreadyClicked = 0
        tvc.topClicked = false
        tvc.leftClicked = false
        tvc.rightClicked = false
        tvc.bottomClicked = false
    }

    
    @IBAction func resetButton(_ sender: Any)
    {
        resetScreen()
        resetTimes += 1
        if resetTimes > 1
        {
            tvc.score -= 40
            scoreLabel.text = "\(tvc.score)"
        }

    }
    
    func checkGameOver()
    {
        if alreadyClicked == 4
        {
            if total == 36
            {
                if tvc.i <= 13
                {
                    
                    print("YAY YOU WON! GO ON TO THE NEXT ROUND!")
                    tvc.winningSound()
                    let alert = UIAlertController(title: "Congratulations! You have found the correct sequence!", message: "On to the next set!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    resetTimes = 0
                    tvc.score += 50
                    tvc.i += 4
                    resetScreen()
                    topNumber.text = "\(valuesArray[tvc.i])"
                    leftNumber.text = "\(valuesArray[tvc.i+1])"
                    rightNumber.text = "\(valuesArray[tvc.i+2])"
                    bottomNumber.text = "\(valuesArray[tvc.i+3])"
                    
                }
                else if tvc.i > 13
                {
                    
                    let alertController = UIAlertController(title: "Congratulations! You have finished the third level!", message: "On to the next level!", preferredStyle: UIAlertControllerStyle.alert)
                    let levelTwo = UIAlertAction(title: "Level 4", style: UIAlertActionStyle.default, handler:
                    {
                        (action) -> Void in self.performSegue(withIdentifier: "Level4", sender: self)
                    })
                    
                    alertController.addAction(levelTwo)
                    self.present(alertController, animated: true, completion: nil)
                    tvc.score += 100
                    resetScreen()
                    topNumber.text = "\(valuesArray[tvc.i])"
                    leftNumber.text = "\(valuesArray[tvc.i+1])"
                    rightNumber.text = "\(valuesArray[tvc.i+2])"
                    bottomNumber.text = "\(valuesArray[tvc.i+3])"
                    
                }
                
            }
                
            else
            {
                print("SORRY YOUR ANSWER IS INCORRECT! PLEASE TRY AGAIN!")
                let alert = UIAlertController(title: "Sorry! Your answer doesn't equal 36!", message: "Better luck next time!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                resetScreen()
            }
        }
    }
    
    
    func selectDifferentNumber()
    {
        let alert = UIAlertController(title: "Please select a different number!", message: "You can select each number only once.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        tvc.topClicked = false
        tvc.leftClicked = false
        tvc.rightClicked = false
        tvc.bottomClicked = false
        tvc.i = 0
        tvc.score = Int(scoreLabel.text!)!
        tvc.valuesArray = [Int]()
        var nextView = segue.destination  as! FourthViewController
        nextView.fvc = tvc
    }
// 25 - 17 / 2 * 9
// 3 * 10 / 2 + 21
// 64 + 8 * 2 / 4
// 52 / 13 * 6 + 12
// 3 * 3 * 8 / 2
}
