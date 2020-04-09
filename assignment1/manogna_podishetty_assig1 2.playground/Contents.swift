/*
 Auther : Manogna Podishetty
 Date   : September 8 2019
 */
import Cocoa

/*
 1. WriteaSwiftfunction,callitquadTable,thathasoneargument,aninteger,callitN.The function prints out on the console the values k and k2 + 3*k - 1 for the values k = 1, 2, ..., N.
    Print each value of k on a separate line. So the output of quadTable(3) is given below. (Where does your the output go?)
    k=1 k*k + 3k - 1 = 3
    k=2 k*k + 3k - 1 = 9
    k=3 k*k + 3k - 1 = 17
 */
func quadtable(quad: Int){
    if quad >= 1 {
        for index in 1...quad {
            var q: Int = index*index + 3*index - 1
            print("k= \(index) k*k + 3k - 1 = \(q)")
        }
    }else{
        print("error in 1 problem -> please pass Int value greater then 0 you have passed invalid Int: \(quad)")
    }
}


/*
 2. WriteaSwiftfunction,callitpolyTable,thathasoneargument,anInt(N)andreturnsan array. The function returns an array of size N. The k’th element of the array contains the
    value k3 + 2*k + 4 for k = 0, 1, ..., N. So polyTable(3) would return [7, 16, 37].

*/
func polytable(poly: Int) -> Array<Int> {
    var yourArray = [Int]()
     if poly >= 1 {
        for index in 1...poly {
            var q: Int = index*index + 3*index - 1
        yourArray.append(q)
        }
     }else{
        print("error in 2 problem -> please pass Int value greater then 0 you have passed invalid Int: \(poly)")
    }
    return yourArray
}

/*
 3. WriteaSwiftfunction,callitbusyStudents,thathasoneargumentanarrayofsetsof names and returns the intersection of all the sets in the array. In the code below busyStu- dents would return {“Peter”}.
    let courseA: Set = ["Peter", "Paul", "Mary"]
     let courseB: Set = ["Peter", "Paul", "Dylan"]
     let courseC: Set = ["Tom", "Peter"] busyStudents([courseA, courseB, courseC])
 */
func busyStudents(arrayOfSets: [Set<String>]) -> Set<String>{
    var common:Set<String> = []
    if arrayOfSets.count > 0 {
        for item in arrayOfSets{
            if common.isEmpty == true{
                common = item
            }else{
                common = common.intersection(item)
            }
        }
    }else{
        print("error in 3 problem -> please pass a valid array you have passed invalid array: \(arrayOfSets)")
    }
    return common;
}

/*
 4. WriteaSwiftfunction,callitaverage,thathasoneargumentanarrayofIntsandreturns an optional double, which is the average of the inputs ints. If the input array is empty return the optional value nil.
 */

func average(arrayofInts:Array<Int>) -> Double?{
    var avg:Double?
    var sum:Int = 0
    if arrayofInts.count > 0 {
        for item in arrayofInts{
            sum = sum + item
        }
    }
    avg = Double(sum)/Double(arrayofInts.count)
    return avg
}

/*
 5. WriteaSwiftfunctionaverage2whichisthesameasaveragein#4exceptthattheinputis an array of optional ints.
 */
func average2(arrayofInts:Array<Int?>) -> Double?{
    var avg:Double?
    var sum:Int = 0
    if arrayofInts.count > 0 {
        for item in arrayofInts{
            if let p = item {
                sum = sum + item!
            }
        }
    }
    avg = Double(sum)/Double(arrayofInts.count)
    return avg
}

/*
 6. WriteaSwiftfunctioncostthathasoneargumentadictionary.Thedictionaryhasthree keys: “name”, “price”, and “quantity”. The function cost returns the cost of the item, that is the price * quantity. The keys and values in the dictionary are all strings. The value at “price” is the string of a double like “3.45”. The string at “quantity” is the string of an integer.
    Note that if either the key “price” or “quantity” is not in the map the function “cost” returns 0 (zero). Examples given below.
 let iceCreamA = ["name":"Mochie Green Tea", "quantity": "2", "price": "2.3"]
 let iceCreamB = ["name":"Mochie Green Tea", "price": "2.3"]
 cost(iceCreamA) // returns 4.6 cost(iceCreamB) // returns 0
 */
func cost(mydict : [String:String]) -> String {
    if mydict["price"] != nil && mydict["quantity"] != nil{
        var result = (Double(mydict["price"]!)! * Double(Int(mydict["quantity"]!)!))
        return String(result)
    }
    return "0"
}

/*
 7. WriteaSwiftfunctionwordCountthathastwoarguments,astringandanInt.Thestring contains words separated by a space. For example “cat bat cat rat mouse bat”. wordCount returns a dictionary where the keys are the words in the string and the values are the num- ber of times the word appears in the list. Only the words that occur at least as many times as the second argument are in the dictionary.
     wordCount(words: “cat bat cat rat mouse bat”, count: 1) returns [“cat”: 2, “bat”: 2 “rat”: 1, “mouse”: 1]
     wordCount(words: “cat bat cat rat mouse bat”, count: 2) returns [“cat”: 2, “bat”: 2 ] wordCount(words: “cat bat cat rat mouse bat”, count: 3) returns [:]

 */
func wordCount(words : String, count: Int) -> Dictionary<String, Int> {

    var result = Dictionary<String, Int>()
    var filter = Dictionary<String, Int>()
    for word in words.components(separatedBy: " "){
        
        // store results
        if result[word] == nil {
            result[word] = 1
        }else {
            result[word] = result[word]! + 1
        }
        
        // filter results
        if result[word]! >= count{
            filter[word] = result[word]!
        }
    }
    return filter
}

/*
 8. WriteaSwiftfunctionwordCount2thathasthesameargumentsaswordCountinproblem 7 and returns the same result. However give the second argument a default value of 2 so we can call the function with one or two arguments as shown below.
    wordCount2(words: “cat bat cat rat mouse bat”) returns [“cat”: 2, “bat”: 2 ]
    wordCount2(words: “cat bat cat rat mouse bat”, count: 3) returns [:]
 */
func wordCount2(words : String, count: Int = 2) -> Dictionary<String, Int> {
    return wordCount(words: words, count: count)
}

/*
 9 . WriteaSwiftfunctionwordCount3thathasoneargumentanInt,whichhasthesamerole as the second argument of wordCount. wordCount3 returns a function. The return function has one argument a String that contains words. When evaluated the returned function re- turns the dictionary of words in the string with the number of times the word appears in the list. But as in problem 7 it only contains the words that occur as many times as the argu- ment to wordCount3. See examples below.
         let testA = wordCount3(2)
         testA(words: “cat bat cat rat mouse bat”) returns [“cat”: 2, “bat”: 2 ] testA(words: “a a a b c c”) returns [“a”: 3, “c”: 2]
         let testB = wordCount3(3)
         testB(words: “a a a b c c”) returns [“a”: 3]
 
 */
func wordCount3(index: Int) -> (String) -> Dictionary<String, Int> {
    return {
        (_words:String) -> Dictionary<String, Int>  in
        let result = wordCount(words: _words, count: index)
        return result
    }
}

/*
 10.The problem with polyTable in problem two is that if we what to change the equation (k3 + 2*k + 4) we need to edit and recompile polyTable. Write a Swift function evaluate that has two arguments. The first argument is an Int as in problem two. The second argument of evaluate is itself a function that has an Int as an argument and returns a double. Your func- tion evaluate then returns an array of doubles. The k’th element of the returned array is the result of evaluating the second argument with the value k for k = 0, 1, ..., N.

 */
func evaluate(poly: Int , callback: (Int) -> Double) -> Array<Double>{
    var yourArray = [Double]()
    if poly >= 1 {
        for index in 1...poly {
            var q: Double = callback(index)
            yourArray.append(q)
        }
    }else{
        print("error in 10 problem -> please pass Int value greater then 0 you have passed invalid Int: \(poly)")
    }
    return yourArray
}



print("-++++++++ Test 1 ++++++++-")
// bad test
var quad_number : Int = -1
quadtable(quad: quad_number)
// good test
quad_number = 6
quadtable(quad: quad_number)

print("-++++++++ Test 2 ++++++++-")
//bad test
var poly_table : Int = -1
print(polytable(poly: poly_table))
//good test
poly_table = 6
print (polytable(poly: poly_table))


print("-++++++++ Test 3 ++++++++-")
// good test
let courseA: Set<String> = ["Peter", "Paul", "Mary","manu"]
let courseB: Set<String> = ["Peter", "Paul", "Dylan","manu"]
let courseC: Set<String> = ["Tom", "Peter"]
var arraySet:Array<Set<String>> = [courseA, courseB, courseC]
print(busyStudents(arrayOfSets: arraySet))
// negative test
arraySet = []
print(busyStudents(arrayOfSets: arraySet))

print("-++++++++ Test 4 ++++++++-")
let Numbers = [2 , 5 , 2]
print (average(arrayofInts: Numbers))

print("-++++++++ Test 5 ++++++++-")
var int1: Int?
var int2: Int?
var int3: Int?
let Numbers2:Array<Int?> = [int1,int2,int3]
print (average2(arrayofInts: Numbers2))
print (average2(arrayofInts: Numbers))
print (average2(arrayofInts: [int1,2,int3]))

print("-++++++++ Test 6 ++++++++-")
let iceCreamA = ["name":"Mochie Green Tea", "quantity": "2", "price": "2.3"]
let iceCreamB = ["name":"Mochie Green Tea", "price": "2.3"]
print(cost(mydict:  iceCreamA)) // returns 4.6
print(cost(mydict: iceCreamB)) // returns 0

print("-++++++++ Test 7 ++++++++-")
print(wordCount(words: "cat bat cat rat mouse bat", count: 1)) //returns [“cat”: 2, “bat”: 2 “rat”: 1, “mouse”: 1]
print(wordCount(words: "cat bat cat rat mouse bat", count: 2)) //returns [“cat”: 2, “bat”: 2 ]
print(wordCount(words: "cat bat cat rat mouse bat", count: 3)) //returns [:]

print("-++++++++ Test 8 ++++++++-")
print(wordCount2(words: "cat bat cat rat mouse bat")) //returns [“cat”: 2, “bat”: 2 ]
print(wordCount2(words: "cat bat cat rat mouse bat", count: 3)) //returns [:]

print("-++++++++ Test 9 ++++++++-")
let testA = wordCount3(index: 2)
print(testA("cat bat cat rat mouse bat")) //returns [“cat”: 2, “bat”: 2 ]
print(testA("a a a b c c")) //returns [“a”: 3, “c”: 2]
let testB = wordCount3(index: 3)
print(testB("a a a b c c")) //returns [“a”: 3]

print("-++++++++ Test 10 ++++++++-")
var callbackfun = { (index: Int)->Double in
    var q: Double = Double(index*index + 3*index - 1)
    return q
}
print(evaluate(poly: 8, callback: callbackfun))
