//
//  AddCategoryController.swift
//  Intents
//
//  Created by Никита on 23.12.2019.
//  Copyright © 2019 Nikita Ananev. All rights reserved.
//

import UIKit

// MARK: - Action Buttons
extension AddCategoryView {
    
    @IBAction func addSelectCategory(_ sender: UIButton) {
        
        if selectCategory == nil {
            if allCategories.count != 0 {
                selectCategory = allCategories.first!
            }
        }
        
        if (selectNameCategories.contains(selectCategory!.name)) {
            let alertController = UIAlertController(title: "Ошибка", message: "Категория \(selectCategory!.name) уже в списке!", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertController.addAction(cancel)
            
            present(alertController, animated: true)
            
        } else {
            content!.categories.append(selectCategory!)
            selectNameCategories.append(selectCategory!.name)
            collectionCategories.reloadData()
            
            UIView.animate(withDuration: 0.3) {
                self.categoryView.alpha = 0.0
            }
        }
        
    }
    
    @IBAction func cancelSelectCategory(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
            self.categoryView.alpha = 0.0
        }
        
    }
    
    @IBAction func saveSelectCategory(_ sender: UIButton) {
        
        if selectNameCategories.count == 0 {
            let alertController = UIAlertController(title: "Ошибка", message: "Нельзя сохранить без категорий!", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            alertController.addAction(cancel)
            
            present(alertController, animated: true)
            
        } else {
            UncategorizedNetService.putUncategorizedContent(content: content!)
        }
        
    }
    
}

// MARK: PickerView
extension AddCategoryView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allCategories[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectCategory = allCategories[row]
    }
    
}

// MARK: CollectionView
extension AddCategoryView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (selectNameCategories.count == allCategories.count) ? selectNameCategories.count : selectNameCategories.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.reuseId, for: indexPath) as! CategoryCollectionCell
        
        let index = indexPath.row
        if (index == content!.categories.count) && (allCategories.count != content!.categories.count) {
            cell.configureLastCellWith()
            
        } else {
            cell.configureCellWith(selectNameCategories[index])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        
        if (index == selectNameCategories.count) {
            
            UIView.animate(withDuration: 0.3) {
                self.categoryView.alpha = 1.0
            }
            
        } else {
            
            let alertController = UIAlertController(title: "Удалить?", message: "Действительно хотите удалить категорию \(selectNameCategories[index])?", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "Да", style: .default) { (action) in
                
                self.content!.categories.remove(at: index)
                self.selectNameCategories.remove(at: index)
                self.collectionCategories.reloadData()
            }
            
            let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            
            alertController.addAction(ok)
            alertController.addAction(cancel)
            
            present(alertController, animated: true)
        }
    }
    
}
