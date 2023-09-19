extends BattleAction
class_name MoveAction


var move: Move


func _init(m, p, u, t):
	move = m
	priority = p
	user = u
	target = t
	
	message = u.species.name + " uses " + m.name + "!"


func Execute():
	print("Executing ", move)
	
	var oStat = {
		Constants.DAMAGE_TYPES.PHYSICAL: "attack",
		Constants.DAMAGE_TYPES.SPECIAL: "specialAttack"
	}[move.damageType]
	var dStat = {
		Constants.DAMAGE_TYPES.PHYSICAL: "defense",
		Constants.DAMAGE_TYPES.SPECIAL: "specialDefense"
	}[move.damageType]
	
	# user offense
	# target defense
	# multipliers
	# base power
	var damage = floor(move.power * (user.GetStat(oStat) / user.GetStat(dStat)))
	# todo: type effectiveness
	target.ApplyDamage(damage)


func _to_string():
	return "<MoveAction:%s:P%d:U%s:T%s>" % [move.name, priority, user, target]
