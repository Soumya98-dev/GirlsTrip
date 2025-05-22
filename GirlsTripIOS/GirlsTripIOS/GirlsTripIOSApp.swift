import SwiftUI

@main
struct GirlsTripIOSApp: App {
    @State private var showingSplash = true
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            if showingSplash {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            withAnimation {
                                self.showingSplash = false
                            }
                        }
                    }
            } else if !hasCompletedOnboarding {
                OnboardingView()
            } else {
                ContentView()
            }
        }
    }
}
