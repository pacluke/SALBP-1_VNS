
# tests.jl
# "Lucas Flores (https://github.com/pacluke) and Isadora Oliveira"

include("../vns/instance_parser.jl")

# instance_parser.jl test

read_instance_file("MERTENS.IN2", 10)
# read_instance_file("MITCHELL.IN2", 10)
# read_instance_file("WEE-MAG.IN2", 10)

include("../vns/data_structure.jl")

k = Instance(1, 2, [1, 2], [(1, 2), (1, 4)], zeros(Int64, 3, 3))