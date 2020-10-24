
import Foundation

// Part 1

// Given string with format "Student1 - Group1; Student2 - Group2; ..."

let studentsStr = "Бортнік Василь - ІВ-72; Чередніченко Владислав - ІВ-73; Гуменюк Олександр - ІВ-71; Корнійчук Ольга - ІВ-71; Киба Олег - ІВ-72; Капінус Артем - ІВ-73; Овчарова Юстіна - ІВ-72; Науменко Павло - ІВ-73; Трудов Антон - ІВ-71; Музика Олександр - ІВ-71; Давиденко Костянтин - ІВ-73; Андрющенко Данило - ІВ-71; Тимко Андрій - ІВ-72; Феофанов Іван - ІВ-71; Гончар Юрій - ІВ-73"

// Task 1
// Create dictionary:
// - key is a group name
// - value is sorted array with students

var studentsGroups: [String: [String]] = [:]

// Your code begins

studentsGroups = studentsStr
      .components(separatedBy: ";")
      .map { $0.split(separator: "-", maxSplits: 1)
               .map { $0.trimmingCharacters(in: .whitespaces) }
      }.reduce(into: [String: [String]]()) {
          if $0[$1[1]] == nil {
              $0[$1[1]] = [$1[0]]
	  } else {
              $0[$1[1]]!.append($1[0]);
	  }
      }.mapValues { $0.sorted() };

// Your code ends

print(studentsGroups)
print()

// Given array with expected max points

let points: [Int] = [5, 8, 12, 12, 12, 12, 12, 12, 15]

// Task 2
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is array with points (fill it with random values, use function `randomValue(maxValue: Int) -> Int` )

func randomValue(maxValue: Int) -> Int {
    switch(Int.random(in: 0..<7)) {
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// Your code begins

studentPoints = studentsGroups.mapValues {
    $0.reduce(into: [String: [Int]]()) { 
        $0[$1] = points.map(randomValue);
    }
};

// Your code ends

print(studentPoints)
print()

// Task 3
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is sum of student's points

var sumPoints: [String: [String: Int]] = [:]

// Your code begins

sumPoints = studentPoints.mapValues {
    $0.mapValues {
        $0.reduce(0, +)
    }
};

// Your code ends

print(sumPoints)
print()

// Task 4
// Create dictionary:
// - key is group name
// - value is average of all students points

var groupAvg: [String: Float] = [:]

// Your code begins

groupAvg = sumPoints.mapValues {
    $0.map { (k, v) in Float(v) }.reduce(0, +) / Float($0.count)
};

// Your code ends

print(groupAvg)
print()

// Task 5
// Create dictionary:
// - key is group name
// - value is array of students that have >= 60 points

var passedPerGroup: [String: [String]] = [:]

// Your code begins

passedPerGroup = sumPoints.mapValues {
    $0.filter { $0.value >= 60 }.map { (k, v) in k }
};

// Your code ends

print(passedPerGroup)

// Example of output. Your results will differ because random is used to fill points.
//
//["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
//
//["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
//
//["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
//
//["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
//
//["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]

enum TimeMPError: Error {
    case invalidTime
}

// Part 2
// 14 % 2 == 0, step 3
class TimeMP {
    var h: UInt = 0;
    var m: UInt = 0;
    var s: UInt = 0;

    // Helper constructor
    private init(fromSeconds sec: UInt) {
        h = (sec / 3600) % 24;
	m = (sec / 60) % 60;
	s = sec % 60;
    }

    // 5.a.
    init() {
        h = 0;
	m = 0;
	s = 0;
    }

    // 5.b.
    init(hour: UInt, min: UInt, sec: UInt) throws {
        if hour > 23 || min > 59 || sec > 59 {
            throw TimeMPError.invalidTime
	}
        h = hour;
	m = min;
	s = sec;
    }

    // 5.c.
    init(fromDate date: Date) {
        let t = UInt(date.timeIntervalSinceReferenceDate);
        h = (t / 3600) % 24;
        m = (t / 60) % 60;
        s = t % 60;
    }

    // 6.a.
    func toString() -> String {
        let xm = h >= 12 ? "PM" : "AM";
        return xm.withCString { String(format: "%02u:%02u:%02u %s", h == 12 ? 12 : h % 12, m, s, $0) };
    }

    // 6.b.
    func add(other: TimeMP) -> TimeMP {
        let t = (h * 3600 + m * 60 + s) + (other.h * 3600 + other.m * 60 + other.s);
	return TimeMP(fromSeconds: t);
    }

    // 6.c.
    func sub(other: TimeMP) -> TimeMP {
        var t = Int(h * 3600 + m * 60 + s) - Int(other.h * 3600 + other.m * 60 + other.s);
	if t < 0 {
             t += 24 * 3600;
	}
	return TimeMP(fromSeconds: UInt(t));
    }

    // 7.a.
    final class func +(left: TimeMP, right: TimeMP) -> TimeMP {
        return left.add(other: right);
    }

    // 7.b.
    final class func -(left: TimeMP, right: TimeMP) -> TimeMP {
        return left.sub(other: right);
    }
};

var t1 = TimeMP();
var t2 = try! TimeMP(hour: 1, min: 2, sec: 3);
var t3 = try! TimeMP(hour: 2, min: 4, sec: 59);
var t4 = TimeMP(fromDate: Date());

// Will print the same
print("Add:")
print("t2.add(other: t3) =\t", terminator: "")
print(t2.add(other: t3).toString());
print("t2 + t3 =\t\t", terminator: "")
print((t2 + t3).toString());

// Will print the same
print("Subtract:")
print("t4 =\t\t\t", terminator: "")
print(t4.toString())
print("t4.sub(other: t1) =\t", terminator: "")
print(t4.sub(other: t1).toString())
print("t4 - t1 =\t\t", terminator: "")
print((t4 - t1).toString())

// 10.a.
var t5 = try! TimeMP(hour: 23, min: 59, sec: 59);
var t6 = try! TimeMP(hour: 12, min: 00, sec: 01);
print(t5.toString(), terminator:" + ")
print(t6.toString(), terminator:" = ")
print((t5 + t6).toString())

// 10.b.
t5 = TimeMP();
t6 = try! TimeMP(hour: 0, min: 0, sec: 1);
print(t5.toString(), terminator:" - ")
print(t6.toString(), terminator:" = ")
print((t5 - t6).toString())
