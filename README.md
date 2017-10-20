## Статьи из файлов в папке

## Установка через composer

```json
{
	"require":{
		"akiyatkin/dirarticles"
	}
}
```

## Использование

Подключить слой
```json
{
	"crumb":"actions",
	"external":"-dirarticles/layer.json",
	"config":{
		"title":"Акции",
		"dir":"~actions/"
	}
}
```

[Пример](http://vss63.ru/services)

## SEO
Достаточно создать файл seo.json и прописать мета-теги (title, keywords и т.д.) для описания раздела. 
Для описания статьи, нужно создать файл с названием этой статьи,ы name.json.
