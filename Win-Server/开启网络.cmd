netsh http add urlacl url=http://+:8099/  user=Everyone
netsh advfirewall firewall Add rule name=\"������Web����8099\" dir=in protocol=tcp localport=8099 action=allow