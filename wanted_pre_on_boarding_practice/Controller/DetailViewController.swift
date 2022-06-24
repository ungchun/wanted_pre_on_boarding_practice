//
//  DetailViewController.swift
//  wanted_pre_on_boarding_practice
//
//  Created by 김성훈 on 2022/06/23.
//

import UIKit

// 선택한 도시의 정보를 받기위한 델리게이트
protocol SendWeatherModelDelegate {
    func sendModel(weatherModel: WeatherModel)
}

extension DetailViewController: SendWeatherModelDelegate {}

class DetailViewController: UIViewController {
    
    private var detailView: DetailView!
    
    var detailCityWeatherModel: WeatherModel?
    
    override func viewWillAppear(_ animated: Bool) {
        // Detail 에서는 navigationBar Title 이 large 세팅 x
        self.navigationItem.largeTitleDisplayMode = .never
        // back button color 변경
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainViewControllerDelegate = MainViewController()
        mainViewControllerDelegate.sendWeatherModelDelegate = self
        
        let detailView = DetailView(frame: self.view.frame, detailCityWeatherModel: self.detailCityWeatherModel!)
        self.detailView = detailView
        self.view.addSubview(detailView)
        
    }
    
    func sendModel(weatherModel: WeatherModel) {
        detailCityWeatherModel = weatherModel
    }
}
