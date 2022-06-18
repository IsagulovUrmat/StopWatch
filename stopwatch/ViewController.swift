//
//  ViewController.swift
//  stopwatch
//
//  Created by Isagulov urmat on 16/6/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var hours: String = "00"
    var minutes: String = "00"
    var seconds: String = "00"
    var counter: Int = 0
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hourLabel.text = hours
        minuteLabel.text = minutes
        secondLabel.text = seconds
    }
    
    //MARK: Stop button action
    @IBAction func stopButton(_ sender: UIButton) {
        timer.invalidate()
        counter = 0
        hours = "00"
        minutes = "00"
        seconds = "00"
        secondLabel.text = seconds
        minuteLabel.text = minutes
        hourLabel.text = hours
        playButton.isEnabled = true
        pauseButton.isEnabled = true
        
        
    }
    
    //MARK: Pause button action
    @IBAction func pauseButton(_ sender: UIButton) {
        timer.invalidate()
        pauseButton.isEnabled = false
        playButton.isEnabled = true
        
    }
    
    //MARK: Play button action
    @IBAction func playButton(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 0.00001, target: self, selector: #selector(makeStep), userInfo: nil, repeats: true)
        pauseButton.isEnabled = true
        playButton.isEnabled = false
    }
    
    @objc func makeStep(){
        
        counter += 1
        let seconds = findSec(seconds: counter)
        let minutes = findMin(seconds: counter)
        let hours = findHours(seconds: counter)
        let TimeString = makeTimeString(hours: hours, minutes: minutes, seconds: seconds)
        secondLabel.text = TimeString[0]
        minuteLabel.text = TimeString[1]
        hourLabel.text = TimeString[2]
        
    }
    
    func findSec(seconds:Int) -> Int{
        
        return seconds / 3600
    }
    
    func findMin(seconds:Int) -> Int{
        
        return (seconds % 3600) / 60
    }
    
    func findHours(seconds:Int) -> Int{
        
        return (seconds % 3600) % 60
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> [String]{
        
        var hour = ""
        hour += String(format: "%02d", hours)
        var min = ""
        min += String(format: "%02d", minutes)
        var sec = ""
        sec += String(format: "%02d", seconds)
        return [hour, min, sec]
    }
    
}

