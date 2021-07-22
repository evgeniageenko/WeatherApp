//
//  ViewController.swift
//  TMS - WeatherApp
//
//  Created by Евгений Агеенко on 14.07.21.
//

import UIKit

struct OtherDayModel {
    let dayTitle: String
    let minTempTitle: String
    let maxTempTitle: String
    let weatherIconString: String
}

enum ControllerSections {
    case currentDay(city: String, description: String, currentTemp: String, minTemp: String, maxTemp: String)
    case otherInfo(hours: [CurrentDayModel])
    case otherDays(days: [OtherDayModel])
    
}



class ViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    //MARK: UI Properties
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: DATA Properties
    private var daysResponse: DaysResponseModel?
    private let dataFetcher = DataFetcherService()
    private var dataSource: [ControllerSections] = []
    
    
    enum DateFormat: String {
        case dayTitle = "E"
        case timeFull = "HH:mm"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: MainTableViewCell.description(), bundle: nil), forCellReuseIdentifier: MainTableViewCell.description())
        tableView.register(UINib(nibName: DayTableViewCell.description(), bundle: nil), forCellReuseIdentifier: DayTableViewCell.description())
        tableView.register(UINib(nibName: WeekTableViewCell.description(), bundle: nil), forCellReuseIdentifier: WeekTableViewCell.description())
        
        dataFetcher.getWeatherDay(count: 12, completion: { [weak self] response in
            guard let self = self, let response = response else { return }
            self.daysResponse = response
            self.configureDataSourceFrom(response: response)
        })
                
        
        tableView.tableFooterView = UIView()
        
    }
    
    // MARK: - Methods
    
    //func configureDataSourceFrom
    func configureDataSourceFrom(response: DaysResponseModel) {
        dataSource.append(.currentDay(city: response.city?.name ?? "",
                                      description: "\(response.list?.first?.weather?.first?.description ?? "")",
                                      currentTemp: "\(Int(response.list?.first?.temp?.day ?? 0))°",
                                      minTemp: "\(Int(response.list?.first?.temp?.min ?? 0))°",
                                      maxTemp: "\(Int(response.list?.first?.temp?.max ?? 0))°"))
        
        //        if let sunrise = response.list?.first?.sunrise, let sunset = response.list?.first?.sunset {
        //            dataSource.append(.otherInfo(pressure: "\(response.list?.first?.pressure ?? 0)",
        //                                         hubidity: "\(response.list?.first?.humidity ?? 0)",
        //                                         sunset: configureDataStringFrom(epoch: sunset, dateFormat: .timeFull),
        //                                         sunrise: configureDataStringFrom(epoch: sunrise, dateFormat: .timeFull)))
        //
        if let hours = response.list {
            dataSource.append(.otherInfo(hours: configureOneDayInfoArrayFrom(hours: hours)))
        }
        
        
        if let days = response.list {
            dataSource.append(.otherDays(days: configureOtherDaysArrayFrom(days: days)))
        }
        
        
        tableView.reloadData()
    }
    
    
    //func configureDataStringFrom
    private func configureDataStringFrom(epoch: Int, dateFormat: DateFormat) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(epoch)) as Date
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = dateFormat.rawValue
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        return dateFormatter.string(from: date)
    }
    
    
    //func configureOtherDaysArrayFrom
    private func configureOtherDaysArrayFrom(days: [List]) -> [OtherDayModel] {
        var otherDays: [OtherDayModel] = []
        
        for day in days {
            var dayTitleString = ""
            
            if let epochInt = day.dt {
                dayTitleString = configureDataStringFrom(epoch: epochInt, dateFormat: .dayTitle)
            }
            
            let model = OtherDayModel(dayTitle: dayTitleString,
                                      minTempTitle: "\(Int(day.temp?.min ?? 0))°",
                                      maxTempTitle: "\(Int(day.temp?.max ?? 0))°",
                                      weatherIconString: "http://openweathermap.org/img/wn/\(day.weather?.first?.icon ?? "")@2x.png")
            
            otherDays.append(model)
        }
        
        return otherDays
    }
    
    //my func configureOneDayInfoArrayFrom
    private func configureOneDayInfoArrayFrom(hours: [List]) -> [CurrentDayModel] {
        var oneDays: [CurrentDayModel] = []
        
        for hour in hours {
            var hourTitleString = ""
            
            if let eponchInt = hour.sunrise {
                hourTitleString = configureDataStringFrom(epoch: eponchInt, dateFormat: .timeFull)
            }
            
            let model = CurrentDayModel(timeTitle: hourTitleString,
                                        weatherTitle: "\(Int(hour.temp?.day ?? 0))",
                                        weatherIconString: "http://openweathermap.org/img/wn/\(hour.weather?.first?.icon ?? "")@2x.png")
            
            oneDays.append(model)
        }
        return oneDays
    }
    
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch dataSource[indexPath.row] {
        case .currentDay(city: let city, description: let description, currentTemp: let currentTemp, minTemp: let minTemp, maxTemp: let maxTemp):
            
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.description(), for: indexPath) as! MainTableViewCell
            let model = CurrentWeatherCellModel(cityString: city, weatherDescription: description, currentTempString: currentTemp, minAndMaxTempString: "Мин: \(minTemp) Макс: \(maxTemp)")
            cell.setupCellFrom(model: model)
            
            return cell
            
        case .otherInfo(hours: let hours):
            let cell = tableView.dequeueReusableCell(withIdentifier: DayTableViewCell.description(), for: indexPath) as! DayTableViewCell
            
            cell.setupWith(model: hours)
            return cell
            
            
        case .otherDays(days: let days):
            let cell = tableView.dequeueReusableCell(withIdentifier: WeekTableViewCell.description(), for: indexPath) as! WeekTableViewCell
            cell.setupWith(model: days)
            
            
            return cell
            
        }
    }
}
