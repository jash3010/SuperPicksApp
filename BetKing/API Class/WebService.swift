//
//  WebService.swift
//  BetKing
//
//  Created by MAC on 23/07/21.
//

import Foundation
import UIKit
import Alamofire

typealias WebServiceResponse = (_ result:NSDictionary?,_ error:Error?) -> ()
typealias WebServiceResponseData = (_ data:Data?,_ error:Error?) -> ()
final class WebService{
    
    static let shared = WebService()
    
    func callPostForDict(api: String, parameters: [String: Any]? = nil,
                     showIndicator: Bool? = true, responseClosure: @escaping WebServiceResponse) {
        
        if !NetworkReachabilityManager()!.isReachable {
            //displayAlertWithSettings()
            return
        }
        
        if showIndicator! {
            Indicator.shared.show()
        }
        
        
        
        let accessToken = "Basic " + "dG9rZW5QYWw6"
        
        let header: HTTPHeaders = ["Authorization": accessToken,
                                   "Accept":"application/json"]
        
        
        let apiString = Apis.BaseUrl + (api as String)
        print(apiString)
        debugPrint("********************************* API Request **************************************")
        debugPrint("Request URL:\(apiString)")
        debugPrint("Request Parameters: \(parameters ?? [: ])")
        debugPrint("Request Headers: \("Bearer")")
        debugPrint("************************************************************************************")
        
        AF.request(apiString, method: .post, parameters:  parameters , encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                Indicator.shared.hide()
                switch response.result
                {
                case .success(_):
                    print(NSString(data: response.data ?? Data(), encoding: String.Encoding.utf8.rawValue) ?? "")
                    if let error = response.error {
                        if let data = response.data{
                            
                            if let data = response.value as? NSDictionary
                            {
                                responseClosure(data, nil)
                            }else{
                                let myDictOfDict:NSDictionary = [
                                    "a" : response.value!
                                ]
                                responseClosure(myDictOfDict, nil)
                            }
                        }else{
                            return responseClosure(nil, error)
                        }
                    }else{
                        return responseClosure(nil, response.error)
                    }
                case .failure(let error):
                    return responseClosure(nil, error)
                }
            }
    }

    func callPostAPIForData(api: String, parameters: [String: Any]? = nil,
                            showIndicator: Bool? = true, responseClosure: @escaping WebServiceResponseData) {
        
        if !NetworkReachabilityManager()!.isReachable {
            //displayAlertWithSettings()
            return
        }
        
        if showIndicator! {
            Indicator.shared.show()
        }
        
        
        let accessToken = "Basic " + "dG9rZW5QYWw6"
        
        let header: HTTPHeaders = ["Authorization": accessToken,
                                   "Accept":"application/json"]
        
        
        let apiString = Apis.BaseUrl + (api as String)
        print(apiString)
        debugPrint("********************************* API Request **************************************")
        debugPrint("Request URL:\(apiString)")
        debugPrint("Request Parameters: \(parameters ?? [: ])")
        debugPrint("Request Headers: \("Bearer")")
        debugPrint("************************************************************************************")
        
        AF.request(apiString, method: .post, parameters:  parameters , encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                Indicator.shared.hide()
                print(response)
                switch response.result
                {
                case .success(_):
                    responseClosure(response.data, nil)
                case .failure(let error):
                    return responseClosure(nil, error)
                }
            }
    }
    
    func callGetAPIForData(api: String,parameters: [String: Any]? = nil ,showIndicator: Bool? = true, useToken: Bool? = true, responseClosure: @escaping WebServiceResponseData) {
        
        if !NetworkReachabilityManager()!.isReachable {
            //displayAlertWithSettings()
            return
        }
        
        if showIndicator! {
            //     Indicator.shared.show()
        }
        
        let header: HTTPHeaders = ["X-API-PLAYSOURCE": "1",
                                   "X-API-BRAND":"1901"]
        
        
        let apiString = (Apis.BaseUrl + (api as String))
        
        print(apiString)
        
        debugPrint("********************************* API Request **************************************")
        debugPrint("Request URL:\(apiString)")
        debugPrint("Request Headers: \(header)")
        debugPrint("************************************************************************************")
        
        AF.request(apiString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                Indicator.shared.hide()
                switch response.result
                {
                case .success(_):
                    print(response.result)
                    print(NSString(data: response.data ?? Data(), encoding: String.Encoding.utf8.rawValue) ?? "")
                    if response.error == nil {
                        
                        if let data = response.data{
                            return responseClosure(data, nil)
                        }else{
                            return responseClosure(nil, response.error)
                        }
                    }else{
                        return responseClosure(nil, response.error)
                    }
                case .failure(let error):
                    return responseClosure(nil, error)
                }
            }
    }
}
