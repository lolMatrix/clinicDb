<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="/updateTreatment.php" method="get">
        <input type="hidden" name="id" value="<?=$id?>">
        <label>Описание:</label>
        <br>
        <textarea name="desc"><?=$treatment["Description"]?></textarea>
        <br>
        <label>Кол-во дней лечения</label>
        <input type="number" name="days" value="<?=$treatment["Count_Days"]?>">
        <br>
        <button>Редактировать</button>
    </form>
</body>
</html>