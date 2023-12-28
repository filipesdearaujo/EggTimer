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
    var eggTimes: [String:Int] = ["Soft": 5,"Medium":7,"Hard":12]
    var timer = Timer()
    var totalTime = 0
    var secondPassed = 0
    var seconds = 3.0
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var messageTitle: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle! // Ponto de exclamação para dizer que é certeza que há apenas valores diferente de nulo
        playReset()
        totalTime = eggTimes[hardness]! * 1// ponto de exclamação para retirar o valor final de Opcional, pois afirmamos que seria diferente de nulo
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        //example functionality
        if secondPassed < totalTime {
            secondPassed += 1
            print(secondPassed)
            progressBar.progress = Float(secondPassed) / Float(totalTime)
      
        }
        if secondPassed == totalTime {
            messageTitle.text = "Your eggs are ready!"
            playSound(soundName:"alarm_sound")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            }
        }
    }
    func playReset() {
        timer.invalidate()
        progressBar.progress = 0
        messageTitle.text = "How do you like your eggs?"
        secondPassed = 0
    }
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

