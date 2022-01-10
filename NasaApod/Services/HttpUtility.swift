//
//  HttpUtility.swift
//  NasaApod
//
//  Created by Vishal on 8/1/2022.
//  HttpUtility is used to call API's

import Foundation

struct HttpUtility
{
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T?, _ error:String?)-> Void)
    {
        debugPrint(requestUrl)
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                do {
                    debugPrint("API Success")
                    let result = try JSONDecoder().decode(T.self, from: responseData!)
                    _=completionHandler(result,nil)
                }
                catch let error {
                    debugPrint("API error occured while decoding = \(error.localizedDescription)")
                    _=completionHandler(nil,error.localizedDescription)
                }
            }else {
                debugPrint("API Failed")
                _=completionHandler(nil,error?.localizedDescription)
            }
            
        }.resume()
    }
}
