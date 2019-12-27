//
//  UncategorizedController.swift
//  Intents
//
//  Created by Никита on 23.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

extension UncategorizedView {
    // добавить слово
    @IBAction func addWordUncategorized(_ sender: Any) {
        print("Добавили")
        //content.append("\(content.count + 1)")
        //uncategorizedTableView.reloadData()
    }
    
    @objc func refreshUncategorizedTable(_ sender: Any) {
        content = []
        uncategorizedTableView.reloadData()
        
        UncategorizedNetService.getUncategorizedContent { (response) in
            DispatchQueue.main.async {
                self.content = response.resultContent
                
                self.refreshControl.endRefreshing()
                self.uncategorizedTableView.reloadData()
            }
        }
    }

}

// MARK: UITableViewDelegate, UITableViewDataSource
extension UncategorizedView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdCell, for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = content[indexPath.row].content
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
