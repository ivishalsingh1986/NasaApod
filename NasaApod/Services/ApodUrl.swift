//
//  URLS.swift
//  NasaApod
//
//  Created by Vishal on 9/1/2022.
//  All Required API Enpoints can be configured here

import Foundation

struct ApiEndpoints {
    
    let apodURL: String
    
    init(date:String) {
        self.apodURL = "https://\(Constants.getApodBaseURL())/planetary/apod?api_key=\(Constants.getAPIKey())&date=\(date)"
    }
    
}
