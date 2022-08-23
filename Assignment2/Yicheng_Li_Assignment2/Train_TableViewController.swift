//
//  Train_TableViewController.swift
//  Yicheng_Li_Assignment2
//
//  Created by mac on 2021/5/3.
//

import UIKit

class Record
{
    var runnumber: String = ""
    var Destination: String = ""
    var Next_Station: String = ""
    var arrive_Time: String = ""
    var prediction_time: String = ""
    var isAPP: String = ""
    var isDly: String = ""
}

class Train_TableViewController: UITableViewController
{
    public var train_position = "";
    public var line:String? = "";
    
    enum SerializationError: Error
    {
        case missing(String)
        case invalid(String, Any)
    }
    
    var dataAvailable = false
    var records: [Record] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.lightGray
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = self.view.frame.height / 11;
        if (line != nil)
        {
            loadData(link:line!);
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return dataAvailable ? records.count : 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if (dataAvailable)
        {
            let cell: Train_TableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "LazyTableCell", for: indexPath) as!  Train_TableViewCell
            if(records.count>0)
            {
                let record = records[indexPath.row]
                cell.Next_Station?.text = record.Next_Station
                cell.Arrive_time?.text = record.arrive_Time
                cell.Destination?.text = record.Destination
                cell.Prediction_time?.text = record.prediction_time
            }
            return cell
        }
        else
        {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "PlaceholderCell", for: indexPath)
            return cell
        }
    }
    
    func loadData(link: String)
    {
        let train_position_url = "http://lapi.transitchicago.com/api/1.0/ttpositions.aspx?key=0026aab046d24b35a347a42d75b77306&rt="+link+"&outputType=JSON";
        guard let train_position_url2 = URL(string: train_position_url) else
        {
            return
        }
        
        let request = URLRequest(url: train_position_url2)
        let session = URLSession.shared
        session.dataTask(with: request)
        { data, response, error in
            guard error == nil else
            {
                print(error!.localizedDescription)
                return
            }
            guard let data = data else { return }
            
            do {
                if let json =
                    try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                {
                    
                    guard let ctatt = json["ctatt"] as? [String:Any] else
                    {
                        throw SerializationError.missing("ctatt")
                    }
                    
                    guard let route = ctatt["route"] as? [Any] else
                    {
                        throw SerializationError.missing("route")
                    }
                    
                    for result in route
                    {
                        if let trains = result as? [String:Any]
                        {
                            guard let train = trains["train"] as? [Any] else
                            {
                                throw SerializationError.missing("train")
                            }
                            for T in train
                            {
                                guard let train_data = T as? [String:Any] else
                                {
                                    throw SerializationError.missing("destNm")
                                }
                                let record = Record()
                                record.Destination = train_data["destNm"] as! String
                                record.Next_Station = train_data["nextStaNm"] as! String
                                record.arrive_Time = train_data["arrT"] as! String
                                record.isAPP = train_data["isApp"] as! String
                                record.isDly = train_data["isDly"] as! String
                                record.prediction_time = train_data["prdt"] as! String
                                record.runnumber = train_data["rn"] as!String

                                self.records.append(record)
                            }
                        }
                    }
                    self.dataAvailable = true
                    DispatchQueue.main.async
                    {
                        self.tableView.reloadData()
                    }
                }
            }
            catch let error as NSError
            {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if let Train_track = segue.destination as? Train_track
        {
           if let indexPath = self.tableView.indexPathForSelectedRow {
            Train_track.runumber = records[indexPath.row].runnumber
           }
       }
    }
}
