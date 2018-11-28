
//
//  DifficultyViewController.swift
//  Project
//
//  Created by Tompa on 2018-11-19.
//  Copyright © 2018 Oscar Stenqvist. All rights reserved.
//

import UIKit

let vc = ViewController()

class DifficultyViewController: UIViewController {
    
    @IBOutlet weak var easyBtn: UIButton!
    @IBOutlet weak var mediumBtn: UIButton!
    @IBOutlet weak var hardBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vc.loadSound()
        // navigation bar
        //navigationBarItems()
        
        easyBtn.backgroundColor = UIColor.white
        easyBtn.layer.cornerRadius = 20
        easyBtn.doGlowAnimation(withColor: UIColor.black, withEffect: .big)
        mediumBtn.backgroundColor = UIColor.white
        mediumBtn.layer.cornerRadius = 20
        mediumBtn.doGlowAnimation(withColor: UIColor.black, withEffect: .big)
        hardBtn.backgroundColor = UIColor.white
        hardBtn.layer.cornerRadius = 20
        hardBtn.doGlowAnimation(withColor: UIColor.black, withEffect: .big)
        // removes navbar bottom line
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Difficulty
    
    @IBAction func easyDifficulty(_ sender: Any) {
        trigger = true // For pushNotification
        vc.owlSound?.play()
        db.getQuestionsFromDB(difficulty: "easy")
        while true {
            if vc.getData(db: db) {
                break
            }
            sleep(1)
        }
        performSegue(withIdentifier: "difficultySegue", sender: self)
    }
    @IBAction func mediumDifficulty(_ sender: Any) {
        trigger = true // For pushNotification
        vc.owlSound?.play()
        db.getQuestionsFromDB(difficulty: "medium")
        while true {
            if vc.getData(db: db) {
                break
            }
            sleep(1)
        }
        performSegue(withIdentifier: "difficultySegue", sender: self)
    }
    @IBAction func hardDifficulty(_ sender: Any) {
        trigger = true // For pushNotification
        vc.owlSound?.play()
        db.getQuestionsFromDB(difficulty: "hard")
        while true {
            if vc.getData(db: db) {
                break
            }
            sleep(1)
        }
        performSegue(withIdentifier: "difficultySegue", sender: self)
    }

}

