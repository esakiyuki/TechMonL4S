//
//  LobbyViewController.swift
//  TechMonL4S
//
//  Created by esaki yuki on 2020/09/13.
//  Copyright © 2020 esaki yuKki. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaLabel: UILabel!
    
    let techMonManager = TechMonManager.shared
    
    var stamina: Int = 100
    var staminaTimer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "勇者"
        staminaLabel.text = "\(stamina) / 100"
        
        staminaTimer = Timer.scheduledTimer(
            timeInterval: 3,
            target:  self,
            selector: #selector(updateStaminaValue),
            userInfo: nil,
            repeats: true)
        staminaTimer.fire()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animaited: Bool) {
        super.viewWillAppear(animaited)
        techMonManager.playBGM(fileName: "lobby")
    }
    
    override func viewWillDisappear(_ animaited: Bool) {
        super.viewWillDisappear(animaited)
        techMonManager.stopBGM()
    }
    
    //条件によって画面遷移できるか変えるためにあの繋ぎ方をしたのかな？
    @IBAction func toBattle() {
        //スタミナが50以上ないと次の画面に進めない
        if stamina >= 50 {
            stamina -= 50
            staminaLabel.text = "\(stamina) / 100"
            performSegue(withIdentifier: "toBattle", sender: nil)
        } else {
            let alert = UIAlertController(title: "バトルに行けません", message: "スタミナをためてください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func updateStaminaValue() {
        if stamina < 100 {
            stamina += 1
            staminaLabel.text = "\(stamina) / 100"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
