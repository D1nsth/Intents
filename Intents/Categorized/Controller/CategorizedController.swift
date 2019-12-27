//
//  CategorizedController.swift
//  Intents
//
//  Created by Никита on 25.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

extension CategorizedView {
    
    @objc func refreshCategorizedTable(_ sender: Any) {
        content = []
        categorizedSentenceTable.reloadData()
        
        do {
            try CategorizedNetService.getCategorizedContent { (response) in
                DispatchQueue.main.async {
                    self.content = response.resultContent
                    
                    self.refreshControl.endRefreshing()
                    self.categorizedSentenceTable.reloadData()
                }
            }
            
        } catch {
            if let e = error as? URLError, e.code == .notConnectedToInternet {
                errorFailedToConnect()
                
            } else {
                print("ERROR")
            }
        }
    }
    
    func errorFailedToConnect() {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.3) {
            self.coverView.alpha = 0.0
        }
        
        let alertController = UIAlertController(title: "Ошибка", message: "Нет интернет соединения! Проверьте подключение к сети.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
    
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension CategorizedView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategorizedTableCell.reuseId, for: indexPath) as! CategorizedTableCell
        
        cell.configure(content[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
