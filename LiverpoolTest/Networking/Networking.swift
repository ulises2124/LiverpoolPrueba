//
//  Networking.swift
//  LiverpoolTest
//
//  Created by Ulises Atonatiuh González Hernández on 14/10/20.
//


import Foundation
protocol APIClientProtocol: Any {
    func getRequest( parametro: String, page: String, total: String, completionBlock: @escaping (_ response: ResponseData?, _ error: String?) -> Void)
    func downloadImage(url: String, completionBlock: @escaping (_ response: Data?, _ error: String?) -> Void)
}

class Networking: APIClientProtocol {
  
    fileprivate let defaultSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10.0
        configuration.timeoutIntervalForResource = 10.0
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
    }()

    public init() { }

    
    public func downloadImage(url: String, completionBlock: @escaping (Data?, String?) -> Void) {
        let url = URL(string: url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let task = defaultSession.dataTask(with: urlRequest) { data, urlResponse, error in
            if error != nil {
                completionBlock(nil, Error.request.rawValue)
                return
            }
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                return
            }
            if httpResponse.statusCode == 200 {
                guard let data = data else {
                    return
                }
                
                do {
                   
                    completionBlock(data, nil)
                } catch _ {
                    completionBlock(nil, Error.serialization.rawValue)
                }
            } else {
                completionBlock(nil, Error.http.rawValue)
            }
        }
        task.resume()
    }
    
    
    public func getRequest(parametro: String, page: String, total: String, completionBlock: @escaping (ResponseData?, String?) -> Void) {
        
        
        if !InternetConnection.isConnectedToNetwork() {
            completionBlock(nil, Error.noInternet.rawValue)
            return
        }
        
        let urlfinal = Strings.url.rawValue + parametro + Strings.urlSection2.rawValue + page + Strings.urlSection3.rawValue + total
        let url = URL(string: urlfinal)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let task = defaultSession.dataTask(with: urlRequest) { data, urlResponse, error in
            if error != nil {
                completionBlock(nil, Error.request.rawValue)
                return
            }
            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                return
            }
            if httpResponse.statusCode == 200 {
                guard let data = data else {
                    return
                }
                
                do {
                    
                    
                    let jsonData: Data = data
                    let jsonDict = try JSONSerialization.jsonObject(with: jsonData) as? NSDictionary
                        print(jsonDict! as Any)
                    
                    let npsResponse = try JSONDecoder().decode(ResponseData.self, from: data)
                   
                    completionBlock(npsResponse, nil)
                } catch let myJSONError {
                    print(myJSONError)
                    completionBlock(nil, Error.serialization.rawValue)
                }
            } else {
                completionBlock(nil, Error.http.rawValue)
            }
        }
        task.resume()
    }

}

extension Networking {

    enum Error: String {
        case serialization = "Error de parsing"
        case request = "Error de request"
        case http = "Error de conexion"
        case noInternet = "No tienes Internet"
    }

}
