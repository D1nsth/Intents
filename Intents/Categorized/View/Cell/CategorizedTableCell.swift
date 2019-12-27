//
//  CategorizedTableCell.swift
//  Intents
//
//  Created by Никита on 23.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class CategorizedTableCell: UITableViewCell {
    
    static let reuseId = "reuseIdCategorizedTable"
    static let nib = UINib(nibName: String(describing: CategorizedTableCell.self), bundle: nil)
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(_ content: Content) {
        contentLabel.text = content.content
        
        var categories = ""
        for category in content.categories {
            categories += category.name + ", "
        }
        
        categoriesLabel.text = String(categories.dropLast(2))
    }
}
