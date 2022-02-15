//
//  OnBoardingView.swift
//  Restart
//
//  Created by enjykhaled on 08/02/2022.
//

import SwiftUI

struct OnBoardingView: View {
    //MARK: - Property
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State private var buttonwidth : Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffSet :CGSize = .zero
    @State private var indicatorOpacity:Double = 0.1
    @State private var textTitle: String = "Share."
    let hapticFeedback = UINotificationFeedbackGenerator()
    //MARK: - Body
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all , edges: .all)
            VStack(spacing: 20) {
                //MARK: - Header
                Spacer()
                VStack(spacing: 0) {
                    Text(textTitle)
                        .font(.system(size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                        
                    Text("""
                    It's not how much we give but
                    how much love we put into giving
                    """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal ,  10)
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration:1), value: isAnimating)
                //MARK: -Body
                ZStack{
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2 )
                    // the offset of the ring will be in the opposite direction of image
                        .offset(x: imageOffSet.width * -1)
                        .blur(radius: abs(imageOffSet.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffSet)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0 )

                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffSet.width * 1.2 , y:0)
                        .rotationEffect(.degrees(Double(imageOffSet.width / 20 )))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if abs(imageOffSet.width)<=150 {
                                        imageOffSet = gesture.translation
                                        withAnimation(.linear(duration: 0.25)){
                                        indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                })
                                .onEnded({ _ in
                                    imageOffSet = .zero
                                    withAnimation(.linear(duration: 0.25)){
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                    }
                                })
                            
                        )
                        .animation(.easeOut(duration: 1), value: imageOffSet)
                }
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 35, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y:60)
                        .opacity(isAnimating ? 1 :0 )
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                    , alignment: .bottom
                    
                )
                Spacer()
                //MARK: - Footer
                ZStack {
                    //static background
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    // call to action
                     Text("Get started")
                        .font(.system( .title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x:20 )
                    // dynamic width
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 65)
                        Spacer()
                    }
                    //circle
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: Font.Weight.bold ))
                            
                        }
                        .foregroundColor(.white)
                    .frame(width: 70, height: 70, alignment: .center)
                    .offset(x:buttonOffset)
                    .gesture(
                    DragGesture()
                        .onChanged({ gesture in
                            if gesture.translation.width > 0 && buttonOffset <= buttonwidth - 80 {
                                
                                buttonOffset = gesture.translation.width
                            }
                        })
                    //placing the red button in poistion zero when we stop tracking
                        .onEnded({ _ in
                            //the button in right area it will go to the home screen
                            withAnimation(Animation.easeOut(duration: 0.4)){
                                if buttonOffset > buttonwidth / 2{
                                    hapticFeedback.notificationOccurred(.success)
                                    playSound(sound: "chimeup", type: "mp3")
                                    buttonOffset = buttonwidth - 80
                                    isOnboardingViewActive = false
                                    //the button is still in the left edge so it will go back
                                    // to the zero
                                } else{
                                    hapticFeedback.notificationOccurred(.warning)
                                    buttonOffset = 0
                                }
                                
                                
                            }
                         
                          
                        })
                    ) // :Gesture
                        Spacer()
                    }
                }// zstack
                .frame(width:buttonwidth ,height: 70, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1: 0)
                .offset(y: isAnimating ? 1 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }//: VSTACK
        }//: ZSTACK
        .onAppear {
            isAnimating = true
            
        }
        .preferredColorScheme(.dark)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
