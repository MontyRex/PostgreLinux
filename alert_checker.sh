   #!/bin/bash

   THRESHOLD=90  # Порог загрузки CPU в %
   ALERT=$(psql -U monitoring_user -d monitoring_db -t -c "SELECT COUNT(*) FROM cpu_metrics WHERE cpu_usage > $THRESHOLD AND timestamp > NOW() - INTERVAL '5 minutes';")

   if [ "$(echo $ALERT | xargs)" -gt 0 ]; then
       echo "⚠️ Высокая нагрузка на CPU ($THRESHOLD%+) за последние 5 минут!" | mail -s "Alert: Высокая нагрузка на сервере" admin@example.com
   fi
