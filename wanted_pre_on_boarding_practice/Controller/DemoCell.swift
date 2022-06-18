//
//  DemoCell.swift
//  wanted_PreOnBoarding_practice
//
//  Created by 김성훈 on 2022/06/17.
//

import UIKit

class DemoCell: UICollectionViewCell {
    
    var myModel: WeatherValue? {
        didSet { bind() }
    }
    
    private func bind() {
        koreaCityName.text = String(describing: CityKoreaListDic.filter {$0.keys.contains(myModel!.name)}.first!.first!.value)
        guard let cityNameValue = myModel?.name else { return }
        cityName.text = String(describing: cityNameValue)
        guard let humidityValue = myModel?.main.humidity else { return }
        humidity.text = String(describing: humidityValue)
        guard let temperatureValue = myModel?.main.temp else { return }
        temperature.text = String(describing: temperatureValue)
        // catch 처리해야함
        //        guard let imgStringValue = myModel?.weather.first?.icon else { return }
        //        let urlStr = NSURL(string:"https://openweathermap.org/img/wn/\(imgStringValue).png")
        //        let urlData = NSData(contentsOf: urlStr! as URL)
        //        if urlData != nil {
        //            iconImage.image = UIImage(data: urlData! as Data)
        //        }
    }
    
    var cityName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "cityName"
        return label
    }()
    var koreaCityName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "한글"
        return label
    }()
    lazy var humidity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "humidity"
        return label
    }()
    lazy var temperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "temperature"
        return label
    }()
    lazy var iconImage: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        //        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var cityStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        addSubview(cityStackView)
        
        cityStackView.addArrangedSubview(koreaCityName)
        cityStackView.addArrangedSubview(cityName)
        
        stackView.addArrangedSubview(iconImage)
        stackView.addArrangedSubview(humidity)
        stackView.addArrangedSubview(temperature)
        
        NSLayoutConstraint.activate([
            humidity.rightAnchor.constraint(equalTo: self.temperature.leftAnchor, constant: -20),
            koreaCityName.leftAnchor.constraint(equalTo: self.leftAnchor),
            cityStackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            cityStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
