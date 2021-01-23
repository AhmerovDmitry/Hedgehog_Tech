//
//  JokesViewController.swift
//  Hedgehog Tech
//
//  Created by Дмитрий Ахмеров on 20.01.2021.
//

import UIKit

class JokesViewController: UIViewController {
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
        
        return tableView
    }()
    let phraseCount: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .lightGray
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        
        return textField
    }()
    let loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LOAD", for: .normal)
        button.addTarget(nil, action: #selector(fetchPhrases), for: .touchUpInside)
        button.backgroundColor = .green
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        registerForKeyboardNotification()
        setupConstraints()
    }
    
}
