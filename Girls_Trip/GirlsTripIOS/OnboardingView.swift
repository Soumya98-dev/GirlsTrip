import SwiftUI
import AVFoundation

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @State private var showingPermissionsPriming = false
    @State private var showingFullNameEntry = false
    @State private var showingCameraPermissionRequest = false
    @State private var showingFinalSetupInstructions = false // New state variable

    @State private var userFirstName: String = ""
    @State private var userLastName: String = ""

    var body: some View {
        ZStack {
            Color(red: 253/255, green: 223/255, blue: 170/255)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                Spacer()
                Text("Welcome to\nGirls Trip!")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text("The first travel companion app where you can:")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 20)

                FeatureView(
                    iconName: "list.bullet.clipboard.fill",
                    text: "centralize individual and group travel itineraries"
                )
                FeatureView(
                    iconName: "photo.on.rectangle.angled",
                    text: "create mood boards and fun visuals for you trips"
                )
                FeatureView(
                    iconName: "shield.checkmark.fill",
                    text: "stay protected domestically and abroad with essential safety features"
                )
                Spacer()
                VStack(spacing: 15) {
                    Button(action: {
                        self.showingPermissionsPriming = true
                    }) {
                        Text("Sign up")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
                    }
                    .padding(.horizontal, 50)
                    .padding(.horizontal, 50)
                }
                .padding(.bottom, 40)
            } // End of main VStack
        } // End of ZStack
        .sheet(isPresented: $showingPermissionsPriming) {
            PermissionsPrimingView {
                self.showingPermissionsPriming = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                     self.showingFullNameEntry = true
                }
            }
        }
        .sheet(isPresented: $showingFullNameEntry) {
            FullNameEntryView { firstName, lastName in
                self.userFirstName = firstName
                self.userLastName = lastName
                self.showingFullNameEntry = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.showingCameraPermissionRequest = true
                }
            }
        }
        .sheet(isPresented: $showingCameraPermissionRequest) {
            CameraPermissionRequestView(
                onYesTapped: {
                    self.showingCameraPermissionRequest = false
                    requestCameraPermission { granted in
                        if granted {
                            print("Camera permission GRANTED by user.")
                        } else {
                            print("Camera permission DENIED by user.")
                        }
                        // Proceed to final setup instructions regardless of camera permission
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.showingFinalSetupInstructions = true
                        }
                    }
                },
                onNoTapped: {
                    self.showingCameraPermissionRequest = false
                    // User chose not to proceed with camera permission at this stage.
                    // Still proceed to final setup instructions.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.showingFinalSetupInstructions = true
                    }
                }
            )
        }
        .sheet(isPresented: $showingFinalSetupInstructions) {
            FinalSetupInstructionsView {
                print("Enter Girls Trip tapped")
                self.showingFinalSetupInstructions = false // Dismiss this sheet
                self.hasCompletedOnboarding = true      // Mark onboarding as fully complete
            }
        }
    } // End of body

    func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        // ... (requestCameraPermission function remains the same) ...
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
}

struct FeatureView: View {
    let iconName: String
    let text: String

    var body: some View {
        HStack(spacing: 0) {
            VStack {
                 Image(systemName: iconName)
                    .font(.system(size: 40))
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255))
                    .padding(.bottom, 8)

                Text(text)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(Color(red: 80/255, green: 80/255, blue: 80/255))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 280)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
