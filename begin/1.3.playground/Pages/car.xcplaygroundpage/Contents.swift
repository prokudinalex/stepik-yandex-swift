class Car {
    var x: Int = 0
    var y: Int = 0
    
    func printCoords() {
        print("Car at: [\(x), \(y)]")
    }
    
    func execute(cmd: Go) {
        switch cmd.dir {
        case .left:
            x -= cmd.value
        case .right:
            x += cmd.value
        case .up:
            y += cmd.value
        case .down:
            y -= cmd.value
        default:
            print("unexpected direction \(cmd.dir)")
        }
    }
}

enum Direction {
    case left
    case right
    case up
    case down
}

struct Go {
    let dir: Direction
    let value: Int
}

let car = Car()
car.printCoords()
car.execute(cmd: Go(dir: Direction.right, value: 10))
car.printCoords()
car.execute(cmd: Go(dir: Direction.up, value: 10))
car.printCoords()
car.execute(cmd: Go(dir: Direction.left, value: 10))
car.printCoords()
car.execute(cmd: Go(dir: Direction.down, value: 10))
car.printCoords()
