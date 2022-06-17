//
//  CustomCollectionViewController.swift
//  wanted_PreOnBoarding_practice
//
//  Created by 김성훈 on 2022/06/17.
//

import UIKit

let cellID = "Cell"

class CustomCollectionViewController: UIViewController {

    var models = [Weather]()

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


        //        flowLayout.itemSize = CGSize(width: (cv.frame.width), height: (cv.frame.height))
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
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

        let key = Bundle.main.WEATHER_API_KEY
        print("key \(key)")

        WeatherService().getWeather { result in
            switch result {
            case .success(let weatherValue):
                DispatchQueue.main.async {
                    print("weatherValue.weather \(weatherValue.weather.first!)")
                    print("weatherValue.main \(weatherValue.main)")
                    print("weatherValue.name \(weatherValue.name)")
                }
            case .failure(let networkError):
                print("\(networkError)")
            }
        }

    }

}


extension CustomCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)

        cell.backgroundColor = .green

        return cell
    }

}

extension CustomCollectionViewController: UICollectionViewDelegate {

}
