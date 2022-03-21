//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
// change to realm

import UIKit
import CoreData



class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    
    var selectedCategory : Category? {
        didSet {
            // aca carga los datos una vez que son selecionados de la categoria
            //loadItems()
        }
        
       
        
    }
    
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    // esto se hace para poder acceder a la clase AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        

       
        }
    
    // MARK: - Tableview DataSource Methods
    
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
    
    
    // MARK: - TableView Delegate Methos
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Unselect the row, and instead, show the state with a checkmark.
        tableView.deselectRow(at: indexPath, animated: true)
        
        //para delete un item, primero se debe eliminar de la base de datos y luego de la app, como en git siempre se debe comunicar con context.save() porque es el realiza el commit y cambia la base
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
        
        
        //el !adelante significa o opuesto, esto es para hacer done=true y dar el marckchek
        
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
            
            
            
            
  //          let newItem = Item(context: self.context)
    //        newItem.title = textField.text!
      //      newItem.done = false
        //    newItem.parentCategory = self.selectedCategory
          //  self.itemArray.append(newItem)
            
           
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
        
    // MARK: - Model Manupulation Methods
    
    func saveItems() {
        
        
        // se codifica la info para poder escribirla y guardala en el archivo que le indique, se hace con do pq puede dar error y se transforma en optional
        
        do {
            
            
            try context.save()
            //aca dice donde se guarda la info, en el dataFilePath esta la dire en el disco local donde se guarda
           
        }catch{
            print("error saving context\(error)")
            
        }
    }
    
   // func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
        
        //debemos especificar el data type, y en la funcion si especificamos el parametro, ponemos el dato como default
        
     //   let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
       // if let addPredicate = predicate {
            
         //   request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: //[categoryPredicate, addPredicate])
       // } else {
         //   request.predicate = categoryPredicate
        //}
        
        
       // do {
        // siempre se debe comunicar con el context que es el intermediario, con fetch, trae el dato y lo manda
         //   itemArray = try context.fetch(request)
       // }catch{
         //   print("error fetching context\(error)")
            
        //}
        
        //tableView.reloadData()
   // }
    

    
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
