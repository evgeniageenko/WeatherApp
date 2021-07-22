//
//  CollectionViewCell.swift
//  TMS - WeatherApp
//
//  Created by Евгений Агеенко on 15.07.21.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    
    func setupWith(model: CurrentDayModel) {
        timeLabel.text = model.timeTitle
        weatherLabel.text = model.weatherTitle
        weatherImage.sd_setImage(with: URL(string: model.weatherIconString), placeholderImage: nil, options: .refreshCached, context: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

     
    }
    
    
    override class func description() -> String {
        return "CollectionViewCell"
    }

}
