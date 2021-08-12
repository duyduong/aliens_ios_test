//
//  SegmentedControl.swift
//  SwiftNews
//
//  Created by Dao Duy Duong on 12/08/2021.
//

import SwiftUI

struct SegmentedControl: View {
    
    @Binding var segment: Segment
    
    var body: some View {
        Picker(selection: $segment, label: Text("View Segmented")) {
            Text(Segment.web.rawValue).tag(Segment.web)
            Text(Segment.smart.rawValue).tag(Segment.smart)
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
