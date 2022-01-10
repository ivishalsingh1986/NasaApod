//
//  NasaApodTests.swift
//  NasaApodTests
//
//  Created by Vishal on 8/1/2022.
//

import XCTest
@testable import NasaApod

class ApiEndpointsTests: XCTestCase {

    func testApodURL() throws {
        
        let apodURL = ApiEndpoints(date: "test").apodURL
        let testURL = "https://\(Constants.getApodBaseURL())/planetary/apod?api_key=\(Constants.getAPIKey())&date=test"
        XCTAssertEqual(apodURL, testURL)
    }
}
