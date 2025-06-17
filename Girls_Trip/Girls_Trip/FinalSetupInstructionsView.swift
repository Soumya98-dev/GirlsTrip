import SwiftUI

struct FinalSetupInstructionsView: View {

    var onNextTapped: () -> Void

    var body: some View {
        ZStack {
            Color(red: 253/255, green: 223/255, blue: 170/255)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                Text("Apple Health")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .padding(.top, 40)

                Image("apple_health_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                    .shadow(radius: 5)

                Text("Ensure Medical ID is up to date in the Health app.")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                Image("medicalIDMockup")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
                
                Spacer()

                Button(action: onNextTapped) {
                    Text("Next")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 50)
            }
            .padding(.horizontal)
        }
    }
}


struct FinalSetupInstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        FinalSetupInstructionsView {
            print("Preview: Next button tapped")
        }
    }
}
