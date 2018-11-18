//
//  ViewController.swift
//  Project
//
//  Created by Oscar Stenqvist on 2018-10-29.
//  Copyright © 2018 Oscar Stenqvist. All rights reserved.
//

import UIKit
import AVFoundation


let db = opentdb() //Skapar databasklassen
let imgAnimations = imageAnimation() // calls imageAnimation class and opens it

class ViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var startpageImage: UIImageView!
    @IBOutlet weak var startQuizBtn: UIButton!

    // MARK: - Owl settings
    let startOwlImage = imgAnimations.getOwlAnimation() // calls owlArray
    var owlSound: AVAudioPlayer?
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load soundfunction
        loadSound()
        
        // removes navbar bottom line
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        // hides back-button in navigationbar
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        // starts owl animation
        startpageImage.animationImages = startOwlImage
        startpageImage.animationDuration = 2.0
        startpageImage.startAnimating()
        
        // button animation
        startQuizBtn.backgroundColor = UIColor.white
        startQuizBtn.layer.cornerRadius = 20
        startQuizBtn.doGlowAnimation(withColor: UIColor.black, withEffect: .big)

        //Hämtar 10 nya frågor ascynk
        db.getQuestionsFromDB()
        //self.getData(db: db) //Kontrollerar om datan är hämtad
    }
    
    // MARK: - viewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
    }
    
    // MARK: - Data controlled
    
    // Kontrollerar om datan är redo rekursivt ascynk, kontroll varje 0.5s
    func getData(db: opentdb) -> Bool {
        if db.isQuestionsReady(){
            print("Data is ready")
            for item in db.getQestions(){
                print(item)
            }
            return true
        }
        else {
            return false
        }
    }

    // MARK: - StarQuizBtn
    
    @IBAction func startQuizBtn(_ sender: UIButton) {
        owlSound?.play() // play loaded sound on click
        while true {
            if self.getData(db: db) {
                break
            }
            sleep(1)
        }
        performSegue(withIdentifier: "questionSegue", sender: self)
        //self.getData(db: db) //Kontrollerar om datan är hämtad
    }
    
    // MARK: - Load sound
    
    // Load sound on buttonclick function in viewDidLoad
    func loadSound(){
        do{
            if let fileURL = Bundle.main.path(forResource: "owlSound", ofType: "wav"){
                owlSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            }else{
                print("no file with that name exists")
            }
        }catch let error{
            print("cant play the audio file, failed with error \(error.localizedDescription)")
        }
    }
}

