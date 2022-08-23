//
//  Train_track.swift
//  Yicheng_Li_Assignment2
//
//  Created by mac on 2021/5/4.
//

import UIKit

var train_track = "http://lapi.transitchicago.com/api/1.0/ttfollow.aspx?key=0026aab046d24b35a347a42d75b77306";

class position
{
    var lat: String = ""
    var lon: String = ""
    var heading: String = ""
}

class NextSt
{
    var staNm: String = ""
    var prdt: String = ""
}

class Train_track: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataAvailable ? NextSts.count : 8
    }
    
    @IBOutlet weak var runnumber: UILabel!
    @IBOutlet weak var Position: UILabel!
    @IBOutlet weak var St_list: UITableView!
    
    var runumber:String? = "";
    var record = position()
    var NextSts: [NextSt] = []
    
    enum SerializationError: Error
    {
        case missing(String)
        case invalid(String, Any)
    }
    
    var dataAvailable = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(runumber != nil)
        {
            runnumber.text = "Run_Number: " + runumber!
            Position.text = "Loading"
            St_list.delegate = self
            St_list.dataSource = self
            loadData(link: runumber!)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "CellIdentifier")
        if NextSts.count > 0
        {
            cell.textLabel?.text = NextSts[indexPath.row].staNm
            cell.detailTextLabel?.text = NextSts[indexPath.row].prdt
        }
        return cell
    }
    
    func loadData(link: String)
    {
        var train_position = "http://lapi.transitchicago.com/api/1.0/ttfollow.aspx?key=0026aab046d24b35a347a42d75b77306&runnumber="+link+"&outputType=JSON";
        
        let queue = DispatchQueue.global(qos: .background)
        queue.async
        {
            
            while(true)
            {
                
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
                            guard let position = ctatt["position"] as? [String:Any] else
                            {
                                throw SerializationError.missing("position")
                            }

                            if let pos = position as? [String:Any]
                            {
                                self.record.lat = pos["lat"] as! String
                                self.record.lon = pos["lat"] as! String
                                self.record.heading = pos["heading"] as! String
                            }
                            
                            guard let pre_st = ctatt["eta"] as? [Any] else
                            {
                                throw SerializationError.missing("eta")
                            }
                            
                            for result in pre_st
                            {
                                if let n_s = result as? [String:Any]
                                {
                                    let record = NextSt()
                                    record.staNm = n_s["staNm"] as! String
                                    record.prdt = n_s["prdt"] as! String
                                    self.NextSts.append(record)
                                }
                            }
                            
                            self.dataAvailable = true
                            DispatchQueue.main.async
                            {
                                self.Position.text = self.record.lat + " " +  self.record.lon + " " + self.record.heading
                                self.St_list.reloadData()
                            }

                        }
                    }
                    catch let error as NSError
                    {
                        print(error.localizedDescription)
                    }
                }.resume()
                sleep(10)
                self.NextSts = []
                self.record = position()
            }
        }
    }
}
