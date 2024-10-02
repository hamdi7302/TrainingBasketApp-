//
//  StatusBarView.swift
//  TrainingBasketBall
//
//  Created by hamdi on 2/10/2024.
//

import SwiftUI

struct StatusBarView: View {
    @ObservedObject var viewModel: StatusBarViewModel
    @State private var animate = false
    
    var body: some View {
        VStack {
            Spacer() // Pushes the content to the bottom
            HStack {
                appLogo
                statusFullText
                settingsIcon
            }
            .padding()
            .background(Color.white)
            .cornerRadius(99)
            .overlay(
                RoundedRectangle(cornerRadius: 99)
                    .stroke(Color.gray, lineWidth: 2)
            )
            .padding()
        }
        .scaleEffect(animate ? 1 : 0.5)
        .opacity(animate ? 1 : 0)
        .onAppear {
            withAnimation(.easeIn(duration: 1)) {
                animate = true
            }
        }
    }
    
    private var appLogo: some View {
        Image("app")
            .resizable()
            .frame(width: 48, height: 48)
            .padding(.leading)
    }
    
    private var settingsIcon: some View {
        Image("setting")
            .resizable()
            .frame(width: 20, height: 20)
            .padding(.trailing)
    }
    
    private var statusFullText: some View {
        HStack {
            switch viewModel.connectionStatus {
            case .connecting:
                buildStatusText(connectionImage: "inProgress",
                                mainText: viewModel.connectionStatus.description.mainMsg)
            case .failed:
                buildStatusText(connectionImage: "failed", 
                                mainText: viewModel.connectionStatus.description.mainMsg)
            case .connected(let chargingStatus):
                switch chargingStatus {
                case .charging(_):
                    buildStatusText(connectionImage: "success",
                                    mainText: viewModel.connectionStatus.description.mainMsg,
                                    chargingStatusImage: "charging",
                                    subText: viewModel.connectionStatus.description.subMsg)
                case .notCharging(_):
                    buildStatusText(connectionImage: "success",
                                    mainText: viewModel.connectionStatus.description.mainMsg,
                                    chargingStatusImage: "notCharging",
                                    subText: viewModel.connectionStatus.description.subMsg)
                }
            }
        }
        .padding(.horizontal, 25)
    }
    
    private func buildStatusText(connectionImage: String, mainText: String, chargingStatusImage: String? = nil, subText: String? = nil) -> some View {
        HStack {
            Image(connectionImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 24)
            Text(mainText)
                .foregroundColor(.black)
        
            
            if let chargingStatusImage = chargingStatusImage, let subText = subText {
                
                Text("•")
                    .font(.title)
                    .foregroundColor(.gray)
                
                Image(chargingStatusImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 14)
                Text(subText)
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    ZStack {
        StatusBarView(viewModel: StatusBarViewModel(connectToMachineUseCase: ConnectToMachineUseCaseImpl(machineService:  MachineServiceImpl()), batteryMonitor: BatteryMonitor()))
    }
    .frame(maxWidth: .infinity)
    .background(Color.cyan)
}
