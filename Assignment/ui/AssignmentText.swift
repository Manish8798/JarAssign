//
//  AssignmentText.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation
import SwiftUI

struct AssignmentText: View {
    let text: String
    let color: String
    let price: Double

    var body: some View {
        VStack {
            Text(text)
                .font(.headline)
                .foregroundColor(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            
            if !color.isEmpty {
                Text("Color: \(color)")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            if price != 0 {
                Text("Price: \(price)")
                    .font(.caption)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
