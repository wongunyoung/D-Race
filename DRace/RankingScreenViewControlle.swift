//
//  ViewController.swift
//  RankingScreen
//
//  Created by Jayron Cena on 2017. 11. 15..
//  Copyright © 2017년 CodeWithJayron. All rights reserved.
//

import UIKit

class RankingScreenViewController: UITableViewController {

    /*
    var items: [RankingItem]
    
    required init?(coder aDecoder: NSCoder){
        
        items = [RankingItem]()
        
        let row0item = RankingItem()
        row0item.text = "Jayron Cena"
        items.append(row0item)
        
        let row1item = RankingItem()
        row1item.text = "Choi GwangIk"
        items.append(row1item)
        
        let row2item = RankingItem()
        row2item.text = "Won Gonyeong"
        items.append(row2item)
        
        let row3item = RankingItem()
        row3item.text = "Angelina Jolie"
        items.append(row3item)
        
        let row4item = RankingItem()
        row4item.text = "Brad Pitt"
        items.append(row4item)
        
        super.init(coder: aDecoder)
        
    }
    
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RankingItem", for: indexPath)
        
       
        let label = cell.viewWithTag(1000) as! UILabel
        let rankingLabel = cell.viewWithTag(100) as! UILabel
        
        rankingLabel.text = "\(indexPath.row + 1)"
        
        if indexPath.row % 5 == 0 {
            label.text = "Jayron Cena"
        }else if indexPath.row % 5 == 1{
            label.text = "Choi GwangIk"
        }else if indexPath.row % 5 == 2{
            label.text = "Won GonYeong"
        }else if indexPath.row % 5 == 3{
            label.text = "Angelina Jolie"
        }else if indexPath.row % 5 == 4{
            label.text = "Brad Pitt"
        }
        return cell
        
        /*
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        
        return cell */
        
    }
    
    func configureText(for cell: UITableViewCell, with item: RankingItem){
        
        let labelName = cell.viewWithTag(1000) as! UILabel
        labelName.text = item.text
    }


}

