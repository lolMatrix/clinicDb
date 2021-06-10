<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <p> Описание: <?=$tr["Description"]?></p>
    <p> Дней лечение: <?=$tr["Count_Days"]?></p>
    Список лекарств:
    <ul>
        <?for($i = 0; $i < count($med); $i++){?>
        <li>
            <a href="/medician.php?id=<?=$med[$i]["Id"]?>"><?=$med[$i]["Name"]?> в кол-ве <?=$med[$i]["Count"]?></a>
            <a href="/deleteTreatmentToMedician.php?treatment=<?=$id?>&medician=<?=$med[$i]["Id"]?>">Удалить лекарство из списка</a>
        </li>
        <?}?>
    </ul>

    <p><h3>Итого:</h3> <?=$total?> вечно деревянных</p>

    <a href="/deleteTreatment.php?id=<?=$id?>">Удалить</a>
    <a href="/updateTreatment.php?id=<?=$id?>">Редактировать рецепт</a>
    <a href="/addMedicianToTreatment.php?id=<?=$id?>">Добавить лекарство</a>
</body>
</html>