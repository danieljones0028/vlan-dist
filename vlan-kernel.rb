require "logger"
$LOG = Logger.new("log.vlan_ips")


def reserva(check)
  if check == "run"
    begin
      $LOG.debug("Iniciando verificação de arquivos para reserva de IPs")
      ip_free = File::readlines("./vlan_ips_disponiveis.txt")
      ip_free_open = File::open("./vlan_ips_disponiveis.txt")
      ip_locked = File::readlines("./vlan_ips_indisponiveis.txt")
      ip_locked_open = File::open("./vlan_ips_indisponiveis.txt")
      if ip_free.empty? == true
        $LOG.debug("Não existem ips disponiveis. Total de ips disponiveis: #{ip_free.length}.")
        puts ("Não existem ips disponiveis, abaixo a lista de ips em uso.")
        puts ("#{ip_locked}")
      elsif
        $LOG.debug("Existem ips disponiveis. Total de ips indisponiveis: #{ip_locked.length}")
        puts ("Temos #{ip_free.length} ips liberados.\nEles são: #{ip_free} ")
        $LOG.debug("lista de ips disponiveis: #{ip_free}")
        puts "Digite o numero do ip para a reserva: "
        ipreserva = STDIN.gets.chomp.to_s
        puts "Digite o e-mail do colaborador solicitante: "
        email_solicitante = STDIN.gets.chomp.to_s
        $LOG.debug("Ip escolhido foi #{ipreserva}")
        if File.read("./vlan_ips_indisponiveis.txt").include?("#{ipreserva}")
          $LOG.debug("O ip #{ipreserva} esta listado no arquivo de ips indisponiveis")
          puts ("ip indisponivel!!!")
        elsif
          $LOG.debug("O ip escolhido #{ipreserva} não esta na lista de ips indisponiveis")
          puts ("O ip #{ipreserva} não esta na lista de ips insdiponiveis\nCriando a reserva...")
          adiciona_reserva = File.open("./vlan_ips_indisponiveis.txt", "a")
          adiciona_reserva.puts ("#{ipreserva}")
          adiciona_reserva.close
          $LOG.debug("#{ipreserva} incluido no arquivo de ips indisponiveis com sucesso.")
          $LOG.debug("retirando ip #{ipreserva} da lista de ips disponiveis.")
          remove_ips_disponiveis = ['./vlan_ips_disponiveis.txt']
          remove_ips_disponiveis.each do |remove_ip_disponivel|
            verificacao = File.read('./vlan_ips_disponiveis.txt')
            nova_saida = verificacao.sub(/#{ipreserva}/, '')
            File.open(remove_ip_disponivel, "w") {|temporario| temporario.puts nova_saida}
            end
          $LOG.debug("nova lista de disponiveis: #{ip_free}")
          if File.read("./vlan_ips_indisponiveis.txt").include?("#{ipreserva}")
            puts ("Ip reservado com sucesso!!!")
            $LOG.debug("Ip #{ipreserva} reservado com sucesso para o e-mail: #{email_solicitante}!!!")
          elsif
            puts ("Ocorreu um erro com sucesso ao tentar incluir o IP#{ipreserva} a lista de ips indisponiveis")
            $LOG.debug("Ocorreu um erro com sucesso ao tentar incluir o IP#{ipreserva} a lista de ips indisponiveis")
          end
        end
      end
    end
  end
end
