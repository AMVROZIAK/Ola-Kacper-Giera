extends CharacterBody2D

var run_speed = 350
var jump_speed = -400
var gravity = 2500
var maxjump = 0
@onready var timer := $"../cooldown" 
@onready var animation := $AnimationPlayer

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_select')
	var rotateright = Input.is_action_just_pressed('ui_right')
	var rotateleft = Input.is_action_just_pressed('ui_left')
	
	if maxjump == 1:
		animation.play("onejump")
		$Camera2D.zoom = Vector2(0.7 ,0.7)
	if maxjump == 2:
		animation.play("twojump")
		$Camera2D.zoom = Vector2(0.5 ,0.5)
	if maxjump == 0:
		animation.play("RESET")
		
		
	if jump and maxjump != 2:
		jump_speed -= 200
		velocity.y = jump_speed
		maxjump += 1
		


	
	if is_on_floor():
		$".".rotation = 0
		animation.play("RESET")
		maxjump = 0
		
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed

func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	move_and_slide()
