//
//  ViewController.swift
//  Project
//
//  Created by Oscar Stenqvist on 2018-10-29.
//  Copyright © 2018 Oscar Stenqvist. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications

let db = opentdb() //Skapar databasklassen
let imgAnimations = imageAnimation() // calls imageAnimation class and opens it
var trigger: Bool = false // Variable for ingame pushnotification

class ViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var startpageImage: UIImageView!
    @IBOutlet weak var startQuizBtn: UIButton!
    @IBOutlet weak var difficultyBtn: UIButton!
    
    
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
        difficultyBtn.backgroundColor = UIColor.white
        difficultyBtn.layer.cornerRadius = 20
        difficultyBtn.doGlowAnimation(withColor: UIColor.black, withEffect: .big)

        //Hämtar 10 nya frågor ascynk
        //db.getQuestionsFromDB()
        //self.getData(db: db) //Kontrollerar om datan är hämtad
        
        //Observ if app loses focus
        let notificationFocus = NotificationCenter.default
        notificationFocus.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
    }
    
    // MARK: - appMovedToBackground
    //Use: If trigger == true push notification will show when app loses focus with specific message.
    @objc func appMovedToBackground(){
        
        if trigger == true {
        let content = UNMutableNotificationContent()
        content.title = "Tahoo!"
        content.subtitle = "Where are you going?"
        content.body = "Cheating is no fun..."
        content.badge = 0
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
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
        trigger = true // For pushNotification
        owlSound?.play() // play loaded sound on click
        db.getQuestionsFromDB()
        while true {
            if self.getData(db: db) {
                break
            }
            sleep(1)
        }
        performSegue(withIdentifier: "questionSegue", sender: self)
        //self.getData(db: db) //Kontrollerar om datan är hämtad
    }

    @IBAction func difficultyBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "difficultySegue", sender: self)
    }
    
    // MARK: - difficulyBtn

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

