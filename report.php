<!DOCTYPE html>

<html>
<head>
    <title></title>
</head>
<body>
    <h1>Search report for Q1 2014</h1>
    <?php if (file_exists("assets/usage-summary-chart.png")) { ?>
        <img src="assets/usage-summary-chart.png">
    <?php } ?>

    <?php if (file_exists("assets/summary-table.html")) {
        echo file_get_contents("assets/summary-table.html");
    } ?>

</body>
</html>
