:inets.start()
{:ok, pid} = :inets.start(:httpd, [
      {:port, 8888},
      {:server_name, 'HTTP Server'},
      {:server_root, '/'},
      {:document_root, '/home/idfumg/.ssh'},
      {:bind_address, '10.1.7.169'}
    ])
:httpd.info(pid)
