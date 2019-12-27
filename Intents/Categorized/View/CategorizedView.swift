//
//  CategorizedView.swift
//  Intents
//
//  Created by Никита on 23.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class CategorizedView: UIViewController {
    
    let refreshControl = UIRefreshControl()
    
    var content: [Content] = []
    
    @IBOutlet weak var categorizedSentenceTable: UITableView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureRefreshAndTable()
        
        do {
            try CategorizedNetService.getCategorizedContent { (response) in
                self.content = response.resultContent
                self.categorizedSentenceTable.reloadData()
                
                self.activityIndicator.stopAnimating()
                UIView.animate(withDuration: 0.3) {
                    self.coverView.alpha = 0.0
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
    
    func configureRefreshAndTable() {
        categorizedSentenceTable.refreshControl = refreshControl
        categorizedSentenceTable.register(CategorizedTableCell.nib, forCellReuseIdentifier: CategorizedTableCell.reuseId)
        
        refreshControl.addTarget(self, action: #selector(refreshCategorizedTable(_:)), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.4469921875, green: 0.657733609, blue: 0.3293619791, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh data")
    }

}
