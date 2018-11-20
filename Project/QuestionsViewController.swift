//
//  QuestionsViewController.swift
//  Project
//
//  Created by Tompa on 2018-11-06.
//  Copyright © 2018 Oscar Stenqvist. All rights reserved.
//

import UIKit
//import AVFoundation


class QuestionsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var speechBubbleImage: UIImageView!
    @IBOutlet weak var owlAsker: UIImageView!
    @IBOutlet weak var answer1Btn: UIButton!
    @IBOutlet weak var answer2Btn: UIButton!
    @IBOutlet weak var answer3Btn: UIButton!
    @IBOutlet weak var answer4Btn: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Variables

    var questionRound = 0
    var scoreCount = 0
    var timer = Timer()
    var seconds = 10
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation bar
        navigationBarItems()
        
        // timer
        timerLabel.text = ("Time left: \(seconds)")
        
        // speech-bubble
        speechBubbleImage.image = UIImage(named:"speech")
        
        // animate owl
        let owlAskImage = imgAnimations.getOwlAnimation() // calls owlArray
        owlAsker.animationImages = owlAskImage
        owlAsker.animationDuration = 2.0
        owlAsker.startAnimating()
        
        // start round
        putQuestions()
        setButtonSettings()
        timerCountdown()
    }
    
    // MARK: - viewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Put question and answers
    
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
    
    // MARK: - Button settings
    
    private func setButtonSettings() -> Void {
        // Answerbutton colors settings
        let listOfButtons = [answer1Btn, answer2Btn, answer3Btn, answer4Btn]
        for btn in listOfButtons {
            btn?.backgroundColor = UIColor.white
            btn?.titleLabel?.numberOfLines = 0
            btn?.layer.cornerRadius = (btn?.frame.width)! * 0.1
            btn?.titleLabel?.minimumScaleFactor = 0.5
            btn?.titleLabel?.adjustsFontSizeToFitWidth = true
            btn?.isExclusiveTouch = true //onley one button should be pressed!
            
        }
    }
    
    func disableButtons() {
        self.answer1Btn.isEnabled = false
        self.answer2Btn.isEnabled = false
        self.answer3Btn.isEnabled = false
        self.answer4Btn.isEnabled = false
    }
    
    func enableButtons() {
        self.answer1Btn.isEnabled = true
        self.answer2Btn.isEnabled = true
        self.answer3Btn.isEnabled = true
        self.answer4Btn.isEnabled = true
    }
    
    // MARK: - Update buttons
    
    //Highlights the correct answer in green, no parameters no return
    func highlightCorrectAnswer() -> Void {
        let listOfButtons = [answer1Btn, answer2Btn, answer3Btn, answer4Btn]
        for btn in listOfButtons {
            if(isAnswerCorrect(answer: btn!.titleLabel!.text!))
            {
                btn!.backgroundColor = UIColor.green
                disableButtons()
                timer.invalidate()
            }
        }
    }
    
    @IBAction func answer1Btn(_ sender: Any) {
        if(isAnswerCorrect(answer: answer1Btn.titleLabel!.text!))
        {
            answer1Btn.backgroundColor = UIColor.green
        }
        else {
            answer1Btn.backgroundColor = UIColor.red
            answer1Btn.shake()
            UIDevice.vibrate()
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
            UIDevice.vibrate()
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
            UIDevice.vibrate()
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
            UIDevice.vibrate()
        }
        highlightCorrectAnswer()
        updateScore(answer: answer4Btn.titleLabel!.text!)
        endRound()
    }
    
    // MARK: - Timer
    
    func timerCountdown() {
        seconds = 10
        timerLabel.text = "Time Left: \(String(seconds))"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(QuestionsViewController.counter), userInfo: nil, repeats: true)
    }
    
    @objc func counter() {
        seconds -= 1
        timerLabel.text = "Time Left: \(String(seconds))"
        
        if seconds == 0 {
            timerLabel.text = "TIMES UP!"
            timer.invalidate()
            disableButtons()
            highlightCorrectAnswer()
            endRound()
            questionRound += 1
            scoreLabel.text = "\(scoreCount) / \(questionRound)"
        }
    }
    
    // MARK: - Navigation bar
    
    private func navigationBarItems() {
        self.navigationItem.setHidesBackButton(true, animated:true);
        
        let titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        titleImageView.contentMode = .scaleAspectFit
        
        let navImage = UIImage(named: "owl1")
        titleImageView.image = navImage
        
        navigationItem.titleView = titleImageView
    }

    // MARK: - End round
    
    //Code that is executed at the end of each round, no parameters no return
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
                self.enableButtons()
                self.timerCountdown()
            }
        }
    }

    // MARK: - Animate question
    
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
    
    // MARK: - Control of answer
    
    //Checks if the answer sent as parameter is correct, returns true if correct
    private func isAnswerCorrect(answer: String) -> Bool {
        let listOfQuestions = db.getQestions()
        let q1 = listOfQuestions[questionRound]
        if q1.correct_answer == answer { return true }
        return false
    }
    
    // MARK: - Update the score
    
    func updateScore(answer: String) {
        let listOfQuestions = db.getQestions()
        let q1 = listOfQuestions[questionRound]
        if q1.correct_answer == answer {
            scoreCount += 1
        }
        questionRound += 1
        scoreLabel.text = "\(scoreCount) / \(questionRound)"
        UserDefaults.standard.set(scoreCount, forKey: "userScore")
    }
    
}
