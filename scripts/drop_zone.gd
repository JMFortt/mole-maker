extends TextureRect
@export var allowed_types : Array[String] = []
@export var zone_id       : int = 0               # 0 nuc,1 inner,2 outer

func _can_drop_data(_pos, data):
	var ok: bool = typeof(data) == TYPE_DICTIONARY \
		and data.type in allowed_types
	print("[DROP]", name, "→ _can_drop_data  ok =", ok, " data =", data)
	return ok

func _drop_data(_pos, data):
	print("[DROP]", name, "→ _drop_data      data =", data)

	# locate AtomAssembler
	var asm := find_parent("AtomAssembler")
	print("        found parent:", asm, "  class:", asm.get_class())

	# no parent named AtomAssembler? – try upwards script check
	if asm == null or not asm.has_method("spawn_particle_at"):
		asm = get_tree().get_root().find_child("AtomAssembler", true, false)
		print("        fallback search ->", asm)

	# If still no valid assembler, log and abort
	if asm == null:
		push_warning("[DROP]   ❌ No AtomAssembler in scene tree!")
		return
	if not asm.has_method("spawn_particle_at"):
		push_warning("[DROP]   ❌ Node has no method spawn_particle_at()")
		return

	# finally call it
	asm.spawn_particle_at(zone_id, data.type)
