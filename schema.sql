   -- Таблица для метрик CPU
   CREATE TABLE cpu_metrics (
       id SERIAL PRIMARY KEY,
       timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       cpu_usage NUMERIC(5,2)
   );

   -- Таблица для метрик памяти
   CREATE TABLE memory_metrics (
       id SERIAL PRIMARY KEY,
       timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       mem_used_mb INT,
       mem_free_mb INT,
       mem_cache_mb INT
   );

   -- Таблица для метрик дисков
   CREATE TABLE disk_metrics (
       id SERIAL PRIMARY KEY,
       timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       device VARCHAR(20),
       read_mb NUMERIC(10,2),
       write_mb NUMERIC(10,2)
   );

   -- Таблица для метрик сети
   CREATE TABLE network_metrics (
       id SERIAL PRIMARY KEY,
       timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       interface VARCHAR(20),
       rx_bytes BIGINT,
       tx_bytes BIGINT
   );
