//
//  ProcedureView.swift
//  BeautyPlanner
//
//  Created by Aizada on 08.09.2024.
//

import SwiftUI

struct Procedure: Identifiable, Codable, Equatable {
    var id = UUID()
    var date: String
    var name: String
}

class ProcedureManager: ObservableObject {
    @Published var procedures: [Procedure] = [] {
        didSet {
            saveProcedures()
        }
    }

    init() {
        loadProcedures()
    }

    func addProcedure(_ procedure: Procedure) {
        procedures.append(procedure)
    }

    func deleteProcedure(at indexSet: IndexSet) {
        procedures.remove(atOffsets: indexSet)
    }

    private func saveProcedures() {
        if let encoded = try? JSONEncoder().encode(procedures) {
            UserDefaults.standard.set(encoded, forKey: "procedures")
        }
    }

    private func loadProcedures() {
        if let savedData = UserDefaults.standard.data(forKey: "procedures"),
           let decoded = try? JSONDecoder().decode([Procedure].self, from: savedData) {
            procedures = decoded
        }
    }
}

struct ProcedureView: View {
    @ObservedObject var procedureManager: ProcedureManager
    @State private var newProcedure: String = ""
    @State private var selectedDate: String

    init(procedureManager: ProcedureManager, selectedDate: String) {
        self.procedureManager = procedureManager
        _selectedDate = State(initialValue: selectedDate)
    }

    var body: some View {
        VStack {
            Text("Процедуры на \(selectedDate)")
                .font(.title)
                .padding()

            List {
                ForEach(procedureManager.procedures.filter { $0.date == selectedDate }) { procedure in
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
            }
            
            HStack {
                TextField("Введите процедуру", text: $newProcedure)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    addProcedure()
                }) {
                    Text("Добавить")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(10)
                }
                .padding(.trailing)
            }
            .padding()
        }
        .navigationTitle("Добавить процедуру")
    }

    private func addProcedure() {
        let procedure = Procedure(date: selectedDate, name: newProcedure)
        procedureManager.addProcedure(procedure)
        newProcedure = ""
    }

    private func deleteProcedure(_ procedure: Procedure) {
        if let index = procedureManager.procedures.firstIndex(where: { $0.id == procedure.id }) {
            procedureManager.procedures.remove(at: index)
        }
    }
}

struct ProcedureView_Previews: PreviewProvider {
    static var previews: some View {
        ProcedureView(procedureManager: ProcedureManager(), selectedDate: "29 августа, четверг")
    }
}
