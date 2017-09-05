require './vlan-kernel.rb'

funcao_kernel = ARGV[0]
parametro_funcao_1 = ARGV[1]

if funcao_kernel == "reserva"
	reserva(parametro_funcao_1)
end
