//
//  HomeView.swift
//  Restart
//
//  Created by enjykhaled on 08/02/2022.
//

import SwiftUI

struct HomeView: View {
    //MARK: -Property
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    @State private var isAnimating: Bool = false
    
    
    var body: some View {
        VStack(spacing: 20) {
            //MARK: - Header
            Spacer()
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                .padding()
                .offset(y: isAnimating ? 35 : -35)
                .animation(
                    Animation
                    .easeOut(duration: 4)
                    .repeatForever()
                , value:isAnimating
                )
            }
            //MARK: - Center
                Text("The time that leads to mastery is dependent on the intensity of our focus.")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            //MARK: - Footer
            Spacer()
            
            Button {
                withAnimation {
                    playSound(sound: "success", type: "m4a")
                    isOnboardingViewActive = true
                }
            } label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.medium)
                Text("Restart")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.small)
            .padding(12)
        
        
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute:{
            isAnimating  = true
            
            } )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
