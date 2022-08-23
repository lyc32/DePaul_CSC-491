//
//  Line_TableViewController.swift
//  Yicheng_Li_Assignment2
//
//  Created by mac on 2021/5/4.
//

import UIKit

class Line_TableViewController: UITableViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.rowHeight = self.view.frame.height / 9;
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return train_line.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let line = train_line[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: line.line.rawValue, for: indexPath)

        cell.textLabel?.text = line.line.rawValue
        cell.detailTextLabel?.text = line.type
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if let Train_TableViewController = segue.destination as? Train_TableViewController
        {
           if let indexPath = self.tableView.indexPathForSelectedRow
           {
            Train_TableViewController.line = train_line[indexPath.row].name
           }
       }
    }
}
