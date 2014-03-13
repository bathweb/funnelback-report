<!DOCTYPE html>

<html>
<head>
    <title>Funnelback search report</title>
</head>
<body>
    <h1>Funnelback search report</h1>
    <?php if (file_exists("assets/usage-summary-chart.png")) { ?>
        <img src="assets/usage-summary-chart.png">
    <?php } ?>

    <?php if (file_exists("assets/summary-table.html")) {
        echo file_get_contents("assets/summary-table.html");
    } ?>

</body>
</html>
