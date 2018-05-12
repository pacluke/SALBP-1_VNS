
# tests.jl
# "Lucas Flores (https://github.com/pacluke) and Isadora Oliveira"

include("../vns/instance_parser.jl")
include("../vns/data_structure.jl")

function main()

    filename::String = ARGS[1]
	cycle_time::Int64 = parse(Int64, ARGS[2])
	seed::Int64 = parse(Int64, ARGS[3])

	k = read_instance_file(filename, cycle_time)
	w = Solution([[1, 2, 3], [1], [1, 2]])

	println("The minimum possible is $(Int64(round(sum(k.tasks_time)/cycle_time)))")
	print("\n")

end

main()