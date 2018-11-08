//
//  QuestionsViewController.swift
//  Project
//
//  Created by Tompa on 2018-11-06.
//  Copyright © 2018 Oscar Stenqvist. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var speechBubbleImage: UIImageView!
    
    @IBOutlet weak var owlAsker: UIImageView!
    
    @IBOutlet weak var answer1Btn: UIButton!
    @IBOutlet weak var answer2Btn: UIButton!
    @IBOutlet weak var answer3Btn: UIButton!
    @IBOutlet weak var answer4Btn: UIButton!
    
    var owlImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarItems()
        
        speechBubbleImage.image = UIImage(named:"speech")
        
        owlImages = [
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
        owlAsker.animationImages = owlImages
        owlAsker.animationDuration = 2.0
        owlAsker.startAnimating()
        // Answerbutton colors
        answer1Btn.backgroundColor = UIColor.white
        answer2Btn.backgroundColor = UIColor.white
        answer3Btn.backgroundColor = UIColor.white
        answer4Btn.backgroundColor = UIColor.white
        
        

        let listOfQuestions = db.getQestions()
        if listOfQuestions.count > 0 {
            let q1 = listOfQuestions[0]
            questionLabel.text = q1.question
            answer1Btn.setTitle(q1.correct_answer, for: .normal)
            answer2Btn.setTitle(q1.incorrect_answers[0], for: .normal)
            answer3Btn.setTitle(q1.incorrect_answers[1], for: .normal)
            answer4Btn.setTitle(q1.incorrect_answers[2], for: .normal)
        }
        
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.answer1Btn.layer.cornerRadius = self.answer1Btn.frame.width * 0.1
        self.answer2Btn.layer.cornerRadius = self.answer2Btn.frame.width * 0.1
        self.answer3Btn.layer.cornerRadius = self.answer3Btn.frame.width * 0.1
        self.answer4Btn.layer.cornerRadius = self.answer4Btn.frame.width * 0.1
    }
    
    private func navigationBarItems() {
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        navigationController?.navigationBar.barTintColor = UIColor.BackgroundColor.pink
        
        let titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        titleImageView.contentMode = .scaleAspectFit
        
        let navImage = UIImage(named: "owl1")
        titleImageView.image = navImage
        
        navigationItem.titleView = titleImageView
    }


}
