
# instance_parser.jl
# "Lucas Flores (https://github.com/pacluke) and Isadora Oliveira"

include("./data_structure.jl")

function print_instance(filename::String, inst::Instance)

	task = 0
	precedences = 0

	print("\n")
	println("Instance name: $(filename)")
	print("\n")
	println("This instance has $(inst.number_of_tasks) tasks.")
	print("\n")
	foreach(x->println("The task $(task+=1) takes $(x) time unit(s)."), inst.tasks_time)
	print("\n")
	foreach(x->println("The precedence $(precedences+=1) is $(x)."), inst.precedences)
	print("\n")

end

function set_instance(num_tasks::Int64, max_cycle::Int64, times::Array{Int64, 1}, stats::Array{Tuple{Int64, Int64}, 1})

	adj_matrix::Array{Int64, 2} = zeros(Int64, num_tasks, num_tasks)

	for tup in stats
		adj_matrix[tup[1], tup[2]] = 1
	end

	inst = Instance(num_tasks, max_cycle, times, stats, adj_matrix)

	return inst

end

function read_instance_file(filename::String, max_cycle::Int64)

	file = open("../instances/$(filename)")
	file_lines = readlines(file)
	close(file)

	num_of_taks = parse(Int64, file_lines[1])
	task_times = map(x->parse(Int64, x), file_lines[2:num_of_taks+1])
	precedence = map(x->tuple(parse(Int64, split(x,",")[1]),parse(Int64, split(x,",")[2])), file_lines[num_of_taks+2:length(file_lines)-1])

	task = 0
	precedences = 0

	inst::Instance = set_instance(num_of_taks, max_cycle, task_times, precedence)

	print_instance(filename, inst)

	return inst
end