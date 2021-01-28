//
//  JokesViewController.swift
//  Hedgehog Tech
//
//  Created by Дмитрий Ахмеров on 20.01.2021.
//

import UIKit

class JokesViewController: UIViewController {
    let descView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter the number of phrases"
        label.font = UIFont(name: "DurangoWestern", size: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.isHidden = false
        
        return label
    }()
    let activityIndicatorBackground: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0.5
        view.isHidden = true
        
        return view
    }()
    let revolverActivityIndicator: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "revolver")
        
        return view
    }()
    var phraseCount = String()
    var allJokes = [Joke]()
    let viewTapGesture = UITapGestureRecognizer()
    let backgroundView: UIImageView = {
        let bg = UIImageView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.image = UIImage(named: "background")
        bg.contentMode = .scaleAspectFill
        
        return bg
    }()
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.estimatedRowHeight = 10
        
        return tableView
    }()
    let phraseCountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.layer.cornerRadius = 25
        textField.addTarget(self, action: #selector(textFieldDidChangeSelection), for: .editingChanged)
        
        return textField
    }()
    let loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "DurangoWestern", size: 30)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("LOAD", for: .normal)
        button.addTarget(nil, action: #selector(fetchPhrases), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationControllerSettings()
        registerForKeyboardNotification()
        tapOnView()
    }
    // MARK: - viewDidLayoutSubviews()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupConstraints()
    }
}
