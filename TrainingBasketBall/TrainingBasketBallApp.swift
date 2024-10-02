//
//  TrainingBasketBallApp.swift
//  TrainingBasketBall
//
//  Created by hamdi on 2/10/2024.
//

import SwiftUI

@main
struct TrainingBasketBallApp: App {
   
    let connectToMachineUseCase: ConnectToMachineUseCase
    let machineService: MachineService
    
    
    init() {
        machineService = MachineServiceImpl()
        connectToMachineUseCase = ConnectToMachineUseCaseImpl(machineService: machineService)
        
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                StatusBarView(viewModel: StatusBarViewModel(connectToMachineUseCase:  ConnectToMachineUseCaseImpl(machineService:  MachineServiceImpl()), batteryMonitor: BatteryMonitor()))
                
            } .frame(maxWidth: .infinity)
                .background(Color.cyan)
        }
    }
}
