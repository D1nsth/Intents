//
//  AddCategoryView.swift
//  Intents
//
//  Created by Никита on 23.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

class AddCategoryView: UIViewController {
    
    var selectNameCategories: [String] = []
    //var selectCategories: [Category] = []
    var allCategories: [Category] = []
    var content: Content?
    var selectCategory: Category?
    
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var collectionCategories: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contentTextView.layer.borderWidth = 1
        contentTextView.layer.borderColor = #colorLiteral(red: 0.7843137255, green: 0.7803921569, blue: 0.8, alpha: 1)
        contentTextView.text = content?.content ?? ""
        
        addButton.layer.cornerRadius = 8
        cancelButton.layer.cornerRadius = 8
        saveButton.layer.cornerRadius = 8
        
        collectionCategories.register(CategoryCollectionCell.nib, forCellWithReuseIdentifier: CategoryCollectionCell.reuseId)
        collectionCategories.collectionViewLayout = CategoriesCollectionViewFlowLayout()
        
        UncategorizedNetService.getCategoriesData { (response) in
            UIView.animate(withDuration: 0.3) {
                self.coverView.alpha = 0.0
            }
            
            self.allCategories = response.resultCategories
            self.collectionCategories.reloadData()
            self.categoryPickerView.reloadAllComponents()
        }
    }

}
