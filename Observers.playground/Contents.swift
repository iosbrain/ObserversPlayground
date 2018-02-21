//
//  Observers.playground
//  Created by Andrew Jaffee on 2/18/18.
//
/*
 
 Copyright (c) 2018 Andrew L. Jaffee, microIT Infrastructure, LLC, and
 iosbrain.com.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
*/

struct Human
{
    var name:String
    {
        willSet // "name" is ABOUT TO CHANGE
        {
            print("\nName WILL be set...")
            print("from current value: \(name)")
            print("to new value: \(newValue).\n")
        }
        didSet // "name" HAS CHANGED
        {
            print("Name WAS changed...")
            print("from current value: \(oldValue)")
            print("to new value: \(name).\n")
        }
    }
}

var person = Human(name: "John")
person.name = "Jack"

print("------------")

class Being
{
    var name:String
    {
        willSet(toNewName)
        {
            print("\nName WILL be set...")
            print("from current value: \(name)")
            print("to new value: \(toNewName).\n")
            // name = "Placeholder"
            /* DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async
            {
                for index in 1...1000000000
                {
                    print("\(index) times 1000 is \(index * 1000)")
                }
                
                DispatchQueue.main.async
                {
                    print("Done with useless loop")
                }
            }*/
        }
        didSet(fromOldName)
        {
            print("Name WAS changed...")
            print("from current value: \(fromOldName)")
            print("to new value: \(name).\n")
            // name = "Placeholder"
        }
    }
    init(name:String)
    {
        self.name = name
    }
}

var alien:Being = Being(name: "Mary")
alien.name = "Marge"
print("Name CHANGED in didSet: \(alien.name)")

print("------------")

//
// CUSTOM CLASS
//
class Person : Equatable
{
    
    var name:String
    var weight:Int
    var sex:String
    
    init(weight:Int, name:String, sex:String)
    {
        self.name = name
        self.weight = weight
        self.sex = sex
    }
    
    // Conformance to Equatable.
    static func == (lhs: Person, rhs: Person) -> Bool
    {
        if lhs.weight == rhs.weight &&
            lhs.name == rhs.name &&
            lhs.sex == rhs.sex
        {
            return true
        }
        else
        {
            return false
        }
    }
    
} // end class Person

class Hierarchy
{
    //
    // Property observer on a
    // COMPLEX/CUSTOM type.
    //
    var leader:Person
    {
        willSet
        {
            //
            // NO COMPARISONS POSSIBLE IF
            // Person CLASS DOES NOT CONFORM
            // TO Equatable.
            //
            if newValue != leader
            {
                print("\nThere will be a change in leadership.")
                print("\(newValue.name) will be the new leader.")
            }
        }
        didSet
        {
            //
            // NO COMPARISONS POSSIBLE IF
            // Person CLASS DOES NOT CONFORM
            // TO Equatable.
            //
            if oldValue != leader
            {
                print("\nThere was a change in leadership.")
                print("\(oldValue.name) was replaced.\n")
            }
        }
    }
    
    var people:[Person]
    
    init(withLeader:Person)
    {
        self.leader = withLeader
        self.people = [Person]()
        self.people.append(leader)
    }
    
} // end class Hierarchy

let frank = Person(weight: 180, name: "Frank", sex: "M")
let brigade = Hierarchy(withLeader: frank)
let barbara = Person(weight: 120, name: "Barbara", sex: "F")
brigade.leader = barbara

print("------------")

class Friend
{
    var name:String
    {
        willSet(toNewName)
        {
            // name = ""
            // Attempting to store to property 'name' within its own willSet, which is about to be overwritten by the new value
            print("\nName WILL be set...")
            print("from current value: \(name)")
            print("to new value: \(toNewName).\n")
        }
        didSet(fromOldName)
        {
            print("Name WAS changed...")
            print("from current value: \(fromOldName)")
            print("to new value: \(name).\n")
        }
    }
    init(name:String)
    {
        self.name = name
    }
}

var buddy:Friend = Friend(name: "Barbara")
buddy.name = "Clara"
