//
//  WeatherService.swift
//  wanted_PreOnBoarding_practice
//
//  Created by 김성훈 on 2022/06/17.
//

import Foundation
import UIKit




// 에러 정의
enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

class WeatherService {
    
    
    let cityName: String
    
    init(cityName: String){
        self.cityName = cityName
    }
    
    func getWeather(completion: @escaping (Result<WeatherValue, NetworkError>) -> Void) {
        
        // API 호출을 위한 URL
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=\(Bundle.main.WEATHER_API_KEY)&q=\(cityName)&units=metric")
        
        guard let url = url else {
            return completion(.failure(.badUrl))
        }
        
        // Data 타입으로 받은 리턴을 디코드
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherValue.self, from: data)
            
            // 성공
            if let weatherResponse = weatherResponse {
                print(weatherResponse)
                completion(.success(weatherResponse))
            } else {
                print("error")
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

extension UIImageView {
    
}
