//
//  CustomVariables.swift
//  Voluntr
//
//  Created by Admin on 2/11/23.
//

import Foundation
import UIKit


// Colors
let textColor = UIColor.white //UIColor(red: 0.96, green: 0.77, blue: 0.76, alpha: 1.00)
let backgroundColors = UIColor.black
let buttonColor = UIColor(red: 0.96, green: 0.77, blue: 0.76, alpha: 1.00)
let buttonSelectedColor = UIColor(red: 0.96, green: 0.77, blue: 0.76, alpha: 1.00)



// Font
let mainFont = "Poppins Regular"
let titleFontSize = 36
let textFontSize = 16
let buttonFontSize = 20


// Buttons
let buttonTextColor = textColor
let buttonBorderColor = textColor
let buttonCornerRadius = 25
let buttonBorderWidth = 5
let buttonMaskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner)


// Images
let logo = UIImage(named: "Logo")
let homeButtonImage = UIImage(named: "home button")
let homeButtonImageSelected = UIImage(named: "home button selected")
let swipeButtonImage = UIImage(named: "swipe button")
let swipeButtonImageSelected = UIImage(named: "swipe button selected")
let mapButtonImage = UIImage(named: "map button")
let mapButtonImageSelected = UIImage(named: "map button selected")
let profileButtonImage = UIImage(named: "profile button")
let profileButtonImageSelected = UIImage(named: "profile button selected")
let mapPinImage = UIImage(named: "map icon")
let mapUserLocationImage = UIImage(named: "inverted map icon")



// Transitions
let presentTransition = UIModalTransitionStyle.partialCurl
let dismissTransition = CATransition().fadeTransition()


// Database
let checkPasswordURLString = "https://customapps.app/Voluntr/CheckPassword.php"
let usersURLString = "https://customapps.app/Voluntr/Users.php"
let usersGroupsURLString = "https://customapps.app/Voluntr/UsersGroups.php"
let groupsURLString = "https://customapps.app/Voluntr/Groups.php"

var thisUser: [String: String] = [:]
var thisUserGroups: [[String: String]] = []
//var allGroups: [[String: String]] = []
var allGroups: [[String: String]] = [
    [
        "groupname": "The Amity Program"
        , "password": ""
        , "website": "customapps.app"
        , "ageMin": "0"
        , "ageMax": "99"
        , "latitude": "40.7941028"
        , "longitude": "-73.969958"
        , "description": "Connects Senior Citizens with high school students"
        , "imageLink": ""
    ]
    , [
        "groupname": "STEMdrive"
        , "password": "STEM4ALL"
        , "website": "stemdrive.org"
        , "ageMin": "0"
        , "ageMax": "99"
        , "latitude": "40.7724724"
        , "longitude": "-73.945441"
        , "description": "Helping girls learn to code!"
        , "imageLink": ""
    ]
    , [
        "groupname": "All Souls"
        , "password": ""
        , "website": "customapps.app"
        , "ageMin": "0"
        , "ageMax": "99"
        , "latitude": "40.7753752"
        , "longitude": "-73.9581623"
        , "description": "Helping prepare food for people!"
        , "imageLink": "https://nfg-sofun.s3.amazonaws.com/uploads/project/photo/61060/poster_board_CF_DR_MAster.jpg"
    ]
]

var thisUserGroupPosts: [[String: String]] = [
    [
        "groupname": "The Amity Program"
        , "text": "Just volunteered with a group of hombound senior citizens the other day..."
        , "postDate": "2-10-23"
        , "imageLink": ""
    ]
    , [
        "groupname": "STEMdrive"
        , "text": "We took everyone to MoMath!"
        , "postDate": "2-11-23"
        , "imageLink": "https://stemdrive.org/Event_Images/MoMath%202017.jpg"
    ]
    , [
        "groupname": "The Brearley School"
        , "text": "Remember to complete your service requirements before March 1st!"
        , "postDate": "2-9-23"
        , "imageLink": ""
    ]
]

var errorString = ""
