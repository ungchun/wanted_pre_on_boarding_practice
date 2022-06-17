//
//  WeatherService.swift
//  wanted_PreOnBoarding_practice
//
//  Created by 김성훈 on 2022/06/17.
//

import Foundation


// 에러 정의
enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

class WeatherService {
    func getWeather(completion: @escaping (Result<WeatherValue, NetworkError>) -> Void) {
        
        // API 호출을 위한 URL
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=\(Bundle.main.WEATHER_API_KEY)&q=seoul")
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

struct WeatherValue: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

