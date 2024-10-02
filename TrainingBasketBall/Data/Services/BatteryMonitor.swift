//
//  File.swift
//  TrainingBasketBall
//
//  Created by hamdi on 2/10/2024.
//

import Foundation
import UIKit
import Combine
 

class BatteryMonitor {
    private var batteryLevel: Float {
        // Retrieve battery level (0.0 to 1.0)
        return UIDevice.current.batteryLevel
    }

    private var isCharging: Bool {
        return UIDevice.current.batteryState == .charging || UIDevice.current.batteryState == .full
    }

    func batteryStatusPublisher() -> AnyPublisher<CharginfStatus, Never> {
        // Simulate current battery status
        let currentBatteryStatus: CharginfStatus = isCharging ? .charging(percent: Int(batteryLevel * 100)) : .notCharging(percent: Int(batteryLevel * 100))
        
        // Combine battery status changes with the initial status
        return NotificationCenter.default
            .publisher(for: UIDevice.batteryStateDidChangeNotification)
            .map { [weak self] _ in
                let percent = Int((self?.batteryLevel ?? 0) * 100)
                return self?.isCharging == true ? .charging(percent: percent) : .notCharging(percent: percent)
            }
            .prepend(currentBatteryStatus) // This ensures the initial battery status is sent
            .eraseToAnyPublisher()
    }
}
