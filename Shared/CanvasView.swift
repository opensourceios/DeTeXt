//
//  CanvasView.swift
//  DeTeXt
//
//  Created by Venkat on 27/8/20.
//

import SwiftUI
import PencilKit
import Combine

class LabelScores: ObservableObject {
    @Published var scores = [Dictionary<String, Double>.Element]()
    @Published var clear: Bool = true
}

struct MainView: View {
    
    @State private var selection: String = "draw"
    @EnvironmentObject var symbols: Symbols
    
    var body: some View {
        TabView(selection: $selection) {
            CanvasView()
                .environmentObject(symbols)
                .tabItem {
                    Image(systemName: "scribble")
                    Text("Draw")
                }
                .tag("draw")
            SymbolsView()
                .environmentObject(symbols)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag("search")
        }
    }
}

struct CanvasView: View {
    
    @State var showAboutView = false
    @State private var canvas = PKCanvasView()
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var symbols: Symbols
    @ObservedObject var labelScores: LabelScores = LabelScores()
    
    var body: some View {
        NavigationView {
            VStack (spacing:0) {
                ZStack {
                    PKCanvas(canvasView: $canvas, labelScores: labelScores)
                        .environmentObject(symbols)
                        .aspectRatio(1.5, contentMode: .fit)
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.blue, lineWidth: 3)
                            )
                        .padding(10)
                }
                .padding(.top, 10)
                .padding(.bottom, 10)

                Divider()
                ZStack {
                if labelScores.clear {
                    Text("Draw in the canvas above")
                        .font(.system(.title, design: .rounded))
                        .frame(maxHeight:.infinity)
                }
                else {
                    List {
                        ForEach(labelScores.scores, id: \.key) { key, value in
                            RowView(symbol: symbols.AllSymbols.first(where: {$0.id==key})!, confidence: (value*100) )
                        }
                    }
                    .listStyle(InsetListStyle())
                    .frame(maxHeight:.infinity)
                }
                }
                .transition(.move(edge: .trailing))
                .animation(.easeInOut)
            }
            .navigationBarItems(leading: Button(action: {
                                            self.canvas.drawing = PKDrawing()
                                            labelScores.clear = true
                                            labelScores.scores = [Dictionary<String, Double>.Element]()
                                            })
                                            { Text("Clear").padding(8)},
                                trailing: Button(action: {self.showAboutView.toggle()})
                                            { Text("About").padding(8) })
            .navigationBarTitle("", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showAboutView) { AboutView() }
    }
}

struct CanvasView_Previews: PreviewProvider {
    static let symbols = Symbols()
    static var previews: some View {
        Group {
            MainView()
                .environmentObject(symbols)
                .previewDevice("iPhone 11 Pro Max")
                
        }
    }
}
