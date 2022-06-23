//
//  DetailView.swift
//  wanted_pre_on_boarding_practice
//
//  Created by 김성훈 on 2022/06/23.
//

import Foundation
import UIKit

class DetailView: UIView {
    
    var detailCityWeatherModel: WeatherModel?
    
    func setCityData() {
        label_1.text = String(describing: CityKoreaListDic.filter {$0.keys.contains(detailCityWeatherModel!.name)}.first!.first!.value)
        
        let intTemperatureValue = Int(detailCityWeatherModel!.main.temp)
        label_2.text = "\(String(describing: intTemperatureValue))°"
        
        label_3.text = detailCityWeatherModel?.weather[0].description
        
        let intTemperatureMaxValue = Int(detailCityWeatherModel!.main.temp_max)
        label_4.text = "최고:\(String(describing: intTemperatureMaxValue))°"
        let intTemperatureMinValue = Int(detailCityWeatherModel!.main.temp_min)
        label_5.text = "최저:\(String(describing: intTemperatureMinValue))°"
        
        let intFeels_likeValue = Int(detailCityWeatherModel!.main.feels_like)
        feels_likeValueLabel.text = "\(String(describing: intFeels_likeValue))°"
        
        let intHumidityValue = Int(detailCityWeatherModel!.main.humidity)
        humidityValueLabel.text = "\(String(describing: intHumidityValue))%"
        
        let intPressureValue = Int(detailCityWeatherModel!.main.pressure)
        pressureValueLabel.text = "\(String(describing: intPressureValue))"
        
        let intSpeedValue = Int(detailCityWeatherModel!.wind.speed)
        speedValueLabel.text = "\(String(describing: intSpeedValue))"
        
        let intVisibilityValue = Int(detailCityWeatherModel!.visibility)
        visibilityValueLabel.text = "\(String(describing: intVisibilityValue))"
        
        
        
        let url = "https://openweathermap.org/img/wn/\(detailCityWeatherModel!.weather[0].icon).png"
        let cacheKey = String(describing: url) // 캐시에 사용될 Key 값
        let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey as NSString)
        iconValueIcon.image = cachedImage
        
    }
    
    private let label_1: UILabel = {
        let label = UILabel()
        label.text = "중구"
        label.font = .systemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    private let label_2: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.font = .systemFont(ofSize: 80)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    private let label_3: UILabel = {
        let label = UILabel()
        label.text = "대체로 흐림"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    private let label_4: UILabel = {
        let label = UILabel()
        label.text = "최고"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let label_5: UILabel = {
        let label = UILabel()
        label.text = "최저"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tempMinMaxStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return stackView
    }()
    
    private let topTextStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.setContentHuggingPriority(.defaultLow, for: .vertical)
        stackView.backgroundColor = .green
        return stackView
    }()
    
    
    private let anotherFirstLineDetailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let anotherSecondLineDetailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let anotherLineDetailStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
//        stackView.backgroundColor = .gray
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.backgroundColor = .purple
        stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return stackView
    }()
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.axis = .vertical
        return stackView
    }()
    

    private let iconTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "아이콘"
        label.textAlignment = .left
        
        return label
    }()
//    private let iconValueLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "아이콘"
//        label.font = .systemFont(ofSize: 25)
//        return label
//    }()
    
    private let iconValueIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let iconStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.layer.borderWidth = 3
        stackView.layer.cornerRadius = 25
        return stackView
    }()
    
    private let feels_likeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "체감기온"
        label.textAlignment = .left
        return label
    }()
    private let feels_likeValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25)
        label.text = "체감기온"
        label.textAlignment = .right
        return label
    }()
    private let feels_likeStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.borderWidth = 3
        stackView.layer.cornerRadius = 25
        return stackView
    }()
    
    private let humidityTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "현재습도"
        label.textAlignment = .left
        return label
    }()
    private let humidityValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "현재습도"
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .right
        return label
    }()
    private let humidityStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.borderWidth = 3
        stackView.layer.cornerRadius = 25
        return stackView
    }()
    
    private let pressureTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "기압"
        label.textAlignment = .left
        return label
    }()
    private let pressureValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "기압"
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .right
        return label
    }()
    private let pressureStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.borderWidth = 3
        stackView.layer.cornerRadius = 25
        return stackView
    }()
    
    private let speedTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "풍속"
        label.textAlignment = .left
        return label
    }()
    private let speedValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "풍속"
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .right
        return label
    }()
    private let speedStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.borderWidth = 3
        stackView.layer.cornerRadius = 25
        return stackView
    }()
    
    private let visibilityTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "시정"
        label.textAlignment = .left
        return label
    }()
    private let visibilityValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "시정"
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .right
        return label
    }()
    private let visibilityStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.borderWidth = 3
        stackView.layer.cornerRadius = 25
        return stackView
    }()
    

    
    required init(frame: CGRect, detailCityWeatherModel: WeatherModel) {
        super.init(frame: frame)
        
        self.detailCityWeatherModel = detailCityWeatherModel
        
        setCityData()
        
        self.addSubview(entireStackView)
//        self.addSubview(topTextStackView)
//        self.addSubview(anotherLineDetailStackView)
        
        iconStackView.addArrangedSubview(iconTitleLabel)
//        iconStackView.addArrangedSubview(iconValueLabel)
        iconStackView.addArrangedSubview(iconValueIcon)
        
        
        
        
        feels_likeStackView.addArrangedSubview(feels_likeTitleLabel)
        feels_likeStackView.addArrangedSubview(feels_likeValueLabel)
        
        humidityStackView.addArrangedSubview(humidityTitleLabel)
        humidityStackView.addArrangedSubview(humidityValueLabel)
        
        tempMinMaxStackView.addArrangedSubview(label_4)
        tempMinMaxStackView.addArrangedSubview(label_5)
        
        anotherFirstLineDetailStackView.addArrangedSubview(iconStackView)
        anotherFirstLineDetailStackView.addArrangedSubview(feels_likeStackView)
        anotherFirstLineDetailStackView.addArrangedSubview(humidityStackView)
        
        
        
        
        iconStackView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        iconStackView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        pressureStackView.addArrangedSubview(pressureTitleLabel)
        pressureStackView.addArrangedSubview(pressureValueLabel)
        
        
        speedStackView.addArrangedSubview(speedTitleLabel)
        speedStackView.addArrangedSubview(speedValueLabel)
        
        visibilityStackView.addArrangedSubview(visibilityTitleLabel)
        visibilityStackView.addArrangedSubview(visibilityValueLabel)
        
        anotherSecondLineDetailStackView.addArrangedSubview(pressureStackView)
        anotherSecondLineDetailStackView.addArrangedSubview(speedStackView)
        anotherSecondLineDetailStackView.addArrangedSubview(visibilityStackView)
        
        pressureStackView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        pressureStackView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        anotherLineDetailStackView.addArrangedSubview(anotherFirstLineDetailStackView)
        anotherLineDetailStackView.addArrangedSubview(anotherSecondLineDetailStackView)
        
//        anotherFirstLineDetailStackView.leftAnchor.constraint(equalTo: self.)
        
        
        
        
        topTextStackView.addArrangedSubview(label_1)
        topTextStackView.addArrangedSubview(label_2)
        topTextStackView.addArrangedSubview(label_3)
        topTextStackView.addArrangedSubview(tempMinMaxStackView)
        
        
        
        entireStackView.addArrangedSubview(topTextStackView)
        entireStackView.addArrangedSubview(anotherLineDetailStackView)
        
//        topTextStackView.setContentHuggingPriority(.defaultLow, for: .vertical)
//        anotherLineDetailStackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        anotherLineDetailStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        anotherLineDetailStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
//        anotherFirstLineDetailStackView.topAnchor.constraint(equalTo: self.topTextStackView.bottomAnchor, constant: 100).isActive = true
        
        iconTitleLabel.leftAnchor.constraint(equalTo: self.iconStackView.leftAnchor, constant: 10).isActive = true
        iconValueIcon.rightAnchor.constraint(equalTo: self.iconStackView.rightAnchor, constant: 4).isActive = true
        
        
        feels_likeTitleLabel.leftAnchor.constraint(equalTo: self.feels_likeStackView.leftAnchor, constant: 10).isActive = true
        feels_likeValueLabel.rightAnchor.constraint(equalTo: self.feels_likeStackView.rightAnchor, constant: -10).isActive = true
        
        humidityTitleLabel.leftAnchor.constraint(equalTo: self.humidityStackView.leftAnchor, constant: 10).isActive = true
        humidityValueLabel.rightAnchor.constraint(equalTo: self.humidityStackView.rightAnchor, constant: -10).isActive = true
        
        pressureTitleLabel.leftAnchor.constraint(equalTo: self.pressureStackView.leftAnchor, constant: 10).isActive = true
        pressureValueLabel.rightAnchor.constraint(equalTo: self.pressureStackView.rightAnchor, constant: -10).isActive = true
        
        speedTitleLabel.leftAnchor.constraint(equalTo: self.speedStackView.leftAnchor, constant: 10).isActive = true
        speedValueLabel.rightAnchor.constraint(equalTo: self.speedStackView.rightAnchor, constant: -10).isActive = true
        
        visibilityTitleLabel.leftAnchor.constraint(equalTo: self.visibilityStackView.leftAnchor, constant: 10).isActive = true
        visibilityValueLabel.rightAnchor.constraint(equalTo: self.visibilityStackView.rightAnchor, constant: -10).isActive = true
        
//        tempMinMaxStackView.topAnchor.constraint(equalTo: self.label_3.bottomAnchor).isActive = true
        
//        anotherLineDetailStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        NSLayoutConstraint.activate([
//            topTextStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
//            topTextStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
//            topTextStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
//            anotherLineDetailStackView.topAnchor.constraint(equalTo: self.topTextStackView.bottomAnchor),
//            anotherLineDetailStackView.heightAnchor.constraint(equalToConstant: self.frame.size.height)
//            anotherLineDetailStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
//            self.addSubview(topTextStackView)
//            self.addSubview(anotherLineDetailStackView)
            
//            entireStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
//            entireStackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
//            entireStackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
//            entireStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            
            entireStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            entireStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
