//
//  DataSource + Delegate.swift
//  Hedgehog Tech
//
//  Created by Дмитрий Ахмеров on 23.01.2021.
//

import UIKit

// MARK: - UITableViewDelegate + DataSource
extension JokesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = "This is cell - \(indexPath.row)"
        cell.selectionStyle = .none
        
        return cell
    }
    
}