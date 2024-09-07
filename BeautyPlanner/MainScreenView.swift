//
//  MainScreenView.swift
//  BeautyPlanner
//
//  Created by Aizada on 27.08.2024.
//

import SwiftUI

struct MainScreenView: View {
    @StateObject private var procedureManager = ProcedureManager()
    @State private var selectedDate: String = "29 августа, четверг" 

    var body: some View {
        NavigationView {
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

                                    ForEach(procedureManager.procedures.filter { $0.date == date }) { procedure in
                                        HStack {
                                            Text(procedure.name)
                                                .font(.body)
                                                .foregroundColor(.gray)

                                            Spacer()

                                            Button(action: {
                                                deleteProcedure(procedure)
                                            }) {
                                                Image(systemName: "trash")
                                                    .foregroundColor(.red)
                                            }
                                        }
                                        .padding(.vertical, 5)
                                    }

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
    }

    func deleteProcedure(_ procedure: Procedure) {
        if let index = procedureManager.procedures.firstIndex(where: { $0.id == procedure.id }) {
            procedureManager.procedures.remove(at: index)
        }
    }

    let categories = [
        Category(title: "Лицо", iconName: "face.smiling"),
        Category(title: "Волосы", iconName: "scissors"),
        Category(title: "Тело", iconName: "figure.walk"),
        Category(title: "Маникюр", iconName: "hand.raised")
    ]

    let dates = [
        "29 августа, четверг",
        "30 августа, пятница"
    ]
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
