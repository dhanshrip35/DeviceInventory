//
//  DeviceHistoryPage.swift
//  DeviceInventory
//
//  Created by Dhanshri Pawar on 06/05/20.
//  Copyright © 2020 Dhanshri Pawar. All rights reserved.
//

import UIKit

class DeviceHistoryPage: UITableViewController, DeviceHistoryProtocol {
    
    @IBOutlet weak var fromDate: UIDatePicker!
    @IBOutlet weak var toDate: UIDatePicker!
    
    var deviceHistoryPresenter = DeviceHistoryPresenter()
    var deviceID : String?
    var issuedDevices : [IssuedDevices] = []
    var resultData : [IssuedDevices] = []
    var lastKey : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceHistoryPresenter.deviceHistoryDelegate = self
        initUI()
    }
    
    func initUI() {
        navigationItem.title = "Device History"
        
        //Registering custom cell with nib.
        let cellNib = UINib(nibName: "DeviceHistoryCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "deviceHistoryCell")
        
        guard let id = deviceID else { return }
        deviceHistoryPresenter.sortByDeviceID(id : id, fromDate: getDateAndTime().fromDate , toDate: getDateAndTime().toDate, fetch : false)
        
    }
    
    // This function will call presenter to get data according to the selected platform and reload data.
    func reloadTable() {
        issuedDevices = issuedDevices.sorted(by: {$0.date > $1.date})
        tableView.reloadData()
    }
        
    func getDateAndTime() -> (toDate : TimeInterval, fromDate : TimeInterval) {
        let from = fromDate.date
        let to = toDate.date
        let convertedFromDate = from.timeIntervalSince1970
        let convertedToDate = to.timeIntervalSince1970
        
        return (convertedFromDate,convertedToDate)
    }
    
    func getDate(indexPath : IndexPath) -> String {
        let date = issuedDevices[indexPath.row].date
        
        let dateFormat = DateFormatter()
        dateFormat.timeZone = TimeZone.current
        dateFormat.dateFormat = "dd-MM-yyyy"
        return dateFormat.string(from: Date(timeIntervalSince1970: date))
    }
    
}

extension DeviceHistoryPage {
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issuedDevices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 100
        let cell = tableView.dequeueReusableCell(withIdentifier: "deviceHistoryCell", for: indexPath) as! DeviceHistoryCell
        cell.cueIDLabel.text = issuedDevices[indexPath.row].cueID
        cell.nameLabel.text = issuedDevices[indexPath.row].name
        cell.dateLabel.text = getDate(indexPath: indexPath)
        cell.checkinLabel.text = issuedDevices[indexPath.row].checkin
        cell.checkoutLabel.text = issuedDevices[indexPath.row].checkout
        return cell
    }
}

extension DeviceHistoryPage {
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // if we are at last cell then we need to fetch more cells.
        if indexPath.row == (issuedDevices.count-1) {
            guard let id = deviceID else { return }
            deviceHistoryPresenter.sortByDeviceID(id : id, fromDate: getDateAndTime().fromDate , toDate: getDateAndTime().toDate, fetch : true)
        }
    }
    
}
