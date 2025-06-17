import SwiftUI

struct PermissionsPrimingView: View {
    var onNextTapped: () -> Void

    var body: some View {
        ZStack {
            Color(red: 253/255, green: 223/255, blue: 170/255)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Location Services")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .padding(.top, 40)

                ZStack {
                    Image("blurred_app_content")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 280)

                    Image("location_dialog_overlay")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .offset(x: 90, y: -100)
                        
                }
                .padding(.vertical, 20)

                Spacer()

                Button(action: onNextTapped) {
                    Text("Next")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 4)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
        }
    }
}

struct PermissionsPrimingView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionsPrimingView {
            print("Next tapped")
        }
        .previewDevice("iPhone 14")
    }
}
