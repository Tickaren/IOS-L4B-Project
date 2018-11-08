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

class ViewController: UIViewController {

    @IBOutlet weak var startpageImage: UIImageView!
    
    @IBOutlet weak var startQuizBtn: UIButton!
    var images: [UIImage] = []
    var owlSound: AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSound() // load soundfunction
        
        navigationController?.navigationBar.barTintColor = UIColor.BackgroundColor.pink
        
        images = [
            UIImage(named: "owl1"),
            UIImage(named: "owl2"),
            UIImage(named: "owl3"),
            UIImage(named: "owl4"),
            UIImage(named: "owl5"),
            UIImage(named: "owl6"),
            UIImage(named: "owl7"),
            UIImage(named: "owl8"),
            UIImage(named: "owl9"),
            UIImage(named: "owl10"),
            UIImage(named: "owl11"),
            UIImage(named: "owl12"),
            UIImage(named: "owl13"),
            UIImage(named: "owl14"),
            UIImage(named: "owl16"),
            UIImage(named: "owl17"),
            UIImage(named: "owl18"),
            UIImage(named: "owl19"),
            UIImage(named: "owl20"),
            UIImage(named: "owl21"),
            UIImage(named: "owl22"),
            UIImage(named: "owl23")
            ] as! [UIImage]
        startpageImage.animationImages = images
        startpageImage.animationDuration = 2.0
        startpageImage.startAnimating()
        startQuizBtn.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        

        //***************EXEMPELKOD:************************
        //Exempel på hur man skulle kunna hämta datan
        db.getQuestionsFromDB() //Hämtar 10 nya frågor ascynk
        //self.getData(db: db) //Kontrollerar om datan är hämtad
        //***************EXEMPELKOD SLUT:*******************
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startQuizBtn.layer.cornerRadius = self.startQuizBtn.frame.width * 0.1
    }
    
    //**************EXEMPELFUNKTION******************
    //Kontrollerar om datan är redo rekursivt ascynk, kontroll varje 0.5s
    func getData(db: opentdb) -> Bool {
        if db.isQuestionsReady(){
            print("Data is ready")
            for item in db.getQestions(){
                print(item)
            }
            return true
//            print(db.getQestions()[0])
        }
        else {
            return false
        }
    }
    //***************EXEMPELFUNKTION SLUT:***********


    @IBAction func startQuizBtn(_ sender: UIButton) {
        owlSound?.play() // play loaded sound on click
        while true {
            if self.getData(db: db) {
                break
            }
            sleep(1)
        }
        performSegue(withIdentifier: "questionSegue", sender: self)
        //performSegue(withIdentifier: "questionSegue", sender: self)
        //self.getData(db: db) //Kontrollerar om datan är hämtad

    }
    
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

