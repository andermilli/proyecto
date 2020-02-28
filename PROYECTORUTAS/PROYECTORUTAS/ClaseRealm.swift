//
//  File.swift
//  PROYECTORUTAS
//
//  Created by  on 11/02/2020.
//  Copyright © 2020 Ander. All rights reserved.
//

import Foundation
import Realm
import  RealmSwift
import CoreLocation
public class Celdadatos: Object {
    @objc dynamic var id = 0
    @objc dynamic var ruta : SomeObject?
    
    
    convenience init(ruta: SomeObject) {
        self.init()
        self.id = id
        self.ruta = ruta
        
    }
    override public static func primaryKey() -> String? {
        return "id"
    }
}
