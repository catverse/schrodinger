import GameplayKit

final class DialogFinishState: State {
    weak var npc: NpcWalk!
    var next: State.Type!
    
    override func didEnter(from: GKState?) {
        super.didEnter(from: from)
        npc.component(ofType: StandingWalk.self)!.waiting()
        stateMachine!.enter(next)
    }
}
