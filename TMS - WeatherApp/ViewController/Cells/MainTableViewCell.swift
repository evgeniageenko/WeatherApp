//
//  MainTableViewCell.swift
//  TMS - WeatherApp
//
//  Created by Евгений Агеенко on 14.07.21.
//

import UIKit


struct CurrentWeatherCellModel {
    let cityString: String
    let weatherDescription: String
    let currentTempString: String
    let minAndMaxTempString: String
}



class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherIntLabel: UILabel!
    @IBOutlet weak var maxMinTempLabel: UILabel!
    
    
    func setupCellFrom(model: CurrentWeatherCellModel) {
        cityLabel.text = model.cityString
        weatherLabel.text = model.weatherDescription
        weatherIntLabel.text = model.currentTempString
        maxMinTempLabel.text = model.minAndMaxTempString
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    override class func description() -> String {
        return "MainTableViewCell" 
    }
    
}


