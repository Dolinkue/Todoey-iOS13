//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Nicolas Dolinkue on 19/03/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    
    var cateArray = [Categories]()
    
    
    
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadItems()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            
            
            
            
            let newItem = Categories(context: self.context)
            newItem.name = textField.text!
            
            self.cateArray.append(newItem)
            
           
            self.saveItems()
            
            
            
            
            self.tableView.reloadData()
            
            
        }
        //el espacio para cargar el texto del nuevo item
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "create new item"
            textField = alertTextfield
            
        }
        
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
        
        }
        
    // MARK - Model Manupulation Methods
    
    func saveItems() {
        

        
        do {
            
            
            try context.save()
            
        }catch{
            print("error saving context\(error)")
            
        }
    }
    
    func loadItems(with request: NSFetchRequest<Categories> = Categories.fetchRequest()){
        
        
        
        do {
        
            cateArray = try context.fetch(request)
        }catch{
            print("error fetching context\(error)")
            
        }
        
        tableView.reloadData()
    }
    
    
        
    }
    
    
    
    
    //MARK - TableView delegate Methods
    
    
    

