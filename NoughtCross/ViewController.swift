import UIKit

class ViewController: UIViewController {
    enum Turn {
        case Nought
        case Cross
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstTurn = Turn.Cross
    var currentTurn = Turn.Cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    var count = 0
    var board = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        board = [a1, a2, a3, b1, b2, b3, c1, c2, c3]
        resetBoard()
    }
    
    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
    }
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        viewDidLoad()
    }
    
    func addToBoard(_ sender: UIButton) {
        if sender.title(for: .normal) == nil {
            switch(currentTurn) {
            case Turn.Cross :
                sender.setTitle(CROSS, for: .normal)
                currentTurn = Turn.Nought
                turnLabel.text = NOUGHT
                count = count + 1;
                if victoryCheck(CROSS) {
                    self.turnLabel.text = "X wins"
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        self.viewDidLoad()
                    }
                }
                break;
            case Turn.Nought :
                sender.setTitle(NOUGHT, for: .normal)
                currentTurn = Turn.Cross
                turnLabel.text = CROSS
                count = count + 1;
                if victoryCheck(NOUGHT) {
                    self.turnLabel.text = "O wins"
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        self.viewDidLoad()
                    }
                }
                break;
            }
            if count == 9 {
                if victoryCheck(CROSS) {
                    self.turnLabel.text = "X wins"
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        self.viewDidLoad()
                    }
                } else if victoryCheck(NOUGHT) {
                    self.turnLabel.text = "O wins"
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        self.viewDidLoad()
                    }
                } else {
                    self.turnLabel.text = "Draw"
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        self.viewDidLoad()
                    }
                }
            }
        }
    }
    func resetBoard() {
        count = 0;
        for button in board {
            button.setTitle(nil, for: .normal);
        }
        firstTurn = firstTurn==Turn.Cross ? Turn.Nought : Turn.Cross;
        switch(firstTurn) {
        case Turn.Cross :
            turnLabel.text = CROSS;
            firstTurn = Turn.Cross;
            currentTurn = Turn.Cross;
            break;
        case Turn.Nought :
            turnLabel.text = NOUGHT;
            firstTurn = Turn.Nought;
            currentTurn = Turn.Nought;
            break;
        }
    }
    func victoryCheck(_ str : String) -> Bool {
        // horizontal check
        if strMatch(a1, str) && strMatch(a2, str) && strMatch(a3, str) { return true; }
        if strMatch(b1, str) && strMatch(b2, str) && strMatch(b3, str) { return true; }
        if strMatch(c1, str) && strMatch(c2, str) && strMatch(a3, str) { return true; }
        // vertical check
        if strMatch(a1, str) && strMatch(b1, str) && strMatch(c1, str) { return true; }
        if strMatch(a2, str) && strMatch(b2, str) && strMatch(c2, str) { return true; }
        if strMatch(a3, str) && strMatch(b3, str) && strMatch(c3, str) { return true; }
        // diagonal check
        if strMatch(a1, str) && strMatch(b2, str) && strMatch(c3, str) { return true; }
        if strMatch(a3, str) && strMatch(b2, str) && strMatch(c1, str) { return true; }
        return false;
    }
    func strMatch(_ button : UIButton, _ str : String) -> Bool {
        return button.title(for: .normal) == str;
    }
    
}

