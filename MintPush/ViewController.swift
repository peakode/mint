//
//  ViewController.swift
//  MintPush
//
//  Created by Gokhan Gultekin on 19/12/2016.
//  Copyright © 2016 Peakode. All rights reserved.
//

import UIKit

class Record: NSObject {
    
    var message: String?
    var time: String?
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView?
    var objects: [Record]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Peakode Ofis"
        
        let nib = UINib(nibName: "RecordTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "RecordTableViewCell")
        
        let o1: Record = Record()
        o1.message = "ASDF 1"
        o1.time = "13:45"
        
        let o2: Record = Record()
        o2.message = "ASDF 2"
        o2.time = "13:58"
        
        let o3: Record = Record()
        o3.message = "ASDF 3"
        o3.time = "14:05"
        
        let o4: Record = Record()
        o4.message = "ASDF 4"
        o4.time = "14:20"
        
        objects = [o1, o2, o3, o4]
        
        tableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (objects?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: RecordTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as! RecordTableViewCell
        
        cell.messageLabel?.text = objects?[indexPath.row].message!
        cell.timeLabel?.text = objects?[indexPath.row].time!s

        if indexPath.row == 0 {
            cell.lineTop?.alpha = 0
            cell.lineBottom?.alpha = 1
        } else if indexPath.row == (objects?.count)!-1 {
            cell.lineTop?.alpha = 1
            cell.lineBottom?.alpha = 0
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    



}
