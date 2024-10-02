//
//  StatusTextView.swift
//  TrainingBasketBall
//
//  Created by hamdi on 2/10/2024.
//

import SwiftUI

struct StatusTextView: View {
    let connectionImage: String
    let mainText: String
    let chargingStatusImage: String?
    let subText: String?

    var body: some View {
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
    VStack(spacing: 20) {
        // Preview for a connecting status
        StatusTextView(connectionImage: "inProgress",
                       mainText: "Connecting to ...",
                       chargingStatusImage: nil,
                       subText: nil)

        // Preview for a failed status
        StatusTextView(connectionImage: "failed",
                       mainText: "Connection Failed try again ",
                       chargingStatusImage: nil,
                       subText: nil)

        // Preview for a connected and charging status
        StatusTextView(connectionImage: "success",
                       mainText: "Connected",
                       chargingStatusImage: "charging",
                       subText: "Charging...")

        // Preview for a connected and not charging status
        StatusTextView(connectionImage: "success",
                       mainText: "Connected",
                       chargingStatusImage: "notCharging",
                       subText: "90 %")
    }
    .padding()
    .background(Color.white)
    .scaledToFit()
    
}
