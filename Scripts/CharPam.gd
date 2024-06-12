extends CharacterBody2D

@onready var Sprite = $Sprite2D
@onready var AnimTree = $AnimationTree
@onready var ParryTimer = $TIMERS/ParryTimer

@onready var Hitbox = $BOXES/Hitbox
@onready var Hurtbox = $BOXES/Hurtbox

@onready var JohnUI = $JOHNUI

@onready var SoundHurt = $SOUNDS/Hurt
@onready var SoundAttacked = $SOUNDS/Attacked
@onready var SoundAttackBlocked = $SOUNDS/AttackBlocked
@onready var SoundAttackParry = $SOUNDS/AttackParry

var statemachine

var dir = Vector2.ZERO
var speed = 3.5
var deltamult = 1000

var isBusy = false
var isBlocking = false
var parrySuccess = false

@export var hp = 100
@export var dmg = 50

func Hurt(theirdmg):
	if isBlocking == true:
		SoundAttackBlocked.play()
		hp -= ( theirdmg /2 )
	else:
		SoundHurt.play()
		hp -= theirdmg
	
	JohnUI.UpdateHealth(hp)
	
	if hp <= 0:
		statemachine.travel("Die")
		Manager.ReqMenuTryAgain()
		set_collision_layer_value(2, false)
		var thetween = create_tween()
		thetween.tween_property(self, "modulate", Color(1,1,1,0), 2)
		
	else:
		StateBusy(2)


func _ready():
	AnimTree.active = true
	statemachine = AnimTree["parameters/playback"]





func ExecuteAttack():
	Hitbox.Execute()

func FinishAnim():
	isBusy = false



func StateMove(delta):
	
	if dir.x == -1:
		Sprite.flip_h = true
		Hitbox.scale.x = -1
	elif dir.x == 1:
		Sprite.flip_h = false
		Hitbox.scale.x = 1
	
	if dir != Vector2.ZERO:
		statemachine.travel("Walk")
	else:
		statemachine.travel("Idle")
	
	
	if Input.is_action_pressed("MoveUp"):
		dir.y = -1
	elif Input.is_action_pressed("MoveDown"):
		dir.y = 1
	else:
		dir.y = 0
	
	if Input.is_action_pressed("MoveLeft"):
		dir.x = -1
	elif Input.is_action_pressed("MoveRight"):
		dir.x = 1
	else:
		dir.x = 0
	
	
	velocity = dir.normalized() * speed * delta * deltamult
	move_and_slide()



func StateBusy(num = 0):
	# 0 = attack
	# 1 = parry
	# 2 = hurt
	
	isBusy = true
	
	if num == 0:
		if ParryTimer.is_stopped():
			statemachine.travel("Attack")
		else:
			statemachine.travel("AttackParry")
	
	elif num == 1:
		statemachine.travel("Parry")
	
	else:
		statemachine.travel("Hurt")


func PlaySoundAttack():
	SoundAttacked.play()

func PlaySoundParry():
	SoundAttacked.play()
	SoundAttackParry.play()



func _physics_process(delta):
	
	if hp <= 0:
		statemachine.travel("Idle")
		return
	
	if isBusy == false:
		StateMove(delta)
	
	if Input.is_action_just_pressed("Attack"):
		StateBusy()
	
	if Input.is_action_pressed("Parry"):
		StateBusy(1)
		isBlocking = true
		
	if Input.is_action_just_pressed("Parry"):
		parrySuccess = true
		if ParryTimer.is_stopped():
			ParryTimer.start()
		
		var bodynode = Hitbox.bodynode
		if !bodynode.is_empty():
			for i in range(bodynode.size()):
				bodynode[i].ReqParry()
		
	if Input.is_action_just_released("Parry"):
		FinishAnim()
		isBlocking = false
	
	if Input.is_action_just_pressed("Interact"):
		print(Hitbox.bodynode)
