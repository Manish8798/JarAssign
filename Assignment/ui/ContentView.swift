//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    private var viewModel = ContentViewModel()
    @EnvironmentObject var viewModel: ContentViewModel
    @Environment(\.modelContext) private var modelContext
    @Query private var devices: [SwiftDataModel]
    @State private var path: [DeviceData] = [] // Navigation path
    @State var searchText: String = ""

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                
                if viewModel.isConnected {
                    
                    HStack {
                        Image(systemName: "magnifyingglass").foregroundColor(.gray)
                        TextField("Search", text: $searchText).textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: searchText, { oldValue, newValue in
                                if newValue.isEmpty {
                                    viewModel.filteredProducts = viewModel.data
                                } else {
                                    viewModel.filteredProducts = viewModel.data?.filter{
                                        $0.name.localizedCaseInsensitiveContains(searchText)
                                        || $0.id.localizedCaseInsensitiveContains(searchText)
                                    }
                                }
                        })
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }, label: {
                                Image(systemName: "xmark.circle.fill").foregroundColor(.gray)
                            })
                        }
                    }.padding(.horizontal)
                    
                    if let computers = viewModel.filteredProducts, !computers.isEmpty {
                        DevicesList(devices: computers)
                        { selectedComputer in
                            viewModel.navigateToDetail(navigateDetail: selectedComputer)
                            debugPrint("selectedComputer", selectedComputer)
                        }
                    } else {
                            ProgressView("Loading...")
                        
                    }
                } else {
                    DevicesListOffline(devices: devices) { selectedValue in
                        debugPrint(selectedValue)
                    }
                }
            }
            .onChange(of: viewModel.navigateDetail, {
                let navigate = viewModel.navigateDetail
                path.append(navigate!)
            })
            .navigationTitle(viewModel.isConnected ? "Devices" : "Devices Offline")
            .navigationDestination(for: DeviceData.self) { computer in
                DetailView(device: computer)
            }
            .onAppear {
                viewModel.fetchAPI()
                
                if devices.isEmpty {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if viewModel.data?.count != 0 {
                            viewModel.data?.forEach{ item in
                                let deviceModel = SwiftDataModel(deviceName: item.name, color: item.data?.color ?? "", price: item.data?.price ?? 0)
                                debugPrint("deviceModel", deviceModel)
                                modelContext.insert(deviceModel)
                            }
                        }
                    }
                } else {
                    debugPrint("devices",devices.count)
                }
//                let navigate = viewModel.navigateDetail
//                if (navigate != nil) {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                        path.append(navigate!)
//                    }
//                }
            }
        }
    }
}
