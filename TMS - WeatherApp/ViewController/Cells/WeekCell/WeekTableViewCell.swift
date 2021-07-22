//
//  TableViewCell.swift
//  TMS - WeatherApp
//
//  Created by Евгений Агеенко on 15.07.21.
//

import UIKit
import SDWebImage


class WeekTableViewCell: UITableViewCell {

    @IBOutlet weak var weekTableView: UITableView!
    
    enum ControllersSections {
        case oneDayInfo
    }
    
    var dataSourse: [OtherDayModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        weekTableView.delegate = self
        weekTableView.dataSource = self
        weekTableView.register(UINib(nibName: OneDayInWeekCell.description(), bundle: nil), forCellReuseIdentifier: OneDayInWeekCell.description())
        
    }


    override class func description() -> String {
        return "WeekTableViewCell"
    }
    
    func setupWith(model: [OtherDayModel]) {
        dataSourse = model
        weekTableView.reloadData()
    }
    

}


//MARK: - UITableViewDelegate, UITableViewDataSource
extension WeekTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSourse.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = weekTableView.dequeueReusableCell(withIdentifier: OneDayInWeekCell.description(), for: indexPath) as! OneDayInWeekCell
        cell.setupWith(model: dataSourse[indexPath.row])
        
        return cell
    }
    
    
}
