//
//  IntroViewController.swift
//  24_FinalApp
//
//  Created by Devanshi Chakrabarti on 6/29/17.
//  Copyright © 2017 Devanshi Chakrabarti. All rights reserved.
//

import UIKit
import AVFoundation

class IntroViewController: UIViewController
{
    var player: AVAudioPlayer!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        playSound()
        
    
    }
    
    func playSound()
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
            player.numberOfLoops = -1
            player.play()
        } catch let error
        {
            print(error.localizedDescription)
        }
    }


}
