<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="/createMedician.php" method="get">
        <label>Название</label>
        <input type="text" name="name">
        <br>
        <label>Цена:</label>
        <input type="number" name="price" step="any">
        <br>
        <label>Срок годности:</label>
        <input type="number" name="shelf">
        <br>
        <button>Создать</button>
    </form>
</body>
</html>