//
//  DayTableViewCell.swift
//  TMS - WeatherApp
//
//  Created by Евгений Агеенко on 15.07.21.
//

import UIKit

struct CurrentDayModel {
    let timeTitle: String
    let weatherTitle: String
    let weatherIconString: String
}


class DayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSourse: [CurrentDayModel] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
     

        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: CollectionViewCell.description(), bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.description())
        
        
    }
    
    override class func description() -> String {
        return "DayTableViewCell"
    }
    
    
    func setupWith(model: [CurrentDayModel]) {
        dataSourse = model
        collectionView.reloadData()
    }
}




//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension DayTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return dataSourse.count
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.description(), for: indexPath) as! CollectionViewCell
        cell.setupWith(model: dataSourse[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: 60.0, height: 131.0)
    }
}
