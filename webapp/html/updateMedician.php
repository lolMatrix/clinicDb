<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="/UpdateMedician.php" method="get">
        <label>Название</label>
        <input type="hidden" name="id" value="<?=$id?>"/>
        <input type="text" name="name" value="<?=$medician["Name"]?>">
        <br>
        <label>Цена:</label>
        <input type="number" name="price" value="<?=floatval($medician['Price'])?>" step="any">
        <br>
        <label>Срок годности:</label>
        <input type="number" name="shelf" value="<?=$medician['Shelf_life']?>">
        <br>
        <button>Редактировать</button>
    </form>
</body>
</html>