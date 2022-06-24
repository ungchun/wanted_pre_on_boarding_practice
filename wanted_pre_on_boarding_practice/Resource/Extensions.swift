//
//  Extensions.swift
//  wanted_PreOnBoarding_practice
//
//  Created by 김성훈 on 2022/06/17.
//

import Foundation
import UIKit

// 숨긴 API KEY 받기
extension Bundle {
    
    // 생성한 .plist 파일 경로 불러오기
    var WEATHER_API_KEY: String {
        guard let file = self.path(forResource: "WeatherInfo", ofType: "plist") else { return "" }
        
        // .plist를 딕셔너리로 받아오기
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        // 딕셔너리에서 값 찾기
        guard let key = resource["WEATHER_API_KEY"] as? String else {
            fatalError("WEATHER_API_KEY error")
        }
        return key
    }
}

extension UIImageView {
    // 이미지 캐시
    func setImageUrl(_ url: String) {
        let cacheKey = NSString(string: url) // 캐시에 사용될 Key 값
        
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) { // 해당 Key 에 캐시이미지가 저장되어 있으면 이미지를 사용
            self.image = cachedImage
            return
        }
        
        // 캐시이미지가 없으면
        DispatchQueue.global(qos: .background).async {
            if let imageUrl = URL(string: url) {
                URLSession.shared.dataTask(with: imageUrl) { (data, res, err) in
                    if let _ = err {
                        DispatchQueue.main.async {
                            self.image = UIImage()
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        if let data = data, let image = UIImage(data: data) {
                            ImageCacheManager.shared.setObject(image, forKey: cacheKey) // 다운로드된 이미지를 캐시에 저장
                            self.image = image
                        }
                    }
                }.resume()
            }
        }
    }
}


