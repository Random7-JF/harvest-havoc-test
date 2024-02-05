extends CharacterBody2D

@export var speed = 100

@onready var animation_tree = $AnimationTree

var is_eating: bool = false

func _input(_event):
	if not is_eating:
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = direction.normalized() * speed
		
	if Input.is_action_just_pressed("ui_accept"):
		is_eating = true

func _physics_process(_delta):
	update_animations()
	move_and_slide()

func update_animations():
	if velocity != Vector2.ZERO:
		animation_tree["parameters/Walk/blend_position"] = velocity.x
		animation_tree["parameters/Eat/blend_position"] = velocity.x
		animation_tree["parameters/Idle/blend_position"] = velocity.x
		animation_tree["parameters/conditions/is_idle"] = false
		animation_tree["parameters/conditions/is_walking"] = true
	else:
		animation_tree["parameters/conditions/is_idle"] = true
		
	animation_tree["parameters/conditions/is_eating"] = is_eating


func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "eat_left" or anim_name == "eat_right":
		is_eating = false
