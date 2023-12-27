//
//  HistoryView.swift
//  TESCIK
//
//  Created by Kuba on 19/12/2023.
//

import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel = HistoryViewModel()
    

    var body: some View {
            NavigationView {
                List {
                    ForEach(viewModel.trainingSessions, id: \.self) { session in
                        NavigationLink(destination: TrainingSessionDetailView(trainingSession: session)) {
                            VStack(alignment: .leading) {
                                Text("Training Date: \(session.date, formatter: dateFormatter)")
                                Text("Exercises: \(session.exerciseSets.count)")
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteTrainingSession)
                }
                .background(Color("CustomGray"))
                .scrollContentBackground(.hidden)
                .navigationBarTitle("Training History")
                
                .onAppear{
                    viewModel.fetchTrainingSessions()
                }
            }
        }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}()


#Preview {
    HistoryView()
}
