# rainbows config
worker_processes 3
Rainbows! do
  use :ThreadPool
  # use :ThreadSpawn
  worker_connections 10
end
