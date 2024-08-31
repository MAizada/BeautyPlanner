//
//  WelcomeView.swift
//  BeautyPlanner
//
//  Created by Aizada on 27.08.2024.
//
import SwiftUI

struct WelcomeView: View {
    @State private var navigateToNextView = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.lightPeach
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            navigateToNextView = true
                        }) {
                            Text("Skip")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(.trailing, 40)
                        }
                    }
                    .padding(.top, 30)

                    Spacer()

                    Text("Welcome to BeautyPlanner")
                        .font(.custom("HelveticaNeue-Bold", size: 36))
                        .foregroundColor(.pink)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)

                    Spacer()

                    Text("Your personal guide to beauty and self-care")
                        .font(.custom("HelveticaNeue", size: 20))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 50)
                }

                NavigationLink(destination: TabBarView().navigationBarBackButtonHidden(true), isActive: $navigateToNextView) {
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    navigateToNextView = true
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) 
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
