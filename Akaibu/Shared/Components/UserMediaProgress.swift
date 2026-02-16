//
//  UserMediaProgress.swift
//  Akaibu
//
//  Created by kite1412 on 17/02/26.
//

import SwiftUI

struct UserMediaProgress: View {
    let userStatus: String
    let userScore: Int
    let userConsumedUnits: Int
    var totalUnits: Int?
    let availableStatuses: [String]
    let completedStatus: String
    let onStatusUpdate: (String) -> Void
    let onScoreUpdate: (Int) -> Void
    let onConsumedUnitsUpdate: (Int) -> Void
    
    @State private var consumedUnits: String = ""
    @State private var score: String = ""
    @State private var statusPopover: Bool = false
    @State private var scorePopover: Bool = false
    @State private var consumedUnitsPopover: Bool = false
    
    init(
        userStatus: String,
        userScore: Int,
        userConsumedUnits: Int,
        totalUnits: Int?,
        availableStatuses: [String],
        completedStatus: String,
        onStatusUpdate: @escaping (String) -> Void,
        onScoreUpdate: @escaping (Int) -> Void,
        onConsumedUnitsUpdate: @escaping (Int) -> Void
    ) {
        self.userStatus = userStatus
        self.userScore = userScore
        self.userConsumedUnits = userConsumedUnits
        self.totalUnits = totalUnits
        self.completedStatus = completedStatus
        self.onStatusUpdate = onStatusUpdate
        self.onScoreUpdate = onScoreUpdate
        self.onConsumedUnitsUpdate = onConsumedUnitsUpdate
        
        if totalUnits == nil {
            self.availableStatuses = availableStatuses.filter { $0 != completedStatus }
        } else {
            self.availableStatuses = availableStatuses
        }
        
        _consumedUnits = State(initialValue: String(userConsumedUnits))
        _score = State(initialValue: String(userScore))
    }
    
    var body: some View {
        editableProp(
            label: "Status",
            value: userStatus,
            systemImage: nil,
            showPopover: $statusPopover
        )
        .popover(isPresented: $statusPopover, arrowEdge: .bottom) {
            popoverContent {
                VStack {
                    ForEach(filteredAvailableStatuses, id: \.self) { status in
                        VStack(spacing: 4) {
                            Text(status)
                            Divider()
                        }
                        .onTapGesture {
                            statusPopover = false
                            onStatusUpdate(status)
                        }
                        .foregroundStyle(userStatus == status ? .accent : .primary)
                    }
                }
            }
        }
        .onChange(of: userStatus) {
            if userStatus == completedStatus {
                if let totalUnits {
                    consumedUnits = String(totalUnits)
                }
            }
        }
        
        HStack {
            editableProp(
                label: "Progress",
                value: "\(userConsumedUnits) / \(totalUnitsString)",
                systemImage: "chevron.down",
                showPopover: $consumedUnitsPopover
            )
            .popover(isPresented: $consumedUnitsPopover, arrowEdge: .bottom) {
                popoverContent {
                    editField(
                        label: "Progress",
                        value: $consumedUnits,
                        trailing: "/ \(totalUnitsString)"
                    ) { newValue in
                        consumedUnitsPopover = false
                        if let newProgress = Int(newValue) {
                            onConsumedUnitsUpdate(newProgress)
                        }
                    }
                    .onChange(of: consumedUnits) {
                        if let consumedUnits = Int(consumedUnits) {
                            self.consumedUnits = String(
                                intThreshold(
                                    actualValue: consumedUnits,
                                    maxValue: totalUnits ?? Int.max
                                )
                            )
                        }
                    }
                }
            }
            .onChange(of: consumedUnitsPopover) {
                if consumedUnitsPopover {
                    consumedUnits = String(consumedUnits)
                }
            }
            
            editableProp(
                label: "Score",
                value: String(userScore),
                systemImage: "star.fill",
                showPopover: $scorePopover
            )
            .popover(isPresented: $scorePopover, arrowEdge: .bottom) {
                popoverContent {
                    editField(
                        label: "Score",
                        value: $score,
                        trailing: "/ 10"
                    ) { newValue in
                        scorePopover = false
                        onScoreUpdate(Int(newValue) ?? 0)
                    }
                    .onChange(of: score) {
                        if let score = Int(score) {
                            self.score = String(intThreshold(actualValue: score, maxValue: 10))
                        }
                    }
                }
            }
            .onChange(of: scorePopover) {
                if scorePopover {
                    score = String(userScore)
                }
            }
        }
    }
    
    private var filteredAvailableStatuses: [String] {
        if totalUnits == 0 {
            return availableStatuses.filter { $0 != completedStatus }
        } else {
            return availableStatuses
        }
    }
    
    private var totalUnitsString: String {
        let unknownTotalUnits: String = "~"
        
        if let totalUnits = totalUnits {
            if totalUnits == 0 {
                return unknownTotalUnits
            } else {
                return String(totalUnits)
            }
        } else {
            return unknownTotalUnits
        }
    }
    
    private func intThreshold(actualValue: Int, maxValue: Int) -> Int {
        min(actualValue >= 0 ? actualValue : 0, maxValue)
    }
    
    private func editableProp(
        label: String,
        value: String,
        systemImage: String?,
        showPopover: Binding<Bool>
    ) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .foregroundStyle(.secondary)
            
            HStack {
                Text(value)
                if let systemImage {
                    Image(systemName: systemImage)
                        .foregroundStyle(.accent)
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray.opacity(0.2))
            )
        }
        .font(.caption)
        .onTapGesture {
            showPopover.wrappedValue.toggle()
        }
    }
    
    private func popoverContent(_ content: () -> some View) -> some View {
        content()
            .padding(8)
            .presentationCompactAdaptation(.popover)
    }
    
    private func editField(
        label: String,
        value: Binding<String>,
        trailing: String,
        onConfirm: @escaping (String) -> Void
    ) -> some View {
        VStack(spacing: 4) {
            Text(label)
                .foregroundStyle(.secondary)
            HStack(spacing: 0) {
                TextField("", text: value)
                    #if os(iOS)
                    .keyboardType(.numberPad)
                    #endif
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        onConfirm(value.wrappedValue)
                    }
                Text(" \(trailing)")
                    .foregroundStyle(.secondary)
            }
            .frame(minWidth: 60)
        }
        .font(.subheadline)
    }
}

#Preview {
    UserMediaProgress(
        userStatus: "Completed",
        userScore: 8,
        userConsumedUnits: 10,
        totalUnits: 12,
        availableStatuses: ["Completed", "Watching", "Dropped"],
        completedStatus: "Completed",
        onStatusUpdate: { status in },
        onScoreUpdate: { score in },
        onConsumedUnitsUpdate: { consumedUnits in }
    )
}
