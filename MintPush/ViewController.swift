//
//  ViewController.swift
//  MintPush
//
//  Created by Gokhan Gultekin on 19/12/2016.
//  Copyright © 2016 Peakode. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Record: NSObject {
    
    var message: String?
    var time: String?
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView?
    var objects: [Record]?
    
    override func viewWillAppear(_ animated: Bool) {
        self.objects = []
        fetchObjects()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Peakode Ofis"
        
        let nib = UINib(nibName: "RecordTableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "RecordTableViewCell")
   
    }
    
    func reloadRecords() {
        self.objects = []
        fetchObjects()
    }
    
    func fetchObjects() {
        
        let url = "http://35.156.231.100/v1/mint/notifications"
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
 
                for object in json["data"].arrayValue {
                    
                    let record: Record = Record()
                    record.message = object["message"].stringValue
                    record.time = object["created_at"].stringValue
                    
                    let time = Double(record.time!)
                    let date = NSDate(timeIntervalSince1970: time!)
                
                    print("DATE: \(date)")
                    
                    let formatter = DateFormatter()
//                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    formatter.locale = Locale.current
                    formatter.dateFormat = "dd MMMM - HH:mm"

                    
                    let timeZoneSeconds = NSTimeZone.local.secondsFromGMT()
//                    let dateInLocalTimezone = date.addingTimeInterval(TimeInterval(timeZoneSeconds))
                    let dateString = formatter.string(from: date as Date)
                    
                    record.time = dateString
          
                    self.objects?.append(record)
                    
                }
                
                self.tableView?.reloadData()

                let indexPath = NSIndexPath(row: (self.objects?.count)!-1, section: 0)
            
                self.tableView?.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
                
            case .failure(let error):
                print(error)
            }
        }
     
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.objects?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: RecordTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as! RecordTableViewCell
        
        cell.messageLabel?.text = objects?[indexPath.row].message!
        cell.timeLabel?.text = objects?[indexPath.row].time!

        if indexPath.row == 0 {
            cell.lineTop?.alpha = 0
            cell.lineBottom?.alpha = 1
        } else if indexPath.row == (objects?.count)!-1 {
            cell.lineTop?.alpha = 1
            cell.lineBottom?.alpha = 0
        } else {
            cell.lineTop?.alpha = 1
            cell.lineBottom?.alpha = 1
//            cell.roundedView?.alpha = 0
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
