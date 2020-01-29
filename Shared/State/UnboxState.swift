import GameplayKit

final class UnboxState: State {
    var next: State.Type!
    var position: vector_int2!
    
    override func didEnter(from: GKState?) {
        (game.scene as! WalkScene).unbox(position)
        stateMachine!.enter(next)
    }
}
