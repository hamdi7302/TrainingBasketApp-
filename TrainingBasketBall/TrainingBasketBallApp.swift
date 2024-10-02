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
    let statusBarViewModel: StatusBarViewModel
    let batteryMonitor: BatteryMonitor
    
    init() {
        machineService = MachineServiceImpl()
        connectToMachineUseCase = ConnectToMachineUseCaseImpl(machineService: machineService)
        batteryMonitor = BatteryMonitor()
        statusBarViewModel = StatusBarViewModel(connectToMachineUseCase: connectToMachineUseCase,
                                                batteryMonitor: batteryMonitor)
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                StatusBarView(viewModel: statusBarViewModel)
                
            } .frame(maxWidth: .infinity)
                .background(Color.cyan)
        }
    }
}
