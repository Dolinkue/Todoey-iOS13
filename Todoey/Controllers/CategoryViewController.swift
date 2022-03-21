//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Nicolas Dolinkue on 19/03/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
     
    
    let realm = try! Realm()
    
    
    var cateArray = [Category]()
    
    
    
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //loadCategory()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cateArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = cateArray[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        
        
        
        
        return cell
    }

    

    
    @IBAction func addBottonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "add new Todoey list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
            
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.cateArray.append(newCategory)
            
           
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
    
    // esta funcion para cuando se elegi una celda
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPach = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = cateArray[indexPach.row]
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
    
    //func loadCategory(with request: NSFetchRequest<Categories> = Categories.fetchRequest()){
        
        
        
      //  do {
        
        //    cateArray = try context.fetch(request)
        //}catch{
          //  print("error fetching context\(error)")
            
       // }
        
        //tableView.reloadData()
    //}
    
    
        
    }
    
    
    
    
    
    
    
    

