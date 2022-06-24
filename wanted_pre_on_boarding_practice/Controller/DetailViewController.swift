//
//  DetailViewController.swift
//  wanted_pre_on_boarding_practice
//
//  Created by 김성훈 on 2022/06/23.
//

import UIKit


protocol SendWeatherModelDelegate {
    func sendModel(weatherModel: WeatherModel)
}

extension DetailViewController: SendWeatherModelDelegate {
    
}

class DetailViewController: UIViewController {
    
    private var detailView: DetailView!
    
    var detailCityWeatherModel: WeatherModel?
    
    func sendModel(weatherModel: WeatherModel) {
        detailCityWeatherModel = weatherModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let mainViewControllerDelegate = MainViewController()
        mainViewControllerDelegate.sendWeatherModelDelegate = self
        
        let detailView = DetailView(frame: self.view.frame, detailCityWeatherModel: self.detailCityWeatherModel!)
        self.detailView = detailView
        self.view.addSubview(detailView)
        
    }
}
