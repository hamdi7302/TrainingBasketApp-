//
//  ConnectionStatus.swift
//  TrainingBasketBall
//
//  Created by hamdi on 2/10/2024.
//

import Foundation

enum ConnectionStatus {
    case connecting
    case connected(chargingStatus: CharginfStatus)
    case failed
    
    var description: (mainMsg: String,subMsg: String?) {
        switch self {
        case .connecting:
            return ("Connecting to machine...",nil)
        case .connected(let chargingStatus):
            return ("Connected" ,"\(chargingStatus.description)")
        case .failed:
            return ("Connection Failed. Try Again.",nil)
        }
    }
}

enum CharginfStatus {
    case notCharging(percent: Int)
    case charging(percent: Int)
    
    var description: String {
        switch self {
        case .notCharging(let percent):
            return "\(percent)%"
        case .charging(let percent):
            return "\(percent)% Charging"
        }
    }
    
}
