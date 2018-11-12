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
    
    @IBOutlet weak var scoreLabel: UILabel!
    //***********Variables:***************
    //Keeps teack on witch questionRound
    private var questionRound = 0
    private var scoreCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionRound = 0
        scoreCount = 0
        navigationBarItems()
        
        speechBubbleImage.image = UIImage(named:"speech")
        
        let owlAskImage = imgAnimations.getOwlAnimation() // calls owlArray

        owlAsker.animationImages = owlAskImage
        owlAsker.animationDuration = 2.0
        owlAsker.startAnimating()
        
        putQuestions()
        setButtonSettings()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    private func setButtonSettings() -> Void {
        // Answerbutton colors settings
        let listOfButtons = [answer1Btn, answer2Btn, answer3Btn, answer4Btn]
        for btn in listOfButtons {
            btn?.backgroundColor = UIColor.white
            btn?.titleLabel?.numberOfLines = 0
            btn?.layer.cornerRadius = (btn?.frame.width)! * 0.1
            btn?.titleLabel?.minimumScaleFactor = 0.5
            btn?.titleLabel?.adjustsFontSizeToFitWidth = true
            
        }
    }
    
    
    //Updates the questionlabel and answerbuttons with the question and answers
    private func putQuestions() -> Void {
        let listOfQuestions = db.getQestions()
        if listOfQuestions.count > 0 {
            let q1 = listOfQuestions[questionRound]
            questionLabel.text = q1.question
            var ansArr = [q1.correct_answer, q1.incorrect_answers[0], q1.incorrect_answers[1], q1.incorrect_answers[2]]
            ansArr.shuffle()
            answer1Btn.setTitle(ansArr[0], for: .normal)
            answer2Btn.setTitle(ansArr[1], for: .normal)
            answer3Btn.setTitle(ansArr[2], for: .normal)
            answer4Btn.setTitle(ansArr[3], for: .normal)
        }
    }
    
    
    private func navigationBarItems() {
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        let titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        titleImageView.contentMode = .scaleAspectFit
        
        let navImage = UIImage(named: "owl1")
        titleImageView.image = navImage
        
        navigationItem.titleView = titleImageView
    }

    
    //Code that is executet at the end of each round, no parameters no return
    private func endRound() -> Void {
        
        //Waits for 2 sec then changes question!
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            //self.questionRound += 1
            if self.questionRound > 9 {
                self.performSegue(withIdentifier: "playAgainSegue", sender: self)
            }
            else {
                self.flip()
                self.putQuestions()
                self.setButtonSettings()

            }
        }
    }
    // flips speechbubble and hides question for 1 second
    @objc func flip() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: speechBubbleImage, duration: 1.0, options: transitionOptions, animations: {
            self.questionLabel.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.questionLabel.isHidden = false
            }

        })
        
    }
    
    //Checks if the answer sent as parameter is correct, returns true if correct
    private func isAnswerCorrect(answer: String) -> Bool {
        let listOfQuestions = db.getQestions()
        let q1 = listOfQuestions[questionRound]
        if q1.correct_answer == answer { return true }
        return false
    }
    
    //Highlights the correct answer in green, no parameters no return
    func highlightCorrectAnswer() -> Void {
        let listOfButtons = [answer1Btn, answer2Btn, answer3Btn, answer4Btn]
        for btn in listOfButtons {
            if(isAnswerCorrect(answer: btn!.titleLabel!.text!))
            {
                btn!.backgroundColor = UIColor.green
            }
        }
    }
    
    func updateScore(answer: String) {
        let listOfQuestions = db.getQestions()
        let q1 = listOfQuestions[questionRound]
        if q1.correct_answer == answer {
            scoreCount += 1
        }
        questionRound += 1
        scoreLabel.text = "\(scoreCount) / \(questionRound)"
    }
    
    @IBAction func answer1Btn(_ sender: Any) {
        if(isAnswerCorrect(answer: answer1Btn.titleLabel!.text!))
        {
            answer1Btn.backgroundColor = UIColor.green
        }
        else {
            answer1Btn.backgroundColor = UIColor.red
            answer1Btn.shake()

        }
        highlightCorrectAnswer()
        updateScore(answer: answer1Btn.titleLabel!.text!)
        endRound()

    }
    
    @IBAction func answer2Btn(_ sender: Any) {
        if(isAnswerCorrect(answer: answer2Btn.titleLabel!.text!))
        {
            answer2Btn.backgroundColor = UIColor.green
        }
        else {
            answer2Btn.backgroundColor = UIColor.red
            answer2Btn.shake()
        }
        highlightCorrectAnswer()
        updateScore(answer: answer2Btn.titleLabel!.text!)
        endRound()
    }
    
    @IBAction func answer3Btn(_ sender: Any) {
        if(isAnswerCorrect(answer: answer3Btn.titleLabel!.text!))
        {
            answer3Btn.backgroundColor = UIColor.green
        }
        else {
            answer3Btn.backgroundColor = UIColor.red
            answer3Btn.shake()
        }
        highlightCorrectAnswer()
        updateScore(answer: answer3Btn.titleLabel!.text!)
        endRound()
    }
    
    @IBAction func answer4Btn(_ sender: Any) {
        if(isAnswerCorrect(answer: answer4Btn.titleLabel!.text!))
        {
            answer4Btn.backgroundColor = UIColor.green
        }
        else {
            answer4Btn.backgroundColor = UIColor.red
            answer4Btn.shake()
        }
        highlightCorrectAnswer()
        updateScore(answer: answer4Btn.titleLabel!.text!)
        endRound()
    }
}
