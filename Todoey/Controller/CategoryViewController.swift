//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ancy Thomas on 1/19/18.
//  Copyright © 2018 ThinkPalm. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class CategoryViewController: SwipteTableViewController {

    let realm = try! Realm()
    
    var categoryArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        loadCategories()
        tableView.rowHeight = 100.0
        tableView.separatorStyle = .none
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 0
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        cell.textLabel?.text = categoryArray?[indexPath.row].title ?? "No categories added yet"
        cell.backgroundColor = HexColor(categoryArray![indexPath.row].color)
        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToItems"){
            let destination = segue.destination as! ToDoViewController

            if let indexPath = tableView.indexPathForSelectedRow {
               destination.selectedCategory = categoryArray?[indexPath.row]
            }
        }
    }
    
    //MARK - Category Add Button Click
    @IBAction func addCategoryButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            
            if textField.text == ""{
                return
            }
            
            let category = Category()
            category.title = textField.text!
            category.color = UIColor.randomFlat.hexValue()
            self.saveCategory(category: category)
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveCategory (category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
       
    }
    
    func loadCategories () {
        
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    override func updateModel(at indexPath: IndexPath){
    
                    if let category = self.categoryArray?[indexPath.row] {
                    do {
                        try self.realm.write {
                            self.realm.delete(category)
                        }
                    } catch {
                        print("Error saving category \(error)")
                    }
                    }
                   super.updateModel(at: indexPath)
    }
}
