//
//  Client.swift
//  WeatherProject
//
//  Created by Yusuf Aksu on 27.11.2022.
//

import Foundation

final class Client {

    enum Endpoints {
        static let base = "http://api.weatherstack.com/current?access_key=449133655f19851094b90d60d8b7c1af"

        case byName(String)

        var stringValue: String {
            switch self {
            case .byName(let cityName):
                return Endpoints.base + "&query=\(cityName)"
            }
        }

        var url: URL {
            return URL(string: stringValue)!
        }
    }

    @discardableResult
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(BaseResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()

        return task
    }

  class func getWeather(cityName:String, completion: @escaping (WeatherModel?, Error?) -> Void) {
        taskForGETRequest(url: Endpoints.byName(cityName).url, responseType: WeatherModel.self) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
