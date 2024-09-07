//
//  CalendarView.swift
//  BeautyPlanner
//
//  Created by Aizada on 29.08.2024.
//

import SwiftUI
import FSCalendar

struct CalendarWrapperView: UIViewRepresentable {
    @Binding var selectedDate: Date
    @Binding var highlightedDates: [Date]
    
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        return calendar
    }

    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.reloadData()
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
        var parent: CalendarWrapperView

        init(_ parent: CalendarWrapperView) {
            self.parent = parent
        }

        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = date
        }

        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
            if shouldHighlightDate(date) {
                return UIColor.red
            }
            return nil
        }

        func shouldHighlightDate(_ date: Date) -> Bool {
            return parent.highlightedDates.contains(date)
        }
    }
}

struct CalendarView: View {
    @StateObject private var procedureManager = ProcedureManager()
    @State private var selectedDate = Date()
    @State private var highlightedDates: [Date] = []
    @State private var showProcedureView = false

    var body: some View {
        VStack {
            Text("Selected Date: \(selectedDate, formatter: dateFormatter)")
                .padding()

            CalendarWrapperView(selectedDate: $selectedDate, highlightedDates: $highlightedDates)
                .frame(height: 400)

            Button("Добавить процедуры для \(selectedDate, formatter: dateFormatter)") {
                showProcedureView = true
            }
            .padding()
            .background(Color.pink)
            .foregroundColor(.white)
            .cornerRadius(10)
            .sheet(isPresented: $showProcedureView) {
                ProcedureView(procedureManager: procedureManager, selectedDate: dateFormatter.string(from: selectedDate))
            }

            Spacer()
        }
        .navigationTitle("")
        .onAppear {
            updateHighlightedDates()
        }
        .onChange(of: procedureManager.procedures) { _ in
            updateHighlightedDates()
        }
    }
    
    private func updateHighlightedDates() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let proceduresDates = Set(procedureManager.procedures.map { formatter.date(from: $0.date)! })
        highlightedDates = Array(proceduresDates)
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
