//
//  Classes.swift
//  Voluntr
//
//  Created by Admin on 2/11/23.
//

import Foundation
import UIKit


class Flashcard: UIView, UIScrollViewDelegate {
    let flashcard = UIScrollView()
    let groupnameTextView = UITextView()
    let groupImage = UIImageView()
    let descriptionTextView = UITextView()
    
    var currentFlashcardIndex = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        
        flashcard.delegate = self
        flashcard.backgroundColor = backgroundColors
        flashcard.layer.borderWidth = CGFloat(buttonBorderWidth)
        flashcard.layer.borderColor = textColor.cgColor
        flashcard.layer.cornerRadius = CGFloat(buttonCornerRadius)
        flashcard.layer.maskedCorners = buttonMaskedCorners
        flashcard.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(flashcard)
        
        groupnameTextView.textAlignment = NSTextAlignment.center
        groupnameTextView.backgroundColor = backgroundColors
        groupnameTextView.textColor = buttonColor
        groupnameTextView.isUserInteractionEnabled = false
        groupnameTextView.isScrollEnabled = false
        groupnameTextView.isUserInteractionEnabled = false
        groupnameTextView.font = UIFont(name: mainFont, size: CGFloat(titleFontSize))
        groupnameTextView.translatesAutoresizingMaskIntoConstraints = false
        flashcard.addSubview(groupnameTextView)
        
        descriptionTextView.textAlignment = NSTextAlignment.left
        descriptionTextView.backgroundColor = backgroundColors
        descriptionTextView.textColor = textColor
        descriptionTextView.isUserInteractionEnabled = false
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isUserInteractionEnabled = false
        descriptionTextView.font = UIFont(name: mainFont, size: CGFloat(buttonFontSize))
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        flashcard.addSubview(descriptionTextView)
        
        
        NSLayoutConstraint.activate([
            flashcard.leftAnchor.constraint(equalTo: self.leftAnchor),
            flashcard.rightAnchor.constraint(equalTo: self.rightAnchor),
            flashcard.topAnchor.constraint(equalTo: self.topAnchor),
            flashcard.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            groupnameTextView.widthAnchor.constraint(equalTo: flashcard.widthAnchor, constant: -10),
            groupnameTextView.centerXAnchor.constraint(equalTo: flashcard.centerXAnchor),
            groupnameTextView.topAnchor.constraint(equalTo: flashcard.topAnchor, constant: 10),
            
            descriptionTextView.widthAnchor.constraint(equalTo: groupnameTextView.widthAnchor),
            descriptionTextView.centerXAnchor.constraint(equalTo: flashcard.centerXAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: groupnameTextView.bottomAnchor, constant: 10),
            flashcard.bottomAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: -10)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class Header: UIView {

    let header = UIView()

    

    let title = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 21))

    

    

    override init(frame: CGRect) {

        super.init(frame: frame)

        

        header.backgroundColor = backgroundColors

        header.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(header)

        

        let logoView = UIImageView(image: logo!)

        logoView.translatesAutoresizingMaskIntoConstraints = false

        header.addSubview(logoView)

        

        title.font = UIFont(name: mainFont, size: 30)

        title.textColor = textColor

        title.textAlignment = .left

        title.translatesAutoresizingMaskIntoConstraints = false

        header.addSubview(title)

        

        

        NSLayoutConstraint.activate([

            header.leftAnchor.constraint(equalTo: self.leftAnchor),

            header.rightAnchor.constraint(equalTo: self.rightAnchor),

            header.topAnchor.constraint(equalTo: self.topAnchor),

            header.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            

            logoView.topAnchor.constraint(equalTo: header.topAnchor, constant: 20),

            logoView.centerXAnchor.constraint(equalTo: header.centerXAnchor),

            logoView.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.8),

            logoView.heightAnchor.constraint(equalTo: logoView.widthAnchor, multiplier: (logoView.image?.size.height)! / (logoView.image?.size.width)!),

            

            title.topAnchor.constraint(equalTo: logoView.bottomAnchor),

            title.widthAnchor.constraint(equalTo: header.widthAnchor, constant: -50),

            title.centerXAnchor.constraint(equalTo: header.centerXAnchor),

            title.bottomAnchor.constraint(equalTo: header.bottomAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class Footer: UIView {
    let footer = UIView()
    var parentViewController = UIViewController()
    var parentView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        footer.backgroundColor = backgroundColors
        footer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(footer)
        
        let leftButtons = UIView()
        leftButtons.backgroundColor = backgroundColors
        leftButtons.translatesAutoresizingMaskIntoConstraints = false
        footer.addSubview(leftButtons)
        
        let homeButton = UIButton(type: .system)
        homeButton.addTarget(self, action: #selector(goHome), for: .touchUpInside)
        homeButton.setImage(homeButtonImage, for: .normal)
        homeButton.setImage(homeButtonImageSelected, for: .selected)
        homeButton.tintColor = buttonColor
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        leftButtons.addSubview(homeButton)
        
        let swipeButton = UIButton(type: .system)
        swipeButton.addTarget(self, action: #selector(goSwipe), for: .touchUpInside)
        swipeButton.setImage(swipeButtonImage, for: .normal)
        swipeButton.setImage(swipeButtonImageSelected, for: .selected)
        swipeButton.tintColor = buttonColor
        swipeButton.translatesAutoresizingMaskIntoConstraints = false
        leftButtons.addSubview(swipeButton)
        
        let rightButtons = UIView()
        rightButtons.backgroundColor = backgroundColors
        rightButtons.translatesAutoresizingMaskIntoConstraints = false
        footer.addSubview(rightButtons)
        
        let mapButton = UIButton(type: .system)
        mapButton.addTarget(self, action: #selector(goMap), for: .touchUpInside)
        mapButton.setImage(mapButtonImage, for: .normal)
        mapButton.setImage(mapButtonImageSelected, for: .selected)
        mapButton.tintColor = buttonColor
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        rightButtons.addSubview(mapButton)
        
        let profileButton = UIButton(type: .system)
        profileButton.addTarget(self, action: #selector(goProfile), for: .touchUpInside)
        profileButton.setImage(profileButtonImage, for: .normal)
        profileButton.setImage(profileButtonImageSelected, for: .selected)
        profileButton.tintColor = buttonColor
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        rightButtons.addSubview(profileButton)
        

        NSLayoutConstraint.activate([
            footer.leftAnchor.constraint(equalTo: self.leftAnchor),
            footer.rightAnchor.constraint(equalTo: self.rightAnchor),
            footer.topAnchor.constraint(equalTo: self.topAnchor),
            footer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            leftButtons.topAnchor.constraint(equalTo: footer.topAnchor, constant: 10),
            leftButtons.bottomAnchor.constraint(equalTo: footer.bottomAnchor, constant: -10),
            leftButtons.leftAnchor.constraint(equalTo: footer.leftAnchor, constant: 10),
            leftButtons.rightAnchor.constraint(equalTo: footer.centerXAnchor, constant: -10),
            leftButtons.heightAnchor.constraint(equalToConstant: 75),
            
            homeButton.topAnchor.constraint(equalTo: leftButtons.topAnchor),
            homeButton.bottomAnchor.constraint(equalTo: leftButtons.bottomAnchor),
            homeButton.leftAnchor.constraint(equalTo: leftButtons.leftAnchor),
            homeButton.widthAnchor.constraint(equalTo: leftButtons.heightAnchor),
            
            swipeButton.topAnchor.constraint(equalTo: leftButtons.topAnchor),
            swipeButton.bottomAnchor.constraint(equalTo: leftButtons.bottomAnchor),
            swipeButton.rightAnchor.constraint(equalTo: leftButtons.rightAnchor),
            swipeButton.widthAnchor.constraint(equalTo: leftButtons.heightAnchor),
            
            rightButtons.topAnchor.constraint(equalTo: leftButtons.topAnchor),
            rightButtons.bottomAnchor.constraint(equalTo: leftButtons.bottomAnchor),
            rightButtons.leftAnchor.constraint(equalTo: footer.centerXAnchor, constant: 10),
            rightButtons.rightAnchor.constraint(equalTo: footer.rightAnchor, constant: -10),
            rightButtons.heightAnchor.constraint(equalTo: leftButtons.heightAnchor),
            
            mapButton.topAnchor.constraint(equalTo: rightButtons.topAnchor),
            mapButton.bottomAnchor.constraint(equalTo: rightButtons.bottomAnchor),
            mapButton.leftAnchor.constraint(equalTo: rightButtons.leftAnchor),
            mapButton.widthAnchor.constraint(equalTo: rightButtons.heightAnchor),
            
            profileButton.topAnchor.constraint(equalTo: rightButtons.topAnchor),
            profileButton.bottomAnchor.constraint(equalTo: rightButtons.bottomAnchor),
            profileButton.rightAnchor.constraint(equalTo: rightButtons.rightAnchor),
            profileButton.widthAnchor.constraint(equalTo: rightButtons.heightAnchor),
        ])
    }
    
    @objc func goHome() {
        presentScreen(fromViewController: parentViewController, toViewController: HomeViewController())
    }
    @objc func goSwipe() {
        presentScreen(fromViewController: parentViewController, toViewController: SwipeViewController())
    }
    @objc func goMap() {
        presentScreen(fromViewController: parentViewController, toViewController: MapViewController())
    }
    @objc func goProfile() {
        presentScreen(fromViewController: parentViewController, toViewController: ProfileViewController())
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
