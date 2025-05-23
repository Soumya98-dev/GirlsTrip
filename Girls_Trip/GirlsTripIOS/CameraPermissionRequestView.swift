import SwiftUI
import AVFoundation

struct CameraPermissionRequestView: View {
    var onYesTapped: () -> Void
    var onNoTapped: () -> Void

    var body: some View {
        ZStack {
            Color(red: 253/255, green: 223/255, blue: 170/255)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Spacer()

                Image("cameraPhotosCollage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 180)
                    .padding(.bottom, 20)

                Text("We'll need access to your camera for location and visual planning features. Do you grant us permission?")
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 15)

                VStack(spacing: 0) {
                    Text("\"Girls Trip\" would like to access your camera.")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.top, 20)
                        .padding(.bottom, 5)
                        .padding(.horizontal, 15)


                    Text("Allow access to the camera to upload photos.")
                        .font(.system(size: 13))
                        .foregroundColor(.black.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 20)

                    Divider()
                        .background(Color.gray.opacity(0.5))

                    HStack(spacing: 0) {
                        Button(action: {
                        }) {
                            Text("Don't Allow")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }

                        Divider()
                            .background(Color.gray.opacity(0.5))
                            .frame(height: 44)

                        Button(action: {
                        }) {
                            Text("Allow")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .overlay(
                                    Circle()
                                        .stroke(Color.green, lineWidth: 3)
                                        .frame(width: 60, height: 35)
                                )
                        }
                    }
                    .frame(height: 44)
                }
                .background(Color(UIColor.systemGray6).opacity(0.8))
                .cornerRadius(14)
                .frame(width: 280)
                .padding(.bottom, 30)


                VStack(spacing: 15) {
                    Button(action: onYesTapped) {
                        Text("Yes")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 5)
                    }

                    Button(action: onNoTapped) {
                        Text("No")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 3)
                    }
                }
                .padding(.horizontal, 50)

                Spacer()
            }
            .padding(.vertical)
        }
    }
}


struct CameraPermissionRequestView_Previews: PreviewProvider {
    static var previews: some View {
        CameraPermissionRequestView(
            onYesTapped: { print("Preview: Yes tapped") },
            onNoTapped: { print("Preview: No tapped") }
        )
    }
}
