//
//  SignInViewController.swift
//  Voluntr
//
//  Created by Admin on 2/11/23.
//

import UIKit
import MessageUI
import LocalAuthentication


class SignInViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, MFMailComposeViewControllerDelegate {
    let screenView = UIView()
    let header = Header()

    

    let signInButton = UIButton(type: .system)

    

    var usernameInput = UITextField()

    var passwordInput = UITextField()

    

    let overlayView = UIView()

    

    

    override func viewDidLoad() {

        super.viewDidLoad()



        // Do any additional setup after loading the view.

        view.backgroundColor = backgroundColors

        

        setUpScreenView(screenView: screenView, parentViewController: self)
        setUpHeader(header: header, titleText: "Welcome Back!", parentView: screenView)
        setUpSignIn()
    }

    

    

    func setUpSignIn() {

        let dismissKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        dismissKeyboardTap.cancelsTouchesInView = false

        self.view.addGestureRecognizer(dismissKeyboardTap)

        

        let signInView = UIView()

        signInView.backgroundColor = backgroundColors

        signInView.translatesAutoresizingMaskIntoConstraints = false

        screenView.addSubview(signInView)

        

        usernameInput = setUpTextbox(text: "Username", parentView: signInView)

        passwordInput = setUpTextbox(text: "Password", parentView: signInView)

        passwordInput.isSecureTextEntry = true

        

        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside) // Function that the button runs

        signInButton.setTitle("Sign In", for: .normal)

        signInButton.setTitle("Sign In", for: .selected)

        signInButton.titleLabel?.font = UIFont(name: mainFont, size: CGFloat(buttonFontSize))

        signInButton.setTitleColor(buttonTextColor, for: .normal)

        signInButton.setTitleColor(buttonTextColor, for: .selected)

        signInButton.setBackgroundColor(backgroundColors, forState: .normal)

        signInButton.setBackgroundColor(backgroundColors, forState: .selected)

        signInButton.layer.borderWidth = CGFloat(buttonBorderWidth)

        signInButton.layer.borderColor = buttonBorderColor.cgColor

        signInButton.layer.cornerRadius = CGFloat(buttonCornerRadius)

        signInButton.layer.maskedCorners = buttonMaskedCorners

        signInButton.translatesAutoresizingMaskIntoConstraints = false

        signInView.addSubview(signInButton)

        

        /*let contactTextView = UITextView()

        contactTextView.contentInsetAdjustmentBehavior = .automatic

        contactTextView.textAlignment = NSTextAlignment.center

        contactTextView.textColor = textColor

        contactTextView.tintColor = buttonColor

        contactTextView.font = UIFont(name: mainFont, size: 18)

        contactTextView.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.00)

        contactTextView.text = "Don't have an account? Email info@mycloth.es!"

        contactTextView.isScrollEnabled = false

        contactTextView.isEditable = false

        contactTextView.isSelectable = true

        contactTextView.isUserInteractionEnabled = true

        contactTextView.dataDetectorTypes = .link

        contactTextView.delegate = self

        contactTextView.translatesAutoresizingMaskIntoConstraints = false

        signInView.addSubview(contactTextView)*/

        

        

        

        NSLayoutConstraint.activate([

            signInView.topAnchor.constraint(equalTo: header.bottomAnchor),

            signInView.centerXAnchor.constraint(equalTo: screenView.centerXAnchor),

            signInView.widthAnchor.constraint(equalTo: screenView.widthAnchor),

            signInView.bottomAnchor.constraint(equalTo: screenView.safeAreaLayoutGuide.bottomAnchor),

            

            // Text inputs

            usernameInput.topAnchor.constraint(equalTo: signInView.topAnchor, constant: 30),

            passwordInput.topAnchor.constraint(equalTo: usernameInput.bottomAnchor, constant: 30),

            

            signInButton.centerXAnchor.constraint(equalTo: signInView.centerXAnchor),

            signInButton.widthAnchor.constraint(equalTo: signInView.widthAnchor, multiplier: 0.5),

            signInButton.heightAnchor.constraint(equalToConstant: 50),

            signInButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 30),

            

            /*contactTextView.centerXAnchor.constraint(equalTo: signInView.centerXAnchor),

            contactTextView.widthAnchor.constraint(equalTo: signInView.widthAnchor, constant: -50),

            contactTextView.bottomAnchor.constraint(equalTo: signInView.bottomAnchor)*/

        ])

    }

    func setUpTextbox(text: String, parentView: UIView) -> UITextField {

        let textInputView = UITextField()

        textInputView.textAlignment = NSTextAlignment.center

        textInputView.textColor = buttonSelectedColor

        textInputView.font = UIFont(name: mainFont, size: 22)

        textInputView.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.00)

        textInputView.text = text

        textInputView.layer.borderWidth = CGFloat(buttonBorderWidth)

        textInputView.layer.borderColor = buttonBorderColor.cgColor

        textInputView.layer.cornerRadius = CGFloat(buttonCornerRadius)

        textInputView.layer.maskedCorners = buttonMaskedCorners

        textInputView.autocorrectionType = .no

        textInputView.autocapitalizationType = .none

        textInputView.delegate = self

        textInputView.translatesAutoresizingMaskIntoConstraints = false

        parentView.addSubview(textInputView)

        

        

        NSLayoutConstraint.activate([

            textInputView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),

            textInputView.widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 0.8),

            textInputView.heightAnchor.constraint(equalToConstant: 50)

        ])

        

        

        return textInputView

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == usernameInput && passwordInput.text == "" {

            passwordInput.text = "Password"

        }

        if textField == passwordInput && usernameInput.text == "" {

            usernameInput.text = "Username"

        }

        if textField == usernameInput && textField.text == "Username" {

            textField.text = ""

        }

        if textField == passwordInput && textField.text == "Password" {

            textField.text = ""

        }

        

        changeButtonText()

    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        changeButtonText()

        

        return true

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == usernameInput && textField.text == "" {

            textField.text = "Username"

        }

        if textField == passwordInput && textField.text == "" {

            textField.text = "Password"

        }

        

        changeButtonText()

        

        textField.resignFirstResponder()

        

        return true

    }

    @objc func dismissKeyboard(sender: UIGestureRecognizer!) {

        self.view.endEditing(true) // Hides the keyboard

        

        if usernameInput.text == "" {

            usernameInput.text = "Username"

        }

        if passwordInput.text == "" {

            passwordInput.text = "Password"

        }

        

        changeButtonText()

    }

    func changeButtonText() {

        if (usernameInput.text != "") && (usernameInput.text != "Username") {

            if (passwordInput.text == "Password") {

                signInButton.setTitle("Face ID", for: .normal)

                signInButton.setTitle("Face ID", for: .selected)

            } else {

                signInButton.setTitle("Sign In", for: .normal)

                signInButton.setTitle("Sign In", for: .selected)

            }

        } else {

            signInButton.setTitle("Sign In", for: .normal)

            signInButton.setTitle("Sign In", for: .selected)

        }

    }

    @objc func signIn(sender: UIButton!) {

        let pullData = PullData()

        

        if (usernameInput.text != "") && (passwordInput.text != "") && (usernameInput.text != "Username") && (passwordInput.text != "Password") { // Check if the username and password inputs are filled in

            // Create an overlay so you don't accidentally press anything

            overlayView.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.30)

            overlayView.translatesAutoresizingMaskIntoConstraints = false

            view.addSubview(overlayView)

            NSLayoutConstraint.activate([

                overlayView.topAnchor.constraint(equalTo: self.view.topAnchor),

                overlayView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),

                overlayView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),

                overlayView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            ])

            

            

            pullData.checkPassword(username: usernameInput.text!)

            

            dispatchGroup.notify(queue: .main) {

                if self.passwordInput.text == thisUser["password"]! as? String { // Correct password

                    thisUser["username"] = self.usernameInput.text!

                    pullData.getUsersInformation(username: thisUser["username"]! as! String)

                    dispatchGroup.notify(queue: .main) {
                        print("tpying")
                        print(thisUser)
                        pullData.getUsersGroups(username: thisUser["username"]! as! String)
                        dispatchGroup.notify(queue: .main) {
                            print(thisUserGroups)
                            //pullData.getGroups(username: thisUser["username"]! as! String)
                            //dispatchGroup.notify(queue: .main) {
                            //    print(allGroups)
                                //presentScreen(fromViewController: self!, toViewController: HomeViewController())
                            //}
                            presentScreen(fromViewController: self, toViewController: HomeViewController())
                        }
                    }
                } else { // Incorrect password
                    self.overlayView.removeFromSuperview()
                    if errorString == "" { // Normal incorrect password
                        makeMessageBar(message: "Incorrect username or password. Please re-enter.", parentView: self.view)
                    } else { // Error in PHP retrival
                        makeMessageBar(message: ("\(errorString) Please try again later."), parentView: self.view)
                    }
                }
            }
        } else if (usernameInput.text != "") && (usernameInput.text != "Username") && (passwordInput.text == "Password") { // If just the username is filled in, then allow not to input the password and use Touch or Face ID instead

            let context = LAContext() // Local authentification context

            var error: NSError? = nil

            

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {

                let reason = "Please authorize with Touch or Face ID"

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in

                    DispatchQueue.main.async {

                        guard success, error == nil else {

                            self!.overlayView.removeFromSuperview()

                            makeMessageBar(message: "Touch or Face ID failed. Please sign in with your username and password.", parentView: self!.view)

                            return

                        }

                        

                        // Create an overlay so you don't accidentally press anything

                        self!.overlayView.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.30)

                        self!.overlayView.translatesAutoresizingMaskIntoConstraints = false

                        self!.view.addSubview(self!.overlayView)

                        NSLayoutConstraint.activate([

                            self!.overlayView.topAnchor.constraint(equalTo: self!.view.topAnchor),

                            self!.overlayView.centerXAnchor.constraint(equalTo: self!.view.safeAreaLayoutGuide.centerXAnchor),

                            self!.overlayView.widthAnchor.constraint(equalTo: self!.view.safeAreaLayoutGuide.widthAnchor),

                            self!.overlayView.bottomAnchor.constraint(equalTo: self!.view.bottomAnchor),

                        ])

                        

                        

                        pullData.checkPassword(username: self!.usernameInput.text!)

                        

                        dispatchGroup.notify(queue: .main) {

                            if thisUser["password"]! as! String == "" { // Either incorrect password or error in pulling data

                                self!.overlayView.removeFromSuperview()

                                

                                if errorString == "" { // Normal incorrect password

                                    makeMessageBar(message: "Incorrect username or password. Please re-enter.", parentView: self!.view)

                                } else { // Error in PHP retrival

                                    makeMessageBar(message: ("\(errorString) Please try again later."), parentView: self!.view)

                                }

                            } else { // There is a password that can be filled in with Touch or Face ID

                                thisUser["username"] = self!.usernameInput.text!

                                pullData.getUsersInformation(username: thisUser["username"]! as! String)

                                dispatchGroup.notify(queue: .main) {
                                    print("face id")
                                    print(thisUser)
                                    pullData.getUsersGroups(username: thisUser["username"]! as! String)

                                    dispatchGroup.notify(queue: .main) {
                                        print(thisUserGroups)
                                        //pullData.getGroups(username: thisUser["username"]! as! String)
                                        
                                        //dispatchGroup.notify(queue: .main) {
                                        //    print(allGroups)
                                            //presentScreen(fromViewController: self!, toViewController: HomeViewController())
                                        //}
                                        presentScreen(fromViewController: self!, toViewController: HomeViewController())
                                    }

                                }

                            }

                        }

                    }

                }

            } else { // Not able to use touch or face ID

                makeMessageBar(message: "Touch or Face ID not availible. Please sign in with your username and password.", parentView: self.view)

            }

        } else {

            overlayView.removeFromSuperview()

            makeMessageBar(message: "Please make sure you have filled in the username and password inputs.", parentView: self.view)

        }

    }

    

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

        // Open mail composer view

        if MFMailComposeViewController.canSendMail() {

            let mailComposeViewController = MFMailComposeViewController()

            mailComposeViewController.mailComposeDelegate = self

            mailComposeViewController.setToRecipients(["info@mycloth.es"])

            mailComposeViewController.setSubject("Sign up for myCloth.es")

            mailComposeViewController.setMessageBody("Type your message here...", isHTML: false)

            

            present(mailComposeViewController, animated: true, completion: nil)

        } else {

            makeMessageBar(message: "Email not set up on this device to send from", parentView: self.view)

        }

        

        

        return false // True makes the UIAlertController pop up

    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {

        controller.dismiss(animated: true, completion: nil)

    }

}
