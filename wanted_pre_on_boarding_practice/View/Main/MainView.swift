//
//  MainView.swift
//  wanted_pre_on_boarding_practice
//
//  Created by 김성훈 on 2022/06/20.
//

import Foundation
import UIKit
import SpriteKit

let cellID = "Cell"

class MainView: UIView {
    
    lazy var snowView: SKView = {
        let view = SKView()
        view.backgroundColor = .clear
        let scene = SnowScene()
        view.presentScene(scene)
        return view
    }()
    
    var weatherModelList: [WeatherModel] = []
    var cellTapAction: ((_ weatherModel: WeatherModel) -> Void)?

    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        for cityName in CityList {
            //main thread에서 load할 경우 URL 로딩이 길면 화면이 멈춘다.
            //이를 방지하기 위해 다른 thread에서 처리함.
            DispatchQueue.global(qos: .background).async {
                WeatherService(cityName: cityName).getWeather { result in
                    switch result {
                    case .success(let weatherValue):
                        DispatchQueue.main.async {
                            self.weatherModelList += [weatherValue]
                            self.collectionView.reloadData()
                        }
                    case .failure(let networkError):
                        print("\(networkError)")
                    }
                }
            }
        }
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width-20, height: 120)
        flowLayout.minimumLineSpacing = 10
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 40, left: 10, bottom: 10, right: 10)
        flowLayout.minimumInteritemSpacing = 1
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    // MARK: func
    fileprivate func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .black
        
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor)
        ])
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    func cellTap(_ weatherModel: WeatherModel) {
        cellTapAction!(weatherModel)
    }
}

extension MainView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        if self.weatherModelList.count > indexPath.item {
            if let cell = cell as? MainCollectionViewCell {
                cell.weatherModel = weatherModelList[indexPath.item]
            }
//            if weatherModelList[indexPath.item].weather.first!.main.contains("Clouds") {
//                // 이렇게 쓰면 cell 에 눈 오긴 옴 -> 근데 스크롤할때 마다 이상해지고 전부 다 적용은 안됨 -> 처리해보기
//                cell.addSubview(snowView)
//                snowView.translatesAutoresizingMaskIntoConstraints = false
//                snowView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
//                snowView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
//                snowView.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
//                snowView.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
//                cell.backgroundView = UIImageView(image: UIImage(named: "cloud.jpg"))
//            } else {
//    //            dataSource[indexPath.item].weather[0].main.contains("Clear")
//                cell.backgroundView = UIImageView(image: UIImage(named: "sun.jpg"))
//            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // cell click
        cellTap(weatherModelList[indexPath.item])
    }
    
}

extension MainView: UICollectionViewDelegate {
    
}
