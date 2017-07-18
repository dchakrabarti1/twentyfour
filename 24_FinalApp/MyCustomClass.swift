//
//  MyCustomClass.swift
//  24_FinalApp
//
//  Created by Devanshi Chakrabarti on 7/10/17.
//  Copyright © 2017 Devanshi Chakrabarti. All rights reserved.
//

import UIKit
import AVFoundation

class MyCustomClass: NSObject
{
    var operation = ""
    var score = 0
    var i = 0
    var valuesArray: ([Int]) = [] // change to different numbers
    var total = 0
    var lastButtonClicked = ""
    var alreadyClicked = 0
    var topClicked = false
    var leftClicked = false
    var rightClicked = false
    var bottomClicked = false
    var player: AVAudioPlayer!
    
    func playSound()
    {
        guard let url = Bundle.main.url(forResource: "ClickSound", withExtension: "wav") else
        {
            print("error")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else
            {
                return
            }
            
            player.play()
        } catch let error
        {
            print(error.localizedDescription)
        }
    }
    
    func playSoundOperator()
    {
        guard let url = Bundle.main.url(forResource: "ClickSoundOperator", withExtension: "wav") else
        {
            print("error")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else
            {
                return
            }
            
            player.play()
        } catch let error
        {
            print(error.localizedDescription)
        }
    }
    
    func winningSound()
    {
        guard let url = Bundle.main.url(forResource: "winning", withExtension: "wav") else
        {
            print("error")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else
            {
                return
            }
            
            player.play()
        } catch let error
        {
            print(error.localizedDescription)
        }
    }
    
    func secondLevel()
    {
        guard let url = Bundle.main.url(forResource: "IntroSong", withExtension: "mp3") else
        {
            print("error")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else
            {
                return
            }
            
            player.play()
        } catch let error
        {
            print(error.localizedDescription)
        }
    }

    func selectDifferentNumber()
    {
        let alert = UIAlertController(title: "Please select a different number!", message: "You can select each number only once.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        //self.present(alert, animated: true, completion: nil)
    }
    
    func selectOperator()
    {
        let alert = UIAlertController(title: "Please select an operator", message: "You cannot select two operands in a row!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        //self.present(alert, animated: true, completion: nil)
    }
    
    func selectOperand()
    {
        let alert = UIAlertController(title: "Please select a number!", message: "You cannot select two operators in a row!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        //self.present(alert, animated: true, completion: nil)
    }
    
    func selectOperandFirst()
    {
        let alert = UIAlertController(title: "Please select a number!", message: "You cannot start off with an operator!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        //self.present(alert, animated: true, completion: nil)
    }
}
