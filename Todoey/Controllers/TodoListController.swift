//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    // esto se hace para poder acceder a la clase AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // carga los datos que ya tenemos en la base de datos
        loadItems()
       
        }
    
    // MARK - Tableview DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // ternary reemplazando el if
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        
        return cell
    }
    
    
    // MARK - TableView Delegate Methos
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Unselect the row, and instead, show the state with a checkmark.
        tableView.deselectRow(at: indexPath, animated: true)
        
        //el !adelante significa o opuesto
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        

        
        // hacemos que se vuelva a cargar la tabla
        tableView.reloadData()
        
   
    }

    
    @IBAction func addBottonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        // popup para cargar items a la lista
        let alert = UIAlertController(title: "add new Todoey list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // lo que pasa cuando el user da click para agregar, agrego al array
            
            
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
           
            self.saveItems()
            
            
            // para que se cargue en la lista le debo avisar a la app
            
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
        
        
        // se codifica la info para poder escribirla y guardala en el archivo que le indique, se hace con do pq puede dar error y se transforma en optional
        
        do {
            
            
            try context.save()
            //aca dice donde se guarda la info, en el dataFilePath esta la dire en el disco local donde se guarda
           
        }catch{
            print("error saving context\(error)")
            
        }
    }
    
    func loadItems(){
        
        //debemos especificar el data type
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
        // siempre se debe comunicar con el context que es el intermediario, con fetch, trae el dato y lo manda
            itemArray = try context.fetch(request)
        }catch{
            print("error fetching context\(error)")
            
        }
    }
}


