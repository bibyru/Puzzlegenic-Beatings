## 📔 Game Description
![Gif of Trash Grabbers gameplay](https://github.com/bibyru/bibyru/blob/main/Gifs/PuzzlegenicBeatings.gif)

**Puzzlegenic Beatings** is a 2D beat-em-up puzzle serious game. Follow Pam’s story as she finds a mysterious but labeled puzzle bag… WITHOUT A PICTURE! How will she even start to finish the puzzle?! And so, she goes to the place with the same name as the puzzle. Play as Pam as she beats up thugs at the tourist destination messing the place up, then finishes the puzzle.

Download game [here](https://drive.google.com/file/d/1YzoLHeXPfgZBqnKLEwyi3CKiMjcV_ZuE/view).

<br/>

## 🎮 Game Controls
| **Action** | **Key binding** |
| :- | :- |
| Move | W, A, S, D |
| Attack | J |
| Parry, Block | L |

<br/>

## 📝 Project Info
This project was developed using Godot v4.1.2.
| **Role** | **Credit** | **Development Time** |
| :- | :- | :- |
| Game programmer | bibyru (Ruby) | 4 days |
| Project lead | bibyru (Ruby) | 8 days |
| Visual designer | bibyru (Ruby) | 3 days |
| Game designer | bibyru (Ruby) | 2 days |
| Sound designer | bibyru (Ruby), Yehuda Ekglecia Manus, Mochamad Realdy Anrizsa Putra  | 2 days |

<br/>

## ⭐ Scripts and Features
| **Script** | **Description** |
| :- | :- |
| `BoxHitbox.gd` | Script for Hitbox to hurt all in Hitbox. |
| `BoxHurtbox.gd` | Script for Hurtbox to subtract health of script owner. |
| `CharPam.gd` | Script for Pam (player character) to read inputs and manage itself. |
| `CharThug.gd` | Script for Thug (enemy character) to change states and manage itself. |
| `EnemyDetector.gd` | Script for Area to count how many enemies are in the screen. |
| `FinishLevel.gd` | Script to start a timer that finishes the level. |
| `JohnUI.gd` | Script for in-game UI to display health and animate it. |
| `Level0.gd` | Script for main menu to manage its buttons. |
| `Manager.gd` | Singleton script for playing music, read inputs, and change levels. |
| `MenuOptions.gd` | Script for options menu to manage its buttons. |
| `MenuPuzzleComplete.gd` | Script for Puzzle Complete UI to display fun facts of the tourist destination in the level. |
| `MenuTryAgain.gd` | Script for Game Over UI to manage its buttons. |
| `PanningCam.gd` | Script for Camera to pan over. |
| `PuzzleArea.gd` | Script for Area to detect if a puzzle piece is in the correct position. |
| `PuzzleManager.gd` | Script for puzzle level to spawn puzzle pieces and manage it. |
| `PuzzlePiece.gd` | Script for Puzzle Piece objects to get picked up when LMB is pressed. |
| `Spawner.gd` | Script for a spawner to spawn Thugs. |
| `VideoIntro.gd` | Script to manage audio when playing cutscenes. |

<br/>

## 📁 File Description
```
├── PuzzlegenicBeatings
    ├── Files      # for text files
    ├── Sauce      # for game assets
        ├── Sounds      # stores sound assets
        ├── Sprites     # stores sprite assets
            ├── Puzzle1      # stores puzzle piece images in level1
        ├── Videos      # stores cutscene videos
    ├── Scenes    # for levels and prefabs
        ├── InGame      # for prefabs used during gameplay
        ├── Menu        # for UI type prefabs
        ├── Puzzle      # for puzzle type prefabs
        ├── Videos      # for cutscene video prefabs
    ├── Scripts   # for scripts used in the game
```

<br/>

## 💿 How to Open in Game Engine
1. Download all files.
2. Extract to **Folder A** (an empty folder).
3. Launch Godot v4.1.2.
4. Press **Import** and select `project.godot` in **Folder A**.
