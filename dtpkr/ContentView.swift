//
//  ContentView.swift
//  dtpkr
//
//  Created by Konstantin on 08.01.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedDate = Date()
    @State private var showDatePicker = true
    
    var body: some View {
        VStack {
            DatePicker("", selection: self.$selectedDate, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(GraphicalDatePickerStyle())                
            
            Text("\(selectedDate, formatter: dateFormatter)")

            Button("Copy and close") {
                print(">>> \(dateFormatter.string(from: selectedDate))")
                copyToClipboard()
                NSApplication.shared.terminate(self)
            }
            .keyboardShortcut(.defaultAction)
        }
        .padding()
        .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification), perform: { _ in
            NSApp.mainWindow?.standardWindowButton(.zoomButton)?.isHidden = true
            NSApp.mainWindow?.standardWindowButton(.closeButton)?.isHidden = true
            NSApp.mainWindow?.standardWindowButton(.miniaturizeButton)?.isHidden = true
        })
    }

    func copyToClipboard() {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(dateFormatter.string(from: selectedDate), forType: .string)
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
