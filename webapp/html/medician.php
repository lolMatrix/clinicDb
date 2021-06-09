<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <p>Название: <?=$medician["Name"]?></p>
    <p>Цена: <?=$medician['Price']?></p>
    <p>Срок годности: <?=$medician['Shelf_life']?></p>
    <a href="/UpdateMedician.php?id=<?=$id?>">Редактировать</a>
    <a href="/deleteMedician.php?id=<?=$id?>">Удалить</a>
</body>
</html>