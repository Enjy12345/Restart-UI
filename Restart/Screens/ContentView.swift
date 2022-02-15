//
//  ContentView.swift
//  Restart
//
//  Created by enjykhaled on 08/02/2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    var body: some View {
        ZStack {
            // if it is true the onboarding will appear
            if isOnboardingViewActive {
                OnBoardingView()
            }
            else{
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
