import SwiftUI

struct PhotoCaptureView: View {
    @State private var showPermissionDialog = true

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.white)
                    .aspectRatio(3/4, contentMode: .fit)
                    .overlay(
                        Group {
                            if showPermissionDialog {
                                PhotoLibraryPermissionDialog(isPresented: $showPermissionDialog)
                            }
                        }
                    )
                
                Spacer()

                bottomToolbar()
            }
        }
    }

    @ViewBuilder
    private func bottomToolbar() -> some View {
        HStack(spacing: 60) {
            Button(action: {
                // TODO: Add action to open PHPickerViewController
                print("Photo Library Tapped")
            }) {
                Image(systemName: "photo.on.rectangle")
                    .font(.system(size: 28, weight: .semibold))
            }

            Button(action: {
                // TODO: Add action to capture photo
                print("Shutter Tapped")
            }) {
                ZStack {
                    Circle()
                        .stroke(Color.white, lineWidth: 4)
                        .frame(width: 70, height: 70)
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 58, height: 58)
                }
            }

            Button(action: {
                // TODO: Add action to flip between front/back camera
                print("Flip Camera Tapped")
            }) {
                Image(systemName: "arrow.triangle.2.circlepath.camera")
                    .font(.system(size: 28, weight: .semibold))
            }
        }
        .foregroundColor(.white)
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(Color.black)
    }
}

struct PhotoLibraryPermissionDialog: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack(spacing: 0) {
            Text("Allow “Girls Trip” access to your camera?")
                .font(.system(size: 17, weight: .semibold))
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                .padding(.bottom, 5)
                .padding(.horizontal, 15)

            Text("Access to your photo library is needed for use of moodboards and #ootd.")
                .font(.system(size: 13))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 15)
                .padding(.bottom, 20)

            Divider()

            Button(action: {
                isPresented = false
                // TODO: Request limited photo library access
            }) {
                Text("Limit Access")
                    .font(.system(size: 17))
                    .frame(maxWidth: .infinity, minHeight: 44)
            }

            Divider()

            Button(action: {
                isPresented = false
                // TODO: Request full photo library access
            }) {
                Text("Allow Full Access")
                    .font(.system(size: 17, weight: .semibold))
                    .frame(maxWidth: .infinity, minHeight: 44)
            }
            
            Divider()

            Button(action: {
                isPresented = false
            }) {
                Text("Don't Allow")
                    .font(.system(size: 17))
                    .frame(maxWidth: .infinity, minHeight: 44)
            }
        }
        .frame(width: 270)
        .background(.thinMaterial) 
        .cornerRadius(14)
        .shadow(radius: 10)
    }
}


// MARK: - Preview
struct PhotoCaptureView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCaptureView()
    }
}
