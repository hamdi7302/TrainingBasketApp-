//
//  MachineService.swift
//  TrainingBasketBall
//
//  Created by hamdi on 2/10/2024.
//
import Foundation
import Combine
import UIKit

protocol MachineService {
    func connect() -> AnyPublisher<MachineStatus, Never>
}

enum MachineStatus {
    case connecting
    case connected
    case failed
}


class MachineServiceImpl: MachineService {
    private var statusSubject = PassthroughSubject<MachineStatus, Never>()
    private var cancellables = Set<AnyCancellable>()

    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true // Enable battery monitoring
    }

    func connect() -> AnyPublisher<MachineStatus, Never> {
        statusSubject.send(.connecting)

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            let isSuccess = Bool.random()
            if isSuccess {
                self.statusSubject.send(.connected)
            } else {
                self.statusSubject.send(.failed)
            }
            self.statusSubject.send(completion: .finished)
        }

        return statusSubject.eraseToAnyPublisher()
    }
}
