
extension Array {
    mutating func myShuffle() {
        for index in 0 ..< self.count {
            let newIndex = getNewRandomIndex(from: index)
            let tmp = self[index]
            self[index] = self[newIndex]
            self[newIndex] = tmp
        }
    }

    private func getNewRandomIndex(from current: Int) -> Int {
        var newIndex = current
        repeat {
            newIndex = Int.random(in: 0 ..< self.count)
        } while (newIndex == current)
        return newIndex
    }
}

var arr1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print(arr1)
arr1.myShuffle()
print(arr1)
arr1.myShuffle()
print(arr1)
arr1.myShuffle()
print(arr1)
arr1.myShuffle()
print(arr1)
arr1.myShuffle()
print(arr1)

extension String {
    func calcLetters() -> [String: Int] {
        var dict: [String: Int] = [:]
        for char in self {
            guard char.isLetter else {
                continue
            }
            let s = String(char)
            if let count = dict[s] {
                dict[s] = count + 1
            } else {
                dict[s] = 1
            }
        }
        return dict
    }
}

let str1 = "Hello, world"
print(str1.calcLetters())
