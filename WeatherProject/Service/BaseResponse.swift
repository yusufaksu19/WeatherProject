//
//  BaseResponse.swift
//  WeatherProject
//
//  Created by Yusuf Aksu on 27.11.2022.
//

import Foundation

struct BaseResponse: Codable {
    let success: Bool
    let message: String
}

extension BaseResponse: LocalizedError {
    var errorDescription: String? {
        return message
    }
}
