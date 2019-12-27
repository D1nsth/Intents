//
//  UncategorizedView.swift
//  Intents
//
//  Created by Никита on 23.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class UncategorizedView: UIViewController {
    
    var content: [Content] = []//["Луна", "Валькирия", "Чемодан", "Рыбалка", "Дом", "Арбуз", "Умею ли я рисовать iOS макеты?"]
    
    let refreshControl = UIRefreshControl()
    let reuseIdCell = "uncategorizedCell"
    let reuseIdSegue = "addCategorySegue"
    
    @IBOutlet weak var uncategorizedTableView: UITableView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRefresh()
        
        UncategorizedNetService.getUncategorizedContent { (response) in
            self.content = response.resultContent
            self.uncategorizedTableView.reloadData()
            
            self.activityIndicator.stopAnimating()
            UIView.animate(withDuration: 0.3) {
                self.coverView.alpha = 0.0
            }
        }
    }
    
    func configureRefresh() {
        uncategorizedTableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshUncategorizedTable(_:)), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.4469921875, green: 0.657733609, blue: 0.3293619791, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh data")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == reuseIdSegue {
            if let indexPath = uncategorizedTableView.indexPathForSelectedRow {
                let test = segue.destination as! AddCategoryView
                test.content = self.content[indexPath.row]
            }
        }
    }
    
}
