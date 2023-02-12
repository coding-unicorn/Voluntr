//
//  SwipeViewController.swift
//  Voluntr
//
//  Created by Admin on 2/11/23.
//

import UIKit

class SwipeViewController: UIViewController, UIScrollViewDelegate {
    let screenView = UIView()
    let createButton = UIButton(type: .system)
    
    let swipeView = UIView()
    let flashcard = Flashcard()
    //let flashcardText1 = UITextView()
    //let flashcardText2 = UITextView()
    //var currentFlashcardIndex = 0
    
    let footer = Footer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        view.backgroundColor = backgroundColors
        
        createButton.addTarget(self, action: #selector(createGroup), for: .touchUpInside) // Function that the button runs
        createButton.setTitle("Create Opportunity", for: .normal)
        createButton.setTitle("Create Opportunity", for: .selected)
        createButton.titleLabel?.font = UIFont(name: mainFont, size: CGFloat(buttonFontSize))
        createButton.setTitleColor(buttonTextColor, for: .normal)
        createButton.setTitleColor(buttonTextColor, for: .selected)
        createButton.setBackgroundColor(backgroundColors, forState: .normal)
        createButton.setBackgroundColor(backgroundColors, forState: .selected)
        createButton.layer.borderWidth = CGFloat(buttonBorderWidth)
        createButton.layer.borderColor = buttonBorderColor.cgColor
        createButton.layer.cornerRadius = CGFloat(buttonCornerRadius)
        createButton.layer.maskedCorners = buttonMaskedCorners
        createButton.translatesAutoresizingMaskIntoConstraints = false
        screenView.addSubview(createButton)
        NSLayoutConstraint.activate([
            createButton.centerXAnchor.constraint(equalTo: screenView.centerXAnchor),
            createButton.topAnchor.constraint(equalTo: screenView.topAnchor, constant: 10),
            createButton.heightAnchor.constraint(equalToConstant: 60),
            createButton.widthAnchor.constraint(equalTo: screenView.widthAnchor, multiplier: 0.5)
        ])
        
        setUpScreenView(screenView: screenView, parentViewController: self)
        setUpFooter(footer: footer, parentViewController: self, parentView: self.view)
        
        setUpSwipeView()
        setUpGestures()
        
        self.view.bringSubviewToFront(self.footer)
    }
    
    
    @objc func createGroup() {
        print("create!")
    }
    
    
    func setUpSwipeView() {
        let swipeView = UIView()
        swipeView.backgroundColor = backgroundColors
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        screenView.addSubview(swipeView)
        
        //let flipFlashcardTap = UITapGestureRecognizer(target: self, action: #selector(self.flipFlashcard))
        //flashcard.addGestureRecognizer(flipFlashcardTap)
        flashcard.currentFlashcardIndex = 0
        flashcard.groupnameTextView.text = allGroups[flashcard.currentFlashcardIndex]["groupname"]!
        if allGroups[flashcard.currentFlashcardIndex]["password"]! == "" {
            flashcard.descriptionTextView.text = "Description: \(allGroups[flashcard.currentFlashcardIndex]["description"]!)\nAge Range: \(allGroups[flashcard.currentFlashcardIndex]["ageMin"]!)-\(allGroups[flashcard.currentFlashcardIndex]["ageMax"]!)\nOpen to public\nWebsite: \(allGroups[flashcard.currentFlashcardIndex]["website"]!)"
        } else {
            flashcard.descriptionTextView.text = "Age Range: \(allGroups[flashcard.currentFlashcardIndex]["description"]!)\nAge Range: \(allGroups[flashcard.currentFlashcardIndex]["ageMin"]!)-\(allGroups[flashcard.currentFlashcardIndex]["ageMax"]!)\nPassword required to join\nWebsite: \(allGroups[flashcard.currentFlashcardIndex]["website"]!)"
        }
        flashcard.translatesAutoresizingMaskIntoConstraints = false
        swipeView.addSubview(flashcard)
        
        /*flashcardText1.textAlignment = NSTextAlignment.center
        flashcardText1.backgroundColor = backgroundColors
        flashcardText1.text = allGroups[currentFlashcardIndex]["groupname"]
        flashcardText1.textColor = textColor
        flashcardText1.isUserInteractionEnabled = false
        flashcardText1.font = UIFont(name: mainFont, size: CGFloat(titleFontSize))
        flashcardText1.translatesAutoresizingMaskIntoConstraints = false
        flashcard.addSubview(flashcardText1)
        
        flashcardText2.textAlignment = NSTextAlignment.left
        flashcardText2.backgroundColor = backgroundColors
        flashcardText2.text = allGroups[currentFlashcardIndex]["description"]
        flashcardText2.textColor = textColor
        flashcardText2.isUserInteractionEnabled = false
        flashcardText2.font = UIFont(name: mainFont, size: CGFloat(titleFontSize))
        flashcardText2.translatesAutoresizingMaskIntoConstraints = false
        flashcard.addSubview(flashcardText2)*/
        
        NSLayoutConstraint.activate([
            swipeView.widthAnchor.constraint(equalTo: screenView.widthAnchor),
            swipeView.topAnchor.constraint(equalTo: createButton.bottomAnchor),
            swipeView.bottomAnchor.constraint(equalTo: footer.topAnchor),
            swipeView.centerXAnchor.constraint(equalTo: screenView.centerXAnchor),
            
            flashcard.widthAnchor.constraint(equalTo: swipeView.widthAnchor, multiplier: 0.75),
            flashcard.heightAnchor.constraint(equalTo: swipeView.heightAnchor, multiplier: 0.75),
            flashcard.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor),
            flashcard.centerYAnchor.constraint(equalTo: swipeView.centerYAnchor),
        ])
    }
    
    /*@objc func flipFlashcard(sender: UITapGestureRecognizer) { // Tapping on the card
        if currentFlashcardWord.text == "\(database[currentFlashcardIndex][selectedLanguages[0]]!)" {
            selectedFlashcardFrontBack = selectedLanguages[1]
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                self.flashcard.transform = CGAffineTransform(scaleX: 1, y: -1)
            }, completion: nil)
            currentFlashcardWord.transform = CGAffineTransform(scaleX: 1, y: -1)
        } else if currentFlashcardWord.text == "\(database[currentFlashcardIndex][selectedLanguages[1]]!)" {
            selectedFlashcardFrontBack = selectedLanguages[0]
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                self.flashcard.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
            currentFlashcardWord.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        currentFlashcardWord.text = "\(database[currentFlashcardIndex][selectedFlashcardFrontBack]!)"
    }*/
    
    func setUpGestures() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(leftSwipe)
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
                case UISwipeGestureRecognizer.Direction.right: // Join
                    // ACTUALLY JOIN IN PHP!
                makeMessageBar(message: "You joined \(allGroups[flashcard.currentFlashcardIndex]["groupname"]!)! Go to your profile to view.", parentView: self.view)
                if flashcard.currentFlashcardIndex == 0 {
                    flashcard.currentFlashcardIndex = allGroups.count - 1
                    } else {
                        flashcard.currentFlashcardIndex = flashcard.currentFlashcardIndex - 1
                    }
                case UISwipeGestureRecognizer.Direction.left: // Skip
                if flashcard.currentFlashcardIndex == 0 {
                    flashcard.currentFlashcardIndex = allGroups.count - 1
                    } else {
                        flashcard.currentFlashcardIndex = flashcard.currentFlashcardIndex - 1
                    }
                default:
                    break
            }
        }
        
        flashcard.groupnameTextView.text = allGroups[flashcard.currentFlashcardIndex]["groupname"]
        if allGroups[flashcard.currentFlashcardIndex]["password"]! == "" {
            flashcard.descriptionTextView.text = "Description: \(allGroups[flashcard.currentFlashcardIndex]["description"]!)\nAge Range: \(allGroups[flashcard.currentFlashcardIndex]["ageMin"]!)-\(allGroups[flashcard.currentFlashcardIndex]["ageMax"]!)\nOpen to public\nWebsite: \(allGroups[flashcard.currentFlashcardIndex]["website"]!)"
        } else {
            flashcard.descriptionTextView.text = "Age Range: \(allGroups[flashcard.currentFlashcardIndex]["description"]!)\nAge Range: \(allGroups[flashcard.currentFlashcardIndex]["ageMin"]!)-\(allGroups[flashcard.currentFlashcardIndex]["ageMax"]!)\nPassword required to join\nWebsite: \(allGroups[flashcard.currentFlashcardIndex]["website"]!)"
        }
    }
}
