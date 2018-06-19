


# makefile para o trabalho de otimização

all: mertens mitchell wee-mag

mertens:
	@echo "MERTENS, C = 6"
	@julia --color=yes vns/vns.jl MERTENS.IN2 6 0
	@echo "MERTENS, C = 15"
	@julia --color=yes vns/vns.jl MERTENS.IN2 15 0
	@echo "MERTENS, C = 18"
	@julia --color=yes vns/vns.jl MERTENS.IN2 18 0

mitchell:
	@echo "MITCHELL, C = 14"
	@julia --color=yes vns/vns.jl MITCHELL.IN2 14 0
	@echo "MITCHELL, C = 35"
	@julia --color=yes vns/vns.jl MITCHELL.IN2 35 0
	@echo "MITCHELL, C = 26"
	@julia --color=yes vns/vns.jl MITCHELL.IN2 26 0

wee-mag:
	@echo "WEE-MAG, C = 28"
	@julia --color=yes vns/vns.jl WEE-MAG.IN2 28 0
	@echo "WEE-MAG, C = 36"
	@julia --color=yes vns/vns.jl WEE-MAG.IN2 36 0
	@echo "WEE-MAG, C = 54"
	@julia --color=yes vns/vns.jl WEE-MAG.IN2 54 0

test:
	@julia --color=yes tests/tests.jl MERTENS.IN2 6 0