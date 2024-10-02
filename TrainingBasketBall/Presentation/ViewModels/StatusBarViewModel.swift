//
//  StatusBarViewModel.swift
//  TrainingBasketBall
//
//  Created by hamdi on 2/10/2024.
//

import Foundation
import Combine
import SwiftUI

class StatusBarViewModel: ObservableObject {
    
    private let connectToMachineUseCase: ConnectToMachineUseCase
    private let batteryMonitor: BatteryMonitor
    private var cancellables = Set<AnyCancellable>()
    
    @Published var connectionStatus: ConnectionStatus = .connecting
    
    init(connectToMachineUseCase: ConnectToMachineUseCase, batteryMonitor: BatteryMonitor) {
        self.connectToMachineUseCase = connectToMachineUseCase
        self.batteryMonitor = batteryMonitor
        
         
        combineStatuses()
        connect() // to move to onappear 
      
    }
    
    func connect() {
        connectToMachineUseCase.execute()
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
    
    private func combineStatuses() {
        let connectionPublisher = connectToMachineUseCase.execute()
        let batteryPublisher = batteryMonitor.batteryStatusPublisher()
        
        connectionPublisher
            .combineLatest(batteryPublisher)
            .sink { [weak self] machineStatus, chargingStatus in
                self?.updateConnectionStatus(connectionStatus: machineStatus, chargingStatus: chargingStatus)
            }
            .store(in: &cancellables)
    }
    
    private func updateConnectionStatus(connectionStatus: MachineStatus, chargingStatus: CharginfStatus) {
        withAnimation {
            switch connectionStatus {
            case .connecting:
                self.connectionStatus = .connecting
            case .connected:
                self.connectionStatus = .connected(chargingStatus: chargingStatus)
            case .failed:
                self.connectionStatus = .failed
            }
        }
    }
}





