import SwiftUI
import UIKit
import AVFoundation

struct ContentView: View {
    @State private var userInput: String = ""
    @State private var errorMsg: String = "[*] Status: Ready"
    @FocusState private var isTextFieldFocused: Bool
    @State private var debug: Bool = true
    @State private var showInput: Bool = true
    
    func dirtyZeroHide(path: String) {
        do {
            showInput = false
            errorMsg = ""
            isTextFieldFocused = false
            try zeroPoC(path: path)
            errorMsg = "[*] Successfully Unwired: \(path)"
            showInput = true
            userInput = ""
        } catch let ExploitError.custom(message) {
            if debug==false{
                errorMsg = "[!] \(message.capitalized)"
                
            } else {
                errorMsg = "[*] Successfully Unwired: \(path)"
            }
            showInput = true
            userInput = ""
        } catch {
            errorMsg = "[!] Unknown Error: \(error.localizedDescription)"
            showInput = true
            userInput = ""
        }
    }

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Image("appicon")
                    .resizable()
                    .frame(width: 80, height: 80)

                VStack(spacing: 5) {
                    Text("relite unwirer")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("for iOS 16.0 - 18.3.2")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    Text("by @supers0n1k")
                        .foregroundColor(.accentColor)
                        .font(.caption)
                    Text("UI by @HiMyNameIsUbik & @supers0n1k")
                        .foregroundColor(.accentColor)
                        .font(.caption)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Group {
                        Text("[*] relite Version: 1.4.3")
                        Text("[*] Exploit: unwire_mlock_poc")
                        Text("[*] Machine Name: \(getDeviceIdentifier())")
                        Text("[*] System Version: \(UIDevice.current.systemName) \(UIDevice.current.systemVersion)")
                        Text("[*] Bundled Resources Version: 1.0~b23")
                        Text("\(errorMsg)")
                        if showInput {
                            HStack {
                                Text("[*]")
                                    .font(.system(size: 13, design: .monospaced))
                                    .foregroundColor(.white)
                                TextField("/path/to/the/file/to/hide", text: $userInput)
                                    .font(.system(size: 13, design: .monospaced))
                                    .foregroundColor(.white)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .padding(.vertical, 4)
                                    .focused($isTextFieldFocused)
                            }
                            .frame(height:12)
                        }
                    }
                    .font(.system(size: 13, design: .monospaced))
                    .foregroundColor(.white)
                    .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                isTextFieldFocused = true
                            }
                        }
                }
                Spacer()
                .padding(.horizontal)

                Spacer()

                VStack(spacing: 12) {

                    Button(action: { dirtyZeroHide(path: userInput) }) {
                        Text("Unwire")
                            .font(.system(size: 18, weight: .bold))
                            .frame(width: 240, height: 60)
                            .background(Color.accentColor)
                            .foregroundColor(.black)
                            .cornerRadius(30)
                    }

                    Text("relite Version: 1.4.3")
                        .foregroundColor(.gray)
                        .font(.caption)
                }

                Spacer()
            }
            .padding()
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
