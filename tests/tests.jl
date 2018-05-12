
# tests.jl
# "Lucas Flores (https://github.com/pacluke) and Isadora Oliveira"

include("../vns/instance_parser.jl")
include("../vns/data_structure.jl")

function main()

    filename::String = ARGS[1]
	cycle_time::Int64 = parse(Int64, ARGS[2])
	seed::Int64 = parse(Int64, ARGS[3])

	k = read_instance_file(filename, cycle_time)

end

main()