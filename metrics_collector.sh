   #!/bin/bash

   # Сбор данных о CPU
   CPU_USAGE=$(top -bn1 | awk '/Cpu/ {print $2}')
   psql -U monitoring_user -d monitoring_db -c "INSERT INTO cpu_metrics (cpu_usage) VALUES ($CPU_USAGE);"

   # Сбор данных о памяти
   MEM_INFO=$(free -m | awk '/Mem:/ {print $3 " " $4 " " $6}')
   read MEM_USED MEM_FREE MEM_CACHE <<< "$MEM_INFO"
   psql -U monitoring_user -d monitoring_db -c "INSERT INTO memory_metrics (mem_used_mb, mem_free_mb, mem_cache_mb) VALUES ($MEM_USED, $MEM_FREE, $MEM_CACHE);"

   # Сбор данных о дисках
   iostat -d | awk '/^[v]/ {print "INSERT INTO disk_metrics (device, read_mb, write_mb) VALUES ('\''"$1"\'', "$2", "$3");"}' | psql -U monitoring_user -d monitoring_db

   # Сбор данных о сети
   IFACE="enp0s3"  # Замените на ваш сетевой интерфейс
   RX_BYTES=$(cat /sys/class/net/$IFACE/statistics/rx_bytes)
   TX_BYTES=$(cat /sys/class/net/$IFACE/statistics/tx_bytes)
   psql -U monitoring_user -d monitoring_db -c "INSERT INTO network_metrics (interface, rx_bytes, tx_bytes) VALUES ('$IFACE', $RX_BYTES, $TX_BYTES);"
