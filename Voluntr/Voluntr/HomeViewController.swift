//
//  HomeViewController.swift
//  Voluntr
//
//  Created by Admin on 2/11/23.
//

import UIKit


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let screenView = UIView()
    let header = Header()
    let footer = Footer()
    
    var imageDispatchGroups: [DispatchGroup] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        setUpScreenView(screenView: screenView, parentViewController: self)
        setUpHeader(header: header, titleText: "my feed", parentView: screenView)
        setUpFooter(footer: footer, parentViewController: self, parentView: self.view)
        
        setUpFeedDisplay()
    }
    
    
    func setUpFeedDisplay() {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = backgroundColors
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        screenView.addSubview(tableView)
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: header.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: screenView.widthAnchor, multiplier: 0.8),
            tableView.centerXAnchor.constraint(equalTo: screenView.centerXAnchor),
            //tableView.heightAnchor.constraint(equalToConstant: CGFloat(130 * thisUserGroups.count)),
            //.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 70)
            tableView.bottomAnchor.constraint(equalTo: footer.topAnchor),
        ])
    }
    
    // Table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thisUserGroupPosts.count + 2
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
        
        
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
            container.widthAnchor.constraint(equalTo: cell.widthAnchor, constant: -20),
            container.topAnchor.constraint(equalTo: cell.topAnchor, constant: 10),
            container.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
        ])
        
        
        if indexPath.row > 1 {
            let dateLabel = UITextView()
            dateLabel.textAlignment = NSTextAlignment.left
            dateLabel.backgroundColor = backgroundColors
            dateLabel.text = thisUserGroupPosts[indexPath.row - 2]["postDate"]!
            dateLabel.textColor = textColor
            dateLabel.isUserInteractionEnabled = false
            dateLabel.isScrollEnabled = false
            dateLabel.font = UIFont(name: mainFont, size: CGFloat(textFontSize))
            dateLabel.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(dateLabel)
            
            let groupnameLabel = UITextView()
            groupnameLabel.textAlignment = NSTextAlignment.center
            groupnameLabel.backgroundColor = buttonColor
            groupnameLabel.text = thisUserGroupPosts[indexPath.row - 2]["groupname"]!
            groupnameLabel.textColor = textColor
            groupnameLabel.isUserInteractionEnabled = false
            groupnameLabel.isScrollEnabled = false
            groupnameLabel.font = UIFont(name: mainFont, size: CGFloat(titleFontSize))
            groupnameLabel.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(groupnameLabel)
            
            let descriptionTextView = UITextView()
            descriptionTextView.textAlignment = NSTextAlignment.left
            descriptionTextView.backgroundColor = backgroundColors
            descriptionTextView.text = thisUserGroupPosts[indexPath.row - 2]["text"]!
            descriptionTextView.textColor = textColor
            descriptionTextView.isUserInteractionEnabled = false
            descriptionTextView.isScrollEnabled = false
            descriptionTextView.isUserInteractionEnabled = false
            descriptionTextView.font = UIFont(name: mainFont, size: CGFloat(buttonFontSize))
            descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(descriptionTextView)
            
            
            NSLayoutConstraint.activate([
                dateLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                dateLabel.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -10),
                dateLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
                
                groupnameLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                groupnameLabel.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -10),
                
                groupnameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
                
                descriptionTextView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                descriptionTextView.widthAnchor.constraint(equalTo: groupnameLabel.widthAnchor),
                descriptionTextView.topAnchor.constraint(equalTo: groupnameLabel.bottomAnchor, constant: 10),
                descriptionTextView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            ])
            
            // Image
            /*let imageView = UIImageView()
            imageView.layer.cornerRadius = CGFloat(buttonCornerRadius);
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            let imageURLString = thisUserGroupPosts[indexPath.row - 2]["imageLink"]!
            if imageURLString != "" {
                if let imageURL = URL(string: imageURLString) {
                    let imageDispatchGroup = DispatchGroup()
                    imageDispatchGroups.append(imageDispatchGroup)
                    for e in 0..<imageDispatchGroups.count {
                        imageDispatchGroups[e].enter()
                        DispatchQueue.main.async {
                            let data = try? Data(contentsOf: imageURL) // Make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                            if data != nil {
                                imageView.image = UIImage(data: data!)
                            } else {
                                // If the app cannot convert any of the stock photos into UIImages from the URL array
                                print("Error loading image")
                            }
                            container.addSubview(imageView)
                            self.imageDispatchGroups[e].leave()
                            NSLayoutConstraint.deactivate([
                                groupnameLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
                            ])
                            NSLayoutConstraint.activate([
                                imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                                //imageView.widthAnchor.constraint(equalTo: container.widthAnchor),
                                imageView.widthAnchor.constraint(equalToConstant: 100),
                                imageView.heightAnchor.constraint(equalToConstant: 100),
                                //imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: (imageView.image?.size.height)! / (imageView.image?.size.width)!),
                                imageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
                                
                                groupnameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
                            ])
                        }
                    }
                }
            }*/
        } else { // Special cells
            if indexPath.row == 0 {
                container.backgroundColor = backgroundColors
                
                let titleLabel = UITextView()
                titleLabel.textAlignment = NSTextAlignment.center
                titleLabel.backgroundColor = backgroundColors
                titleLabel.text = "voluntr wrapped"
                titleLabel.textColor = textColor
                titleLabel.isUserInteractionEnabled = false
                titleLabel.isScrollEnabled = false
                titleLabel.font = UIFont(name: mainFont, size: CGFloat(titleFontSize))
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                container.addSubview(titleLabel)
                
                let subtitleLabel = UITextView()
                subtitleLabel.textAlignment = NSTextAlignment.center
                subtitleLabel.backgroundColor = backgroundColors
                subtitleLabel.text = "your accomplishments for the year..."
                subtitleLabel.textColor = textColor
                subtitleLabel.isUserInteractionEnabled = false
                subtitleLabel.isScrollEnabled = false
                subtitleLabel.isUserInteractionEnabled = false
                subtitleLabel.font = UIFont(name: mainFont, size: CGFloat(buttonFontSize))
                subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
                container.addSubview(subtitleLabel)
                
                let yearHoursLabel = UITextView()
                yearHoursLabel.textAlignment = NSTextAlignment.center
                yearHoursLabel.backgroundColor = backgroundColors
                yearHoursLabel.text = "\(thisUser["hoursCompleted"]!) hrs completed"
                yearHoursLabel.textColor = textColor
                yearHoursLabel.isUserInteractionEnabled = false
                yearHoursLabel.isScrollEnabled = false
                yearHoursLabel.isUserInteractionEnabled = false
                yearHoursLabel.font = UIFont(name: mainFont, size: CGFloat(buttonFontSize))
                yearHoursLabel.translatesAutoresizingMaskIntoConstraints = false
                container.addSubview(yearHoursLabel)
                
                let percentHoursLabel = UITextView()
                percentHoursLabel.textAlignment = NSTextAlignment.center
                percentHoursLabel.backgroundColor = backgroundColors
                percentHoursLabel.text = "\(round(Float(thisUser["hoursCompleted"]!)! / Float(thisUser["hoursGoal"]!)! * 100) / 100.00) % of goal reached"
                percentHoursLabel.textColor = textColor
                percentHoursLabel.isUserInteractionEnabled = false
                percentHoursLabel.isScrollEnabled = false
                percentHoursLabel.isUserInteractionEnabled = false
                percentHoursLabel.font = UIFont(name: mainFont, size: CGFloat(buttonFontSize))
                percentHoursLabel.translatesAutoresizingMaskIntoConstraints = false
                container.addSubview(percentHoursLabel)
                
                
                let affiliatedLabel = UITextView()
                affiliatedLabel.textAlignment = NSTextAlignment.center
                affiliatedLabel.backgroundColor = backgroundColors
                affiliatedLabel.text = "3 affiliated organizations"
                affiliatedLabel.textColor = textColor
                affiliatedLabel.isUserInteractionEnabled = false
                affiliatedLabel.isScrollEnabled = false
                affiliatedLabel.isUserInteractionEnabled = false
                affiliatedLabel.font = UIFont(name: mainFont, size: CGFloat(buttonFontSize))
                affiliatedLabel.translatesAutoresizingMaskIntoConstraints = false
                container.addSubview(affiliatedLabel)
                
                let topOrganizationLabel = UITextView()
                topOrganizationLabel.textAlignment = NSTextAlignment.center
                topOrganizationLabel.backgroundColor = backgroundColors
                topOrganizationLabel.text = "top voluntr organization is...\nSTEMdrive"
                topOrganizationLabel.textColor = textColor
                topOrganizationLabel.isUserInteractionEnabled = false
                topOrganizationLabel.isScrollEnabled = false
                topOrganizationLabel.isUserInteractionEnabled = false
                topOrganizationLabel.font = UIFont(name: mainFont, size: CGFloat(buttonFontSize))
                topOrganizationLabel.translatesAutoresizingMaskIntoConstraints = false
                container.addSubview(topOrganizationLabel)
                
                
                NSLayoutConstraint.activate([
                    titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                    titleLabel.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -10),
                    titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
                    
                    subtitleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                    subtitleLabel.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -10),
                    subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                    
                    yearHoursLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                    yearHoursLabel.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -10),
                    yearHoursLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
                    
                    percentHoursLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                    percentHoursLabel.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -10),
                    percentHoursLabel.topAnchor.constraint(equalTo: yearHoursLabel.bottomAnchor, constant: 10),
                    
                    affiliatedLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                    affiliatedLabel.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -10),
                    affiliatedLabel.topAnchor.constraint(equalTo: percentHoursLabel.bottomAnchor, constant: 10),
                    
                    topOrganizationLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                    topOrganizationLabel.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -10),
                    topOrganizationLabel.topAnchor.constraint(equalTo: affiliatedLabel.bottomAnchor, constant: 10),
                    
                    topOrganizationLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
                ])
            }
        }
        
        
        return cell
    }
}
