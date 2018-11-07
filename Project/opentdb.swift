//
//  opentdb.swift
//  Project
//
//  Created by Oscar Stenqvist on 2018-11-03.
//  Copyright © 2018 Oscar Stenqvist. All rights reserved.
//

import Foundation
import UIKit


struct question {
    let difficulty : String
    let category : String
    let question : String
    let correct_answer : String
    let incorrect_answers : [String]
    
}
/* Contains functions for cummunication with the opentdb database
 - getQuestions() -> Void gets 10 new questions and puts them in the class variable questions
 
 TODO:
 - getNQuestions(nrOfQuestions) //get anny number of questions
 - getDifficulty(nrOfQuestions, difficulty) //get anny number of questions and specific difficulty
 
 */
class opentdb {

    private var IsDataReady : Bool = false
    
    private var questions = [question]()
    
    private let opentdbURL = "https://opentdb.com/api.php?"
    
    // Returns true if data is ready else false
    public func isQuestionsReady() -> Bool {
        return self.IsDataReady
    }
    
    // getQuestions() returns list of questions if data is ready else returns empty list
    //Parameters: NONE
    //Return: [question]
    func getQestions() -> [question] {
        if IsDataReady{
            return questions
        }
        else {
            return [question]()
        }
    }
    // getQuestionsFromDB() -> Void gets 10 new questions and puts them in the class variable questions
    //Parameters: NONE
    //Return: VOID
    public func getQuestionsFromDB() -> Void {
        print("Opentdb: GetQuestions()")
        
        let nrOfQuestions = 10
        let typeOfQuestion = "multiple"
        let jsonURLAsString = opentdbURL + "amount=" + String(nrOfQuestions) + "&type=" + typeOfQuestion
        
        //Checking the url is ok:
        guard let url = URL(string: jsonURLAsString) else {
            print("Opentdb: No URL")
            return
        }
        
        //Retrivieng data ascync:
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            self.IsDataReady = false
            //If no data recieved:
            guard let data = data else {
                print("Opentdb: No data")
                return
            }
            //Decoding JSON:
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else {
                    print("Opentdb: Något gick snett med avkodningen av json")
                    return
                }
                let results = json["results"]
                //Looping through all questions recieved:
                for object in (results as! NSArray) {
                    if let x : NSDictionary = object as? NSDictionary{
                        let category = (x["category"] as! String).stringByDecodingHTMLEntities
                        let quest = (x["question"] as! String).stringByDecodingHTMLEntities
                        let correct_answer = (x["correct_answer"] as! String).stringByDecodingHTMLEntities
                        let difficulty = (x["difficulty"] as! String).stringByDecodingHTMLEntities
                        var incorrect_answers = [String]()
                        for i in (x["incorrect_answers"] as? NSArray)!{
                            incorrect_answers.append((i as! String).stringByDecodingHTMLEntities)
                        }
                        //Adding all info in the object to the question struct
                        let structQuestion = question(difficulty: difficulty, category: category, question: quest, correct_answer: correct_answer, incorrect_answers: incorrect_answers)
                        //Append question strukt to list of questions:
                        self.questions.append(structQuestion)
                    }
                    
                }

            } catch{
                print("Opentdb: Något gick snett i datahanteringen")
                return
            }
            //DONE!
            print("Opentdb: Klar med datahanteringen")
            self.IsDataReady = true
            }.resume()
        
    }
    
    

}

// Mapping from XML/HTML character entity reference to character
// From http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
private let characterEntities : [ Substring : Character ] = [
    // XML predefined entities:
    "&quot;"    : "\"",
    "&amp;"     : "&",
    "&apos;"    : "'",
    "&lt;"      : "<",
    "&gt;"      : ">",
    
    // HTML character entity references:
    "&nbsp;"    : "\u{00a0}",
    // ...
    "&diams;"   : "♦",
]

extension String {
    
    /// Returns a new string made by replacing in the `String`
    /// all HTML character entity references with the corresponding
    /// character.
    var stringByDecodingHTMLEntities : String {
        
        // ===== Utility functions =====
        
        // Convert the number in the string to the corresponding
        // Unicode character, e.g.
        //    decodeNumeric("64", 10)   --> "@"
        //    decodeNumeric("20ac", 16) --> "€"
        func decodeNumeric(_ string : Substring, base : Int) -> Character? {
            guard let code = UInt32(string, radix: base),
                let uniScalar = UnicodeScalar(code) else { return nil }
            return Character(uniScalar)
        }
        
        // Decode the HTML character entity to the corresponding
        // Unicode character, return `nil` for invalid input.
        //     decode("&#64;")    --> "@"
        //     decode("&#x20ac;") --> "€"
        //     decode("&lt;")     --> "<"
        //     decode("&foo;")    --> nil
        func decode(_ entity : Substring) -> Character? {
            
            if entity.hasPrefix("&#x") || entity.hasPrefix("&#X") {
                return decodeNumeric(entity.dropFirst(3).dropLast(), base: 16)
            } else if entity.hasPrefix("&#") {
                return decodeNumeric(entity.dropFirst(2).dropLast(), base: 10)
            } else {
                return characterEntities[entity]
            }
        }
        
        // ===== Method starts here =====
        
        var result = ""
        var position = startIndex
        
        // Find the next '&' and copy the characters preceding it to `result`:
        while let ampRange = self[position...].range(of: "&") {
            result.append(contentsOf: self[position ..< ampRange.lowerBound])
            position = ampRange.lowerBound
            
            // Find the next ';' and copy everything from '&' to ';' into `entity`
            guard let semiRange = self[position...].range(of: ";") else {
                // No matching ';'.
                break
            }
            let entity = self[position ..< semiRange.upperBound]
            position = semiRange.upperBound
            
            if let decoded = decode(entity) {
                // Replace by decoded character:
                result.append(decoded)
            } else {
                // Invalid entity, copy verbatim:
                result.append(contentsOf: entity)
            }
        }
        // Copy remaining characters to `result`:
        result.append(contentsOf: self[position...])
        return result
    }
}
