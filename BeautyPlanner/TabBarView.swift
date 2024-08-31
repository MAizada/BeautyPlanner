//
//  TabBarView.swift
//  BeautyPlanner
//
//  Created by Aizada on 27.08.2024.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            MainScreenView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Main")
                }
            
            Text("Settings")
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
            
            Text("Another Tab")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("More")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
