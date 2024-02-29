//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!

    let eggTimes = ["Soft":3, "Medium": 420, "Hard": 720]
    var timer = Timer()
    var secondsLeft = 0
    var totalTime = 60
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        progressBar.progress = 0.0
        
        titleLabel.text = "How do you like your eggs?"
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        secondsLeft = eggTimes[hardness]!
        
        totalTime = eggTimes[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector:#selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer(){
        if secondsLeft > 0 {
            progressBar.progress = (1-(Float(secondsLeft)/Float(totalTime)))
            print("\(secondsLeft) seconds.")
            secondsLeft -= 1
        } else {
            timer.invalidate()
            progressBar.progress = 1.0
            titleLabel.text = "DONE!"
            playSound()
        }
    }
    
    func playSound(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }

}
