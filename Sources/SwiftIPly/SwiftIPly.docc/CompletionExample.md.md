# Completion Handler Usage

```swift
import IPly

// Basic usage
IPly.getPublicIP { result in
    switch result {
    case .success(let ip):
        print("Public IP: \(ip)")
    case .failure(let error):
        print("Error: \(error.localizedDescription)")
    }
}

// Updating UI
func fetchAndDisplayIP() {
    IPly.getPublicIP { [weak self] result in
        DispatchQueue.main.async {
            switch result {
            case .success(let ip):
                self?.ipLabel.text = ip
            case .failure(let error):
                self?.showError(error)
            }
        }
    }
}

// Wrapping in Combine publisher
import Combine

func ipPublisher() -> AnyPublisher<String, IPly.Error> {
    Future { promise in
        IPly.getPublicIP(completion: promise)
    }
    .eraseToAnyPublisher()
}