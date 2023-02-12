//
//  PullData.swift
//  Voluntr
//
//  Created by Admin on 2/11/23.
//

import Foundation
import UIKit


//var infoArray = informationStructure // Array of rows, array of columns, column information
let dispatchGroup = DispatchGroup()


class PullData: UIViewController {
    var editedString = ""


    // Making sure there is a password that matches the username
    func checkPassword(username: String) {

        dispatchGroup.enter()

        let request = NSMutableURLRequest(url: NSURL(string: checkPasswordURLString)! as URL)

        request.httpMethod = "POST"

        let postString = "username=\(username)"

        request.httpBody = postString.data(using: String.Encoding.utf8)

        

        let task = URLSession.shared.dataTask(with: request as URLRequest) {

            data, response, error in

            if error != nil {

                DispatchQueue.main.async {

                    errorString = error!.localizedDescription

                    dispatchGroup.leave()

                }

                return

            }

            

            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)

            //print("responseString = \(responseString!)")

            

            DispatchQueue.main.async {
                thisUser["password"] = "\(responseString!.replacingOccurrences(of: "\"", with: ""))"
                dispatchGroup.leave()
            }

        }

        

        task.resume()

    }

    

    // Getting the user data
    func getUsersInformation(username: String) {
        dispatchGroup.enter()

        let request = NSMutableURLRequest(url: NSURL(string: usersURLString)! as URL)
        request.httpMethod = "POST"
        let postString = "username=\(username)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("ERROR: \(error!)")
                return
            }

            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!
            let basicArray = responseString.replacingOccurrences(of: "\"", with: "").components(separatedBy: ", ")
            for i in 0..<basicArray.count {
                let elementArray = basicArray[i].components(separatedBy: ": ")
                if (elementArray[0] == "Headshot") || (elementArray[0] == "Body") { // For images
                    print("downloading images...")
                    /*if let data = try? Data(contentsOf: URL(string: elementArray[1].replacingOccurrences(of: "\\/", with: "/"))!) {
                        DispatchQueue.main.async {
                            let image: UIImage = UIImage(data: data)!
                            thisUser[elementArray[0]]! = image
                        }
                    } else {
                        print("couldn't convert image at \(elementArray[0])")
                    }*/
                } else { // Text*/
                    thisUser[elementArray[0]] = elementArray[1]
                }
            }

            DispatchQueue.main.async {
                dispatchGroup.leave()
            }
        }

        task.resume()
    }
    
    // Getting the user hours
    func getUsersGroups(username: String) {
        dispatchGroup.enter()

        let request = NSMutableURLRequest(url: NSURL(string: usersGroupsURLString)! as URL)
        request.httpMethod = "POST"
        let postString = "username=\(username)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("ERROR: \(error!)")
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Table.self, from: data)
                    for row in 0..<result.rows.count {
                        var wholeRow: [String] = []
                        for count in 0..<result.cols.count {
                            var rowInformation = ""
                            let characterArray: [Character] = Array("\(result.rows[row].c[count].v)")
                            
                            if characterArray[0] == "I" { // Int value
                                rowInformation = String(characterArray[9..<characterArray.endIndex - 1])
                            } else { // String value
                                rowInformation = String(characterArray[13..<characterArray.endIndex - 2]) // One more indentation in on each side to get rid of the extra quotes
                            }
                            
                            wholeRow.append(rowInformation)
                        }
                        
                        thisUserGroups.append(["groupname": wholeRow[0], "volunteerdate": wholeRow[1], "duration": wholeRow[2]])
                    }
                    
                    DispatchQueue.main.async {
                        dispatchGroup.leave()
                    }
                }
                catch {
                    print("Error in JSON parsing.\n\(error)")
                }
            }
        }

        task.resume()
    }
    
    // Getting the groups
    func getGroups(username: String) {
        dispatchGroup.enter()

        let request = NSMutableURLRequest(url: NSURL(string: groupsURLString)! as URL)
        request.httpMethod = "POST"
        let postString = "username=\(username)"
        request.httpBody = postString.data(using: String.Encoding.utf8)

        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("ERROR: \(error!)")
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Table.self, from: data)
                    for row in 0..<result.rows.count {
                        var wholeRow: [String] = []
                        for count in 0..<result.cols.count {
                            var rowInformation = ""
                            let characterArray: [Character] = Array("\(result.rows[row].c[count].v)")
                            print(characterArray)
                            if characterArray[0] == "I" { // Int value
                                rowInformation = String(characterArray[9..<characterArray.endIndex - 1])
                            } else { // String value
                                rowInformation = String(characterArray[13..<characterArray.endIndex - 2]) // One more indentation in on each side to get rid of the extra quotes
                            }
                            
                            wholeRow.append(rowInformation)
                        }
                        
                        allGroups.append(["groupname": wholeRow[0], "password": wholeRow[1], "eligibility": wholeRow[2], "agemin": wholeRow[2], "agemax": wholeRow[2], "latitude": wholeRow[2], "longitude": wholeRow[2], "website": wholeRow[2], "description": wholeRow[2]])
                    }
                    
                    DispatchQueue.main.async {
                        dispatchGroup.leave()
                    }
                }
                catch {
                    print("Error in JSON parsing.\n\(error)")
                }
            }
        }

        task.resume()
    }
    

    // Getting the user's clothes as links from the database and turning them into images

    /*func getClothes(username: String) {

        dispatchGroup.enter()

        

        let request = NSMutableURLRequest(url: NSURL(string: getClothesURLString)! as URL)

        request.httpMethod = "POST"

        let postString = "username=\(username)"

        request.httpBody = postString.data(using: String.Encoding.utf8)

        

        let task = URLSession.shared.dataTask(with: request as URLRequest) {

            data, response, error in

            if error != nil {

                print("ERROR: \(error!)")

                return

            }

            

            if let data = data {

                let decoder = JSONDecoder()

                do {

                    //let responseNSString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)!

                    //print("responseString = \(responseNSString)")

                    

                    let result = try decoder.decode(Table.self, from: data)

                    //print(result)

                    

                    for row in 0..<result.rows.count {

                        var wholeRow: [String] = []

                        

                        for count in 0..<result.cols.count {

                            var rowInformation = ""

                            

                            let characterArray: [Character] = Array("\(result.rows[row].c[count].v)")

                            if characterArray[0] == "I" { // Int value

                                rowInformation = String(characterArray[9..<characterArray.endIndex - 1])

                            } else { // String value

                                rowInformation = String(characterArray[13..<characterArray.endIndex - 2]) // One more indentation in on each side to get rid of the extra quotes

                            }

                            

                            wholeRow.append(rowInformation.replacingOccurrences(of: "\\n", with: "\n").replacingOccurrences(of: "\\", with: "'").replacingOccurrences(of: "''", with: "'"))

                        }

                        

                        if let data = try? Data(contentsOf: URL(string: wholeRow[3])!) {

                            DispatchQueue.main.async {

                                let image: UIImage = UIImage(data: data)!

                                userClothes[wholeRow[1]]!.append(["Name": wholeRow[2], "Image": image, "Style": wholeRow[4], "Color": wholeRow[5], "Pattern": wholeRow[6], "Material": wholeRow[7], "Brand": wholeRow[8], "Notes": wholeRow[9]])

                            }

                        } else {

                            print("couldn't convert image at \(wholeRow[0])")

                        }

                    }

                    

                    DispatchQueue.main.async {

                        dispatchGroup.leave()

                    }

                }

                catch {

                    print("Error in JSON parsing.\n\(error)")

                }

            }

        }

        

        task.resume()

    }*/

}





// JSON

struct GeneralData: Codable { // Only used in the Google Sheet as start
    var table: Table
}



struct Table: Codable { // Starting for the clothing JSON
    let cols: [Columns]
    let rows: [Rows]
}



struct Columns: Codable {
    var label: String
}



struct Rows: Codable {
    let c: [C]
}



struct C: Codable {
    var v: NumberOrStringValue
}





enum NumberOrStringValue: Codable {

    case IntValue(Int)

    case FloatValue(Float)

    case ArrayValue([Int])

    case StringValue(String)

    

    

    init(from decoder: Decoder) throws {

        if let int = try? decoder.singleValueContainer().decode(Int.self) {

            self = .IntValue(int)

            return

        }

        

        if let float = try? decoder.singleValueContainer().decode(Float.self) {

            self = .FloatValue(float)

            return

        }

        

        if let array = try? decoder.singleValueContainer().decode([Int].self) {

            self = .ArrayValue(array)

            return

        }

        

        if let string = try? decoder.singleValueContainer().decode(String.self) {

            self = .StringValue(string)

            return

        }

        

        throw NumberOrStringError.missingValue

    }

    enum NumberOrStringError: Error {

        case missingValue

    }

    

    

    func encode(to encoder: Encoder) throws {

        var container = encoder.singleValueContainer()

        

        switch self {

            case .IntValue(let value):

                try container.encode(value)

            case .FloatValue(let value):

                try container.encode(value)

            case .ArrayValue(let value):

                try container.encode(value)

            case .StringValue(let value):

                try container.encode(value)

            }

    }

}

