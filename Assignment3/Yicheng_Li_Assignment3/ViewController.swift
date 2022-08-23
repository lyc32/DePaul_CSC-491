//
//  ViewController.swift
//  Yicheng_Li_Assignment3
//
//  Created by mac on 2021/5/17.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var Location: UILabel!
    
    @IBOutlet weak var Station_State: UILabel!
    
    @IBOutlet weak var St_list: UITableView!
    
    let locationManager = CLLocationManager()
    let stations =
    [
        (lat: 41.735372, lon: -87.624717, name: "87th", ID: "41430"),
        (lat: 41.750419, lon: -87.625112, name: "79th", ID: "40240"),
        (lat: 41.768367, lon: -87.625724, name: "69th", ID: "40990"),
        (lat: 41.722596, lon: -87.624391, name: "95th/Dan Ryan", ID: "40450"),
        (lat: 41.780536, lon: -87.630952, name: "63rd", ID: "40910"),
        (lat: 41.79542, lon: -87.631157, name: "Garfield", ID: "41170"),
        (lat: 41.810318, lon: -87.63094, name: "47th", ID: "41230"),
        (lat: 41.831191, lon: -87.630636, name: "Sox-35th", ID: "40190"),
        (lat: 41.853206, lon: -87.630968, name: "Cermak-Chinatown", ID: "41000"),
        (lat: 41.8675, lon: -87.626667, name: "Roosevelt", ID: "41400"),
        (lat: 41.874039, lon: -87.627479, name: "Harrison", ID: "41490"),
        (lat: 41.878153, lon: -87.627596, name: "Jackson", ID: "40560"),
        (lat: 41.8807 , lon: -87.6277, name: "Monroe", ID: "41090"),
        (lat: 41.884809, lon: -87.627813, name: "Lake", ID: "41660"),
        (lat: 41.8917 , lon: -87.6280, name: "Grand", ID: "40330"),
        (lat: 41.8967 , lon: -87.6282, name: "Chicago", ID: "41450"),
        (lat: 41.90392, lon: -87.631412, name: "Clark/Division", ID: "40630"),
        (lat: 41.910655, lon: -87.649177, name: "North/Clybourn", ID: "40650"),
        (lat: 41.925051, lon: -87.652866, name: "Fullerton", ID: "41220"),
        (lat: 41.939562, lon: -87.653345, name: "Belmont", ID: "41320"),
        (lat: 41.947462, lon: -87.653636, name: "Addison", ID: "41240"),
        (lat: 41.953883, lon: -87.655269, name: "Sheridan", ID: "40080"),
        (lat: 41.965285, lon: -87.657965, name: "Wilson", ID: "40540"),
        (lat: 41.969139, lon: -87.658493, name: "Lawrence", ID: "40770"),
        (lat: 41.973365, lon: -87.658561, name: "Argyle", ID: "41200"),
        (lat: 41.977833, lon: -87.658683, name: "Berwyn", ID: "40340"),
        (lat: 41.983572, lon: -87.658862, name: "Bryn Mawr", ID: "41380"),
        (lat: 41.990133, lon: -87.659082, name: "Torndale", ID: "40880"),
        (lat: 41.993731, lon: -87.659148, name: "Cranville", ID: "40760"),
        (lat: 42.00819, lon: -87.66595, name: "Morse", ID: "40100"),
        (lat: 42.015876, lon: -87.669092, name: "Jarvis", ID: "41190"),
        (lat: 42.019161, lon: -87.673093, name: "Howard", ID: "40900"),
    ]
    
    var regions = [CLCircularRegion]()
    
    enum SerializationError: Error
    {
        case missing(String)
        case invalid(String, Any)
    }
    var dataAvailable = false
    var stationDatas: [stationData] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        let status = locationManager.authorizationStatus
        if status == .denied || status == .restricted
        {
            Location.text = "Location service not authorized"
        }
        else
        {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = 1 // meter
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            
            St_list.delegate = self
            St_list.dataSource = self
            
            mapView.mapType = .hybridFlyover
            mapView.showsUserLocation = true
            mapView.showsBuildings = true
            
            if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self)
            {
                for st in stations
                {
                    let center = CLLocationCoordinate2D(latitude: st.lat, longitude: st.lon)
                    let region = CLCircularRegion(center: center, radius: 10, identifier: st.name)
                    region.notifyOnEntry = true
                    region.notifyOnExit = true
                    regions.append(region)
                }
            }
            else
            {
                showAlert(withTitle:"Error", message: "The device is not supported!")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.startUpdatingLocation()
        }
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) &&
            !regions.isEmpty
        {
            for region in regions
            {
                locationManager.startMonitoring(for: region)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
        for region in regions
        {
            locationManager.stopMonitoring(for: region)
        }
    }
    
    // delegate methods
    
    var annotation: MKAnnotation?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[locations.count - 1]
        Location.text = "Latitude: " + String(format: "%.4f", location.coordinate.latitude) + "\nLongitude: " +  String(format: "%.4f", location.coordinate.longitude)
        
        mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
        if mapView.isPitchEnabled
        {
            mapView.setCamera(MKMapCamera(lookingAtCenter: location.coordinate, fromDistance: 1000, pitch: 60, heading: 0), animated: true)
        }
        
        if annotation != nil
        {
            mapView.removeAnnotation(annotation!)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion)
    {
        Station_State.text = "Arriving \(region.identifier)"
        getCloseTrain(location_name: region.identifier)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion)
    {
        Station_State.text = "Leaving \(region.identifier)"
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning();
    }
    
    func showAlert(withTitle title: String?, message: String?)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataAvailable ? stationDatas.count : 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "CellIdentifier")
        if stationDatas.count > 0
        {
            cell.detailTextLabel?.text = "to " + stationDatas[indexPath.row].staNm
            
            cell.textLabel?.text = stationDatas[indexPath.row].prdt
        }
        return cell
    }
    
    func getCloseTrain(location_name:String)
    {
        
        var ID:String
        for st in stations
        {
            if st.name == location_name
            {
                ID = st.ID;
                var train_position = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx?key=0026aab046d24b35a347a42d75b77306&mapid="+ID+"&max=6&outputType=JSON";

                    guard let train_position_url = URL(string: train_position) else
                    {
                        return
                    }
                
                    let request = URLRequest(url: train_position_url)
                    let session = URLSession.shared
                    session.dataTask(with: request)
                    { data, response, error in

                        guard error == nil else
                        {
                            print(error!.localizedDescription)
                            return
                        }
                        guard let data = data else {return }
                        do
                        {
                            if let json =
                                try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                            {
                                guard let ctatt = json["ctatt"] as? [String:Any] else
                                {
                                    throw SerializationError.missing("ctatt")
                                }
                                guard let pre_st = ctatt["eta"] as? [Any] else
                                {
                                    throw SerializationError.missing("eta")
                                }
                                for result in pre_st
                                {
                                    if let n_s = result as? [String:Any]
                                    {
                                        let record = stationData()
                                        record.staNm = n_s["destNm"] as! String
                                        record.prdt = n_s["prdt"] as! String
                                        self.stationDatas.append(record)
                                    }
                                }
                                self.dataAvailable = true
                                DispatchQueue.main.async
                                {
                                    self.St_list.reloadData()
                                }
                            }
                        }
                        catch let error as NSError
                        {
                            print(error.localizedDescription)
                        }
                    }.resume()
                self.stationDatas = []
            }
        }
    }
}

class stationData
{
    var staNm: String = ""
    var prdt: String = ""
}
