//
//  ProfileViewController.swift
//  Voluntr
//
//  Created by Admin on 2/11/23.
//

import UIKit


class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let screenView = UIView()
    let header = Header()
    let scrollView = UIScrollView()
    let footer = Footer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        setUpScreenView(screenView: screenView, parentViewController: self)
        setUpHeader(header: header, titleText: "my profile", parentView: screenView)
        setUpScrolling(scrollView: scrollView, topAnchor: header.bottomAnchor, parentView: screenView)
        setUpFooter(footer: footer, parentViewController: self, parentView: self.view)
        
        setUpProfile()
        
        self.view.bringSubviewToFront(self.footer)
    }
    
    
    func setUpProfile() {
        // Goals
        let goalText1 = UITextView()
        goalText1.textAlignment = NSTextAlignment.center
        goalText1.backgroundColor = backgroundColors
        goalText1.text = "Goal"
        goalText1.textColor = buttonColor
        goalText1.isUserInteractionEnabled = false
        goalText1.font = UIFont(name: mainFont, size: CGFloat(titleFontSize))
        goalText1.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(goalText1)
        
        let goalText2 = UITextView()
        goalText2.textAlignment = NSTextAlignment.center
        goalText2.backgroundColor = backgroundColors
        goalText2.text = "\(thisUser["hoursGoal"]!) hrs"
        goalText2.textColor = textColor
        goalText2.isUserInteractionEnabled = false
        goalText2.font = UIFont(name: mainFont, size: CGFloat(titleFontSize))
        goalText2.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(goalText2)
        
        let setGoalButton = UIButton(type: .system)
        setGoalButton.addTarget(self, action: #selector(setGoal), for: .touchUpInside)
        setGoalButton.setTitle("Set Goal", for: .normal)
        setGoalButton.setTitle("Set Goal", for: .selected)
        setGoalButton.titleLabel?.font = UIFont(name: mainFont, size: CGFloat(buttonFontSize))
        setGoalButton.setTitleColor(buttonTextColor, for: .normal)
        setGoalButton.setTitleColor(buttonTextColor, for: .selected)
        setGoalButton.setBackgroundColor(backgroundColors, forState: .normal)
        setGoalButton.setBackgroundColor(backgroundColors, forState: .selected)
        setGoalButton.layer.borderWidth = CGFloat(buttonBorderWidth)
        setGoalButton.layer.borderColor = buttonBorderColor.cgColor
        setGoalButton.layer.cornerRadius = CGFloat(buttonCornerRadius)
        setGoalButton.layer.maskedCorners = buttonMaskedCorners
        setGoalButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(setGoalButton)
        
        // Hours completed
        let completedText1 = UITextView()
        completedText1.textAlignment = NSTextAlignment.center
        completedText1.backgroundColor = backgroundColors
        completedText1.text = "Total Hrs Completed"
        completedText1.textColor = buttonColor
        completedText1.isUserInteractionEnabled = false
        completedText1.font = UIFont(name: mainFont, size: CGFloat(titleFontSize))
        completedText1.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(completedText1)
        
        let completedText2 = UITextView()
        completedText2.textAlignment = NSTextAlignment.center
        completedText2.backgroundColor = backgroundColors
        completedText2.text = "\(thisUser["hoursCompleted"]!) hrs"
        completedText2.textColor = textColor
        completedText2.isUserInteractionEnabled = false
        completedText2.font = UIFont(name: mainFont, size: CGFloat(titleFontSize))
        completedText2.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(completedText2)
        
        // All groups
        let groupsText = UITextView()
        groupsText.textAlignment = NSTextAlignment.center
        groupsText.backgroundColor = backgroundColors
        groupsText.text = "Hours Breakdown"
        groupsText.textColor = buttonColor
        groupsText.isUserInteractionEnabled = false
        groupsText.font = UIFont(name: mainFont, size: CGFloat(titleFontSize))
        groupsText.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(groupsText)
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = backgroundColors
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            goalText1.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            goalText1.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8),
            goalText1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            goalText1.heightAnchor.constraint(equalToConstant: 50),
            
            goalText2.topAnchor.constraint(equalTo: goalText1.bottomAnchor),
            goalText2.widthAnchor.constraint(equalTo: goalText1.widthAnchor),
            goalText2.centerXAnchor.constraint(equalTo: goalText1.centerXAnchor),
            goalText2.heightAnchor.constraint(equalToConstant: 50),
            
            setGoalButton.topAnchor.constraint(equalTo: goalText2.bottomAnchor, constant: 10),
            setGoalButton.widthAnchor.constraint(equalTo: goalText1.widthAnchor, multiplier: 0.5),
            setGoalButton.centerXAnchor.constraint(equalTo: goalText1.centerXAnchor),
            setGoalButton.heightAnchor.constraint(equalToConstant: 60),
            
            completedText1.topAnchor.constraint(equalTo: setGoalButton.bottomAnchor, constant: 20),
            completedText1.widthAnchor.constraint(equalTo: goalText1.widthAnchor),
            completedText1.centerXAnchor.constraint(equalTo: goalText1.centerXAnchor),
            completedText1.heightAnchor.constraint(equalToConstant: 50),
            
            completedText2.topAnchor.constraint(equalTo: completedText1.bottomAnchor),
            completedText2.widthAnchor.constraint(equalTo: goalText1.widthAnchor),
            completedText2.centerXAnchor.constraint(equalTo: goalText1.centerXAnchor),
            completedText2.heightAnchor.constraint(equalToConstant: 50),
            
            groupsText.topAnchor.constraint(equalTo: completedText2.bottomAnchor, constant: 20),
            groupsText.widthAnchor.constraint(equalTo: goalText1.widthAnchor),
            groupsText.centerXAnchor.constraint(equalTo: goalText1.centerXAnchor),
            groupsText.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: groupsText.bottomAnchor, constant: 5),
            tableView.widthAnchor.constraint(equalTo: goalText1.widthAnchor),
            tableView.centerXAnchor.constraint(equalTo: goalText1.centerXAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(130 * thisUserGroups.count)),
            scrollView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 70)
        ])
    }
    
    @objc func setGoal() {
        print("set goal")
    }
    
    
    // Table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thisUserGroups.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none // Not letting the user to be able to select the cell
        cell.backgroundColor = backgroundColors
        
        let container = UIView()
        container.backgroundColor = buttonColor
        container.layer.borderWidth = CGFloat(buttonBorderWidth)
        container.layer.borderColor = textColor.cgColor
        container.layer.cornerRadius = CGFloat(buttonCornerRadius)
        container.layer.maskedCorners = buttonMaskedCorners
        container.translatesAutoresizingMaskIntoConstraints = false
        cell.addSubview(container)
        
        let groupnameLabel = UITextView()
        groupnameLabel.textAlignment = NSTextAlignment.center
        groupnameLabel.backgroundColor = buttonColor
        groupnameLabel.text = thisUserGroups[indexPath.row]["groupname"]!
        groupnameLabel.textColor = textColor
        groupnameLabel.isUserInteractionEnabled = false
        groupnameLabel.isScrollEnabled = false
        groupnameLabel.font = UIFont(name: mainFont, size: CGFloat(titleFontSize))
        groupnameLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(groupnameLabel)
        
        let dateLabel = UITextView()
        dateLabel.textAlignment = NSTextAlignment.center
        dateLabel.backgroundColor = buttonColor
        dateLabel.text = thisUserGroups[indexPath.row]["volunteerdate"]!
        dateLabel.textColor = textColor
        dateLabel.isUserInteractionEnabled = false
        dateLabel.font = UIFont(name: mainFont, size: CGFloat(buttonFontSize))
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(dateLabel)
        
        let durationLabel = UITextView()
        durationLabel.textAlignment = NSTextAlignment.center
        durationLabel.backgroundColor = buttonColor
        durationLabel.text = thisUserGroups[indexPath.row]["duration"]!
        durationLabel.textColor = textColor
        durationLabel.isUserInteractionEnabled = false
        durationLabel.font = UIFont(name: mainFont, size: CGFloat(buttonFontSize))
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(durationLabel)
        
        
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
            container.widthAnchor.constraint(equalTo: cell.widthAnchor, constant: -20),
            container.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10),
            container.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            
            groupnameLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            groupnameLabel.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -10),
            groupnameLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            
            dateLabel.leftAnchor.constraint(equalTo: groupnameLabel.leftAnchor),
            dateLabel.rightAnchor.constraint(equalTo: container.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 50),
            dateLabel.topAnchor.constraint(equalTo: groupnameLabel.bottomAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            
            durationLabel.rightAnchor.constraint(equalTo: groupnameLabel.rightAnchor),
            durationLabel.leftAnchor.constraint(equalTo: container.centerXAnchor),
            durationLabel.heightAnchor.constraint(equalToConstant: 50),
            durationLabel.topAnchor.constraint(equalTo: groupnameLabel.bottomAnchor),
            durationLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
        ])
        
        return cell
    }
}
