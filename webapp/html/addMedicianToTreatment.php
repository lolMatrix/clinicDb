<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form method="GET" action="/addMedicianToTreatment.php">
        <input type="hidden" name="id" value="<?=$treatmentId?>">
        <label>лекарство</label>
        <select name="medician">
        <?foreach($arr as $entity){?>
            <option  value="<?=$entity["Id"]?>">
                <?=$entity["Name"]?>
            </option>
        <?}?>
        </select>
        <br>
        <label>кол-во таблеток</label>
        <input type="number" name="count">
        <button>подтвердить</button>
    </form>
</body>
</html>