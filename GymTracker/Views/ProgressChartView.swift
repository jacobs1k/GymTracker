//
//  ProgressChartView.swift
//  TESCIK
//
//  Created by Kuba on 27/12/2023.
//

import SwiftUI
import Charts

struct ProgressChartView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @Binding var selectedExercise: Exercise?
        
    var body: some View {
        VStack {
            Chart {
                ForEach(viewModel.progressData) { progress in
                    LineMark(
                        x: .value("Month", progress.date),
                        y: .value("Temp", progress.totalWeight)
                    )
                }
            }
            .frame(height: 300)
        }
        .onChange(of: selectedExercise){
            viewModel.fetchProgress(for: selectedExercise!.name)
        }
        .onAppear {
            if let selectedExercise = selectedExercise{
                viewModel.fetchProgress(for: selectedExercise.name)
            } else {
                viewModel.fetchProgress(for: "Squat")
            }
        }
    }
}

//#Preview {
//    ProgressChartView()
//}
