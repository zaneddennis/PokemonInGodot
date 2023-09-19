extends Node


enum DAMAGE_TYPES {PHYSICAL, SPECIAL}

const DIRECTIONS = {
	"up": Vector2(0, -1),
	"down": Vector2(0, 1),
	"left": Vector2(-1, 0),
	"right": Vector2(1, 0)
}

enum GENDER {BOY, GIRL}

const GRID_SIZE = 32

const LAYERS = {
	"Water": 0,
	"Base": 1,
	"Path": 2,
	"Objects": 3,
	"Decorations": 4
}

const MAPS = [
	"empty_map",
	"Flowershore",
	"FlowershoreHospital",
	"FlowershoreHouse1",
	"RouteA"
]

const MAX_LEVEL = 10

const MAX_PARTY_SIZE = 4

enum TYPES {FIRE, WATER, GRASS, NORMAL, FLYING, ROCK}
