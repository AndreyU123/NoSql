-- 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных
-- IP-адресов.
-- Используем хеш-таблицу addresses для быстрого поиска по ключу и увеличения значения по данному ключу:
HINCRBY addresses '127.0.0.1' 1 -- увеличиваем на 1 для IP '127.0.0.1'
HINCRBY addresses '127.0.0.2' 1 -- увеличиваем на 1 для IP '127.0.0.2'
HGETALL addresses  -- показать ключи и значения хеш-таблицы addresses 

HGET addresses '127.0.0.1' -- получить число посещений для IP '127.0.0.1'

-- 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному
--  адресу и наоборот, поиск электронного адреса пользователя по его имени.
--  Используем хеш-таблицу emails для отображения имени пользователя на email и users для отображения email на имя пользователя.
--  это решение понятное и оптимальное, т.к. для поиска лучше всего подходит хеш-таблица. Также для простоты и наглядности лучше сделать 2  
--  хеш-таблицы.

HSET emails 'igor' 'igorsimdyanov@gmail.com'
HSET emails 'sergey' 'sergey@gmail.com'
HSET emails 'olga' 'olga@mail.ru'

HGET emails 'igor'

HSET users 'igorsimdyanov@gmail.com' 'igor'
HSET users 'sergey@gmail.com' 'sergey'
HSET users 'olga@mail.ru' 'olga'

HGET users 'olga@mail.ru'

-- 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД
--  MongoDB.
-- Создаем 2 коллекции 'catalogs' и 'products'. Делаем максимально просто - необходимые поля для каталогов и продуктов и
-- также в продуктах делаем  ссылочный столбец на каталог. Это гибче, чем использовать поле с именем каталога в коллекции 
-- 'products', т.к. в каталоги могут быть добавлены новые атрибуты, которые при данной схеме 
-- (со столбцом-ссылкой на коллекцию каталогов) могут быть легко добавлены в коллекцию каталогов.


use shop

db.createCollection('catalogs')
db.createCollection('products')

db.catalogs.insert({name: 'Процессоры'})
db.catalogs.insert({name: 'Мат.платы'})
db.catalogs.insert({name: 'Видеокарты'})

db.products.insert(
  {
    name: 'Intel Core i3-8100',
    description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
    price: 7890.00,
    catalog_id: new ObjectId("5b56c73f88f700498cbdc56b")
  }
);

db.products.insert(
  {
    name: 'Intel Core i5-7400',
    description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
    price: 12700.00,
    catalog_id: new ObjectId("5b56c73f88f700498cbdc56b")
  }
);

db.products.insert(
  {
    name: 'ASUS ROG MAXIMUS X HERO',
    description: 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX',
    price: 19310.00,
    catalog_id: new ObjectId("5b56c74788f700498cbdc56c")
  }
);

db.products.find()

db.products.find({catalog_id: ObjectId("5b56c73f88f700498cbdc56bdb")})

