//
//  ViewController.swift
//  Junior Test Task
//
//  Created by Sergey on 05.09.2021.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    let mapView : MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
        
 } ()
    
    let addAdressButton : UIButton = {
      let button = UIButton()
        button.setImage(UIImage(named: "addAdress"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    
    
    let routeButton : UIButton = {
      let button = UIButton()
        button.setImage(UIImage(named: "route10"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    } ()
    
    let resetButton : UIButton = {
      let button = UIButton()
        button.setImage(UIImage(named: "reset2"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    } ()
    
    // создаем массив для хранения наших аанотаций
    var annotationsArray = [MKPointAnnotation]()
    
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        
        
        setConstraints()
        
        addAdressButton.addTarget(self, action: #selector(addAdressButtonTapped), for: .touchUpInside)
        routeButton.addTarget(self, action: #selector(routeButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)

        
        
    }
    
    @objc func addAdressButtonTapped() {
      //  print("TapAdd")
        // действие для кнопки
        alertAddAdress(title: "ДОБАВИТЬ", placeholder: "Ведите адрес") { [self] (text) in
            setupPlacemark(adressPlace: text)
        }
        
    }

    @objc func routeButtonTapped() {
        
        for index in 0...annotationsArray.count - 2 {
            createDirectionRequest(startCoordinate: annotationsArray[index].coordinate, destinationCoordinate: annotationsArray[index + 1 ].coordinate)
         }
            mapView.showAnnotations(annotationsArray, animated: true)
        }
    
    @objc func resetButtonTapped() {
       
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        annotationsArray = [MKPointAnnotation]()
        routeButton.isHidden = true
        resetButton.isHidden = true
        
        
        
        

    }
    
    private func setupPlacemark(adressPlace: String) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(adressPlace) { [self] (placemarks, error) in
            
            if let error = error {
                print(error)
                
                alertError(title: adressPlace, message: "Сервер не доступен, введите адрес еще раз")
                return
            }
            
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            
            // строим анотацию
            
            let annotation = MKPointAnnotation()
            annotation.title = "\(adressPlace)"
            
            // координаты аннотации расположение
            guard let placemarkLocation = placemark?.location else { return }
            
            annotation.coordinate = placemarkLocation.coordinate
            
            annotationsArray.append(annotation)
            
            if annotationsArray.count > 2 {
                routeButton.isHidden = false
                resetButton.isHidden = false
                
            }
            
            mapView.showAnnotations(annotationsArray, animated: true)
        }
        
    }
    // постраение маршрута между двумя точками
    private func createDirectionRequest(startCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D ) {
          
        let startLocation = MKPlacemark(coordinate: startCoordinate)
        let destinationLocation = MKPlacemark(coordinate: destinationCoordinate)
        
        // делаем запрос
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startLocation)
        request.destination = MKMapItem(placemark: destinationLocation)
        
        request.transportType =  .walking
        request.requestsAlternateRoutes = true
        
        
        // указываем diraction
        let diraction = MKDirections(request: request)
        diraction.calculate { [self] (responce, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let responce = responce else {
                alertError(title: "Ошибка", message: "Маршрут недоступен")
                return
            }
            
            var minRoute = responce.routes[0]
            for route in responce.routes{
                
                minRoute = (route.distance < minRoute.distance) ? route : minRoute
            }
            self.mapView.addOverlay(minRoute.polyline)
            
        }
        // отобразить polyline через extension
        
    }
    
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .red
        return renderer
    }
    
}
















extension ViewController {
    
    func setConstraints() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.rightAnchor .constraint(equalTo: view.rightAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        
        // создали кнопки и таргеты и размещаем их на экране
        
        mapView.addSubview(addAdressButton)
        
        NSLayoutConstraint.activate([
            addAdressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
            addAdressButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addAdressButton.heightAnchor.constraint(equalToConstant: 50),
            addAdressButton.widthAnchor.constraint(equalToConstant: 50)

        ])
        
        mapView.addSubview(routeButton)
        NSLayoutConstraint.activate([
            routeButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            routeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            routeButton.heightAnchor.constraint(equalToConstant: 50),
            routeButton.widthAnchor.constraint(equalToConstant: 80)

        ])
        
        mapView.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            resetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            resetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.widthAnchor.constraint(equalToConstant: 80)

        ])
        
        
        
        
        
        
        
    }
}



