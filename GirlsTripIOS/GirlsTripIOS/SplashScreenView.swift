import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background Image
                Image("beachBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geometry.size.width, height: geometry.size.height)

                // Overlay Text
                VStack {
                    Text("GIRLS")
                        .font(.system(size: 80, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .orange.opacity(0.7), radius: 2, x: 0, y: 5)
                        .overlay(
                            Text("GIRLS")
                                .font(.system(size: 80, weight: .bold, design: .rounded))
                                .foregroundColor(.orange)
                                .offset(x: -2, y: -2)
                                .mask(
                                    Text("GIRLS")
                                        .font(.system(size: 80, weight: .bold, design: .rounded))
                                )
                        )


                    Text("TRIP")
                        .font(.system(size: 80, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(color: .orange.opacity(0.7), radius: 2, x: 0, y: 5)
                        .overlay(
                            Text("TRIP")
                                .font(.system(size: 80, weight: .bold, design: .rounded))
                                .foregroundColor(.orange)
                                .offset(x: -2, y: -2)
                                .mask(
                                    Text("TRIP")
                                        .font(.system(size: 80, weight: .bold, design: .rounded))
                                )
                        )
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
