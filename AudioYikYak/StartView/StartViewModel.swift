import Foundation
import Combine
import FirebaseAuth

class StartViewModel: ObservableObject {
    
    // MARK: - Output
    @Published var email: String = ""
    @Published var idToken: String = ""
    @Published var user: User?
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    
    // MARK: - Dependencies
    private var authenticationService: AuthenticationService?
    
    func connect(authenticationService: AuthenticationService) {
        if self.authenticationService == nil {
            self.authenticationService = authenticationService
            
            self.authenticationService?
                .$authenticationState
                .assign(to: &$authenticationState)
            
            self.authenticationService?
                .$user
                .assign(to: &$user)
            
            $user
                .map { $0?.email }
                .replaceNil(with: "(no email address)")
                .assign(to: &$email)
        }
    }
    
    @MainActor
    func refreshIDToken() {
        Task {
            do {
                idToken = try await user?.idTokenForcingRefresh(true) ?? ""
            }
            catch {
                idToken = error.localizedDescription
                print(error)
            }
        }
    }
    
    func getCurrUser(user: User) async -> CustomUser {
        return await CustomUser(username: getUsername(user: user), bio: getBio(user: user))
    }
    
}
