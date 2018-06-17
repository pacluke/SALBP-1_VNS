


# makefile para o trabalho de otimização

all: mertens mitchell wee-mag

mertens:
#	@julia --color=yes vns/vns.jl MERTENS.IN2 6 0
#	@julia --color=yes vns/vns.jl MERTENS.IN2 15 0
	@julia --color=yes vns/vns.jl MERTENS.IN2 18 0

mitchell:
#	@julia --color=yes vns/vns.jl MITCHELL.IN2 14 0
#	@julia --color=yes vns/vns.jl MITCHELL.IN2 35 0
#	@julia --color=yes vns/vns.jl MITCHELL.IN2 26 0

wee-mag:
#	@julia --color=yes vns/vns.jl WEE-MAG.IN2 28 0
#	@julia --color=yes vns/vns.jl WEE-MAG.IN2 36 0
#	@julia --color=yes vns/vns.jl WEE-MAG.IN2 54 0

test:
	@julia --color=yes tests/tests.jl MERTENS.IN2 6 0