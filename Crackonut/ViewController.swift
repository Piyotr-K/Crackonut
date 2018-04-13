//
//  ViewController.swift
//  Crackonut
//
//  Created by Piyotr Kao on 2018-04-13.
//  Copyright © 2018 Piyotr Kao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    final var timeLimit: Double = 20.0
    final var resetClick: Int = 0
    
    var clicks: Int = 0
    var timeLeft: Double = 0.0
    var gameRunning: Bool = false
    var color_curr: UIColor?
    var timer: Timer?
    var updater: Timer?
    @IBOutlet weak var label_clicks: UILabel!
    @IBOutlet weak var label_timer: UILabel!
    @IBOutlet weak var button_newGame: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        color_curr = button_newGame.tintColor
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func on_click_coconut(_ sender: UIButton) {
        if (gameRunning)
        {
            clicks += 1;
            label_clicks.text = clicks.description + " clicks"
        }
    }
    
    @IBAction func on_click_newGame(_ sender: UIButton) {
        if (!gameRunning)
        {
            clicks = resetClick
            timeLeft = timeLimit
            button_newGame.isEnabled = false
            button_newGame.tintColor = UIColor.gray
            label_clicks.text = "0 clicks"
            label_timer.textColor = UIColor.blue
            gameRunning = true
            startTimer()
        }
    }
    
    @objc func endGame()
    {
        label_timer.textColor = UIColor.red
        label_timer.text = "Game Over!"
        timer?.invalidate()
        timer = nil
        updater?.invalidate()
        updater = nil
        button_newGame.isEnabled = true
        button_newGame.tintColor = color_curr
        gameRunning = false
    }
    
    @objc func update()
    {
        label_timer.text = String(format: "%.1f sec", timeLeft)
        timeLeft -= 0.1
    }
    
    func startTimer()
    {
        if ((timer == nil) && (updater == nil))
        {
            timer = Timer.scheduledTimer(timeInterval: timeLimit, target: self, selector: #selector(self.endGame), userInfo: nil, repeats: false)
            updater = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        }
    }
    

}

