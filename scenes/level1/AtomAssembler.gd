class_name AtomAssembler 
extends Node2D

var ParticleScene : PackedScene = preload("res://scenes/level1/ParticleSprite.tscn")

var proton  : int = 0
var neutron : int = 0
var inner_e : int = 0
var outer_e : int = 0

func _ready():
	name = "AtomAssembler"      # ensure the node’s actual name
	print("[ASM] ready —", self)
	_update_labels()

func spawn_particle_at(zone: int, ptype: String) -> void:
	# ------------------------------------------------ 1.  load texture
	var tex_path := "res://assets/%s.png" % ptype
	var tex: Texture2D = load(tex_path)
	if tex == null:
		push_error("[ASM] ⚠ texture missing → " + tex_path)
		return

	# ------------------------------------------------ 2.  build particle (Control)
	var rect := TextureRect.new()
	rect.texture        = tex
	rect.expand_mode    = TextureRect.EXPAND_KEEP_SIZE
	rect.size           = tex.get_size()          # be sure size ≠ 0
	rect.pivot_offset   = rect.size * 0.5
	rect.anchor_left    = 0.5                     # anchor in parent centre
	rect.anchor_top     = 0.5
	rect.anchor_right   = 0.5
	rect.anchor_bottom  = 0.5
	rect.position       = Vector2.ZERO            # so anchor == final pos
	rect.mouse_filter   = Control.MOUSE_FILTER_IGNORE
	rect.z_index        = 10                      # draw above zone art

	# ------------------------------------------------ 3.  pick target zone
	var target: Control = null                    # declare first
	match zone:
		0:
			target = $DropZones/NucleusZone
		1:
			target = $DropZones/InnerShellZone
		2:
			target = $DropZones/OuterShellZone
		_:
			push_error("[ASM] ❌ invalid zone id " + str(zone))
			return

	target.add_child(rect)
	print("[ASM] ✔ added", ptype, "to", target.name)

	# ------------------------------------------------ 4.  update counters
	match ptype:
		"proton":
			if zone == 0: proton += 1
		"neutron":
			if zone == 0: neutron += 1
		"electron":
			if zone == 1:
				inner_e += 1
			elif zone == 2:
				outer_e += 1

	_update_labels()


func _update_labels():
	$ProtonCountLabel.text   = str(proton)
	$NeutronCountLabel.text  = str(neutron)
	$InnerECountLabel.text   = str(inner_e)
	$OuterECountLabel.text   = str(outer_e)
	print("[ASM] counts  P", proton, " N", neutron, " e(1)", inner_e, " e(2)", outer_e)
