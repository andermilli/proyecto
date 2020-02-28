//
//  tableview.swift
//  PROYECTORUTAS
//
//  Created by  on 14/02/2020.
//  Copyright © 2020 Ander. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift
import Realm
import MapKit


class Celdas : UITableViewController{
    var listaceldas = [Celdadatos]()
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet weak var boton: UIButton!
    
    override  func viewDidLoad() {
        tableView.reloadData()
        
        do {
            let realm = try Realm()
            
            
            let celdas = realm.objects(Celdadatos.self)
            for celda in celdas{
                listaceldas.append(celda)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaceldas.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        
        
        cell.textLabel?.text = String(listaceldas[indexPath.row].id)
        return cell
    }
    
    //función que elimina las filas de las tablas
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            listaceldas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            
        }
    }
}


