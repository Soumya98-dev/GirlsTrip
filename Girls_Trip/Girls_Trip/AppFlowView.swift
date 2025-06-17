import SwiftUI

struct AppFlowView: View {
    @AppStorage("hasSeenSplash")                  private var hasSeenSplash               = false
    @AppStorage("hasCompletedOnboarding")         private var hasCompletedOnboarding      = false
    @AppStorage("hasCompletedProfileSetup")       private var hasCompletedProfileSetup    = false
    @AppStorage("hasCompletedFinalSetup")         private var hasCompletedFinalSetup      = false
    @AppStorage("hasCompletedPermissionsPriming") private var hasCompletedPermissionsPriming = false

    var body: some View {
        Group {
            if !hasSeenSplash {
                // 1) Splash
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            hasSeenSplash = true
                        }
                    }

            } else if !hasCompletedOnboarding {
                // 2) Onboarding (Sign In with Apple)
                OnboardingView()

            } else if !hasCompletedProfileSetup {
                // 3) Profile Setup
                ProfileSetupView()

            } else if !hasCompletedFinalSetup {
                // 4) Final Apple Health setup instructions
                FinalSetupInstructionsView {
                    hasCompletedFinalSetup = true
                }

            } else if !hasCompletedPermissionsPriming {
                // 5) Location Services priming
                PermissionsPrimingView {
                    hasCompletedPermissionsPriming = true
                }

            } else {
                // 6) Main App
                ContentView()
            }
        }
        .animation(.easeOut(duration: 0.3), value: hasSeenSplash)
        .animation(.easeOut(duration: 0.3), value: hasCompletedOnboarding)
        .animation(.easeOut(duration: 0.3), value: hasCompletedProfileSetup)
        .animation(.easeOut(duration: 0.3), value: hasCompletedFinalSetup)
        .animation(.easeOut(duration: 0.3), value: hasCompletedPermissionsPriming)
    }
}

struct AppFlowView_Previews: PreviewProvider {
    static var previews: some View {
        AppFlowView()
            .environment(\.colorScheme, .light)
    }
}
