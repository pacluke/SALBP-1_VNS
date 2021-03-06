
# vns.jl
# "Lucas Flores (https://github.com/pacluke) and Isadora Oliveira (https://github.com/isadorasop)"

include("./instance_parser.jl")
include("./data_structure.jl")

function print_solution(sol::Solution)

	station::Int64 = 0
    foreach(x->println("Station $(station+=1) is composed by $(x[1]) and has $(x[2]) time unit(s) of cycle time."),
    	sol.stations)
    print("\n")
    println("The solution has $(length(sol.stations)) stations.")
    print("\n")

end

function dfs(inst::Instance, task_a::Int64, task_b::Int64)

	for i::Int64 in 1:inst.number_of_tasks
		# println("Visiting $i")
		if inst.adjacency_matrix[task_a, i]
			if i == task_b
			    return true
			elseif dfs(inst, i, task_b)
				return true
			end
		end
	end

	return false
end

function dfs_station(inst::Instance, sol::Solution, task_a::Int64, task_b::Int64, station::Int64)
	for i::Int64 in 1:inst.number_of_tasks
		# println("Visiting $i")
		if inst.adjacency_matrix[task_a, i]
			if i == task_b
				if (get_station_by_task(sol, task_a) == station)
					return false
				end
			    return true
			elseif dfs_station(inst, sol, i, task_b, station)
				return true
			end
		end
	end

	return false
end

function verify_precedence(inst::Instance, task_a::Int64, task_b::Int64)
	if(inst.adjacency_matrix[task_a, task_b] || inst.adjacency_matrix[task_b, task_a])
	    return true
	else
		return !(dfs(inst, task_a, task_b) || dfs(inst, task_b, task_a))
	end
end

function verify_precedence_station(inst::Instance, sol::Solution, task_a::Int64, task_b::Int64, station::Int64)
	if(inst.adjacency_matrix[task_a, task_b] || inst.adjacency_matrix[task_b, task_a])
	    return true
	else
		return !(dfs_station(inst, sol, task_a, task_b, station) || dfs_station(inst, sol, task_b, task_a, station))
	end
end


function verify_task_time(inst::Instance, sol::Solution, station_index::Int64, task::Int64)

	return ((sol.stations[station_index][2] + inst.tasks_time[task]) <= inst.maximum_cicle_time)

end

function add_task(inst::Instance, sol::Solution, station_index::Int64, task::Int64)

	if station_index <= length(sol.stations)

		if verify_task_time(inst, sol, station_index, task)
			for task_b in sol.stations[station_index][1]
				if !(verify_precedence(inst, task, task_b))
				    return false
				end
			end
			push!(sol.stations[station_index][1], task)
			sol.stations[station_index] = tuple(sol.stations[station_index][1],
				sol.stations[station_index][2] + inst.tasks_time[task])
			return true
		end

		return false
	else

		push!(sol.stations, tuple([task], inst.tasks_time[task]))
		return true
	end

	return false
end

function add_task_station(inst::Instance, sol::Solution, station_index::Int64, task::Int64)

	if station_index <= length(sol.stations)

		if verify_task_time(inst, sol, station_index, task)
			for task_b in sol.stations[station_index][1]
				if !(verify_precedence_station(inst, sol, task, task_b, station_index))
				    return false
				end
			end
			push!(sol.stations[station_index][1], task)
			sol.stations[station_index] = tuple(sol.stations[station_index][1],
				sol.stations[station_index][2] + inst.tasks_time[task])
			return true
		end

		return false
	else

		push!(sol.stations, tuple([task], inst.tasks_time[task]))
		return true
	end

	return false
end

function remove_task(inst::Instance, sol::Solution, station_index::Int64, task::Int64)

	filter!(x->x != task, sol.stations[station_index][1])
	sol.stations[station_index] = tuple(sol.stations[station_index][1],
			sol.stations[station_index][2] - inst.tasks_time[task])

	if length(sol.stations[station_index][1]) == 0
		deleteat!(sol.stations, station_index)
	end

end

function get_station_by_task(sol::Solution, task::Int64)

	for i::Int64 in 1:length(sol.stations)
	    if task in sol.stations[i][1]
	        return i
	    end
	end

    return 0
end

function get_minor_station(sol::Solution)

	minor_index = 1

	for index::Int64 in 1:length(sol.stations)

	    if sol.stations[minor_index][2] > sol.stations[index][2]
	        minor_index = index
	    end

	end

	return minor_index

end

function simple_initial_solution(inst::Instance)

    sol::Solution = Solution([])

    for i::Int64 in 1:inst.number_of_tasks
        push!(sol.stations, tuple([i], inst.tasks_time[i]))
    end

    # print_solution(sol)

    return sol

end

function greedy_initial_solution(inst::Instance)

	# de alguma forma, criar uma solução gulosa
	# que não seja muito custosa, mas que ajude
	# a começar bem o algoritmo

	#TODO

	sol::Solution = Solution([])

	check = Array{Bool}(inst.number_of_tasks)
	sol_index::Int64 = 1

	for k::Int64 in 1:inst.number_of_tasks
		check[k] = false
	end

	for i::Int64 in 1:inst.number_of_tasks
		if check[i] == false
			push!(sol.stations, tuple([i], inst.tasks_time[i]))
			check[i] = true
			for j::Int64 in i+1:inst.number_of_tasks
				if check[j] == false
					insert = add_task(inst, sol, sol_index, j)
					if insert == true
						check[j] = true
					end
				end
			end
			sol_index = sol_index +1
		end
	end
	return sol
end

function neighbours(inst::Instance, sol::Solution, neighbourhood_number::Int64)
	neighbourhood = generate_random_neighbours(inst, sol, neighbourhood_number)
	if (length(neighbourhood) < neighbourhood_number)
		generate_neighbours(inst, sol, (neighbourhood_number - length(neighbourhood)), neighbourhood)
	end
	return neighbourhood
end

function generate_neighbours(inst::Instance, sol::Solution, neighbourhood_number::Int64, neighbourhood::Array{Solution, 1})

   # for i::Int64 in 1:Int64(ceil(inst.number_of_tasks/2))
   for i::Int64 in 1:inst.number_of_tasks

	   station_index::Int64 = 1
	   added::Bool = false

	   neighbour::Solution = deepcopy(sol)

	   while ((station_index <= length(sol.stations)))

		   task_station = get_station_by_task(neighbour, inst.ordered_tasks[i])

		   if (task_station != station_index)

			   added = add_task(inst, neighbour, station_index, inst.ordered_tasks[i])

			   if added
				   remove_task(inst, neighbour, task_station, inst.ordered_tasks[i])
				   push!(neighbourhood, neighbour)
				   break
			   end

		   end

		   station_index += 1

	   end

	end

	neigh_length::Int64 = length(neighbourhood)

	for csgo::Int64 in 1:neighbourhood_number

		for neigh in 1:neigh_length

			for i::Int64 in 1:Int64(ceil(inst.number_of_tasks/2))

				station_index::Int64 = 1
				added::Bool = false

				neighbour::Solution = deepcopy(neighbourhood[neigh])

				while ((station_index <= length(neighbourhood[neigh].stations)))

					task_station = get_station_by_task(neighbour, inst.ordered_tasks[i])

					if (task_station != station_index)

						added = add_task(inst, neighbour, station_index, inst.ordered_tasks[i])

						if added
							remove_task(inst, neighbour, task_station, inst.ordered_tasks[i])
							push!(neighbourhood, neighbour)
							break
						end
					end
					station_index += 1
				end
			end
		end
	end

	return neighbourhood
end

function generate_random_neighbours(inst::Instance, sol::Solution, neighbourhood_number::Int64)

	# gerar soluções da forma menos custosa possível

    #TODO
	station::Int64 = 0
	task::Int64 = 0
    neighbourhood::Array{Solution, 1} = []
	j::Int64 = 1
	check::Array{Bool, 2} = falses(inst.number_of_tasks, length(sol.stations))

	while j <= neighbourhood_number
		for i::Int64 in 1:inst.number_of_tasks
			task = rand(1:inst.number_of_tasks)
			station = get_station_by_task(sol, task)
			if (check[task, station] == true)
				station = 0
			else
				check[task,station] = true
				if (length(sol.stations[station][1]) == 1)
					break
				else
					station = 0
				end
			end
		end

		if station == 0
			return neighbourhood
		end

	    # for i::Int64 in 1:Int64(ceil(inst.number_of_tasks/2))
	    for i::Int64 in 1:length(sol.stations)
	    	added::Bool = false
	    	neighbour::Solution = deepcopy(sol)
			if (station != i)
				added = add_task_station(inst, neighbour, i, task)
				if added
					remove_task(inst, neighbour, station, task)
					push!(neighbourhood, neighbour)
					break
				end
			end
	    end

		j +=1
	end
    return neighbourhood
end

function shake(inst::Instance, sol::Solution)

	# acho que vou usar a shake pra remover nodos e a
	# geradora de vizinhos pra colocar dentro
	station::Int64 = 0

	sol_copy::Solution = deepcopy(sol)

	for j::Int64 in 1:length(sol_copy.stations)
		station = rand(1:length(sol_copy.stations))
		if length(sol_copy.stations[station][1]) > 1
			break
		end
	end

	for i::Int64 in 1:length(sol_copy.stations[station][1])
		removedTask = sol_copy.stations[station][1][1]
		remove_task(inst, sol_copy, station, removedTask)
		add_task(inst, sol_copy, length(sol.stations)+1, removedTask)
	end

    return sol_copy

end

function local_search(solutions::Array{Solution, 1})

	# tem que escolher a melhor solução em um vetor de soluções
	# mas se duas tiverem o mesmo número de estaçãoes
	# como escolher qual é mais promissora?

    #TODO
    best_solution::Solution = solutions[1]

    for i in 2:length(solutions)
        if (length(solutions[i].stations) <= length(best_solution.stations))
        	best_solution = solutions[i]
        end
    end

    return best_solution

end

function VNS(inst::Instance, initial_solution::Solution, max_neighborhoods::Int64, max_iterations::Int64)
     tic() # tempo inicial
     for i in 1:max_iterations
        k = 1

         while k <= max_neighborhoods

             x1 = shake(inst, initial_solution)
             x2 = local_search(neighbours(inst, x1, k)) # aqui seria o hill climbing
             # println("Current best:\t$(length(x2.stations)) stations")
             if length(x2.stations) < length(initial_solution.stations)
                 initial_solution = x2
                 k = 1
             else
                 k += 1
             end
         end
     end
     toc() # tempo final
     return initial_solution
end



function main()

	filename::String = ARGS[1]
	cycle_time::Int64 = parse(Int64, ARGS[2])
	bks::Int64 = parse(Int64, ARGS[3])

	full_instance::Instance = read_instance_file(filename, cycle_time)
	greedy_solution::Solution = greedy_initial_solution(full_instance)

	m_stations::Array{Int64, 1} = []

	print("\nINSTANCE:\t\t")
	print_with_color(:magenta, "$filename\n")
	print("MAXIMUM CYCLE TIME:\t")
	print_with_color(:magenta, "$cycle_time\n")
	print("MINIMUM POSSIBLE:\t")
	print_with_color(:magenta, "$(Int64(round(sum(full_instance.tasks_time)/cycle_time))) stations\n")
	print("GREEDY RESULT:\t\t")
	print_with_color(:magenta, "$(length(greedy_solution.stations)) stations\n")
	print_with_color(:red, "------------------------------------------------\n")

	for seed::Int64 in 01:50

		srand(seed)
		print("\nSEED: ")
		print_with_color(:white, "$seed ")
		# print_with_color(:red, "-----------------------------------\n")
		vns_solution = VNS(full_instance, greedy_solution, 5, 25)
		# print("VNS RESULT:\t\t")
		# print_with_color(:white, "$(length(vns_solution.stations)) stations\n")
		# print_with_color(:red, "-----------------------------------\n")
	    push!(m_stations, length(vns_solution.stations))

	end

	avg_stations::Float64 = sum(m_stations)/50

	print("BEST VALUE:\t\t")
	print_with_color(:magenta, "$(minimum(m_stations)) stations\n")
	print("WORST VALUE:\t\t")
	print_with_color(:magenta, "$(maximum(m_stations)) stations\n")

	print("AVERAGE STATIONS:\t")
	print_with_color(:magenta, "$(avg_stations) stations\n")
	print("GAP:\t\t\t")
	print_with_color(:magenta, "$(100*((avg_stations - bks)/(bks)))%\n")
	print_with_color(:red, "*********************************************************\n\n\n\n\n")

end

main()
