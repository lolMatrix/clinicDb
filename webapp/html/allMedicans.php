<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <a href="/createMedician.php">Создать лекарство</a>
    <?foreach($medicians as $medician){?>
        <p><a href="/medician.php?id=<?=$medician['Id']?>"><?=$medician["Name"]?></a></p>
    <?}?>
</body>
</html>