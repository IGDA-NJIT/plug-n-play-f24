extends Control

@export var endoflevel:PackedScene

var die = false
var live = false
var diec = 0
var livec = 0
var down = 0.1

var count = 0
var once = false
var once2 = false
var wait = true

var torki = load("res://calchoo/givethanks/assets/torky.jpg")
var me = load("res://calchoo/givethanks/assets/me.jpg")
var alex = load("res://calchoo/givethanks/assets/alekj.jpg")
var brine = load("res://calchoo/givethanks/assets/DSC_0150.jpg")
var seb = load("res://calchoo/givethanks/assets/image.jpg")
var ltg = load("res://calchoo/givethanks/assets/low-tier-god-2-1081105726.jpg")
var win = load("res://calchoo/givethanks/assets/ty].jpg")
var ppl = [torki,me,alex,brine,seb,ltg,win]

var turk = load("res://calchoo/givethanks/audio/turkey-leg---roblox.mp3")
var mee = load("res://calchoo/givethanks/audio/zaoshanghao.mp3")
var aleks = load("res://calchoo/givethanks/audio/Hey All Scott Here.mp3")
var brin = load("res://calchoo/givethanks/audio/Fart sound effect.mp3")
var sebin = load("res://calchoo/givethanks/audio/Wii sports wow.mp3")
var ltgbruh = load("res://calchoo/givethanks/audio/Vine Boom Sound Effect (Longer Verison For Real) (Read Description Please).mp3")
var winning = load("res://calchoo/givethanks/audio/Kids Cheering - FNAF 1 Sound Effects.mp3")
var intro = [turk,mee,aleks,brin,sebin,ltgbruh,winning]

var torkdie = load("res://calchoo/givethanks/audio/Destroy Sound effect TF2.mp3")
var medie = load("res://calchoo/givethanks/audio/tyler1 scream.mp3")
var alekdie = load("res://calchoo/givethanks/audio/cat scream.mp3")
var drinded = load("res://calchoo/givethanks/audio/engineer scream.mp3")
var sebdie = load("res://calchoo/givethanks/audio/tom scott scream.mp3")
var ltgdie = load("res://calchoo/givethanks/audio/ltg-shares-some-motivational-words.mp3")
var diesounds = [torkdie,medie,alekdie,drinded,sebdie,ltgdie,winning]

var torklive = load("res://calchoo/givethanks/audio/bong.mp3")
var melive = load("res://calchoo/givethanks/audio/Samsung notification sound effect ( no copyright).mp3")
var aleklive = load("res://calchoo/givethanks/audio/Nice Shot! - Wii Sports Golf Announcer Voice.mp3")
var drinliv = load("res://calchoo/givethanks/audio/Cartoon Slipping _ Sound Effect.mp3")
var seblive = load("res://calchoo/givethanks/audio/Cr1tikal disappears.mp3")
var ltglive = load("res://calchoo/givethanks/audio/youservepurpose.mp3")
var livesounds = [torklive,melive,aleklive,drinliv,seblive,ltglive,winning]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%subject.texture = ppl[count]
	%scream.stream = intro[count]
	%scream.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Spike.position.y += down
	if die:
		wait = false
		%subject.position += Vector2(-50,0)
		if !once:
			%scream.stream = diesounds[count]
			%scream.play()
			once = true
	if live:
		wait = false
		%subject.position += Vector2(50,0)
		if !once:
			%scream.stream = livesounds[count]
			%scream.play()
			once = true
	
	if %subject.position.x < -400 or %subject.position.x > 500:
		if count < 6:
			count += 1
		if !once2 and count == 6:
			if diec >5:
				$omin.text = "YOU GAVE TOO MUCH."
				down = 1
			elif livec >5:
				$omin.text = "YOU THANK TOO MUCH."
				down = 1
			else:
				var leave = endoflevel.instantiate()
				get_tree().root.get_node("Level").call_deferred("add_child",leave)
				leave.position = Vector2(194,650)
				once2 = true
		die = false
		live = false
		%GIVE.position = Vector2(randi_range(-200,500),randi_range(600,700))
		%THANKS.position = Vector2(randi_range(-200,500),randi_range(600,700))
		%subject.texture = ppl[count]
		%subject.position = Vector2(194,634)
		%intro.stream = intro[count]
		%intro.play()
		once = false
		await get_tree().create_timer(1).timeout
		wait = true

func _on_give_body_entered(_body: Node2D) -> void:
	if wait:
		die = true
		diec += 1


func _on_thanks_body_entered(_body: Node2D) -> void:
	if wait:
		live = true
		livec +=1
