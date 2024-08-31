//
//  CalendarView.swift
//  BeautyPlanner
//
//  Created by Aizada on 29.08.2024.
//

import SwiftUI
import UIKit


struct CalendarView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            Text("Select a Date")
                .font(.headline)
                .padding()
            
       //     CalendarView(selectedDate: $selectedDate)
                .padding()
            
            Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
                .padding()
            
            Spacer()
        }
        .navigationTitle("Calendar")
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CalendarView()
        }
    }
}
