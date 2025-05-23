import SwiftUI

@main
struct Girls_TripApp: App {
    @State private var showingSplash = true
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            if showingSplash {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                self.showingSplash = false
                            }
                        }
                    }
            } else if !hasCompletedOnboarding {
                OnboardingView()
            } else {
                MainAppTabView()
            }
        }
    }
}

struct MainAppTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            // Example of another tab
            Text("Past Trips Screen")
                .tabItem {
                    Label("Past Trips", systemImage: "suitcase.fill")
                }

            Text("Import Screen")
                .tabItem {
                    Label("Import", systemImage: "square.and.arrow.down.fill")
                }

            Text("Map Screen")
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }

            Text("#OOTD Screen")
                .tabItem {
                    Label("#OOTD", systemImage: "tshirt.fill")
                }
        }
        // .accentColor(.yourAppAccentColor) 
    }
}
