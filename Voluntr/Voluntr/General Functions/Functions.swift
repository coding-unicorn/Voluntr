//
//  Functions.swift
//  Voluntr
//
//  Created by Admin on 2/11/23.
//

import Foundation
import UIKit

func goBack(fromViewController: UIViewController) {

    fromViewController.view.window!.layer.add(dismissTransition, forKey: nil)

    fromViewController.dismiss(animated: false, completion: nil)

}





func presentScreen(fromViewController: UIViewController, toViewController: UIViewController) {

    fromViewController.modalTransitionStyle = presentTransition

    toViewController.modalPresentationStyle = .fullScreen

    fromViewController.present(toViewController, animated: true, completion: nil)

}





func setUpHeader(header: Header, titleText: String, parentView: UIView) {

    header.title.text = titleText

    

    header.translatesAutoresizingMaskIntoConstraints = false

    parentView.addSubview(header)

    NSLayoutConstraint.activate([

        header.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor),

        header.centerXAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.centerXAnchor),

        header.widthAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.widthAnchor)

    ])

}





func setUpFooter(footer: Footer, parentViewController: UIViewController, parentView: UIView) {
    footer.parentViewController = parentViewController
    footer.parentView = parentView
    footer.translatesAutoresizingMaskIntoConstraints = false
    parentView.addSubview(footer)

    NSLayoutConstraint.activate([
        footer.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
        footer.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
        footer.widthAnchor.constraint(equalTo: parentView.widthAnchor)
    ])
}





func setUpScreenView(screenView: UIView, parentViewController: UIViewController) {

    screenView.backgroundColor = backgroundColors

    screenView.translatesAutoresizingMaskIntoConstraints = false

    parentViewController.view.addSubview(screenView)

    let maxAspectRatio = CGFloat(16.0 / 9.0) // Needs to hae the decimal to be a valid CGFloat to work

    NSLayoutConstraint.activate([

        screenView.centerXAnchor.constraint(equalTo: parentViewController.view.safeAreaLayoutGuide.centerXAnchor),

        screenView.widthAnchor.constraint(equalTo: parentViewController.view.safeAreaLayoutGuide.heightAnchor, multiplier: (1.0 / maxAspectRatio)), // Needs to have the decimal to be a valid CGFloat to work

        screenView.topAnchor.constraint(equalTo: parentViewController.view.safeAreaLayoutGuide.topAnchor),

        screenView.bottomAnchor.constraint(equalTo: parentViewController.view.bottomAnchor)

    ])

}





func setUpScrolling(scrollView: UIScrollView, topAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, parentView: UIView) {

    scrollView.delegate = parentView.superview! as? UIScrollViewDelegate

    scrollView.backgroundColor = backgroundColors

    scrollView.translatesAutoresizingMaskIntoConstraints = false

    parentView.addSubview(scrollView)

    NSLayoutConstraint.activate([

        scrollView.topAnchor.constraint(equalTo: topAnchor),

        scrollView.widthAnchor.constraint(equalTo: parentView.widthAnchor),

        scrollView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)

    ])

}





func makeMessageBar(message: String, parentView: UIView) {

    let messageBarOverlay = UIView()

    messageBarOverlay.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.00)

    messageBarOverlay.layer.opacity = 0.0

    messageBarOverlay.translatesAutoresizingMaskIntoConstraints = false

    parentView.addSubview(messageBarOverlay)

    

    let messageBar = UIView()

    messageBar.backgroundColor = buttonColor

    messageBar.layer.opacity = 0.0

    messageBar.layer.borderWidth = CGFloat(buttonBorderWidth)

    messageBar.layer.borderColor = buttonBorderColor.cgColor

    messageBar.layer.cornerRadius = CGFloat(buttonCornerRadius)

    messageBar.layer.maskedCorners = buttonMaskedCorners

    messageBar.translatesAutoresizingMaskIntoConstraints = false

    parentView.addSubview(messageBar)

    

    let messageBarText = UITextView()

    messageBarText.contentInsetAdjustmentBehavior = .automatic

    messageBarText.textAlignment = NSTextAlignment.center

    messageBarText.textColor = backgroundColors

    messageBarText.font = UIFont(name: mainFont, size: CGFloat(buttonFontSize))

    messageBarText.backgroundColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.00)

    messageBarText.layer.opacity = 0.0

    messageBarText.text = message

    messageBarText.isScrollEnabled = false

    messageBarText.isEditable = false

    messageBarText.isSelectable = false

    messageBarText.translatesAutoresizingMaskIntoConstraints = false

    messageBar.addSubview(messageBarText)

    

    

    NSLayoutConstraint.activate([

        messageBarOverlay.topAnchor.constraint(equalTo: parentView.topAnchor),

        messageBarOverlay.centerXAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.centerXAnchor),

        messageBarOverlay.widthAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.widthAnchor),

        messageBarOverlay.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),

        

        messageBar.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor),

        messageBar.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),

        messageBar.widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 0.9),

        

        messageBarText.topAnchor.constraint(equalTo: messageBar.topAnchor, constant: 5),

        messageBarText.centerXAnchor.constraint(equalTo: messageBar.centerXAnchor),

        messageBarText.widthAnchor.constraint(equalTo: messageBar.widthAnchor, constant: -10),

        messageBarText.bottomAnchor.constraint(equalTo: messageBar.bottomAnchor, constant: -5),

    ])

    

    

    UIView.animate(withDuration: 0.5, animations: {

        messageBarOverlay.layer.opacity = 0.3

        messageBar.layer.opacity = 1.0

        messageBarText.layer.opacity = 1.0

    }) { (finished) in // After animation

        UIView.animate(withDuration: 1.5, animations: {

            messageBarOverlay.layer.opacity = 0.29

            messageBar.layer.opacity = 0.99

            messageBarText.layer.opacity = 0.99

        }) { (finished) in // After animation

            UIView.animate(withDuration: 0.5, animations: {

                messageBarOverlay.layer.opacity = 0.0

                messageBar.layer.opacity = 0.0

                messageBarText.layer.opacity = 0.0

            }) { (finished) in // After animation

                messageBarOverlay.removeFromSuperview()

                messageBar.removeFromSuperview()

                messageBarText.removeFromSuperview()

            }

        }

    }

}
