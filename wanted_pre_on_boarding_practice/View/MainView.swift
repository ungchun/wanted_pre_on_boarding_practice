//
//  MainView.swift
//  wanted_pre_on_boarding_practice
//
//  Created by 김성훈 on 2022/06/20.
//

import Foundation
import UIKit

let cellID = "Cell"

class MainView: UIView {
    
    var dataSource: [WeatherValue] = []
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        for cityName in CityList {
            WeatherService(cityName: cityName).getWeather { result in
                switch result {
                case .success(let weatherValue):
                    DispatchQueue.main.async {
                        print("weatherValue.weather \(weatherValue.weather.first!)")
                        self.dataSource += [weatherValue]
                        self.collectionView.reloadData()
                    }
                case .failure(let networkError):
                    print("\(networkError)")
                }
            }
        }
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "전국 날씨"
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width-20, height: 100)
        flowLayout.minimumLineSpacing = 10
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 40, left: 10, bottom: 10, right: 10)
        flowLayout.minimumInteritemSpacing = 1
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    // MARK: func
    func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor)
        ])
        collectionView.register(DemoCell.self, forCellWithReuseIdentifier: cellID)
    }
}

extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        if self.dataSource.count > indexPath.item {
            if let cell = cell as? DemoCell {
                cell.myModel = dataSource[indexPath.item]
            }
        }
        cell.backgroundColor = .green
        return cell
    }
    
}

extension MainView: UICollectionViewDelegate {
    
}
