//
//  ViewController.swift
//  Crackonut
//
//  Created by Piyotr Kao on 2018-04-13.
//  Copyright © 2018 Piyotr Kao. All rights reserved.
//

import UIKit

struct Coconut {
    var hp: Int;
    let timeBonus: Double;
    init(level: Int)
    {
        self.hp = (10 + level) * level
        self.timeBonus = 1.5 * Double(level)
    }
    
    func getHp() -> Int
    {
        return self.hp
    }
    
    func getTime() -> Double
    {
        return self.timeBonus
    }
    
    mutating func damage()
    {
        self.hp = self.hp - 1
    }
    
}

class ViewController: UIViewController {
    final var timeLimit: Double = 20.0
    final var resetClick: Int = 0
    final var levelStart: Int = 1
    
    var clicks: Int = 0
    var timeLeft: Double = 0.0
    var gameRunning: Bool = false
    var color_curr: UIColor?
    var timer: Timer?
    var updater: Timer?
    var currLevel: Int?
    var CrackONut: Coconut?
    @IBOutlet weak var label_clicks: UILabel!
    @IBOutlet weak var label_timer: UILabel!
    @IBOutlet weak var button_newGame: UIButton!
    @IBOutlet weak var label_health: UILabel!
    @IBOutlet weak var button_coconut: UIButton!
    
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
            button_coconut.setImage(UIImage(named: "Brown-Coconut.png"), for: .normal)
            if (CrackONut?.getHp())! > 1
            {
                CrackONut?.damage()
                label_health.text = "HP: " + (CrackONut?.getHp().description)!
            }
            else
            {
                clicks += 1
                label_clicks.text = clicks.description + " cracked"
                advanceLevel()
            }
        }
    }
    
    @IBAction func on_click_newGame(_ sender: UIButton) {
        if (!gameRunning)
        {
            clicks = resetClick
            timeLeft = timeLimit
            button_newGame.isEnabled = false
            button_newGame.tintColor = UIColor.gray
            label_clicks.text = "0 cracked"
            label_timer.textColor = UIColor.blue
            currLevel = levelStart
            CrackONut = Coconut(level: currLevel!)
            label_health.text = "HP: " + (CrackONut?.getHp().description)!
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
        CrackONut = nil
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
    
    func addTime(timeAdd: Double)
    {
        timeLeft += timeAdd
        timer?.invalidate()
        timer = nil
        timer = Timer.scheduledTimer(timeInterval: timeLeft, target: self, selector: #selector(self.endGame), userInfo: nil, repeats: false)
    }
    
    func advanceLevel()
    {
        (currLevel)! += 1
        addTime(timeAdd: (CrackONut?.getTime())!)
        CrackONut = nil
        CrackONut = Coconut(level: currLevel!)
        button_coconut.setImage(UIImage(named: "cracked.png"), for: .normal)
        label_health.text = "Crack!"
    }

}

