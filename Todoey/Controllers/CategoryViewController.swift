//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Nicolas Dolinkue on 19/03/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit


class CategoryViewController: UITableViewController {
     
    
    let realm = try! Realm()
    
    
    // como dataType results los datos se actualizan automaticamente y no debemos agregarlos
    var cateArray: Results<Category>?
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadCategory()
        
        tableView.rowHeight = 80.0
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cateArray?.count ?? 1
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! SwipeTableViewCell
        
        cell.textLabel?.text = cateArray?[indexPath.row].name ?? "no category"
        cell.delegate = self
        
        
        return cell
    }

    

    
    @IBAction func addBottonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "add new Todoey list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            
            
           
            self.save(category: newCategory)
            
            
            
            
            self.tableView.reloadData()
            
            
        }
        //el espacio para cargar el texto del nuevo item
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "create new category"
            textField = alertTextfield
            
        }
        
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
        
        }
    
    //MARK: - TableView delegate Methods
    
    // esta funcion para cuando se elegi una celda, esto nos lleva a los items
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPach = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = cateArray?[indexPach.row]
        }
    }
    
    
    
    
        
    // MARK: - Model Manupulation Methods
    
    func save(category: Category) {
        

        
        do {
            
            
            try realm.write {
                realm.add(category)
            }
            
        }catch{
            print("error saving context\(error)")
            
        }
    }
    
    func loadCategory(){
        
        
        //para cargar la info
        cateArray = realm.objects(Category.self)
        
        
        
        tableView.reloadData()
    }
    
    
        
    }
    

//MARK: - Swipe Cell Delegate Methods


extension CategoryViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion, donde pasa la accion
            
            if let cate = self.cateArray?[indexPath.row] {
                do {
                    try self.realm.write {
                        
                      
                        self.realm.delete(cate)
                    }
                    }catch {
                        print("error saving \(error)")
                }
            }
            tableView.deselectRow(at: indexPath, animated: true)
            
            tableView.reloadData()
            
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "trash-circle")

        return [deleteAction]
    }
    
}
    
    
    
    
    
    

