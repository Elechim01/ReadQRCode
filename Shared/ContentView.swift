//
//  ContentView.swift
//  Shared
//
//  Created by Michele Manniello on 19/06/22.
//

import SwiftUI
import CodeScanner
import UniformTypeIdentifiers

struct ContentView: View {
    @State var text: String = "..."
    @State var isShowingScanner = false
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack{
            Button {
                isShowingScanner.toggle()
            } label: {
                Text("ReadQrCode")
            }
            Menu(text){
                Button {
                    UIPasteboard.general.setValue(text,forPasteboardType: UTType.plainText.identifier)
                } label: {
                    Text("Copia")
                    
                }
            }
            
            
            .foregroundColor(colorScheme == .dark ? .white : .black)
        }
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], completion: handleScan(result:))
        }
    }
    func handleScan(result: Result<ScanResult,ScanError>){
        self.isShowingScanner.toggle()
        switch result{
        case.success(let result):
            text = result.string
        case .failure(let error):
            text = "Screen fallied" + error.localizedDescription
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
