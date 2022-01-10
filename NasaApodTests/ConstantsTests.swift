//
//  NasaApodTests.swift
//  NasaApodTests
//
//  Created by Vishal on 8/1/2022.
//

import XCTest
@testable import NasaApod

class ConstantsTests: XCTestCase {
    
    func testConstantValues() throws {
        
        XCTAssertEqual(Constants.ApodDateFormat, "yyyy-MM-dd")
        XCTAssertEqual(Constants.CalenderImage, "calender")
        XCTAssertEqual(Constants.NoImage, "no-image-icon")
        XCTAssertEqual(Constants.ErrorAlertTitle, "Error")
        XCTAssertEqual(Constants.OkAlertTitle, "Ok")
        XCTAssertEqual(Constants.CancelAlertTitle, "Cancel")
        XCTAssertEqual(Constants.MediaTypeImage, "image")
        XCTAssertEqual(Constants.MediaTypeVideo, "video")
        
    }
    
    func testAPIKEY() throws {
        
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
        let apiKey =  config?["APOD_KEY"] as? String ?? ""
        XCTAssertEqual(Constants.getAPIKey(), apiKey)
        
        //Test Base URL
        
        let baseURL =  config?["BASE_URL"] as? String ?? ""
        XCTAssertEqual(Constants.getApodBaseURL(), baseURL)
        
    }
    
}
