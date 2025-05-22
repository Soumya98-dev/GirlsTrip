import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @State private var showingPermissionsPriming = false

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
                        print("Sign Up tapped on OnboardingView")
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

                    Button(action: {
                        print("Maybe later tapped")
                        self.hasCompletedOnboarding = true
                    }) {
                        Text("Maybe later")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.gray)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 3)
                    }
                    .padding(.horizontal, 50)
                }
                .padding(.bottom, 40)
            }
        }
        .sheet(isPresented: $showingPermissionsPriming) {
            PermissionsPrimingView {
                print("Got it! tapped from PermissionsPrimingView")
                self.showingPermissionsPriming = false
                self.hasCompletedOnboarding = true
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
