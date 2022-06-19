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
    
    @IBOutlet weak var sliderTime: UISlider!
    @IBOutlet weak var SegView: UISegmentedControl!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var hours: String = "00"
    var minutes: String = "00"
    var seconds: String = "00"
    var counter: Int = 0
    var isTimer = true
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hourLabel.text = hours
        minuteLabel.text = minutes
        secondLabel.text = seconds
        view.backgroundColor = .lightGray
        
        sliderTime.isHidden = true
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
        if isTimer == true{
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(makeStepBack), userInfo: nil, repeats: true)
        }else{
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(makeStep), userInfo: nil, repeats: true)
            pauseButton.isEnabled = true
            playButton.isEnabled = false
        }
    }
    
    @objc func makeStepBack(){
        if counter != 0 {
            if counter > 10{
                secondLabel.text = "\(counter)"
            }else{
                secondLabel.text = "0\(counter)"
            }
            counter -= 1
            sliderTime.value = Float(counter)
            
        }else{
            playButton.isEnabled = false
            stopButton.isEnabled = true
            pauseButton.isEnabled = true
            counter = 0
            hours = "00"
            minutes = "00"
            seconds = "00"
            secondLabel.text = seconds
            minuteLabel.text = minutes
            hourLabel.text = hours
            timer.invalidate()
        }
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
    
    @IBAction func SegmentedTap(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
        case 0:
            view.backgroundColor = .lightGray
            sliderTime.isHidden = true
            isTimer = false
        case 1:
            view.backgroundColor = .white
            sliderTime.isHidden = false
            isTimer = true
        default:
            print("1")

        }
    }
    
    @IBAction func slider(_ sender: UISlider) {
        
        secondLabel.text = "\(Int(sender.value))"
        counter = Int(sender.value)
        
    }
    
}

