
enum FibonachiError : Error {
    case invalidArgument
}

func fib(_ n: Int) throws -> Int {
    guard n >= 0 else {
        throw FibonachiError.invalidArgument
    }
    guard n > 0 else {
        return 0
    }
    guard n > 1 else {
        return 1
    }
    
    var n1 = 0
    var n2 = 0
    var sum = 1
    for _ in 1...n-1 {
        n1 = n2
        n2 = sum
        sum = n1 + n2
    }
    return sum
}

func printFib(_ n: Int) {
    do {
        print("Fibonacci[\(n)] = \(try fib(n))")
    } catch FibonachiError.invalidArgument {
        print("Invalid argument")
    } catch {
        print("Runtime error")
    }
}

[0, 1, 2, 3, 4, 5, 6, 10, 20, 44, 92, -1, -100].forEach { n in
    printFib(n)
}
