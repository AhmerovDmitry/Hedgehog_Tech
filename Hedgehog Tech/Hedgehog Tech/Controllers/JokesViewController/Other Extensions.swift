//
//  Other Extensions.swift
//  Hedgehog Tech
//
//  Created by Дмитрий Ахмеров on 23.01.2021.
//

import UIKit

// MARK: - KeyboardNotification
extension JokesViewController {
    // Register keyboard notification
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // Method for show keyboard in controller
    @objc func keyboardWillShow(notification: Notification) {
        let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        UIView.animate(withDuration: 2.5, animations: {
            self.view.frame.size.height = UIScreen.main.bounds.height - (keyboardSize.height - self.tabBarController!.tabBar.bounds.height)
            self.view.layoutIfNeeded()
        })
    }
    // Method for hide keyboard in controller
    @objc func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 2.5, animations: {
            self.view.frame.size.height = UIScreen.main.bounds.height
            self.view.layoutIfNeeded()
        })
    }
}

// MARK: - @objc methods
@objc
extension JokesViewController {
    func fetchPhrases() {
        print("hello!")
        view.endEditing(true)
    }
}

// MARK: - Setup constraints
extension JokesViewController {
    func setupConstraints() {
        [backgroundView,tableView, phraseCount, loadButton].forEach({ view.addSubview($0) })
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: phraseCount.topAnchor),
            
            phraseCount.bottomAnchor.constraint(equalTo: loadButton.topAnchor),
            phraseCount.heightAnchor.constraint(equalToConstant: 50),
            phraseCount.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
            phraseCount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                               constant: -tabBarController!.tabBar.bounds.height),
            loadButton.heightAnchor.constraint(equalTo: phraseCount.heightAnchor),
            loadButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 3),
            loadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
