//
//  CustomCollectionViewController.swift
//  wanted_PreOnBoarding_practice
//
//  Created by 김성훈 on 2022/06/17.
//

import UIKit

let cellID = "Cell"

class CustomCollectionViewController: UIViewController {
    
    var dataSource: [WeatherValue] = []
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "전국 날씨"
        return label
    }()
    
    let collectionView: UICollectionView = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        self.title = "전국 날씨"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        view.backgroundColor = .white
        
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        collectionView.register(DemoCell.self, forCellWithReuseIdentifier: cellID)
    }
}


extension CustomCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        if dataSource.count > indexPath.item {
            if let cell = cell as? DemoCell {
                cell.myModel = dataSource[indexPath.item]
            }
        }
        cell.backgroundColor = .green
        return cell
    }
    
}

extension CustomCollectionViewController: UICollectionViewDelegate {
    
}
