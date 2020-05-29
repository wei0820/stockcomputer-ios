struct ReceiptData: Codable {
    let receipt: String
    let sandbox: Bool
}
    
struct AppStoreValidationResult: Codable {
    let status: Int
    let environment: String
}

func requestReceiptValidation() {
    let (receiptData, isSandbox) = readReceipt()
    
    // Encode json request body
    let receiptRequestData = ReceiptData(receipt: receiptData.base64EncodedString(), sandbox: isSandbox)
    let bodyData = try! JSONEncoder().encode(receiptRequestData)
        
    // Create actual request
    let url = URL(string: "https://<your ip goes here>/validatereceipt")
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // Create upload task
    let task = URLSession.shared.uploadTask(with: request, from: bodyData) { data, response, error in
        if let error = error {
            print(error)
            return
        }
            
        // Here we only accept server response code 200
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("Unexpected server response")
            return
        }
            
        if let mimeType = response.mimeType, mimeType == "application/json", let data = data {
            // Decode json response
            let result = try! JSONDecoder().decode(AppStoreValidationResult.self, from: data)
                
            print("Receipt validated by \(result.environment) environment")
                
            // Apple status code definitions:
            // https://developer.apple.com/library/archive/releasenotes/General/ValidateAppStoreReceipt/Chapters/ValidateRemotely.html
            switch(result.status) {
                case 0:
                    print("Receipt is valid!")
                case 21000:
                    print("ERROR: The App Store could not read the JSON object you provided.")
                case 21002:
                    print("ERROR: The data in the receipt-data property was malformed or missing.")
                case 21003:
                    print("ERROR: The receipt could not be authenticated.")
                case 21004:
                    print("ERROR: The shared secret you provided does not match the shared secret on file for your account.")
                case 21005:
                    print("ERROR: The receipt server is not currently available.")
                case 21006:
                    print("ERROR: This receipt is valid but the subscription has expired.")
                case 21007:
                    print("ERROR: This receipt is from the test environment, but it was sent to the production environment for verification. Send it to the test environment instead.")
                case 21008:
                    print("ERROR: This receipt is from the production environment, but it was sent to the test environment for verification. Send it to the production environment instead.")
                case 21010:
                    print("ERROR: This receipt could not be authorized. Treat this the same as if a purchase was never made.")
                case 21100..<21200:
                    print("ERROR: Internal data access error.")
                default:
                    print("Unknown error (\(result.status))!")
            }
        }
    }
        
    // Send request
    task.resume()
}