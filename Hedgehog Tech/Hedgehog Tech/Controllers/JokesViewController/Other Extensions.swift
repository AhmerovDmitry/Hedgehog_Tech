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
        if Int(phraseCount) == nil || Int(phraseCount)! <= 0 || Int(phraseCount)! > 50 {
            showAlert(title: "Enter the right value",
                      message: "Value is 1 to 50")
            phraseCountTextField.text = ""
        } else {
            NetworkService().fetchJokes(processedText: phraseCount) { [weak self] (result) in
                switch result {
                case .success(let jokes):
                    self?.allJokes = jokes
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.tableView.reloadData()
                self?.view.endEditing(true)
            }
        }
    }
}

// MARK: - Setup constraints
extension JokesViewController {
    func setupConstraints() {
        [backgroundView,tableView, phraseCountTextField, loadButton].forEach({ view.addSubview($0) })
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor,
                                           constant: UIApplication.shared.statusBarFrame.height),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: phraseCountTextField.topAnchor),
            
            phraseCountTextField.bottomAnchor.constraint(equalTo: loadButton.topAnchor),
            phraseCountTextField.heightAnchor.constraint(equalToConstant: 50),
            phraseCountTextField.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
            phraseCountTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loadButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                               constant: -bottomLayoutGuide.length),
            loadButton.heightAnchor.constraint(equalTo: phraseCountTextField.heightAnchor),
            loadButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 3),
            loadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
