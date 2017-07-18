//
//  FourthViewController.swift
//  24_FinalApp
//
//  Created by Devanshi Chakrabarti on 7/12/17.
//  Copyright © 2017 Devanshi Chakrabarti. All rights reserved.
//

import UIKit
import AVFoundation

class FourthViewController: UIViewController
{
    @IBOutlet weak var topNumber: GridLabel!
    @IBOutlet weak var leftNumber: GridLabel!
    @IBOutlet weak var rightNumber: GridLabel!
    @IBOutlet weak var bottomNumber: GridLabel!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var totalDisplay: GridLabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var fvc = MyCustomClass()
    var player: AVAudioPlayer!
    var resetTimes = 0
    var lives = 3
    var time = 45
    var timer = Timer()
    var operation = ""
    var valuesArray: ([Int]) = [8, 2, 2, 9, 2, 5, 14, 13, 3, 30, 33, 6, 6, 11, 1, 8, 21, 5, 24, 4]
    var total = 0
    var i = 0
    var lastButtonClicked = ""
    var alreadyClicked = 0
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(FourthViewController.timerCountdown), userInfo: nil, repeats: true)
        
        self.title = "LEVEL 4"
        topNumber.text = "\(valuesArray[i])"
        leftNumber.text = "\(valuesArray[i+1])"
        rightNumber.text = "\(valuesArray[i+2])"
        bottomNumber.text = "\(valuesArray[i+3])"
        
        topNumber.isUserInteractionEnabled = true
        leftNumber.isUserInteractionEnabled = true
        rightNumber.isUserInteractionEnabled = true
        bottomNumber.isUserInteractionEnabled = true
        
        var topTapGesture = UITapGestureRecognizer(target: self, action: #selector(FourthViewController.TopLabelTapped))
        var leftTapGesture = UITapGestureRecognizer(target: self, action: "LeftLabelTapped")
        var rightTapGesture = UITapGestureRecognizer(target: self, action: "RightLabelTapped")
        var bottomTapGesture = UITapGestureRecognizer(target: self, action: "BottomLabelTapped")
        self.topNumber.addGestureRecognizer(topTapGesture)
        self.leftNumber.addGestureRecognizer(leftTapGesture)
        self.rightNumber.addGestureRecognizer(rightTapGesture)
        self.bottomNumber.addGestureRecognizer(bottomTapGesture)
    }
    
    func timerCountdown()
    {
        time -= 1
        timerLabel.text = String(time)
        
        if time == 0
        {
            if lives > 0
            {
            lives -= 1
            let alert = UIAlertController(title: "Your time is up!", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Try Again!", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            resetScreen()
            timerLabel.textColor = UIColor.white
            time = 45
            }
            else if lives == 0
            {
                time = 100
                let alertController = UIAlertController(title: "You have lost all your lives!", message: "You have been demoted to Level 3", preferredStyle: UIAlertControllerStyle.alert)
                let levelTwo = UIAlertAction(title: "Level 3", style: UIAlertActionStyle.default, handler:
                {
                    (action) -> Void in self.performSegue(withIdentifier: "BackTo3", sender: self)
                })
                
                alertController.addAction(levelTwo)
                self.present(alertController, animated: true, completion: nil)
                

            }
        }
        else if time == 10
        {
            timerLabel.textColor = UIColor.red
        }
        
        
        
    }
    func TopLabelTapped()
    {
        if fvc.topClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x"
            {
                print("Valid Move")
                fvc.playSound()
                lastButtonClicked = "\(topNumber.text!)"
                topNumber.textColor = UIColor.clear
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(topNumber.text!)!)
                fvc.topClicked = true
                
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
        if fvc.leftClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x"
            {
                print("Valid Move")
                fvc.playSound()
                lastButtonClicked = "\(leftNumber.text!)"
                leftNumber.textColor = UIColor.clear
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(leftNumber.text!)!)
                fvc.leftClicked = true
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
        if fvc.rightClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x"
            {
                print("Valid Move")
                fvc.playSound()
                lastButtonClicked = "\(rightNumber.text!)"
                rightNumber.textColor = UIColor.clear
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(rightNumber.text!)!)
                fvc.rightClicked = true
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
        if fvc.bottomClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == ""
            {
                print("Valid Move")
                fvc.playSound()
                lastButtonClicked = "\(bottomNumber.text!)"
                bottomNumber.textColor = UIColor.clear
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(bottomNumber.text!)!)
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
        if lastButtonClicked == "-" || lastButtonClicked == "+" || lastButtonClicked == "x"
        {
            selectOperand()
        }
        else if lastButtonClicked == ""
        {
            selectOperandFirst()
        }
        else
        {
            fvc.playSoundOperator()
            operation = "+"
            lastButtonClicked = "+"
            displayLabel.text = displayLabel.text! + " " + "+"
        }
    }
    
    @IBAction func subtractionButton(_ sender: Any)
    {
        if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "x"
            
        {
            selectOperand()
        }
        else if lastButtonClicked == ""
        {
            selectOperandFirst()
        }
        else
        {
            fvc.playSoundOperator()
            operation = "-"
            lastButtonClicked = "-"
            displayLabel.text = displayLabel.text! + " " + "-"
        }
    }
    
    
    
    @IBAction func multiplicationButton(_ sender: Any)
    {
        if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "x"
        {
            selectOperand()
        }
        else if lastButtonClicked == ""
        {
            selectOperandFirst()
        }
        else
        {
           fvc.playSoundOperator()
            operation = "x"
            lastButtonClicked = "x"
            displayLabel.text = displayLabel.text! + " " + "x"
        }
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
        fvc.topClicked = false
        fvc.leftClicked = false
        fvc.rightClicked = false
        fvc.bottomClicked = false
    }
    
    @IBAction func resetButton(_ sender: Any)
    {
        resetScreen()
        resetTimes += 1
        if resetTimes > 1
        {
            fvc.score -= 40
            scoreLabel.text = "\(fvc.score)"
        }

    }
    
    func checkGameOver()
    {
        if alreadyClicked == 4
        {
            if total == 36
            {
                if fvc.i <= 13
                {
                    
                    print("YAY YOU WON! GO ON TO THE NEXT ROUND!")
                    fvc.winningSound()
                    let alert = UIAlertController(title: "Congratulations! You have found the correct sequence!", message: "On to the next set!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    resetTimes = 0
                    fvc.score += 50
                    fvc.i += 4
                    resetScreen()
                    topNumber.text = "\(valuesArray[fvc.i])"
                    leftNumber.text = "\(valuesArray[fvc.i+1])"
                    rightNumber.text = "\(valuesArray[fvc.i+2])"
                    bottomNumber.text = "\(valuesArray[fvc.i+3])"
                    
                }
                else if fvc.i > 13
                {
                    
                    let alertController = UIAlertController(title: "Congratulations! You have finished the fourth level!", message: "On to the next level!", preferredStyle: UIAlertControllerStyle.alert)
                    let levelTwo = UIAlertAction(title: "Level 5", style: UIAlertActionStyle.default, handler:
                    {
                        (action) -> Void in self.performSegue(withIdentifier: "Level5", sender: self)
                    })
                    
                    alertController.addAction(levelTwo)
                    self.present(alertController, animated: true, completion: nil)
                    fvc.score += 100
                    resetScreen()
                    topNumber.text = "\(valuesArray[fvc.i])"
                    leftNumber.text = "\(valuesArray[fvc.i+1])"
                    rightNumber.text = "\(valuesArray[fvc.i+2])"
                    bottomNumber.text = "\(valuesArray[fvc.i+3])"
                    
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
        default:
            break
        }
        
        checkGameOver()
        
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
        if segue.identifier == "Level5"
        {
        fvc.topClicked = false
        fvc.leftClicked = false
        fvc.rightClicked = false
        fvc.bottomClicked = false
        fvc.i = 0
        fvc.score = Int(scoreLabel.text!)!
        fvc.valuesArray = [Int]()
        var nextView = segue.destination  as! FifthViewController
        nextView.fivc = fvc
        }
    }

    // 9 + 8 * 2 + 2
    // 14 * 2 - 5 + 13
    // 33 + 3 - 30 * 6
    // 8 * 6 - 11 + 1
    // 21 + 24 / 5 * 4
}
