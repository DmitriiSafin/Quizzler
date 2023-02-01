//
//  ViewController.swift
//  Quizzler
//
//  Created by Дмитрий on 31.01.2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
        
    let stack = UIStackView()
    
    lazy var labelScore: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 10).isActive = true
        label.text = "Score: 0"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    lazy var labelText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Question Text"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var buttonTrue: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.layer.cornerRadius = 16
        button.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        button.setTitle("True", for: .normal)
        
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(answerButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var buttonFalse: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 80).isActive = true
        button.layer.cornerRadius = 16
        button.setBackgroundImage(UIImage(named: "Rectangle"), for: .normal)
        button.setTitle("False", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(answerButtonPressed), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var progressBar: UIProgressView = {
        let progress = UIProgressView()
        progress.progress = quizBrain.getProgress()
        progress.progressTintColor = .red
        progress.trackTintColor = .white
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.heightAnchor.constraint(equalToConstant: 5).isActive = true
        return progress
    }()
    
    var timer = Timer()
    var quizBrain = QuizBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2283495665, green: 0.3638430834, blue: 0.6011071801, alpha: 1)
        view.addSubview(stack)
        setupConstraints()
        updateUI()
    }

    @objc func answerButtonPressed(_ sender: UIButton) {
        
        guard let userAnswer = sender.currentTitle else { return }
        let userGotItRight = quizBrain.checkAnswer(userAnswer)
        
        if userGotItRight {
            sender.backgroundColor = UIColor.green
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        if quizBrain.questionNumber + 1 < quizBrain.quiz.count {
            quizBrain.questionNumber += 1
            progressBar.progress += quizBrain.getProgress()
        } else {
            quizBrain.questionNumber = 0
            progressBar.progress = quizBrain.getProgress()
            quizBrain.score = 0
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    @objc func updateUI() {
        labelText.text = quizBrain.getQuestionText()
        labelScore.text = "Score: \(quizBrain.getScore())"
        self.buttonTrue.backgroundColor = UIColor.clear
        self.buttonFalse.backgroundColor = UIColor.clear
    }
}

extension ViewController {
    func setupConstraints() {
        let bubbles = UIImage(named: "Bubbles")
        let bubblesView = UIImageView(image: bubbles)
        bubblesView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bubblesView)
        
        stack.axis = .vertical
        stack.spacing = 15
        stack.alignment = .fill
        stack.contentMode = .scaleToFill
        stack.addArrangedSubview(labelScore)
        stack.addArrangedSubview(labelText)
        stack.addArrangedSubview(buttonTrue)
        stack.addArrangedSubview(buttonFalse)
        stack.addArrangedSubview(progressBar)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            stack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(
                equalToSystemSpacingBelow: stack.bottomAnchor,
                multiplier: 2),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(
                equalToSystemSpacingAfter: stack.trailingAnchor,
                multiplier: 2),
            
            bubblesView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 1),
            bubblesView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            bubblesView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 1),
        ])
    }
}

struct ViewControllerPresentable_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPresentable()
            .ignoresSafeArea()
    }
}
