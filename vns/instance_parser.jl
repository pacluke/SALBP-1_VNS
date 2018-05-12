
# instance_parser.jl
# "Lucas Flores (https://github.com/pacluke) and Isadora Oliveira"

# this will make sense when we actually have a data structure
# include("data_structure.jl")

function read_instance_file(filename::String)

    file = open("../instances/$(filename)")
	file_lines = readlines(file)
	close(file)

	num_of_taks = parse(Int64, file_lines[1])
	task_times = map(x->parse(Int64, x), file_lines[2:num_of_taks+1])
	precedence = map(x->tuple(parse(Int64, split(x,",")[1]),parse(Int64, split(x,",")[2])), file_lines[num_of_taks+2:length(file_lines)-1])

	task = 0
	precedences = 0

	println("Instance name: $(filename)")
	println("This instance has $(num_of_taks) tasks.")
	foreach(x->println("The task $(task+=1) takes $(x) time units."), task_times)
	foreach(x->println("The precedence $(precedences+=1) is $(x)."), precedence)

	println("\n")

end

# read_instance_file("MERTENS.IN2")
# read_instance_file("MITCHELL.IN2")
# read_instance_file("WEE-MAG.IN2")
