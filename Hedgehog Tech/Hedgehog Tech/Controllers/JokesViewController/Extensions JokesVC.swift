//
//  Extensions JokesVC.swift
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
            self.view.frame.size.height = (UIScreen.main.bounds.height - keyboardSize.height) + self.tabBarController!.tabBar.bounds.height
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
        descView.isHidden = true
        if Int(phraseCount) == nil || Int(phraseCount)! <= 0 || Int(phraseCount)! > 50 || phraseCount.first == "0" {
            view.endEditing(true)
            showAlert(title: "Enter the right value",
                      message: "Value is 1 to 50")
            phraseCountTextField.text = ""
        } else {
            showRevolver()
            NetworkService().fetchJokes(processedText: phraseCount) { [weak self] (result) in
                switch result {
                case .success(let jokes):
                    self?.allJokes = jokes
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.activityIndicatorBackground.isHidden = true
                self?.tableView.reloadData()
                self?.view.endEditing(true)
                self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
}

// MARK: - Setup constraints
extension JokesViewController {
    func setupConstraints() {
        [backgroundView,
         descView,
         tableView,
         phraseCountTextField,
         loadButton,
         activityIndicatorBackground].forEach({ view.addSubview($0) })
        activityIndicatorBackground.addSubview(revolverActivityIndicator)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor,
                                           constant: topLayoutGuide.length),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: phraseCountTextField.topAnchor),
            
            descView.bottomAnchor.constraint(equalTo: phraseCountTextField.topAnchor),
            descView.heightAnchor.constraint(equalTo: phraseCountTextField.heightAnchor),
            descView.widthAnchor.constraint(equalTo: view.widthAnchor),
            descView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            phraseCountTextField.bottomAnchor.constraint(equalTo: loadButton.topAnchor),
            phraseCountTextField.heightAnchor.constraint(equalToConstant: 50),
            phraseCountTextField.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
            phraseCountTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            loadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                               constant: -tabBarController!.tabBar.bounds.height),
            loadButton.heightAnchor.constraint(equalTo: phraseCountTextField.heightAnchor),
            loadButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 3),
            loadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            activityIndicatorBackground.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicatorBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicatorBackground.leftAnchor.constraint(equalTo: view.leftAnchor),
            activityIndicatorBackground.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            revolverActivityIndicator.heightAnchor.constraint(equalToConstant: 100),
            revolverActivityIndicator.widthAnchor.constraint(equalToConstant: 100),
            revolverActivityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorBackground.centerYAnchor),
            revolverActivityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorBackground.centerXAnchor),
        ])
    }
}

// MARK: - Method for hiding keyboard by taping view 
extension JokesViewController {
    func tapOnView() {
        viewTapGesture.addTarget(self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(viewTapGesture)
    }
    @objc func hideKeyboard() -> Void {
        view.endEditing(true)
    }
}

// MARK: - TextField Method
@objc
extension JokesViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        phraseCount = text
    }
}

//MARK: - UIAlertController
extension JokesViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UINavigationController Setting
extension JokesViewController {
    func navigationControllerSettings() {
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Activity Indicator Animation
extension JokesViewController {
    func showRevolver() {
        activityIndicatorBackground.isHidden = false
        
        if self.revolverActivityIndicator.layer.animation(forKey: "kRotationAnimationKey") == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float(Double.pi * 2.0)
            rotationAnimation.duration = 2.5
            rotationAnimation.repeatCount = Float.infinity
            self.revolverActivityIndicator.layer.add(rotationAnimation, forKey: "kRotationAnimationKey")
        }
    }
}
