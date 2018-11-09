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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarItems()
        
        speechBubbleImage.image = UIImage(named:"speech")
        
        let owlAskImage = imgAnimations.getOwlAnimation() // calls owlArray

        owlAsker.animationImages = owlAskImage
        owlAsker.animationDuration = 2.0
        owlAsker.startAnimating()
        
        // Answerbutton colors
        let listOfButtons = [answer1Btn, answer2Btn, answer3Btn, answer4Btn]
        for btn in listOfButtons {
            btn?.backgroundColor = UIColor.white
            btn?.titleLabel?.numberOfLines = 0
            btn?.layer.cornerRadius = (btn?.frame.width)! * 0.1

        }
//        answer1Btn.backgroundColor = UIColor.white
//        answer2Btn.backgroundColor = UIColor.white
//        answer3Btn.backgroundColor = UIColor.white
//        answer4Btn.backgroundColor = UIColor.white
//        answer1Btn.titleLabel?.numberOfLines = 0
//        answer2Btn.titleLabel?.numberOfLines = 0
//        answer3Btn.titleLabel?.numberOfLines = 0
//        answer4Btn.titleLabel?.numberOfLines = 0
        

        let listOfQuestions = db.getQestions()
        if listOfQuestions.count > 0 {
            let q1 = listOfQuestions[0]
            questionLabel.text = q1.question
            var ansArr = [q1.correct_answer, q1.incorrect_answers[0], q1.incorrect_answers[1], q1.incorrect_answers[2]]
            ansArr.shuffle()
            answer1Btn.setTitle(ansArr[0], for: .normal)
            answer2Btn.setTitle(ansArr[1], for: .normal)
            answer3Btn.setTitle(ansArr[2], for: .normal)
            answer4Btn.setTitle(ansArr[3], for: .normal)
        }
        
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.answer1Btn.layer.cornerRadius = self.answer1Btn.frame.width * 0.1
//        self.answer2Btn.layer.cornerRadius = self.answer2Btn.frame.width * 0.1
//        self.answer3Btn.layer.cornerRadius = self.answer3Btn.frame.width * 0.1
//        self.answer4Btn.layer.cornerRadius = self.answer4Btn.frame.width * 0.1
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
