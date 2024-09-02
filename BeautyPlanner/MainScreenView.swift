//
//  MainScreenView.swift
//  BeautyPlanner
//
//  Created by Aizada on 27.08.2024.
//

import SwiftUI

struct MainScreenView: View {
    var body: some View {
        ZStack {
            Color.lightPeach
                .edgesIgnoringSafeArea(.all)

            VStack {
                               HStack {
                                   Text("План ухода")
                                       .font(.title)
                                       .fontWeight(.bold)
                                       .foregroundColor(.black)
                                   
                                   Spacer()
                                   
                                   NavigationLink(destination: CalendarView()) {
                                       Image(systemName: "calendar")
                                           .font(.system(size: 24))
                                           .foregroundColor(.pink)
                                           .padding(.trailing)
                                   }
                               }
                               .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                       
                        ForEach(categories) { category in
                            VStack {
                                Image(systemName: category.iconName)
                                    .font(.system(size: 30))
                                    .foregroundColor(.pink)
                                Text(category.title)
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                            .frame(width: 150)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        }
                    }
                    .padding()
                }
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(dates, id: \.self) { date in
                            VStack(alignment: .leading) {
                                Text(date)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.bottom, 5)
                                
                                ForEach(proceduresFor(date: date), id: \.self) { procedure in
                                    Text(procedure)
                                        .font(.body)
                                        .foregroundColor(.gray)
                                }
                                .padding(.bottom, 10)
                                
                                Divider()
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
            }
        }
    }

    let categories = [
        Category(title: "", iconName: "face.smiling"),
        Category(title: "", iconName: "scissors"),
        Category(title: "", iconName: "figure.walk"),
        Category(title: "", iconName: "hand.raised")
    ]
    
    let dates = [
        "29 августа, четверг",
        "30 августа, пятница"
    ]
    
    func proceduresFor(date: String) -> [String] {
        return ["Процедура 1", "Процедура 2", "Процедура 3"]
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
