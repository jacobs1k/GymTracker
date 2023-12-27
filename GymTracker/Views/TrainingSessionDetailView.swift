//
//  TrainingSessionDetailView.swift
//  TESCIK
//
//  Created by Kuba on 27/12/2023.
//

import SwiftUI

struct TrainingSessionDetailView: View {
    let trainingSession: TrainingSession

    var body: some View {
        List {
            Section(header: Text("Training Details")) {
                Text("Date: \(trainingSession.date, formatter: dateFormatter)")
                ForEach(trainingSession.exerciseSets, id: \.self) { exerciseSet in
                    VStack(alignment: .leading) {
                        Text("Exercise: \(exerciseSet.exercise?.name ?? "N/A")")
                        ForEach(exerciseSet.sets, id: \.self) { set in
                            Text("Set \(set.sets): \(set.repetitions) reps, \(set.weight) kg")
                        }
                    }
                }
            }
        }
        .background(Color("CustomGray"))
        .scrollContentBackground(.hidden)
        .navigationBarTitle("Training Session", displayMode: .inline)
    }
}

//#Preview {
//    TrainingSessionDetailView()
//}
