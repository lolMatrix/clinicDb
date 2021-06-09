<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Все рецепты</title>
</head>
<body>
    <a href="/createTreatment.php">Создать рецепт</a>
    <a href="/allMedicians.php">Все лекарства</a>
    <a href="/statistic.php">Отчет по продажам лекарств</a>
    <br>
    <? for ($i = 0; $i < count($array); $i++){?>
        <a href="/treatment.php?id=<?=$array[$i]["Id"]?>"><?=$array[$i]["Description"]?></a>
        <br>
    <?}?>
    <?for($i = 0; $i < $count / 10; $i++){?>
        <a href="/?page=<?=$i+1?>"><?=$i+1?></a>
        <?}?>
</body>
</html>