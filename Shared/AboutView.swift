//
//  About.swift
//  deTeX
//
//  Created by Venkat on 26/8/20.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
                List {
                    Text("Made, with ❤️, by Venkat. Inspired by Detexify, I wanted to make a native iOS app to translate LaTeX symbols to their corresponding commands that was fast, efficient, and light.")
                    Section(header: Text("Feedback")) {
                        Text("You can contact me on Twitter @_venkatasg to report any bugs or if you have any feature requests for the app. Feel free to file issues on GitHub as well!")
                        Link("My Twitter", destination: URL(string: "https://twitter.com/_venkatasg")!)
                        Link("GitHub Repository", destination: URL(string: "https://github.com/venkatasg/DeTeXt")!)
                    }
                    Section(header: Text("How it works")) {
                        Text("DeTeXt uses a MobileNet_v2 model PyTorch model trained on the Detexify training data, which was then translated to CoreML using ") +
                        Text("coremltools").font(.system(.body, design: .monospaced)) +
                        Text(".\nThe symbol images are generated by converting PDF files containing each symbol (made with LaTeX) to SVG files. All symbols are typeset in their default font. ")
                        Link("Detexify", destination: URL(string: "http://detexify.kirelabs.org")!)
                        Link("coremltools", destination: URL(string: "https://coremltools.readme.io")!)
                        Link("MobileNet_v2", destination: URL(string: "https://pytorch.org/docs/stable/torchvision/models.html#torchvision.models.mobilenet_v2")!)
                    }
                    Section(header: Text("Privacy Policy")) {
                        Text("DeTeXt does not collect or store any personal data or information.")
                    }
                    Section(header: Text("Thanks")) {
                        Text("Thanks to Daniel Kirsch and the team at Detexify for their cool open-source web app that inspired me to make DeTeXt, and for providing the training data and prompt responses to my questions. \n\nThanks to Will Bishop for helping me figure out a tricky problem I had with the PencilKit APIs. \n\nFinally a big thanks to all the folks on the NetNewsWire Slack for being supportive and inspiring me to build my own iOS app.")
                    }
                    
                }
                .listStyle(InsetGroupedListStyle())
    
            .navigationBarTitle("About", displayMode: .inline)
            .navigationBarItems(leading: Button(action: { self.presentationMode.wrappedValue.dismiss()})                                         { Text("Back").padding(8) })
        }
    }
}


struct About_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
            .previewDevice("iPhone 11 Pro Max")
    }
}
