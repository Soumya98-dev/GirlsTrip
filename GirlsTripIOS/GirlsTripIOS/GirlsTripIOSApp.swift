

import SwiftUI

@main
struct GirlsTripIOSApp: App {
    @State private var isActive: Bool = false

    var body: some Scene {
        WindowGroup {
            if isActive {
                ContentView()
            } else {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation { 
                                self.isActive = true
                            }
                        }
                    }
            }
        }
    }
}
