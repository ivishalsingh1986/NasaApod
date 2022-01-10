//
//  ApodHomeViewModel.swift
//  NasaApod
//
//  Created by Vishal on 8/1/2022.
//  ApodHomeViewModel is View Model for HomeViewController all BusisinesLogic / API call can be here

import Foundation

class ApodHomeViewModel
{
    var date: String?
    var title: String?
    var explanation: String?
    var url: String?
    var media_type: Constants.MediaType?
    let cache = NSCache<NSString, ApodResponse>()
    var queryDate : NSString?
    
    
    func updateQueryDate(queryDate: Date) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.ApodDateFormat
        let dateString = dateFormatter.string(from: queryDate)
        self.queryDate = dateString as NSString
    }
    
    //Modify business logic here if needed
    func updateResponse(apodApiResponse:ApodResponse) {
        
        self.date = apodApiResponse.date
        self.title = apodApiResponse.title
        self.explanation = apodApiResponse.explanation
        self.url = apodApiResponse.url
        if(apodApiResponse.media_type == Constants.MediaTypeImage) {
            self.media_type = .image
        }else {
            self.media_type = .video
        }
    }
    
    //APOD API Call
    func callApodApi(queryDate: Date, completion : @escaping (_ isSuccess: Bool,_ error:String?) -> Void) {
        
        
        self.updateQueryDate(queryDate: queryDate)
        guard let queryDate = self.queryDate else {
            return
        }
        let apodRequest = ApodRequest(date: queryDate as String)
        //Use ApodResource to call API
        let apodResource = ApodResource()
        apodResource.getApod(apodRequest: apodRequest) { [self] (apodApiResponse,error) in
            
            //Return the response to view get from apodResource
            if(error == nil && apodApiResponse != nil) {
                
                self.updateResponse(apodApiResponse: apodApiResponse!)
                
                //If need to cache all requests
                //cache.setObject(apodApiResponse!, forKey: self.queryDate as NSString)
                cache.setObject(apodApiResponse!, forKey: Constants.CachedResponseKey as NSString)
                _ = completion(true,nil)
                
            } else {
                
                if let cachedResponse = cache.object(forKey: Constants.CachedResponseKey as NSString)  {
                    // Return Last API Cached Response
                    self.updateResponse(apodApiResponse: cachedResponse)
                    _ = completion(true,nil)
                }
                // Also Return Error
                _ = completion(false,error)
            }
        }
    }
}
