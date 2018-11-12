//
//  ResultPageViewController.swift
//  Project
//
//  Created by Henrik Sandwall on 2018-11-08.
//  Copyright © 2018 Oscar Stenqvist. All rights reserved.
//

import UIKit

class ResultPageViewController: UIViewController {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var playAgainBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hides back-button in navigationbar
        self.navigationItem.setHidesBackButton(true, animated:true);

        showRating()
        getFinalScore()
        
        playAgainBtn.layer.cornerRadius = 20
        
        playAgainBtn.doGlowAnimation(withColor: UIColor.black, withEffect: .big)
    }
    
    func getFinalScore() {
        let resultScore = UserDefaults.standard.integer(forKey: "userScore")
        finalScoreLabel.text = ("Final Score: \(resultScore)")
    }
    
    func showRating() {
        var rating = ""
        var textColor = UIColor.black
        let resultScore = UserDefaults.standard.integer(forKey: "userScore")
        if resultScore <= 2 {
            rating = "Poor"
            textColor = UIColor.darkGray
        }  else if resultScore <= 5 {
            rating = "Average"
            textColor = UIColor.blue
        } else if resultScore <= 8 {
            rating = "Very Good"
            textColor = UIColor.yellow
        } else if resultScore <= 10 {
            rating = "Outstanding"
            textColor = UIColor.red
        }
        ratingLabel.text = "\(rating)"
        ratingLabel.textColor = textColor
    }
}
