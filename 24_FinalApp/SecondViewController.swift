//
//  SecondViewController.swift
//  24_FinalApp
//
//  Created by Devanshi Chakrabarti on 7/10/17.
//  Copyright © 2017 Devanshi Chakrabarti. All rights reserved.
//

import UIKit


class SecondViewController: UIViewController
{
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var topNumber: GridLabel!
    @IBOutlet weak var leftNumber: GridLabel!
    @IBOutlet weak var rightNumber: GridLabel!
    @IBOutlet weak var bottomNumber: GridLabel!
    @IBOutlet weak var totalDisplay: GridLabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var svc = MyCustomClass()
    var resetTimes = 0
    var operation = ""
    var lastButtonClicked = ""
    var total = 0
    var alreadyClicked = 0
    var valuesArray: ([Int]) = [2, 2, 6, 8, 24, 23, 25, 1, 19, 30, 15, 6, 24, 60, 3, 4, 53, 2, 22, 79]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "LEVEL 2"
        scoreLabel.text = "\(svc.score)"
        topNumber.text = "\(valuesArray[svc.i])"
        leftNumber.text = "\(valuesArray[svc.i+1])"
        rightNumber.text = "\(valuesArray[svc.i+2])"
        bottomNumber.text = "\(valuesArray[svc.i+3])"
        
        topNumber.isUserInteractionEnabled = true
        leftNumber.isUserInteractionEnabled = true
        rightNumber.isUserInteractionEnabled = true
        bottomNumber.isUserInteractionEnabled = true
        
        var topTapGesture = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.TopLabelTapped))
        var leftTapGesture = UITapGestureRecognizer(target: self, action: "LeftLabelTapped")
        var rightTapGesture = UITapGestureRecognizer(target: self, action: "RightLabelTapped")
        var bottomTapGesture = UITapGestureRecognizer(target: self, action: "BottomLabelTapped")
        
        self.topNumber.addGestureRecognizer(topTapGesture)
        self.leftNumber.addGestureRecognizer(leftTapGesture)
        self.rightNumber.addGestureRecognizer(rightTapGesture)
        self.bottomNumber.addGestureRecognizer(bottomTapGesture)
        
    }
    @IBAction func resetButton(_ sender: Any)
    {
        resetScreen()
        resetTimes += 1
        if resetTimes > 1
        {
            svc.score -= 40
            scoreLabel.text = "\(svc.score)"
        }
    }
    
    func resetScreen()
    {
        displayLabel.text = ""
        totalDisplay.text = ""
        operation = ""
        lastButtonClicked = ""
        total = 0
        alreadyClicked = 0
        
        topNumber.backgroundColor = UIColor.lightGray
        leftNumber.backgroundColor = UIColor.lightGray
        rightNumber.backgroundColor = UIColor.lightGray
        bottomNumber.backgroundColor = UIColor.lightGray
        
        svc.topClicked = false
        svc.leftClicked = false
        svc.rightClicked = false
        svc.bottomClicked = false
    }
    
    func TopLabelTapped()
    {
        if svc.topClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x" || lastButtonClicked == "/"
            {
                print("Top label tapped")
                
                svc.playSound()
                lastButtonClicked = "\(topNumber.text!)"
        
                topNumber.backgroundColor = UIColor.orange
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                
                calculateTotal(value: Int(topNumber.text!)!)
                svc.topClicked = true
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
        if svc.leftClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x" || lastButtonClicked == "/"
            {
                print("Valid Move")
                svc.playSound()
                lastButtonClicked = "\(leftNumber.text!)"
                leftNumber.backgroundColor = UIColor.orange
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(leftNumber.text!)!)
                svc.leftClicked = true
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
        if svc.rightClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x" || lastButtonClicked == "/"
            {
                print("Right label tapped")
                svc.playSound()
                lastButtonClicked = "\(rightNumber.text!)"
                rightNumber.backgroundColor = UIColor.orange
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(rightNumber.text!)!)
                svc.rightClicked = true
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
        if svc.bottomClicked == false
        {
            if lastButtonClicked == "+" || lastButtonClicked == "-" || lastButtonClicked == "" || lastButtonClicked == "x" || lastButtonClicked == "/"
            {
                print("Valid Move")
                svc.playSound()
                lastButtonClicked = "\(bottomNumber.text!)"
                bottomNumber.backgroundColor = UIColor.orange
                displayLabel.text = displayLabel.text! + " " + lastButtonClicked
                alreadyClicked += 1
                calculateTotal(value: Int(bottomNumber.text!)!)
                svc.bottomClicked = true
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
            svc.playSoundOperator()
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
            svc.playSoundOperator()
            operation = "-"
            lastButtonClicked = "-"
            displayLabel.text = displayLabel.text! + " " + "-"
        }
        print("\(operation) subtract button")
    }
    
    @IBAction func multiplyButton(_ sender: Any)
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
            svc.playSoundOperator()
            operation = "x"
            lastButtonClicked = "x"
            displayLabel.text = displayLabel.text! + " " + "x"
        }
        
    }
    
    @IBAction func divideButton(_ sender: Any)
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
            svc.playSoundOperator()
            operation = "/"
            lastButtonClicked = "/"
            displayLabel.text = displayLabel.text! + " " + "/"
        }
    }
    
    
    func checkGameOver()
    {
        
        if alreadyClicked == 4
        {
            if total == 24
            {
                if svc.i <= 13
                {
                    
                    print("YAY YOU WON! GO ON TO THE NEXT ROUND!")
                    svc.winningSound()
                    let alert = UIAlertController(title: "Congratulations! You have found the correct sequence!", message: "On to the next set!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    resetTimes = 0
                    svc.score += 50
                    svc.i += 4
                    resetScreen()
                    topNumber.text = "\(valuesArray[svc.i])"
                    leftNumber.text = "\(valuesArray[svc.i+1])"
                    rightNumber.text = "\(valuesArray[svc.i+2])"
                    bottomNumber.text = "\(valuesArray[svc.i+3])"
                    
                }
                else if svc.i > 13
                {
                    
                    let alertController = UIAlertController(title: "Congratulations! You have finished the second level!", message: "On to the next level!", preferredStyle: UIAlertControllerStyle.alert)
                    let levelTwo = UIAlertAction(title: "Level 3", style: UIAlertActionStyle.default, handler:
                    {
                        (action) -> Void in self.performSegue(withIdentifier: "Level3", sender: self)
                    })
                    
                    alertController.addAction(levelTwo)
                    self.present(alertController, animated: true, completion: nil)
                    svc.score += 100
                    resetScreen()
                    topNumber.text = "\(valuesArray[svc.i])"
                    leftNumber.text = "\(valuesArray[svc.i+1])"
                    rightNumber.text = "\(valuesArray[svc.i+2])"
                    bottomNumber.text = "\(valuesArray[svc.i+3])"
                    
                }
                
            }
                
            else
            {
                print("SORRY YOUR ANSWER IS INCORRECT! PLEASE TRY AGAIN!")
                let alert = UIAlertController(title: "Sorry! Your answer doesn't equal 24!", message: "Better luck next time!", preferredStyle: UIAlertControllerStyle.alert)
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
        case "/":
            total /= value
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
        svc.topClicked = false
        svc.leftClicked = false
        svc.rightClicked = false
        svc.bottomClicked = false
        svc.i = 0
        svc.score = Int(scoreLabel.text!)!
        svc.valuesArray = [Int]()
        var nextView = segue.destination  as! ThirdViewController
        nextView.tvc = svc
    }
    
    // 6 - 2 + 8 * 2
    // 25 - 24 + 23 * 1
    // 15 + 19 - 30 * 6
    // 24 + 60 / 4 + 3
    // 79 - 53 + 22 / 2
    
    
    
}

