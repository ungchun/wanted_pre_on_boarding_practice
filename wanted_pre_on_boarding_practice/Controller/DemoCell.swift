//
//  DemoCell.swift
//  wanted_PreOnBoarding_practice
//
//  Created by 김성훈 on 2022/06/17.
//

import UIKit

//// MARK: Loading
//class LoadingIndicator {
//    static func showLoading() {
//        DispatchQueue.main.async {
//            // 최상단에 있는 window 객체 획득
//            guard let window = UIApplication.shared.windows.last else { return }
//            let loadingIndicatorView: UIActivityIndicatorView
//            if let existedView = window.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
//                loadingIndicatorView = existedView
//            } else {
//                loadingIndicatorView = UIActivityIndicatorView(style: .large)
//                // 다른 UI가 눌리지 않도록 indicatorView의 크기를 full로 할당
//                loadingIndicatorView.frame = window.frame
//                window.addSubview(loadingIndicatorView)
//            }
//            loadingIndicatorView.startAnimating()
//        }
//    }
//    static func hideLoading() {
//        DispatchQueue.main.async {
//            guard let window = UIApplication.shared.windows.last else { return }
//            window.subviews.filter({ $0 is UIActivityIndicatorView }).forEach { $0.removeFromSuperview() }
//        }
//    }
//}

class ImageCacheManager {
    
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}

class DemoCell: UICollectionViewCell {
    //     var activityIndicator  = {
    //    let indicator = UIActivityIndicatorView()
    //    indicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    //    indicator.center = self.center
    //    return indicator
    //}
    
    let activityIndicatorView =  UIActivityIndicatorView(style: .medium)
    
    
    var myModel: WeatherValue? {
        didSet { bind() }
    }
    
    private func bind() {
        
        koreaCityName.text = String(describing: CityKoreaListDic.filter {$0.keys.contains(myModel!.name)}.first!.first!.value)
        guard let cityNameValue = myModel?.name else { return }
        cityName.text = String(describing: cityNameValue)
        guard let humidityValue = myModel?.main.humidity else { return }
        humidity.text =  "\(String(describing: humidityValue)) %"
        guard let temperatureValue = myModel?.main.temp else { return }
        let intTemperatureValue = Int(temperatureValue)
        temperature.text = "\(String(describing: intTemperatureValue)) ℃"
        
        // catch 처리해야함
        guard let imgStringValue = myModel?.weather.first?.icon else { return }
        let url = "https://openweathermap.org/img/wn/\(imgStringValue).png"
        //        let cacheKey = String(describing: url) // 캐시에 사용될 Key 값
        let cacheKey = NSString(string: url) // 캐시에 사용될 Key
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) { // 해당 Key 에 캐시이미지가 저장되어 있으면 이미지를 사용
            print("이미지 캐시 있음")
            stackView.removeArrangedSubview(activityIndicatorView)
            
            iconImage.image = cachedImage
            stackView.addArrangedSubview(iconImage)
            stackView.addArrangedSubview(humidity)
            stackView.addArrangedSubview(temperature)
            
            cityStackView.addArrangedSubview(koreaCityName)
            cityStackView.addArrangedSubview(cityName)
            
            koreaCityName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
            cityName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
            humidity.rightAnchor.constraint(equalTo: self.temperature.leftAnchor, constant: -20).isActive = true
            activityIndicatorView.stopAnimating()
            return
        } else {
            print("이미지 캐시 없음")
            let url = NSURL(string: "https://openweathermap.org/img/wn/\(imgStringValue).png")
            let urlData = NSData(contentsOf: url! as URL)
            if urlData != nil {
                stackView.removeArrangedSubview(activityIndicatorView)
                ImageCacheManager.shared.setObject(UIImage(data: urlData! as Data)!, forKey: cacheKey) // 다운로드된 이미지를 캐시에 저장
                iconImage.image = UIImage(data: urlData! as Data)
                stackView.addArrangedSubview(iconImage)
                stackView.addArrangedSubview(humidity)
                stackView.addArrangedSubview(temperature)
                
                cityStackView.addArrangedSubview(koreaCityName)
                cityStackView.addArrangedSubview(cityName)
                
                koreaCityName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
                cityName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
                humidity.rightAnchor.constraint(equalTo: self.temperature.leftAnchor, constant: -20).isActive = true
                activityIndicatorView.stopAnimating()
            }
        }
    }
    
    var cityName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "city"
        label.textColor = .white
        return label
    }()
    var koreaCityName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "도시"
        label.font = .systemFont(ofSize: 35)
        label.textColor = .white
        return label
    }()
    lazy var humidity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "습도"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    lazy var temperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "온도"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
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
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        self.backgroundColor = .black
        activityIndicatorView.startAnimating()
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        //        activityIndicatorView.backgroundColor = .white
        addSubview(activityIndicatorView)
        addSubview(stackView)
        addSubview(cityStackView)
        
//        cityStackView.addArrangedSubview(koreaCityName)
//        cityStackView.addArrangedSubview(cityName)
        
        stackView.addArrangedSubview(activityIndicatorView)
        
//        stackView.addArrangedSubview(iconImage)
//        stackView.addArrangedSubview(humidity)
//        stackView.addArrangedSubview(temperature)
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
//            koreaCityName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
//            cityName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            
            cityStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30),
            cityStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
