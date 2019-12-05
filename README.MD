# Использование 

Для получения доступа к github из виртуальной машины положить в папку `ssh` ключи от github под именами `id_rsa` и `id_rsa.pub`

1. Для использования нестандартных параметров виртуальной машины создать файл `local_config.yaml` и установить желаемые параметры
```yaml
# Количество процессоров у виртуальной машины
cpus: 4
# Количество памяти у виртуальной машины
memory: 8192
# Имя базы данных
db_name: congress_events
# Логин и пароль владельца БД
db_login: vagrant
db_password: vagrant
``` 

2. Установить плагин vbguest версии 0.21  
```
vagrant plugin install vagrant-vbguest --plugin-version 0.21
```
3. Запустить виртуальную машину  
```
vagrant up
```  
4. Подождать пока пройдет первичная настройка
5. Зайти в виртуальную машину
```
vagrant ssh
```
6. Проверить работоспособность сервера  
```
cd EventsProj/app
python3.6 main.py --create-tables CREATE_TABLES
```