//
//  DemoCell.swift
//  wanted_PreOnBoarding_practice
//
//  Created by 김성훈 on 2022/06/17.
//

import UIKit

class ImageCacheManager {
    
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}

class MainCollectionViewCell: UICollectionViewCell {
    
    let activityIndicatorView =  UIActivityIndicatorView(style: .medium) // API 값 불러오는 동안 보이는 loadingView
    
    var weatherModel: WeatherModel? {
        didSet { bind() } // API로 들어오는 weatherModel의 갱신된 값을 갱신될때마다 cell에 보여줘야함 -> didset, willset
    }
    
    fileprivate func bind() {
        koreaCityName.text = String(describing: CityKoreaListDic.filter {$0.keys.contains(weatherModel!.name)}.first!.first!.value)
        
        guard let cityNameValue = weatherModel?.name else { return }
        cityName.text = String(describing: cityNameValue)
        
        guard let humidityValue = weatherModel?.main.humidity else { return }
        humidity.text =  "\(String(describing: humidityValue)) %"
        
        guard let temperatureValue = weatherModel?.main.temp else { return }
        let intTemperatureValue = Int(temperatureValue)
        temperature.text = "\(String(describing: intTemperatureValue))°"
        
        guard let imgStringValue = weatherModel?.weather.first?.icon else { return }
        let url = "https://openweathermap.org/img/wn/\(imgStringValue).png"
        let cacheKey = String(describing: url) // 캐시에 사용될 Key 값
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey as NSString) { // 해당 Key 에 캐시이미지가 저장되어 있으면 이미지를 사용
            print("이미지 캐시 있음")
            stackView.removeArrangedSubview(activityIndicatorView) // loadingView remove
            
            // 불러온값들 set
            iconImage.image = cachedImage
            
            stackView.addArrangedSubview(iconImage)
            stackView.addArrangedSubview(humidity)
            stackView.addArrangedSubview(temperature)
            
            cityStackView.addArrangedSubview(koreaCityName)
            cityStackView.addArrangedSubview(cityName)
            
            koreaCityName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
            cityName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
            humidity.rightAnchor.constraint(equalTo: self.temperature.leftAnchor, constant: -20).isActive = true
            
            activityIndicatorView.stopAnimating() // activityIndicatorView stopAnimating
            return
        } else {
            print("이미지 캐시 없음")
            let url = NSURL(string: "https://openweathermap.org/img/wn/\(imgStringValue).png")
            let urlData = NSData(contentsOf: url! as URL)
            if urlData != nil {
                stackView.removeArrangedSubview(activityIndicatorView) // loadingView remove
                
                ImageCacheManager.shared.setObject(UIImage(data: urlData! as Data)!, forKey: cacheKey as NSString) // 다운로드된 이미지를 캐시에 저장
                
                // 불러온값들 set
                iconImage.image = UIImage(data: urlData! as Data)
                
                stackView.addArrangedSubview(iconImage)
                stackView.addArrangedSubview(humidity)
                stackView.addArrangedSubview(temperature)
                
                cityStackView.addArrangedSubview(koreaCityName)
                cityStackView.addArrangedSubview(cityName)
                
                koreaCityName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
                cityName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
                humidity.rightAnchor.constraint(equalTo: self.temperature.leftAnchor, constant: -20).isActive = true
                
                activityIndicatorView.stopAnimating() // activityIndicatorView stopAnimating
            }
        }
    }
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        activityIndicatorView.startAnimating() // loadingView
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(activityIndicatorView)
        addSubview(stackView)
        addSubview(cityStackView)
        
        stackView.addArrangedSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            cityStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            cityStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    private lazy var cityName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "city"
        label.textColor = .white
        return label
    }()
    private lazy var koreaCityName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "도시"
        label.font = .systemFont(ofSize: 35)
        label.textColor = .white
        return label
    }()
    private lazy var humidity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "습도"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    private lazy var temperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "온도"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    private lazy var iconImage: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
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
    
    private lazy var tempView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        return view
    }()

}
