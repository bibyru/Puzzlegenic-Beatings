extends CharacterBody2D

@onready var AnimTree = $AnimationTree
@onready var JohnUI = $JOHNUI

@onready var WanderTimer = $TIMERS/WanderTimer
@onready var ChillTimer = $TIMERS/ChillTimer
@onready var AttackTimer = $TIMERS/AttackTimer
@onready var ShockTimer = $TIMERS/ShockTimer
@onready var ParriedTimer = $TIMERS/ParriedTimer

@onready var Hinge = $Hinge
@onready var Sprite = $Hinge/Sprite2D
@onready var EffectShock = $Hinge/Shock
@onready var Hitbox = $Hinge/BOXES/Hitbox
@onready var Hurtbox = $Hinge/BOXES/Hurtbox

@onready var SoundAlert = $Sounds/Alert
@onready var SoundDie = $Sounds/Die
@onready var SoundHurt = $Sounds/Hurt
@onready var SoundParried = $Sounds/Parried
@onready var SoundAttacked = $Sounds/Attacked

var statemachine

var dir = Vector2.ZERO
var speed = 2
var deltamult = 1000

var Player
var PlayerDist
var maxDist = 18
var minDist = 10

var parried = false

@export var hp = 100
@export var realdmg = 30
var dmg = realdmg
var parryMe = false

@export var boss = false
var fromspawner = false




func Hurt(theirdmg):
	if parried == true:
		theirdmg *= 2
		
	hp -= theirdmg
	parried = false
	
	JohnUI.UpdateHealth(hp)
	
	if hp <= 0:
		SoundDie.play()
		statemachine.travel("Dead")
		set_collision_layer_value(3, false)
		z_index = -1
	else:
		SoundHurt.play()
		statemachine.travel("Hurt")




func Die():
	JohnUI.visible = false
	set("process_mode", PROCESS_MODE_DISABLED)
	
	if fromspawner == true:
		get_parent().Spawn()
	
	if boss == true:
		get_tree().change_scene_to_file("res://Scenes/Videos/VideoAfterbeating.tscn")

func ExecuteAttack():
	if parried == false:
		Hitbox.Execute()

func PlaySoundAttack():
	SoundAttacked.play()



func _ready():
	AnimTree.active = true
	statemachine = AnimTree["parameters/playback"]
	ChillTimer.start()
	EffectShock.visible = false





func _on_eyes_body_entered(body):
	Player = body
	SoundAlert.play()

func _on_eyes_body_exited(body):
	Player = null





func ParryAvailable():
	parryMe = true

func ParryOut():
	parryMe = false

func _on_parried_timer_timeout():
	parried = false

func ReqParry():
	if parryMe == true:
		SoundParried.play()
		parried = true
		statemachine.travel("Idle")
		
		if ShockTimer.is_stopped():
			ShockTimer.start()
			EffectShock.visible = true
		
		ParriedTimer.start()

func BackToIdle():
	statemachine.travel("Idle")






func GetRandInt():
	var rand = int(randf_range(0, 21))
	if rand % 2 == 0:
		return -(randi() % 25) % 2
	return (randi() % 25) % 2

func _physics_process(delta):
	
	if hp > 0:
		
		if dir != Vector2.ZERO:
			statemachine.travel("Walk")
		else:
			statemachine.travel("Idle")
		
		
		if Player == null:
			# WANDER
			
			if WanderTimer.is_stopped() && ChillTimer.is_stopped():
				WanderTimer.start()
			
			
			if dir.x > 0:
				Hinge.scale.x = 1
			elif dir.x < 0:
				Hinge.scale.x = -1
		
		
		else:
			# ATTACK
			if to_local(Player.global_position).x < 0 == true:
				Hinge.scale.x = -1
			else:
				Hinge.scale.x = 1
			
			PlayerDist = Player.global_position - global_position
			
			if PlayerDist.length() > maxDist:
				dir = PlayerDist.normalized()
				
			elif PlayerDist.length() < minDist:
				dir = -PlayerDist.normalized()
			
			else:
				if AttackTimer.is_stopped():
					AttackTimer.wait_time = randf_range(.5, 2)
					AttackTimer.start()
					statemachine.travel("Attack")
		
		
		velocity = dir * speed * delta * deltamult
		var curranim = statemachine.get_current_node()
		if curranim == "Attack" or curranim == "Hurt":
			velocity = Vector2.ZERO
		move_and_slide()





func _on_wander_timer_timeout():
	ChillTimer.start()
	dir = Vector2.ZERO

func _on_chill_timer_timeout():
	WanderTimer.start()
	dir = Vector2(GetRandInt(), GetRandInt())

func _on_shock_timer_timeout():
	EffectShock.visible = false
