//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation //needed to use sound




class ViewController: UIViewController {
    //initializing egg cooking times
    let eggTimes = [
        "Soft": 5 , "Medium": 7 * 60, "Hard": 10
    ]
    //Cooking times variables
    var totalTime = 0
    var secondsPast = 0
    var eggHard = "Soft"
    
    //timer initialization
    var timer = Timer()
    var player: AVAudioPlayer!  // initializing audio player
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //restting timer
        timer.invalidate()
        //setting the harndess to what was clicked on
        eggHard = sender.currentTitle!
        totalTime = eggTimes[eggHard]!
        
        //setting progress bar to 0
        progressBar.progress = 0.0
        secondsPast = 0
        //changing the title to what is being cooked
        titleLabel.text = ("Timing your \(eggHard) eggs")
        
        //setting up timer
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
       
    }
        
   
    @objc func updateCounter() {
        //incrementing the counter each second and changing progress bar
        if secondsPast < totalTime {
            secondsPast += 1
            progressBar.progress = Float(secondsPast) / Float(totalTime)
            
        } else {
            timer.invalidate()
           // eggHard = "How do you want your eggs done?"
            timer.invalidate()  //resetting timer
            //changing title to eggs done
            titleLabel.text = "Your \(eggHard) eggs are done!!"
            //setting up the alarm sound
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
                        
            }
        }
    }

