//
//  GetStatusUseCase.swift
//  TrainingBasketBall
//
//  Created by hamdi on 2/10/2024.
//

import Foundation
import Combine

protocol ConnectToMachineUseCase {
    func execute() -> AnyPublisher<MachineStatus, Never>
}

import Combine

class ConnectToMachineUseCaseImpl: ConnectToMachineUseCase {
    private let machineService: MachineService
    private var cancellables = Set<AnyCancellable>()

    init(machineService: MachineService) {
        self.machineService = machineService
    }

    func execute() -> AnyPublisher<MachineStatus, Never> {
        return machineService.connect()
       
          
    }
}
