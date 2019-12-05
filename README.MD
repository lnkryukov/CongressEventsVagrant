# Использование 

1. Установить плагин vbguest версии 0.21  
```
vagrant plugin install vagrant-vbguest --plugin-version 0.21
```
2. Запустить виртуальную машину  
```
vagrant up
```
3. Подождать пока пройдет первичная настройка
1. Зайти в виртуальную машину  
```
vagrant ssh
```
5. Проверить работоспособность сервера  
```
cd EventsProj/app
python3.6 main.py --create-tables CREATE_TABLES
```