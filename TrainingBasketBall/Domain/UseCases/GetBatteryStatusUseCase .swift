//
//  GetBatteryStatusUseCase .swift
//  TrainingBasketBall
//
//  Created by hamdi on 2/10/2024.
//

import Foundation



import Combine

protocol GetBatteryStatusUseCase {
    func execute() -> AnyPublisher<CharginfStatus, Never>
}

class GetBatteryStatusUseCaseImpl: GetBatteryStatusUseCase {
    private let batteryMonitor: BatteryMonitor

    init(batteryMonitor: BatteryMonitor) {
        self.batteryMonitor = batteryMonitor
    }

    func execute() -> AnyPublisher<CharginfStatus, Never> {
        // Simply return the battery status publisher from the service
        return batteryMonitor.batteryStatusPublisher()
    }
}

