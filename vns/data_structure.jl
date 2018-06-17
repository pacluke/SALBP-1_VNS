
# data_structure.jl
# "Lucas Flores (https://github.com/pacluke) and Isadora Oliveira (https://github.com/isadorasop)"

struct Instance
	number_of_tasks :: Int64
	maximum_cicle_time :: Int64
	tasks_time :: Array{Int64, 1}
	precedences :: Array{Tuple{Int64, Int64}, 1}
	adjacency_matrix :: Array{Bool, 2}
	times_matrix :: Array{Int64, 2}
	ordered_tasks::Array{Int64, 1}
end

struct Solution
	stations :: Array{Tuple{Array{Int64, 1}, Int64}, 1}
end