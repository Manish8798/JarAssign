//
//  AssignmentApp.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI
import SwiftData

@main
struct AssignmentApp: App {
    @StateObject private var viewModel = ContentViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)
        }.modelContainer(for: SwiftDataModel.self)
    }
}
