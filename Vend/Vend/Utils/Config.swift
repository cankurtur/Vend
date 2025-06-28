//
//  Config.swift
//  Vend
//
//  Created by Can Kurtur on 2025-06-26.
//

import Foundation

class Config {
    static let shared = Config()
    
    var configs: NSDictionary!
    
    private init() {
        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Config")!
        let path = Bundle.main.path(forResource: "Config", ofType: "plist")!
        configs = (NSDictionary(contentsOfFile: path)!.object(forKey: currentConfiguration) as! NSDictionary)
    }
}

extension Config {
    var baseUrl: String {
        return configs.object(forKey: "baseUrl") as! String
    }
    
    var googleAdAdaptiveBannerID: String {
        return configs.object(forKey: "googleAdAdaptiveBannerID") as! String
    }
}
