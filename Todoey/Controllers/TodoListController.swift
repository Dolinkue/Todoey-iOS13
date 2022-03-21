//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
// change to realm

import UIKit
import RealmSwift



class TodoListViewController: UITableViewController {
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            // aca carga los datos una vez que son selecionados de la categoria
            loadItems()
        }
        
       
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

       
        }
    
    // MARK: - Tableview DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            // ternary reemplazando el if
            cell.accessoryType = item.done == true ? .checkmark : .none
            
        } else {
            cell.textLabel?.text = "No Items added"
        }
        
        
        
        
        return cell
    }
    
    
    // MARK: - TableView Delegate Methos
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let item = todoItems?[indexPath.row] {
            do {
            try realm.write {
                item.done = !item.done
            }
            }catch {
                print("el \(error)")
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
 

        
        // hacemos que se vuelva a cargar la tabla, y enviamos la info a para poner la marca o no arriba de esta funcion
        tableView.reloadData()
        
   
    }

    
    @IBAction func addBottonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        // popup para cargar items a la lista
        let alert = UIAlertController(title: "add new Todoey list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // lo que pasa cuando el user da click para agregar, agrego al array
            
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    currentCategory.items.append(newItem)
                    
                }
                } catch {
                    print("error \(error)")
                }
            }
            
            self.tableView.reloadData()
           
            
            
            
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
        
    // MARK: - Model Manupulation Methods
    
    func save(item: Item) {
        
        
        // se codifica la info para poder escribirla y guardala en el archivo que le indique, se hace con do pq puede dar error y se transforma en optional
        
        do {
            
            
            try realm.write {
                realm.add(item)
            }
        }catch{
            print("error saving context\(error)")
            
        }
    }
    
    func loadItems(){
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
    

    
}

// MARK: - Search bar methods

//extension TodoListViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        //aca hacemos el query, como buscamos la info, los que esta en "" es el query y con %@ remplaza el texto
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//
//
//        loadItems(with: request, predicate: predicate)
//
//
//
//    }
//    //para eliminar la busqueda y que vuelva la lista original, este metodo se dispara cuando la barra se modifica, con cual si vuelve a 0 le decis que cargue la lista original
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//
//            //con esto terminamos el proceso que ocurre en el background de la app
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//
//
//        }
//    }
//
//
//}
//
