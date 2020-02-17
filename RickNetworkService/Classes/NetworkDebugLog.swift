//
//  NetworkDebugLog.swift
//  AlamofireTest
//
//  Created by Rick on 2019/10/15.
//  Copyright © 2019 Rick. All rights reserved.
//

import Foundation
import Alamofire

public enum DebugLogStatus: Int {
    case Debug
    case Test
    case Release
}

open class NetworkDebugLog {
    
    public static var logStatus: DebugLogStatus = DebugLogStatus.Debug
    
    open class func printDebugInfo(_ dataResponse: DataResponse<Any>){
        
        if logStatus != .Debug{
            return
        }
        
        print("\n -------------------------网络请求信息开始--------------------------- \n")
        
        if dataResponse.request != nil {
            print(" 请求如下：\n \(dataResponse.request!) \n")
            if dataResponse.request?.allHTTPHeaderFields != nil {
                print(" 请求头如下：\n \(dataResponse.request!.allHTTPHeaderFields!) \n")
            }
            
            if let httpBody = dataResponse.request?.httpBody {
                let bodyString = String(data: httpBody, encoding: String.Encoding.utf8)
                print(" 请求体如下：\n \(bodyString ?? "空") \n")
            }
        }
        
        print(" 请求耗时：\(dataResponse.timeline) \n")
        
        if dataResponse.response != nil {
            print(" 响应如下：\n \(dataResponse.response!) \n")
        }
        
        switch dataResponse.result {
        case .failure(let error):
            let statusCode = dataResponse.response?.statusCode
            print(" 请求失败，状态码：\(statusCode ?? 0) \n 错误：\(error) \n")
        case .success(let data):
            print(" 请求成功，服务器的响应数据为：\n \(data) \n")
        }
        
        print("\n -------------------------网络请求信息结束--------------------------- \n")
    }
    
}
