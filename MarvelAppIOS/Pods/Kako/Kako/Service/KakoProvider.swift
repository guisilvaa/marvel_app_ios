//
//  KakoProvider.swift
//  Kako
//
//  Created by Guilherme Silva on 05/03/21.
//

import Foundation
import UIKit
import Moya
import ObjectMapper
import Reachability

public class KakoProvider<Target>: MoyaProvider<Target> where Target: Moya.TargetType {
    
    private var isRefreshing = false
    
    private var reachability: Reachability!
    
    public init() {
        
        let tokenPlugin = AccessTokenPlugin { (_) -> String in
            return KakoManager.shared.dataSource.accessToken()
        }
        
        let endpointClosure = { (target: Target) -> Endpoint in
            let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
            var headers = [String: String]()
            
            if let customHeaders = KakoManager.shared.dataSource.customHeaders() {
                customHeaders.forEach { headers.updateValue($0.value, forKey: $0.key) }
            }
            
            return defaultEndpoint.adding(newHTTPHeaderFields: headers)
        }
        
        let loggerConfig = NetworkLoggerPlugin.Configuration(logOptions: .verbose)
        let networkLoggerPlugin = NetworkLoggerPlugin(configuration: loggerConfig)
        
        super.init(endpointClosure: endpointClosure, plugins: [networkLoggerPlugin, tokenPlugin])
    }
    
    public func isReachable() -> Bool {
        self.reachability = try! Reachability()
        return self.reachability.connection != .unavailable
    }
    
    public func requestObject<T: Mappable>(target: Target, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, completionHandler: @escaping (Result<T, KakoError>) -> Void) {
        requestService(target: target, callbackQueue: callbackQueue, progress: progress, objectHandler: completionHandler)
    }
    
    public func requestCollection<T: Mappable>(target: Target, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, completionHandler:  @escaping (Result<[T], KakoError>) -> Void) {
        requestService(target: target, callbackQueue: callbackQueue, progress: progress, collectionHandler: completionHandler)
    }
    
    private func requestService<T: Mappable>(target: Target, callbackQueue: DispatchQueue? = .none, progress: ProgressBlock? = .none, objectHandler: ((Result<T, KakoError>) -> Void)? = nil, collectionHandler: ((Result<[T], KakoError>) -> Void)? = nil) {
        if self.isReachable() {
            
            self.request(target, callbackQueue: callbackQueue, progress: progress, completion: { (result) in
                switch result {
                case .success(let response):
                    if response.statusCode >= 200 && response.statusCode <= 300 {
                        if response.statusCode == 200 {
                            do {
                                let json = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
                                if let handler = objectHandler,
                                   let object = Mapper<T>().map(JSONObject: json) {
                                    handler(.success(object))
                                }
                                else if let handler = collectionHandler,
                                        let array = Mapper<T>().mapArray(JSONObject: json) {
                                    handler(.success(array))
                                }
                            }
                            catch {
                                self.completionError(error: KakoError(error: .parse), objectHandler: objectHandler, collectionHandler: collectionHandler)
                            }
                        }
                        else {
                            let emptyResponse = Mapper<T>().map(JSONString: "{}")!
                            
                            if let handler = objectHandler {
                                handler(.success(emptyResponse))
                            }
                        }
                    }
                    else if response.statusCode == 401 {
                        self.refreshToken(target: target, objectHandler: objectHandler, collectionHandler: collectionHandler)
                    }
                    else if response.statusCode == 412 {
                        self.completionError(error: KakoError(error: .invalidAppVersion), objectHandler: objectHandler, collectionHandler: collectionHandler)
                    }
                    else {
                        let error = self.handleErrorResponse(response: response)
                        self.completionError(error: error, objectHandler: objectHandler, collectionHandler: collectionHandler)
                    }
                case .failure(let error):
                    let err = self.handleErrorResponse(error: error)
                    self.completionError(error: err, objectHandler: objectHandler, collectionHandler: collectionHandler)
                }
            })
        }
        else {
            self.completionError(error: KakoError(error: .connection), objectHandler: objectHandler, collectionHandler: collectionHandler)
        }
    }
    
    private func completionError<T: Mappable>(error: KakoError, objectHandler: ((Result<T, KakoError>) -> Void)? = nil, collectionHandler: ((Result<[T], KakoError>) -> Void)? = nil) {
        
        if let handler = objectHandler {
            handler(.failure(error))
        }
        else if let handler = collectionHandler {
            handler(.failure(error))
        }
    }
    
    private func refreshToken<T: Mappable>(target: Target, objectHandler: ((Result<T, KakoError>) -> Void)? = nil, collectionHandler: ((Result<[T], KakoError>) -> Void)? = nil) {
        //TODO
        /*
        if !isRefreshing {
            self.isRefreshing = true
            
            
            AuthenticationManager.shared.refreshToken(completionHandler: { (result) in
                
                self.isRefreshing = false
                
                switch result {
                case .success(_):
                    if let handler = collectionHandler {
                        self.requestCollection(target: target, completionHandler: handler)
                    }
                    else {
                        self.requestObject(target: target, completionHandler: objectHandler!)
                    }
                    
                case .failure(_):
                    if let handler = collectionHandler {
                        handler(.failure(GameficError(error: .unauthorized)))
                    }
                    else {
                        objectHandler!(.failure(GameficError(error: .unauthorized)))
                    }
                }
            })
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
                if let handler = collectionHandler {
                    self.requestCollection(target: target, completionHandler: handler)
                }
                else if let handler = objectHandler {
                    self.requestObject(target: target, completionHandler: handler)
                }
            })
        }*/
    }
    
    func handleErrorResponse(response: Response? = nil, error: MoyaError? = nil) -> KakoError {
        if let response = response {
            print(response.debugDescription)
            
            do {
                let json = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
                print(json)
                if let obj = Mapper<KakoError>().map(JSONObject: json) {
                    return obj
                }
                
                return KakoError(error: .parse)
            }
            catch {
                return KakoError(error: .parse)
            }
        }
        else if let error = error {
            print(error.errorDescription ?? "")
            
            //TODO fix later MoyaError
            if error.localizedDescription.contains("timed out") {
                return KakoError(error: .timeout)
            }
            
            return KakoError(error: .unknown)
        }
        else {
            return KakoError(error: .unknown)
        }
    }
}
