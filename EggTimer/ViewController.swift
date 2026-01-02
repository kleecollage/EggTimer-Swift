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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    // let softTime = 5
    // let mediumTime = 7
    // let hardTime = 12
    var player: AVAudioPlayer?
    var steps: Float  = 0
    var progress: Float  = 0
    var progressProgress: Float = 0
    var count: Float = 0
    var timer = Timer()
    var timeLeft: TimeInterval = 0
    var totalTime = 0
    var timePassed = 0
    let eggTimes = [
        "Soft" : 3,
        "Medium" : 4,
        "Hard" : 7
    ]
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        // resetVariables()
        
        let hardness = sender.currentTitle ?? ""
        print(hardness)
        
        totalTime = eggTimes[hardness]!
        timePassed = 0
        progressBar.progress = 0
        titleLabel.text = "Cooking \(hardness) Egg"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
//        switch hardness {
//        case "Soft":
//            // print(eggTimes["Soft"]!)
//            countdown(hardness: hardness)v
//        case "Medium":
//            countdown(hardness: hardness)
//        case "Hard":
//            countdown(hardness: hardness)
//        default:
//            print("oops!")
//        }
    }
    
    @objc func updateTimer() {
        // increasseProgressBar()
        if timePassed < totalTime {
            timePassed += 1
            progressBar.setProgress(Float(timePassed) / Float(totalTime), animated: true)
        } else {
            playSound()
            timer.invalidate()
            titleLabel.text = "DONE!"
            print("DONE!")
        }
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
    
    func increasseProgressBar() {
        print(count)
        print(progressProgress)
        if count < steps {
            count += 1
            progressProgress = progress * count
            progressBar.setProgress(progressProgress, animated: true)
        }
    }
    
    func resetVariables() {
        timer.invalidate()
        steps = 0
        progress = 0
        progressProgress = 0
        count = 0
        titleLabel.text = "How do you like your eggs?"
        progressBar.setProgress(steps, animated: true)
    }
    
    func countdown(hardness: String) {
        var timeLeft = TimeInterval(eggTimes[hardness]!)
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
            if timeLeft >= 0 {
                print ("Seconds left: \(timeLeft)s")
                timeLeft -= 1
            } else {
                print("DONE!")
                self.timer.invalidate()
            }
        }
    }
}
