


# makefile para o trabalho de otimização

all: mertens mitchell wee-mag

mertens:
	@julia --color=yes vns/vns.jl MERTENS.IN2 6 6
	@julia --color=yes vns/vns.jl MERTENS.IN2 15 2
	@julia --color=yes vns/vns.jl MERTENS.IN2 18 2

mitchell:
	@julia --color=yes vns/vns.jl MITCHELL.IN2 14 8
	@julia --color=yes vns/vns.jl MITCHELL.IN2 35 3
	@julia --color=yes vns/vns.jl MITCHELL.IN2 26 5

wee-mag:
	@julia --color=yes vns/vns.jl WEE-MAG.IN2 56 30
	@julia --color=yes vns/vns.jl WEE-MAG.IN2 28 63
	@julia --color=yes vns/vns.jl WEE-MAG.IN2 36 60
	@julia --color=yes vns/vns.jl WEE-MAG.IN2 54 31
