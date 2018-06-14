


# makefile para o trabalho de otimização

all: compile_and_run

compile_and_run:
	@julia --color=yes vns/vns.jl MERTENS.IN2 6 0

test:
	@julia --color=yes tests/tests.jl MERTENS.IN2 6 0