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
        button.setImage(UIImage(named: "route66"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    let resetButton : UIButton = {
      let button = UIButton()
        button.setImage(UIImage(named: "reset"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        
        addAdressButton.addTarget(self, action: #selector(addAdressButtonTapped), for: .touchUpInside)
        routeButton.addTarget(self, action: #selector(routeButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)

        
        
    }
    
    @objc func addAdressButtonTapped() {
        print("TapAdd")
        
    }

    @objc func routeButtonTapped() {
        print("TapRoute")

        
    }
    
    @objc func resetButtonTapped() {
        print("TapReset")

        
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
        
        
  //      NSLayoutConstraint.activate([
 //           routeButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
    //        routeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
    //        routeButton.heightAnchor.constraint(equalToConstant: 70),
    //        routeButton.widthAnchor.constraint(equalToConstant: 70)

    //    ])
        
    //    NSLayoutConstraint.activate([
    //        resetButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
   //         resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),//
   //         resetButton.heightAnchor.constraint(equalToConstant: 70),
   //         resetButton.widthAnchor.constraint(equalToConstant: 70)

   //     ])
        
        
        
        
        
        
        
    }
}



