//
//  CategoryCollectionCell.swift
//  Intents
//
//  Created by Никита on 23.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    
    static let reuseId = "reuseIdCategoryCollection"
    static let nib = UINib(nibName: String(describing: CategoryCollectionCell.self), bundle: nil)
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var backgroundMainView: UIView!
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundMainView.layer.cornerRadius = 14
        
    }
    
    func configureCellWith(_ textLabel: String) {
        mainLabel.text = textLabel
        
        backgroundMainView.backgroundColor = #colorLiteral(red: 0.4469921875, green: 0.657733609, blue: 0.3293619791, alpha: 1)
        mainImage.image = UIImage(systemName: "minus")
    }
    
    func configureLastCellWith() {
        mainLabel.text = "Добавить"
        
        backgroundMainView.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.6392156863, blue: 0.6392156863, alpha: 1)
        mainImage.image = UIImage(systemName: "plus")
    }
    
    
}
