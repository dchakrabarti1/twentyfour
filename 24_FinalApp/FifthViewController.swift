//
//  FifthViewController.swift
//  24_FinalApp
//
//  Created by Devanshi Chakrabarti on 7/12/17.
//  Copyright © 2017 Devanshi Chakrabarti. All rights reserved.
//

import UIKit
import AVFoundation

class FifthViewController: UIViewController
{
  
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var totalDisplay: GridLabel!
    @IBOutlet weak var topNumber: GridLabel!
    @IBOutlet weak var leftNumber: GridLabel!
    @IBOutlet weak var rightNumber: GridLabel!
    @IBOutlet weak var bottomNumber: GridLabel!
    @IBOutlet weak var corner1: GridLabel!
    @IBOutlet weak var corner2: GridLabel!
    @IBOutlet weak var corner3: GridLabel!
    @IBOutlet weak var corner4: GridLabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
        
    var fivc = MyCustomClass()
    var player: AVAudioPlayer!
    var score = 0
    var resetTimes = 0
    var lives = 2
    var time = 60
    var timer = Timer()
    var operation = ""
    var valuesArray: ([Int]) = [1, 2, 3, 4, 5, 6, 7, 8, 8, 13, 3, 7, 3, 4, 16, 9, 23, 3, 34, 13, 4, 4, 8, 20, 2, 11, 4, 33, 3, 3, 27, 7]
    var total = 0
    var i = 0
    var lastButtonClicked = ""
    var alreadyClicked = 0
    var corner1Clicked = false
    var corner2Clicked = false
    var corner3Clicked = false
    var corner4Clicked = false
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "LEVEL 5"

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(FourthViewController.timerCountdown), userInfo: nil, repeats: true)
        topNumber.text = "\(valuesArray[i])"
        leftNumber.text = "\(valuesArray[i+1])"
        rightNumber.text = "\(valuesArray[i+2])"
        bottomNumber.text = "\(valuesArray[i+3])"
        corner1.text = "\(valuesArray[i+4])"
        corner2.text = "\(valuesArray[i+5])"
        corner3.text = "\(valuesArray[i+6])"
        corner4.text = "\(valuesArray[i+7])"
        
        topNumber.isUserInteractionEnabled = true
        leftNumber.isUserInteractionEnabled = true
        rightNumber.isUserInteractionEnabled = true
        bottomNumber.isUserInteractionEnabled = true
        corner1.isUserInteractionEnabled = true
        corner2.isUserInteractionEnabled = true
        corner3.isUserInteractionEnabled = true
        corner4.isUserInteractionEnabled = true
        
        var topTapGesture = UITapGestureRecognizer(target: self, action: #selector(FirstLevelViewController.TopLabelTapped))
        var leftTapGesture = UITapGestureRecognizer(target: self, action: "LeftLabelTapped")
        var rightTapGesture = UITapGestureRecognizer(target: self, action: "RightLabelTapped")
        var bottomTapGesture = UITapGestureRecognizer(target: self, action: "BottomLabelTapped")
        var corner1TapGesture = UITapGestureRecognizer(target: self, action: "Corner1Tapped")
        var corner2TapGesture = UITapGestureRecognizer(target: self, action: "Corner2Tapped")
        var corner3TapGesture = UITapGestureRecognizer(target: self, action: "Corner3Tapped")
        var corner4TapGesture = UITapGestureRecognizer(target: self, action: "Corner4Tapped")
        self.topNumber.addGestureRecognizer(topTapGesture)
        self.leftNumber.addGestureRecognizer(leftTapGesture)
        self.rightNumber.addGestureRecognizer(rightTapGesture)
        self.bottomNumber.addGestureRecognizer(bottomTapGesture)
        self.corner1.addGestureRecognizer(corner1TapGesture)
        self.corner2.addGestureRecognizer(corner2TapGesture)
        self.corner3.addGestureRecognizer(corner3TapGesture)
        self.corner4.addGestureRecognizer(corner4TapGesture)
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
                time = 60
                timerLabel.textColor = UIColor.black
            }
            else if lives == 0
            {
                let alertController = UIAlertController(title: "You have lost all your lives!", message: "You have been demoted to Level 3", preferredStyle: UIAlertControllerStyle.alert)
                let levelTwo = UIAlertAction(title: "Level 3", style: UIAlertActionStyle.default, handler:
                {
                    (action) -> Void in self.performSegue(withIdentifier: "BackTo4", sender: self)
                })
                
                alertController.addAction(levelTwo)
                self.present(alertController, animated: true, completion: nil)
                player.stop()
            }
        }
        else if time <= 10
        {
            timerLabel.textColor = UIColor.red
        }
    }
    
    func TopLabelTapped()
    {
        if fivc.topClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x"
            {
                print("Valid Move")
                fivc.playSound()
                lastButtonClicked = "\(topNumber.text!)"
                topNumber.textColor = UIColor.clear
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(topNumber.text!)!)
                fivc.topClicked = true
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
        if fivc.leftClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x"
            {
                print("Valid Move")
                fivc.playSound()
                lastButtonClicked = "\(leftNumber.text!)"
                leftNumber.textColor = UIColor.clear
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(leftNumber.text!)!)
                fivc.leftClicked = true
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
        if fivc.rightClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x"
            {
                print("Valid Move")
                fivc.playSound()
                lastButtonClicked = "\(rightNumber.text!)"
                rightNumber.textColor = UIColor.clear
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(rightNumber.text!)!)
                fivc.rightClicked = true
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
        if fivc.bottomClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x"
            {
                print("Valid Move")
                fivc.playSound()
                lastButtonClicked = "\(bottomNumber.text!)"
                bottomNumber.textColor = UIColor.clear
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(bottomNumber.text!)!)
                fivc.bottomClicked = true
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
    
    func Corner1Tapped()
    {
        if corner1Clicked == false
            {
                if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x"
                {
                    print("Valid Move")
                    fivc.playSound()
                    lastButtonClicked = "\(corner1.text!)"
                    corner1.textColor = UIColor.clear
                    displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                    alreadyClicked += 1
                    calculateTotal(value: Int(corner1.text!)!)
                    corner1Clicked = true
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
    
    func Corner2Tapped()
    {
        if corner2Clicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x"
            {
                print("Valid Move")
                fivc.playSound()
                lastButtonClicked = "\(corner2.text!)"
                corner2.textColor = UIColor.clear
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(corner2.text!)!)
                corner2Clicked = true
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
    
    func Corner3Tapped()
    {
        if corner3Clicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x"
            {
                print("Valid Move")
                fivc.playSound()
                lastButtonClicked = "\(corner3.text!)"
                corner3.textColor = UIColor.clear
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(corner3.text!)!)
                corner3Clicked = true
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
    
    func Corner4Tapped()
    {
        if corner4Clicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == ""
            {
                print("Valid Move")
                fivc.playSound()
                Int(corner4.text!)!
                lastButtonClicked = "\(corner4.text!)"
                corner4.textColor = UIColor.clear
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(corner4.text!)!)
                corner4Clicked = true
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
            fivc.playSoundOperator()
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
             fivc.playSoundOperator()
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
             fivc.playSoundOperator()
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
        corner1.textColor = UIColor.black
        corner2.textColor = UIColor.black
        corner3.textColor = UIColor.black
        corner4.textColor = UIColor.black
        alreadyClicked = 0
        fivc.topClicked = false
        fivc.leftClicked = false
        fivc.rightClicked = false
        fivc.bottomClicked = false
        corner1Clicked = false
        corner2Clicked = false
        corner3Clicked = false
        corner4Clicked = false
    }
    
    @IBAction func resetButton(_ sender: Any)
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
        if alreadyClicked == 8
        {
            if total == 36
            {
                if fivc.i <= 32
                {
                    
                    print("YAY YOU WON! GO ON TO THE NEXT ROUND!")
                    fivc.winningSound()
                    let alert = UIAlertController(title: "Congratulations! You have found the correct sequence!", message: "On to the next set!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    resetTimes = 0
                    fivc.score += 50
                    fivc.i += 8
                    resetScreen()
                    topNumber.text = "\(valuesArray[fivc.i])"
                    leftNumber.text = "\(valuesArray[fivc.i+1])"
                    rightNumber.text = "\(valuesArray[fivc.i+2])"
                    bottomNumber.text = "\(valuesArray[fivc.i+3])"
                    corner1.text = "\(valuesArray[i+4])"
                    corner2.text = "\(valuesArray[i+5])"
                    corner3.text = "\(valuesArray[i+6])"
                    corner4.text = "\(valuesArray[i+7])"
                    
                    
                }
                else if fivc.i > 32
                {
                    
                    let alert = UIAlertController(title: "Congratulations! You have finished all of the levels!", message: "YOU ARE A CHAMPION", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)

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
    
    // 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8
    // 4 * 16 / 8 + 13 * 3 / 7 * 3 + 9
    // 23 + 34 / 3 + 13 / 4 * 8 / 4 + 20
    // 33 * 2 / 11 * 4 + 3 / 3 * 7 - 27
    // 56 - 23 * 3 / 11 + 12 * 2 - 12 + 36
    

}
