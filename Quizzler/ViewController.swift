//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var currentQuestionIndex: Int = 0
    var pickedAnswer: Bool = false
    var score : Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       updateUI()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        nextQuestion()
    }
    
    
    func updateUI() {
      
        let currentQuestion = allQuestions.list[currentQuestionIndex]
        questionLabel.text = currentQuestion.questionText
        // update score and progress bar
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(currentQuestionIndex + 1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(currentQuestionIndex + 1)
    }
    

    func nextQuestion() {
        if currentQuestionIndex == 12 {
            let alert = UIAlertController(title: "Start Over?", message: "You've finished the quiz with score \(score)! Do you want to do it again?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        } else {
            currentQuestionIndex += 1
            updateUI()
        }
        
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[currentQuestionIndex].answer
        if pickedAnswer == correctAnswer {
            ProgressHUD.showSuccess("Correct!")
            score += 1
        } else {
            ProgressHUD.showError("Wrong!") 
        }
    }
    
    
    func startOver() {
        currentQuestionIndex = 0
        score = 0
        updateUI()
    }
    

    
}
