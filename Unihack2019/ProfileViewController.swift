//
//  ProfileViewController.swift
//  Unihack2019
//
//  Created by Gabrielle Chandrasaputra on 17/3/19.
//  Copyright © 2019 Gabrielle Chandrasaputra. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let list = ["NAME", "EMAIL", "CURRENT CREDIT", "TOTAL CREDIT", "CLAIMED CREDIT"]
    let name = ["REBECCA CHEUNG", "", "", "", ""]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
}
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return list.count
    }
    
    //set table view data cells
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row] + " : " + name[indexPath.row]//list array as table cells
        cell.backgroundColor = UIColor.clear //make cells clear
        cell.textLabel?.textColor = UIColor.white //make text color white
        return(cell)
        
    }

    
    
}
