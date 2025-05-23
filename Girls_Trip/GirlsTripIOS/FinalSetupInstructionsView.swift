import SwiftUI

struct FinalSetupInstructionsView: View {
    var onEnterGirlsTripTapped: () -> Void

    var body: some View {
        ZStack {
            Color(red: 253/255, green: 223/255, blue: 170/255)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Spacer()

                Text("Please update your Medical ID in the Health app and enable location sharing in FindMy to experience necessary safety features.")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.top, 40)
                    .padding(.bottom, 20)

                HStack(alignment: .center, spacing: 15) {
                    Image("medicalIDMockup")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 130)
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)


                    Image("findMyLocationMockup")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 130)
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .overlay(
                            Circle()
                                .stroke(Color.blue, lineWidth: 3)
                                .frame(width: 40, height: 30)
                                .offset(x: 45, y: 42)
                        )
                }
                .padding(.bottom, 30)

                Spacer()

                Button(action: onEnterGirlsTripTapped) {
                    Text("Enter Girls Trip")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 50)
            }
        }
    }
}

struct FinalSetupInstructionsView_Previews: PreviewProvider {
    static var previews: some View {
        FinalSetupInstructionsView {
            print("Preview: Enter Girls Trip tapped")
        }
    }
}
