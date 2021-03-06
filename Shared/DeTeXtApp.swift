//
//  DeTeXtApp.swift
//  Shared
//
//  Created by Venkat on 29/8/20.
//

import SwiftUI
import PencilKit

class LabelScores: ObservableObject {
    @Published var scores = [Dictionary<String, Double>.Element]()
    
    func ClearScores() {
        self.scores = [Dictionary<String, Double>.Element]()
    }
}

@main
struct DeTeXtApp: App {
    
    @StateObject var symbols = Symbols()
    @StateObject var labelScores: LabelScores = LabelScores()

    var body: some Scene {
        #if targetEnvironment(macCatalyst)
        WindowGroup {
            SidebarView(labelScores: labelScores, symbols: symbols)
        }
        .commands {   
            CommandGroup(replacing: .help, addition: {
                Link("Help and Support",
                     destination: URL(string: "https://venkatasg.me/apps/detext#support")!)
                
                Divider()
                
                Link("Website",
                     destination: URL(string: "https://venkatasg.me/apps/detext")!)
                Link("GitHub Repository",
                     destination: URL(string: "https://github.com/venkatasg/DeTeXt")!)
                
                Divider()
                
                Link("Credits",
                     destination: URL(string: "https://venkatasg.me/apps/detext#credits")!)
                Link("Release Notes",
                     destination: URL(string: "https://venkatasg.me/apps/detext#release-notes")!)
            })
    
            CommandGroup(after: CommandGroupPlacement.undoRedo) {
                Button("Clear Canvas") {
                    self.labelScores.ClearScores()
                }
                .keyboardShortcut("r", modifiers: [.command])
            }
        }
        #else
        WindowGroup {
            MainView(labelScores: labelScores, symbols: symbols)
        }
        #endif
    }
}



