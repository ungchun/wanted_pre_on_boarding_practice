//
//  CustomCollectionViewController.swift
//  wanted_PreOnBoarding_practice
//
//  Created by 김성훈 on 2022/06/17.
//

import UIKit

class MainViewController: UIViewController  {
    
    var sendWeatherModelDelegate: SendWeatherModelDelegate?
    
    private var mainView: MainView!
    
    // Main 에서는 navigationBar Title 이 large 세팅
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupView()
        setNavigationBarTitle()
    }
    
    // MARK: func
    fileprivate func setupView() {
        let mainView = MainView(frame: self.view.frame)
        mainView.cellTapAction = navigationDetailView(_:)
        self.view.addSubview(mainView)
        
        // API 통해서 city weather 값 가져옴
        for cityName in CityList {
            //main thread에서 load할 경우 URL 로딩이 길면 화면이 멈춘다.
            //이를 방지하기 위해 다른 thread에서 처리함.
            DispatchQueue.global(qos: .background).async {
                WeatherService(cityName: cityName).getWeather { result in
                    switch result {
                    case .success(let weatherValue):
                        DispatchQueue.main.async {
                            mainView.weatherModelList += [weatherValue]
                            mainView.collectionView.reloadData()
                        }
                    case .failure(let networkError):
                        print("\(networkError)")
                    }
                }
            }
        }
    }
    
    fileprivate func setNavigationBarTitle() {
        self.title = "전국 날씨"
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .black
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func navigationDetailView(_ weatherModel: WeatherModel) {
        let detailVC = DetailViewController()
        detailVC.sendModel(weatherModel: weatherModel) // 델리게이트로 도시정보 전달
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

