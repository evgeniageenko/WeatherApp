//
//  OneDayInWeekCell.swift
//  TMS - WeatherApp
//
//  Created by Евгений Агеенко on 15.07.21.
//

import UIKit
import SDWebImage

class OneDayInWeekCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var hightTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    
    func setupWith(model: OtherDayModel) {
        dayLabel.text = model.dayTitle
        hightTempLabel.text = model.maxTempTitle
        lowTempLabel.text = model.minTempTitle
        weatherImage.sd_setImage(with: URL(string: model.weatherIconString), placeholderImage: nil, options: .refreshCached, context: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override class func description() -> String {
        return "OneDayInWeekCell"
    }
}



