import SwiftUI
import AuthenticationServices // Import this framework for Sign in with Apple

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false

    var body: some View {
        ZStack {
            // Background color
            Color(red: 253/255, green: 223/255, blue: 170/255)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                Spacer()
                
                // Welcome Text
                Text("Welcome to Girls Trip!")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .padding(.bottom, 30)

                // Image Collage
                imageCollage()
                    .padding(.bottom, 40)

                // Feature List
                VStack(alignment: .leading, spacing: 25) {
                    FeatureRow(iconName: "list.bullet.clipboard.fill", text: "Centralize travel itinerary")
                    FeatureRow(iconName: "photo.on.rectangle.angled", text: "Create moodboards for your trips")
                    FeatureRow(iconName: "shield.checkmark.fill", text: "Stay protected with essential safety features")
                }

                Spacer()
                
                // Swoosh Heart
                Image("swoosh_heart") // Use the name from your assets
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .padding(.bottom, 15)

                // Sign in with Apple Button
                SignInWithAppleButton(
                    onRequest: { request in
                        request.requestedScopes = [.fullName, .email]
                    },
                    onCompletion: { result in
                        switch result {
                        case .success(let authResults):
                            print("Authorization successful: \(authResults)")
                            // Here you would typically handle the user's credentials
                            // (e.g., save their name, email, user identifier)
                            
                            // For now, we'll just mark onboarding as complete
                            self.hasCompletedOnboarding = true
                            
                        case .failure(let error):
                            print("Authorization failed: \(error.localizedDescription)")
                            // Handle the error (e.g., show an alert to the user)
                        }
                    }
                )
                .signInWithAppleButtonStyle(.black) // You can choose .black, .white, or .whiteOutline
                .frame(height: 55)
                .cornerRadius(100)
                .padding(.horizontal, 40)
            }
            .padding(.bottom, 50)
            .padding(.top, 20)
        }
    }
    
    // ViewBuilder for the image collage
    @ViewBuilder
    private func imageCollage() -> some View {
        ZStack {
            // Image 1 (Left)
            Image("collage_image_1") // Use your asset name
                .resizable().scaledToFill()
                .frame(width: 130, height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color.pink, lineWidth: 2))
                .rotationEffect(.degrees(-15))
                .offset(x: -45, y: 15)

            // Image 3 (Right)
            Image("collage_image_3") // Use your asset name
                .resizable().scaledToFill()
                .frame(width: 140, height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color.purple, lineWidth: 2))
                .rotationEffect(.degrees(8))
                .offset(x: 50, y: 40)

            // Image 2 (Top)
            Image("collage_image_2") // Use your asset name
                .resizable().scaledToFill()
                .frame(width: 135, height: 135)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .overlay(RoundedRectangle(cornerRadius: 25.0).stroke(Color.blue, lineWidth: 2))
                .rotationEffect(.degrees(10))
                .offset(y: -30)
        }
        .frame(height: 250) // Give the ZStack a fixed height to manage layout
    }
}

// Reusable view for the feature list items
struct FeatureRow: View {
    let iconName: String
    let text: String

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: iconName)
                .font(.system(size: 24, weight: .semibold))
                .frame(width: 30)
                .foregroundColor(.black)
            
            Text(text)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding(.horizontal, 40)
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
