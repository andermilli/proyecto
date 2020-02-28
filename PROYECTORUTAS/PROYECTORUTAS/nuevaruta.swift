//
//  nuevaruta.swift
//  PROYECTORUTAS
//
//  Created by  on 31/01/2020.
//  Copyright © 2020 Ander. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import RealmSwift
import Realm

class nuevaruta: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    var time = 0
    var controlempezarboton = true
    @IBOutlet weak var mapview: MKMapView!
    var rutaposiciones = SomeObject()
    var posiciones :[Location] = []
    let locationManager = CLLocationManager()
    var locationss: [CLLocationCoordinate2D] = []
    
    
    
    
    
    // timer
    var timer = Timer()
    @IBOutlet weak var cronometro: UILabel!
    @IBOutlet weak var stopstart: UIButton!
    
    
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)

        
        
        mapview.delegate = self
        mapview.showsUserLocation = true
        
    }
    
    
    
    
    @IBAction func startstop(_ sender: UIButton) {
        if (controlempezarboton == true ){
            //Arranca el cronómetro, actualiza gps si el usuario se mueve.
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(nuevaruta.action), userInfo: nil, repeats: true)
            controlempezarboton = false
            stopstart.setTitle("Pausar", for: .normal)
        }
        else if ( controlempezarboton == false){
            //Pausa el cronometro, no actualiza gps.
            timer.invalidate()
            controlempezarboton = true
            stopstart.setTitle("Continuar", for: .normal)
            locationManager.stopUpdatingLocation()
            
        }
        
    }
    
    //detiene el cronómetro, no actualiza gps.
    @IBAction func acabar(_ sender: UIButton) {
        timer.invalidate()
        time = 0
        controlempezarboton = true
        cronometro.text = String(time)
        stopstart.setTitle("Empezar", for: .normal)
        locationManager.stopUpdatingLocation()
        
        //hay que hacer que guarde la ruta y luego borre la línea.
        
        
        for n in locationss {
            let location = Location()
            location.latitude = n.latitude
            location.longitude = n.longitude
            
            rutaposiciones.coordinates.append(location)
            
            
            
            
        }
        
        do {
            
            let realm = try Realm()
            let celdas = realm.objects(Celdadatos.self)
            
            let celda = Celdadatos(ruta: rutaposiciones)
            
            celda.id = celdas.count + 1
            
            try! realm.write {
                
                realm.add(celda)
            }
            
            
        } catch {
            
            print(error.localizedDescription)
        }
        
        
        
        //   let realm = try! Realm()
        
        
    }
    
    @objc func action (){
        time += 1
        cronometro.text = String(time)
        //updatea las coordenadas.
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
    }
    //Muestra las coordenadas(la parte del print, el resto ya existe de base.)
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        locationss.append(locValue)
        print(locValue)
        
        let polyline = MKPolyline(coordinates:locationss , count: locationss.count)
        
        
        // let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: locValue, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapview.setRegion(region, animated: true)
        
        
        
        mapview.addOverlay(polyline)
        
    }
    
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = .black
        polylineRenderer.lineWidth = 2
        
        return polylineRenderer
    }
    
    
}

