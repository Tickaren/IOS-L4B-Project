//
//  ResultPageViewController.swift
//  Project
//
//  Created by Henrik Sandwall on 2018-11-08.
//  Copyright © 2018 Oscar Stenqvist. All rights reserved.
//

import UIKit

class ResultPageViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var playAgainBtn: UIButton!
    @IBOutlet weak var theOwl: UIImageView!
    @IBOutlet weak var thinkingBubble: UIImageView!
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hides back-button in navigationbar
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        // thought-bubble
        thinkingBubble.image = UIImage(named: "thoughtbubble")
        
        // animate owl
        let owlThinking = imgAnimations.getOwlAnimation() // calls owlArray
        theOwl.animationImages = owlThinking
        theOwl.animationDuration = 2.0
        theOwl.startAnimating()
        
        // show rating and score
        showRating()
        getFinalScore()
        
        // animate play again button
        playAgainBtn.layer.cornerRadius = 20
        playAgainBtn.doGlowAnimation(withColor: UIColor.black, withEffect: .big)
    }
    
    // MARK: - Get final score
    
    func getFinalScore() {
        let resultScore =  UserDefaults.standard.integer(forKey: "userScore")
        finalScoreLabel.text = ("Final Score: \(resultScore)/10")
    }
    
    // MARK: - Show rating
    
    func showRating() {
        var rating = ""
        
        let resultScore = UserDefaults.standard.integer(forKey: "userScore")
        if resultScore <= 2 {
            rating = "WOW! Didn't this kid go to school?"
            
        }  else if resultScore <= 5 {
            rating = "So Average"
            
        } else if resultScore <= 8 {
            rating = "Impressive!"
            
        } else if resultScore <= 10 {
            rating = "Outstanding! This kid is a genius"
            
        }
        ratingLabel.text = "\(rating)"
    }
}
