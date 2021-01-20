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
        
        return textField
    }()
    let loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LOAD", for: .normal)
        button.addTarget(nil, action: #selector(fetchPhrases), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(backgroundView)
        view.addSubview(phraseCount)
        view.addSubview(loadButton)
        view.addSubview(tableView)
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
                backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
                tableView.bottomAnchor.constraint(equalTo: phraseCount.topAnchor),
                
                phraseCount.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
                phraseCount.heightAnchor.constraint(equalToConstant: 50),
                phraseCount.leftAnchor.constraint(equalTo: view.leftAnchor),
                phraseCount.rightAnchor.constraint(equalTo: view.rightAnchor),
                
                loadButton.topAnchor.constraint(equalTo: phraseCount.bottomAnchor),
                loadButton.heightAnchor.constraint(equalTo: phraseCount.heightAnchor),
                loadButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 3),
                loadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        } else {
            // Fallback on earlier versions
        }
    }
    
}

extension JokesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = "This is cell - \(indexPath.row)"
        
        return cell
    }
    
}

@objc
extension JokesViewController {
    func fetchPhrases() {
        print("hello!")
    }
}
