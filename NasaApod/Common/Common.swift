//
//  Common.swift
//  NasaApod
//
//  Created by Vishal on 8/1/2022.
//  Common constants/ functions

import Foundation

struct Constants {
    
    static let ErrorAlertTitle = "Error"
    static let OkAlertTitle = "Ok"
    static let CancelAlertTitle = "Cancel"
    static let CalenderImage = "calender"
    static let NoImage = "no-image-icon"
    static let ApodDateFormat = "yyyy-MM-dd"
    static let MediaTypeImage = "image"
    static let MediaTypeVideo = "video"
    static let CachedResponseKey = "CachedResponse"
    enum MediaType {
        case image
        case video
    }
    
    static func getAPIKey() -> String {
        
        let config = getConfig()
        return config?["APOD_KEY"] as? String ?? ""
    }
    
    static func getApodBaseURL() -> String {
        
        let config = getConfig()
        return config?["BASE_URL"] as? String ?? ""
    }
    
    static func getConfig() -> [String: Any]? {
        
        var config: [String: Any]?
        
        if let infoPlistPath = Bundle.main.url(forResource: "Info", withExtension: "plist") {
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)
                if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                    config = dict
                }
            } catch {
                print(error)
            }
        }
        return config
    }
}
